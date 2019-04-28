package rigid.dynamics.body;
import haxe.ds.Option;
import rigid.common.MFloat;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.dynamics.body.Transform;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.body.shape.ShapeKind;
import rigid.dynamics.collision.broadphase.AABB;

/**
 * RigidBody
 * @author leonaci
 */
enum BodyState {
	Dynamic;
	Static;
}

@:expose("RHEI.Body")
class Body {
	public var prev:Body;
	public var next:Body;
	
	//動力学に関する全ての情報
	public var transform(default, null):Transform;
	
	//衝突判定に関する全ての情報
	public var shape(default, null):Shape;
	
	public var q(get, set):Vec2;
	inline function get_q() return transform.q;
	inline function set_q(q:Vec2) return transform.q = q;
	
	public var qa(get, set):Float;
	inline function get_qa() return transform.qa;
	inline function set_qa(qa:Float) return transform.qa = qa;
	
	public var v(get, set):Vec2;
	inline function get_v() return transform.p*(1/mass);
	inline function set_v(v:Vec2) return transform.p = mass*v;
	
	public var va(get, set):Float;
	inline function get_va() return transform.pa*(1/inertia);
	inline function set_va(va:Float) return transform.pa = inertia*va;
	
	public var mass(get, set):MFloat;
	inline function get_mass():MFloat return transform.m;
	inline function set_mass(mass:MFloat) {
		transform.i = mass * shape.inertia;
		transform.m = mass;
		return mass;
	}
	
	public var inertia(get, never):MFloat;
	inline function get_inertia() return mass * shape.inertia;
	
	public var aabb(get, null):AABB;
	inline function get_aabb():AABB return shape.aabb;
	
	public var kind(get, null):ShapeKind;
	inline function get_kind():ShapeKind return shape.kind;
	
	public var state(get, never):BodyState;
	inline function get_state() return 1/mass!=0? BodyState.Dynamic : BodyState.Static;
	
	public function new(shape:Shape) {
		this.transform = new Transform();
		this.shape = shape;
		
		switch(shape.assigned) {
			case Option.None:
				shape.assigned = Option.Some(this);
			case Option.Some(_):
				throw 'Not allowed to assign the shape that has been already assigned.';
		}
	}
	
	@:extern
	public inline function integrate(dt:Float) {
		switch(state) {
			case BodyState.Dynamic:
				transform.q += transform.p / mass * dt;
				transform.qa += transform.pa / inertia * dt;
				transform.qa %= 2 * MathUtil.PI;
			case BodyState.Static:
		}
	}
	
	@:extern
	public inline function sync() {
		shape.calcAABB(transform);
	}
	
	public function addTo(body:Body):Void {
		if (body == null) body = this;
		else {
			body.prev = this;
			this.next = body;
			body = this;
		}
	}
	
	public function removeFrom(body:Body):Void {
		if (this.prev != null) this.prev.next = this.next;
		if (this.next != null) this.next.prev = this.prev;
		if (this == body) body = this.next;
		this.prev = null;
		this.next = null;
	}
}