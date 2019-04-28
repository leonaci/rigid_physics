package rigid.dynamics.collision.broadphase.bruteforce;
import rigid.dynamics.collision.Pair;
import rigid.dynamics.collision.broadphase.BroadPhase;

/**
 * ...
 * @author leonaci
 */

class BruteForceBroadPhase extends BroadPhase {
	public function new() {
		super();
	}
	
	override public inline function updatePairs() {
		// scanning just i > j pairs.
		for (i in 1...bodies.length) for (j in 0...i) {
			var b1 = bodies[i], b2 = bodies[j];
			if (overlap(b1.shape.aabb, b2.shape.aabb)) {
				var pair = new Pair();
				pair.s1 = b1.shape;
				pair.s2 = b2.shape;
				addPair(pair);
			}
		}
	}
}