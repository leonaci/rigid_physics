package rigid.dynamics.collision;

/**
 * ...
 * @author leonaci
 */
abstract Pair(Contact) to Contact {
	inline function new(c:Contact) this = c;
	
	@:from
	static public inline function from(c:Contact) return new Pair(c);
	
	public inline function detach() this = null;
	
	public inline function updateContact() {
		// judge whether a collision occurs, and if so, generate a constraint.
		this = switch(this) {
			case Contact.YET(detector): detector.detect();
			case _: throw 'Already Judged.';
		}
	}
}