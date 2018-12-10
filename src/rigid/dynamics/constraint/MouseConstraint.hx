package rigid.dynamics.constraint;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.Transform;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.common.MFloat;

/**
 * ...
 * @author leonaci
 */

@:expose("RHEI.MouseConstraint")
class MouseConstraint extends Constraint {
	public var n:Vec2;
	public var rq1:Vec2;
	public var rq2:Vec2;
	
	var distance:Float;
	var EffectiveMassN:Float;
	var relativeVelN:Float;
	var impulseN:Float;
	var soft:Float;
	var o:Float;
	var z:Float;
	var beta:Float;
	var gamma:Float;
	
	public function new(b:Body, p:Vec2) {
		var a = new Transform();
		a.q = p;
		
		this.p1 = b.transform; this.p2 = a;
		
		this.relaxation = 1.0;
		this.repetition = 2;
		this.o = 10.0;
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
			soft = relativeVelN + beta*((((p1.q+rq1) - (p2.q+rq2))*n) - distance) + gamma*impulseN;
			impulseN = - relaxation * soft * EffectiveMassN;
			
			var deltaImpulseN = impulseN - oldImpulseN;
			
			p1.p  += deltaImpulseN * 	  n;
			p1.pa += deltaImpulseN * (rq1^n);
			
			oldImpulseN = impulseN;
		}
	}
}