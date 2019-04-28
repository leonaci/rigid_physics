package rigid.dynamics.collision.narrowphase;
import haxe.ds.Option;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.body.shape.ShapeKind;

/**
 * ...
 * @author leonaci
 */
class NarrowPhase {
	private var detector:Detector;
	
	private var sphereSphereDetector:SphereSphereDetector;
	
	public function new() {
		detector = new Detector();
		
		sphereSphereDetector = new SphereSphereDetector();
	}
	
	private inline function chooseDetector(s1:Shape, s2:Shape):Void {
		detector.impl = switch[s1.kind, s2.kind] {
			case [ShapeKind.Sphere, ShapeKind.Sphere]: sphereSphereDetector;
		}
	}
	
	public inline function detect(contact:Contact):Void {
		// judge whether a collision occurs, and if so, generate a constraint.
		chooseDetector(contact.s1, contact.s2);
		switch[contact.s1.assigned, contact.s2.assigned] {
			case [Option.Some(b1), Option.Some(b2)]:
				contact.constraint = detector.detect(b1, b2);
			case [_, _]:
				throw 'Any body does not be assigned.';
		}
	}
}