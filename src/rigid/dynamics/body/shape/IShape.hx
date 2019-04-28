package rigid.dynamics.body.shape;
import haxe.ds.Option;
import rigid.dynamics.collision.Contact;
import rigid.dynamics.collision.broadphase.AABB;

/**
 * @author leonaci
 */
interface IShape {
	@:allow(rigid.dynamics.body.Body)
	var assigned(default, null):Option<Body>;
	var shapeLinks:ShapeLink;
	
	var aabb(default, null):AABB;
	var kind(default, null):ShapeKind;
	// inertia per mass unit
	var inertia(get, never):Float;

	function calcAABB(transform:Transform):Void;
}