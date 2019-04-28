package rigid.dynamics.collision.broadphase;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Pair;

/**
 * ...
 * @author leonaci
 */
class BroadPhase {
	public var numPairs(default, null):Int;
	public var pairs(default, null):Pair;
	
	public var numBodies:Int;
	public var bodies:Body;
	
	
	public function new() {
		numPairs = 0;
		numBodies = 0;
	}
	
	public function updatePairs() throw 'Not Implemented.';
	
	private inline function addPair(p:Pair) {
		if (pairs == null) pairs = p;
		else {
			pairs.prev = p;
			p.next = pairs;
			pairs = p;
		}
		numPairs++;
	}
	
	public inline function clearPairs():Void {
		if (pairs == null) return;
		
		var pair:Pair = pairs;
		while (pair != null) {
			pair.prev = null;
			pair.next = null;
			pair.s1 = null;
			pair.s2 = null;
			pair = pair.next;
		}
		pairs = null;
		numPairs = 0;
	}
	
	public function addBody(body:Body) {
		bodies = body;
		numBodies++;
		body.sync();
	}
	
	public function removeBody(body:Body) {
		if (body == bodies) bodies = body.next;
		numBodies--;
	}
	
	private inline function overlap(aabb1:AABB, aabb2:AABB) {
		return aabb1.minX < aabb2.maxX
			&& aabb2.minX < aabb1.maxX
			&& aabb1.minY < aabb2.maxY
			&& aabb2.minY < aabb1.maxY;
	}
}