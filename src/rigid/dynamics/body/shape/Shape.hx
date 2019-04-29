package rigid.dynamics.body.shape;
import haxe.ds.Option;
import rigid.dynamics.body.Transform;
import rigid.dynamics.collision.Contact;
import rigid.dynamics.collision.broadphase.AABB;

/**
 * basic shape.
 * @author leonaci
 */
@:expose("RHEI.Shape")
 class Shape implements IShape {
	@:allow(rigid.dynamics.body.Body)
	public var assigned(default, null):Option<Body>;
	
	public var shapeLinks:ShapeLink;
	
	public var aabb(default, null):AABB;
	public var kind(default, null):ShapeKind;
	
	// inertia per mass unit
	public var inertia(get, never):Float;
	function get_inertia():Float throw 'Not Implemented.';
	

	public function new() {
		assigned = Option.None;
		aabb = new AABB();
		aabb.shape = this;
	}
	
	public function calcAABB(transform:Transform) throw 'Not Implemented.';
}