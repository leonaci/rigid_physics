package rigid.dynamics.constraint;
import rigid.dynamics.body.Transform;

/**
 * ...
 * @author leonaci
 */
@:expose("RHEI.Constraint")
class Constraint {
	public var p1:Transform;
	public var p2:Transform;
	
	public var relaxation:Float;
	public var repetition:Int;
	
	public function presolve(dt:Float) throw 'Not Implemented.';
	public function solveMoment() throw 'Not Implemented.';
}