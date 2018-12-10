package rigid.dynamics.collision.broadphase.bruteforce;
import rigid.dynamics.collision.broadphase.BroadPhase;
import rigid.dynamics.collision.narrowphase.Detector;

/**
 * ...
 * @author leonaci
 */

class BruteForceBroadPhase extends BroadPhase {
	public function new() {
		super();
	}
	
	override public inline function updatePairs() {
		this.pairs = [];
		for (i in 1...bodies.length) for (j in 0...i) {
			var b1 = bodies[i], b2 = bodies[j];
			if (overlap(b1.shape.aabb, b2.shape.aabb)) {
				var pair = Contact.YET(new Detector(b1, b2));
				this.pairs.push(pair);
			}
		}
	}
	
	static private inline function overlap(aabb1:AABB, aabb2:AABB) {
		return aabb1.maxX < aabb2.maxX
			&& aabb1.maxX > aabb2.minX
			&& aabb1.minY < aabb2.maxY
			&& aabb1.maxY > aabb2.minY;
	}
}