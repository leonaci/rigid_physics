package rigid.dynamics.collision.broadphase;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.collision.broadphase.AABBEdge;

/**
 * ...
 * @author leonaci
 */
@:expose('RHEI.AABB')
class AABB {
	public var shape:Shape;
	
	public var minX(get, set):Float;
	extern inline function get_minX():Float return edgeMinX.pos;
	extern inline function set_minX(minX:Float):Float return edgeMinX.pos = minX;
	
	public var maxX(get, set):Float;
	extern inline function get_maxX():Float return edgeMaxX.pos;
	extern inline function set_maxX(maxX:Float):Float return edgeMaxX.pos = maxX;
	
	public var minY(get, set):Float;
	extern inline function get_minY():Float return edgeMinY.pos;
	extern inline function set_minY(minY:Float):Float return edgeMinY.pos = minY;
	
	public var maxY(get, set):Float;
	extern inline function get_maxY():Float return edgeMaxY.pos;
	extern inline function set_maxY(maxY:Float):Float return edgeMaxY.pos = maxY;
	
	public var edgeMinX(default,null):AABBEdge;
	public var edgeMaxX(default,null):AABBEdge;
	public var edgeMinY(default,null):AABBEdge;
	public var edgeMaxY(default,null):AABBEdge;
	
	public inline function new() {
		edgeMinX = new AABBEdge(this, 0.0, true);
		edgeMaxX = new AABBEdge(this, 0.0, false);
		
		edgeMinY = new AABBEdge(this, 0.0, true);
		edgeMaxY = new AABBEdge(this, 0.0, false);
	}
	
	public function getMinX():Float return edgeMinX.pos;
	public function getMaxX():Float return edgeMaxX.pos;
	public function getMinY():Float return edgeMinY.pos;
	public function getMaxY():Float return edgeMaxY.pos;
}