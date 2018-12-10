package rigid.dynamics.collision.narrowphase;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Contact;

/**
 * ...
 * @author leonaci
 */
class DetectorImpl {
	var b1:Body;
	var b2:Body;

	public function new() {}

	public function detect():Contact throw 'Not Implemented.';
}