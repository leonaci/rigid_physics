package rigid.dynamics;
import haxe.ds.List;
import rigid.common.Constant;
import rigid.common.Vec2;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Contact;
import rigid.dynamics.collision.PairManager;
import rigid.dynamics.collision.broadphase.BroadPhaseKind;
import rigid.dynamics.constraint.Constraint;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * ...
 * @author leonaci
 */
@:expose("RHEI.World")
class World {
	public var underGravity:Bool;
	public var bodies(default, null):List<Body>;
	public var constraints(default, null):Array<Constraint>;
	
	private var pairManager:PairManager;
	
	public function new() {
		this.underGravity = true;
		this.bodies = new List();
		this.constraints = [];
		this.pairManager = new PairManager(BroadPhaseKind.BruteForce);
	}
	
	public function addBody(body:Body) {
		bodies.push(body);
		pairManager.broadPhase.addBody(body);
	}
	
	public function removeBody(body:Body) {
		bodies.remove(body);
		pairManager.broadPhase.removeBody(body);
	}
	
	public function addConstraint(constraint:Constraint) {
		constraints.push(constraint);
	}
	
	public function removeConstraint(constraint:Constraint) {
		constraints.remove(constraint);
	}
	
	public function step(dt:Float) {
		detectConstraints();
		solveConstraints(dt);
		integrate(dt);
	}

	@:extern
	private inline function detectConstraints() {
		//broad phase collision judgement
		pairManager.broadJudge();
		
		//narrow phase collision judgement
		pairManager.narrowJudge();
		
		//update constraints
		for (p in pairManager.pairs.copy()) {
			switch(p:Contact) {
				case Contact.TRUE(cc): constraints.push(cc);
				case Contact.FALSE:
				case Contact.YET(_): throw 'Not Yet Judged.';
			}
			pairManager.removePair(p);
		}
	}
	
	@:extern
	private inline function solveConstraints(dt:Float) {
		for(c in constraints) c.presolve(dt);
		for(c in constraints) c.solveMoment();
		removeContacts();
	}
	
	@:extern
	private inline function integrate(dt:Float) {
		for (b in bodies) {
			if (underGravity) b.v += new Vec2(Constant.GRAVITY_X, Constant.GRAVITY_Y);
			b.integrate(dt);
			b.sync();
		}
	}
	
	private inline function removeContacts() {
		for(c in constraints) if(Std.is(c, ContactConstraint)) this.removeConstraint(c);
	}
}