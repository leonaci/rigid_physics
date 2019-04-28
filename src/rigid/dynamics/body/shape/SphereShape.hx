package rigid.dynamics.body.shape;
import rigid.common.Vec2;
import rigid.dynamics.body.Transform;
import rigid.dynamics.body.shape.Shape;

/**
 * ...
 * @author leonaci
 */
@:expose("RHEI.SphereShape")
 class SphereShape extends Shape {
	override function get_inertia():Float return 1 / 2 * radius * radius;
	
	public var radius:Float;

	public function new(radius:Float) {
		super();
		kind = ShapeKind.Sphere;
		this.radius = radius;
	}
	
	override public function calcAABB(transform:Transform) {
		var r:Vec2 = new Vec2(radius, radius);
		var o = transform.q;
		aabb.maxX = o.x + r.x;
		aabb.maxY = o.y + r.y;
		aabb.minX = o.x - r.x;
		aabb.minY = o.y - r.y;
	}
}