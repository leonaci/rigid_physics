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
		// scanning just j < i pairs.
		var i = 1, b1 = bodies.next;
		while (i++ < numBodies) {
			var j = 0, b2 = bodies;
			while (j++ < i) {
				if (overlap(b1.shape.aabb, b2.shape.aabb)) {
					var pair = new Pair();
					pair.s1 = b1.shape;
					pair.s2 = b2.shape;
					addPair(pair);
				}
				b2 = b2.next;
			}
			b1 = b1.next;
		}
	}
}