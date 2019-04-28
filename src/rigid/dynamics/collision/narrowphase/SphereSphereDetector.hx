package rigid.dynamics.collision.narrowphase;
import haxe.ds.Option;
import rigid.common.MathUtil;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.SphereShape;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * ...
 * @author leonaci
 */
class SphereSphereDetector extends DetectorImpl {
	public function new() {
		super();
	}
	
	override public inline function detect(b1:Body, b2:Body):Option<ContactConstraint> {
		var d = b1.q - b2.q;
		var r1 = cast(b1.shape, SphereShape).radius;
		var r2 = cast(b2.shape, SphereShape).radius;
		var ll = d*d;
		
		return if ((r1+r2)*(r1+r2)>ll && ll>0) {
			var cc = new ContactConstraint(b1, b2);
			
			var n = d / MathUtil.sqrt(ll);
			cc.n = n;
			cc.penetration = r1 + r2 - MathUtil.sqrt(ll);
			cc.rq1 = -r1 * n;
			cc.rq2 = r2 * n;
			
			Option.Some(cc);
		}
		else Option.None;
	}
}