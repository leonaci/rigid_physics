package rigid.dynamics.collision;
import haxe.ds.Option;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.body.shape.ShapeLink;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * Linked list of collided pairs.
 * @author leonaci
 */
class Contact {
	public var prev:Contact;
	public var next:Contact;
	
	public var s1:Shape;
	public var s2:Shape;
	public var constraint:Option<ContactConstraint>;
	
	private var link1:ShapeLink;
	private var link2:ShapeLink;
	
	public var newContact:Bool;
	
	public function new() {
		constraint = Option.None;
		link1 = new ShapeLink();
		link2 = new ShapeLink();
	}
	
	public function attach():Void {
		link1.attach(s1);
		link2.attach(s2);
		link1.theOtherShape = s2;
		link2.theOtherShape = s1;
	}
	
	public function detach():Void {
		link1.detach(s1);
		link2.detach(s2);
		link1.theOtherShape = null;
		link2.theOtherShape = null;
	}
}