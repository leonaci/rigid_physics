package rigid.dynamics.collision.broadphase;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Pair;

/**
 * ...
 * @author leonaci
 */
class BroadPhase {
	public var bodies:Array<Body>;
	public var pairs(default, null):Array<Pair>;
	
	
	public function new() {
		this.pairs = [];
		this.bodies = [];
	}
	
	public function updatePairs() throw 'Not Implemented.';
	
	public function addBody(body:Body) {
		bodies.push(body);
		body.sync();
	}
	
	public function removeBody(body:Body) {
		bodies.remove(body);
	}
}