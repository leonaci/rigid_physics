package rigid.dynamics.collision;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.Shape;

/**
 * Linked list of possibly-collided pairs.
 * @author leonaci
 */
class Pair {
	public var prev:Pair;
	public var next:Pair;
	
	public var s1:Shape;
	public var s2:Shape;
	
	public function new() {}
}