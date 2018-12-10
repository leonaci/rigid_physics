package rigid.dynamics.constraint;
import rigid.dynamics.body.Body;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.common.MFloat;

/**
 * ...
 * @author leonaci
 */
@:expose("RHEI.CylindricalConstraint")
class CylindricalConstraint extends Constraint {
	public var n:Vec2;
	public var t:Vec2;
	public var rq1:Vec2;
	public var rq2:Vec2;
	
	var EffectiveMassT:Float;
	var relativeVelT:Float;
	var impulseT:Float;
	
	var o:Float;
	var z:Float;
	var beta:Float;
	var gamma:Float;
	
	public function new(b1:Body, b2:Body, n:Vec2) {
		this.p1 = b1.transform; this.p2 = b2.transform;
		this.relaxation = 1.0;
		this.repetition = 50;
		this.o = 1e5;
		this.z = 1.0;
		
		this.n = n/MathUtil.sqrt(n*n);
	}
	
	override public inline function presolve(dt:Float) {
		this.rq1 = new Vec2(0.0, 0.0);
		this.rq2 = new Vec2(0.0, 0.0);
		
		var d = (p1.q+rq1) - (p2.q+rq2);
		var ll = d * d;
		
		var im1 = 1/p1.m, im2 = 1/p2.m;
		
		this.t = new Vec2(-n.y, n.x);
		
		this.EffectiveMassT = 1/(im1 + im2);
		
		this.relativeVelT = (p1.p*im1-p2.p*im2)*t;
		
		this.impulseT = - (EffectiveMassT*relativeVelT);
		
		this.beta = o/(2*z+o*dt);
		this.gamma = beta/(EffectiveMassT*o*o);
	}
	
	override public inline function solveMoment() {
		var oldImpulseT = 0.0;
		for (i in 0...repetition) {
			var soft = relativeVelT + beta*(((p1.q+rq1) - (p2.q+rq2))*t) + gamma*impulseT;
			impulseT = - relaxation * soft * EffectiveMassT;
			
			var deltaImpulseT = impulseT - oldImpulseT;
			
			p1.p += deltaImpulseT * t;
			p2.p -= deltaImpulseT * t;
			
			oldImpulseT = impulseT;
		}
	}
}