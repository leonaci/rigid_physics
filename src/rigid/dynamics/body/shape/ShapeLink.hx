package rigid.dynamics.body.shape;
import rigid.dynamics.collision.Contact;

/**
 * ...
 * @author leonaci
 */
class ShapeLink {
	public var prev:ShapeLink;
	public var next:ShapeLink;
	
	public var theOtherShape:Shape;
	
	public function new() {}
	
	public function attach(to:Shape):Void {
		if (to.shapeLinks == null) to.shapeLinks = this;
		else {
			to.shapeLinks.prev = this;
			this.next = to.shapeLinks;
			to.shapeLinks = this;
		}
	}
	
	public function detach(from:Shape) {
		if (this.prev != null) this.prev.next = this.next;
		if (this.next != null) this.next.prev = this.prev;
		if (this == from.shapeLinks) from.shapeLinks = this.next;
		prev = null;
		next = null;
	}

}