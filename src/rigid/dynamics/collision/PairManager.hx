package rigid.dynamics.collision;
import haxe.ds.Option;
import rigid.dynamics.body.shape.ShapeLink;
import rigid.dynamics.collision.broadphase.AABB;
import rigid.dynamics.collision.broadphase.BroadPhase;
import rigid.dynamics.collision.broadphase.BroadPhaseKind;
import rigid.dynamics.collision.broadphase.bruteforce.BruteForceBroadPhase;
import rigid.dynamics.collision.narrowphase.NarrowPhase;

/**
 * ...
 * @author leonaci
 */
class PairManager {
	public var numContacts(default, null):Int;
	public var contacts(default, null):Contact;
	
	public var broadPhase(default, null):BroadPhase;
	public var narrowPhase(default, null):NarrowPhase;

	public function new(type:BroadPhaseKind) {
		numContacts = 0;
		
		this.broadPhase = switch(type) {
			case BroadPhaseKind.BruteForce: new BruteForceBroadPhase();
		}
		
		this.narrowPhase = new NarrowPhase();
	}
	
	@:extern
	public inline function broadJudge() {
		broadPhase.clearPairs();
		
		//collect possibly-collided pairs
		broadPhase.updatePairs();
		
		//create contacts
		var pair:Pair = broadPhase.pairs;
		while(pair != null) {
			var nextPair = pair.next;
			createContact(pair);
			pair = nextPair;
		}
	}
	
	@:extern
	public inline function narrowJudge() {
		var contact:Contact = contacts;
		while (contact != null) {
			var nextContact = contact.next; // elements of `contacts` are maybe removed.
			
			var touching = contact.newContact || overlap(contact.s1.aabb, contact.s2.aabb);
			// update collision data : destroy seperated pairs
			touching? narrowPhase.detect(contact) : removeContact(contact);
			contact.newContact = false;
			
			contact = nextContact;
		}
	}
	
	private inline function overlap(aabb1:AABB, aabb2:AABB) {
		return aabb1.minX < aabb2.maxX
			&& aabb2.minX < aabb1.maxX
			&& aabb1.minY < aabb2.maxY
			&& aabb2.minY < aabb1.maxY;
	}
	
	@:extern
	private inline function createContact(pair:Pair):Void {
		var found = false;
		
		//looking for duplicated pairs...
		var shapeLink:ShapeLink = pair.s1.shapeLinks;
		while (shapeLink != null) {
			var nextShapeLink = shapeLink.next;
			if (shapeLink.theOtherShape == pair.s2) found = true;
			shapeLink = nextShapeLink;
		}
		
		if (!found) {
			var contact = new Contact();
			contact.newContact = true;
			contact.s1 = pair.s1;
			contact.s2 = pair.s2;
			addContact(contact);
			contact.attach();
		}
	}
	
	@:extern
	private inline function addContact(c:Contact) {
		if (contacts == null) contacts = c;
		else {
			contacts.prev = c;
			c.next = contacts;
			contacts = c;
		}
		numContacts++;
	}
	
	@:extern
	public inline function removeContact(c:Contact) {
		c.detach();
		if (c.prev != null) c.prev.next = c.next;
		if (c.next != null) c.next.prev = c.prev;
		if (c == contacts) contacts = c.next;
		c.next = null;
		c.prev = null;
		c.constraint = null;
		numContacts--;
	}
}




