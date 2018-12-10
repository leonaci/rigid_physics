package rigid.dynamics.body.shape;
import rigid.dynamics.body.Transform;
import rigid.dynamics.collision.broadphase.AABB;

/**
 * interface of Shape
 * @author leonaci
 */

@:expose("RHEI.Shape")
interface Shape {
	var aabb(default, null):AABB;
	var kind(default, null):ShapeKind;
	// inertia per mass unit
	var inertia(get, never):Float;

	function calcAABB(transform:Transform):Void;
}