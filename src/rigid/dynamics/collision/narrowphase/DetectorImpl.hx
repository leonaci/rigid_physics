package rigid.dynamics.collision.narrowphase;
import haxe.ds.Option;
import rigid.dynamics.body.Body;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * ...
 * @author leonaci
 */
class DetectorImpl {
	public function new() {}

	public function detect(b1:Body, b2:Body):Option<ContactConstraint> throw 'Not Implemented.';
}