package rigid.dynamics.constraint;
import rigid.dynamics.body.Body;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.common.MFloat;

/**
 * ...
 * @author leonaci
 */
@:expose("RHEI.ContactConstraint")
class ContactConstraint extends Constraint {
	public var n:Vec2;
	public var t:Vec2;
	public var rq1:Vec2;
	public var rq2:Vec2;
	public var penetration:Float;
	
	var friction:Float;
	var restitution:Float;
	var threshold:Float;
	
	var EffectiveMassN:Float;
	var EffectiveMassT:Float;
	var EffectiveIMass:Float;
	
	var relativeVelN:Float;
	var relativeVelT:Float;
	
	var impulseN:Float;
	var impulseT:Float;
	
	public function new(b1:Body, b2:Body) {
		this.p1 = b1.transform; this.p2 = b2.transform;
		this.relaxation = 1.0;
		this.repetition = 2;
	}
	
	override public inline function presolve(dt:Float) {
		this.t = new Vec2(-n.y, n.x);
		
		this.friction = 0.1;
		this.restitution = 0.5;
		this.threshold = 0.2;
		
		var im1 = 1/p1.m, im2 = 1/p2.m, ii1 = 1/p1.i, ii2 = 1/p2.i;
		this.EffectiveMassN = im1!=0.0&&im2!=0.0? 1/(im1 + im2 + (rq1^n)*(rq1^n)*ii1 + (rq2^n)*(rq2^n)*ii2) : 0.0;
		this.EffectiveMassT = im1!=0.0&&im2!=0.0? 1/(im1 + im2 + (rq1^t)*(rq1^t)*ii1 + (rq2^t)*(rq2^t)*ii2) : 0.0;
		this.EffectiveIMass = (rq1^n)*(rq1^t)*ii1 + (rq2^n)*(rq2^t)*ii2;
		
		this.relativeVelN = (p1.p*im1 - p2.p*im2)*n + ((p1.pa*rq1*ii1 - p2.pa*rq2*ii2)^n);
		this.relativeVelT = (p1.p*im1 - p2.p*im2)*t + ((p1.pa*rq1*ii1 - p2.pa*rq2*ii2)^t);
		
		this.impulseN = EffectiveMassN*relativeVelN;
		this.impulseT = EffectiveMassT*relativeVelT;
	}

	//Projected Gauss-Seidel method
	override public inline function solveMoment() {
		var oldImpulseN = 0.0, oldImpulseT = 0.0;
		for(i in 0...repetition) {
			var e = -relativeVelN>threshold? restitution : 0;
			impulseN = - relaxation * ( EffectiveIMass * impulseT + (1+e) * relativeVelN) * EffectiveMassN;
			impulseN = MathUtil.max(impulseN, 0.0);
			
			impulseT = - relaxation * ( EffectiveIMass * impulseN + relativeVelT ) * EffectiveMassT;
			impulseT = MathUtil.clamp(impulseT, -friction*impulseN, friction*impulseN);
			
			var deltaImpulseN = impulseN - oldImpulseN, deltaImpulseT = impulseT - oldImpulseT;
			
			p1.p  += deltaImpulseN * 	  n  + deltaImpulseT * 		t;
			p1.pa += deltaImpulseN * (rq1^n) + deltaImpulseT * (rq1^t);
			p2.p  -= deltaImpulseN * 	  n  + deltaImpulseT * 		t;
			p2.pa -= deltaImpulseN * (rq2^n) + deltaImpulseT * (rq2^t);
			
			oldImpulseN = impulseN; oldImpulseT = impulseT;
		}
		
		//trace(p1.p + ',' + p1.ap);
		//trace('');
	}
}