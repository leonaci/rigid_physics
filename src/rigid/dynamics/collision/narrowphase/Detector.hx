package rigid.dynamics.collision.narrowphase;
import haxe.ds.Option;
import rigid.dynamics.body.Body;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * ...
 * @author leonaci
 */
 
class Detector {
	@:allow(rigid.dynamics.collision.narrowphase.NarrowPhase.chooseDetector)
	private var impl:DetectorImpl;
	
	public function new() {}
	
	public inline function detect(b1:Body, b2:Body):Option<ContactConstraint> return impl.detect(b1, b2);
}