package rigid.dynamics;
import haxe.ds.List;
import haxe.ds.Option;
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
	
	public var numBodies(default, null):Int;
	public var bodies(default, null):Body;
	
	public var constraints(default, null):Array<Constraint>;
	
	private var pairManager:PairManager;
	
	public function new() {
		this.constraints = [];
		this.pairManager = new PairManager(BroadPhaseKind.SweepAndPrune);
	}
	
	public function addBody(body:Body) {
		if (bodies == null) bodies = body;
		else {
			bodies.prev = body;
			body.next = bodies;
			bodies = body;
		}
		numBodies++;
		pairManager.broadPhase.addBody(bodies);
	}
	
	public function removeBody(body:Body) {
		if (body.prev != null) body.prev.next = body.next;
		if (body.next != null) body.next.prev = body.prev;
		if (body == bodies) bodies = body.next;
		body.prev = null;
		body.next = null;
		numBodies--;
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
		if(underGravity) integrateGravity();
		integrate(dt);
	}

	@:extern
	private inline function detectConstraints() {
		//broad phase collision judgement
		pairManager.broadJudge();
		
		//narrow phase collision judgement
		pairManager.narrowJudge();
		
		//remove old contacts
		removeContacts();
		
		//update contacts
		var contact:Contact = pairManager.contacts;
		while (contact != null) {
			var nextContact = contact.next;
			
			switch(contact.constraint) {
				case Option.Some(cc): constraints.push(cc);
				case Option.None:
			}
			
			contact = nextContact;
		}
	}
	
	@:extern
	private inline function solveConstraints(dt:Float) {
		for(c in constraints) c.presolve(dt);
		for(c in constraints) c.solveMoment();
	}
	
	@:extern
	private inline function integrateGravity() {
		var body = bodies;
		while (body != null) {
			if (body.state == BodyState.Dynamic) body.v += new Vec2(Constant.GRAVITY_X, Constant.GRAVITY_Y);
			body = body.next;
		}
	}
	
	@:extern
	private inline function integrate(dt:Float) {
		var body = bodies;
		while (body != null) {
			body.integrate(dt);
			body.sync();
			body = body.next;
		}
	}
	
	private inline function removeContacts() {
		for(c in constraints) if(Std.is(c, ContactConstraint)) this.removeConstraint(c);
	}
}