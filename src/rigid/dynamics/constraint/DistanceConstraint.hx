package rigid.dynamics.constraint;
import rigid.dynamics.body.Body;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.common.MFloat;

/**
 * ...
 * @author leonaci
 */

@:expose("RHEI.DistanceConstraint")
class DistanceConstraint extends Constraint {
	public var n:Vec2;
	public var rq1:Vec2;
	public var rq2:Vec2;
	
	var distance:Float;
	var EffectiveMassN:Float;
	var relativeVelN:Float;
	var impulseN:Float;
	
	var o:Float;
	var z:Float;
	var beta:Float;
	var gamma:Float;
	
	public function new(b1:Body, b2:Body) {
		this.p1 = b1.transform; this.p2 = b2.transform;
		this.relaxation = 1.0;
		this.repetition = 50;
		this.o = 100.0;
		this.z = 1.0;
		
		var d = p1.q - p2.q;
		this.distance = MathUtil.sqrt(d*d);
	}
	
	override public inline function presolve(dt:Float) {
		this.rq1 = new Vec2(0.0, 0.0);
		this.rq2 = new Vec2(0.0, 0.0);
		
		var d = (p1.q+rq1) - (p2.q+rq2);
		var ll = d * d;
		
		var im1 = 1/p1.m, im2 = 1/p2.m;
		
		this.n = d*(1/MathUtil.sqrt(ll));
		
		this.EffectiveMassN = 1/(im1 + im2);
		
		this.relativeVelN = (p1.p*im1 - p2.p*im2)*n;
		
		this.impulseN = - EffectiveMassN*relativeVelN;
		
		this.beta = o/(2*z+o*dt);
		this.gamma = beta/(EffectiveMassN*o*o);
	}
	
	override public inline function solveMoment() {
		var oldImpulseN = 0.0;
		for (i in 0...repetition) {
			var soft = relativeVelN + beta*((((p1.q+rq1) - (p2.q+rq2))*n) - distance) + gamma*impulseN;
			impulseN = - relaxation * soft * EffectiveMassN;
			
			var deltaImpulseN = impulseN - oldImpulseN;
			
			p1.p += deltaImpulseN * n;
			p2.p -= deltaImpulseN * n;
			
			oldImpulseN = impulseN;
		}
	}
}