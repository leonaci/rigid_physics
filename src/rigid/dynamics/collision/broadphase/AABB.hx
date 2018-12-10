package rigid.dynamics.collision.broadphase;
import rigid.dynamics.collision.broadphase.AABBEdge;

/**
 * ...
 * @author leonaci
 */
class AABB {
	public var minX(get, set):Float;
	inline function get_minX():Float return edgeMinX.pos;
	inline function set_minX(minX:Float):Float return edgeMinX.pos = minX;
	
	public var maxX(get, set):Float;
	inline function get_maxX():Float return edgeMaxX.pos;
	inline function set_maxX(maxX:Float):Float return edgeMaxX.pos = maxX;
	
	public var minY(get, set):Float;
	inline function get_minY():Float return edgeMinY.pos;
	inline function set_minY(minY:Float):Float return edgeMinY.pos = minY;
	
	public var maxY(get, set):Float;
	inline function get_maxY():Float return edgeMaxY.pos;
	inline function set_maxY(maxY:Float):Float return edgeMaxY.pos = maxY;
	
	public var edgeMinX(default,null):AABBEdge;
	public var edgeMaxX(default,null):AABBEdge;
	public var edgeMinY(default,null):AABBEdge;
	public var edgeMaxY(default,null):AABBEdge;
	
	public inline function new() {
		
		edgeMinX = new AABBEdge(this, 0.0, true);
		edgeMaxX = new AABBEdge(this, 0.0, false);
		edgeMinX.theOther = edgeMaxX;
		edgeMaxX.theOther = edgeMinX;
		
		edgeMinY = new AABBEdge(this, 0.0, true);
		edgeMaxY = new AABBEdge(this, 0.0, false);
		edgeMinY.theOther = edgeMaxY;
		edgeMaxY.theOther = edgeMinY;
	}
}