package rigid.dynamics.body;
import rigid.common.Vec2;
import rigid.common.MFloat;

/**
 * All physical parameters that characterize the physical state of the rigid body.
 * @author leonaci
 */
class Transform {
	public var q:Vec2; //linear position
	public var qa:Float; //linear angular position
	
	public var p:Vec2; //linear momentum
	public var pa:Float; //linear angular momentum
	
	public var m:MFloat; //mass
	public var i:MFloat; //inertia
	
	public function new() {
		q = new Vec2(0.0, 0.0);
		qa = 0.0;
		p = new Vec2(0.0, 0.0);
		pa = 0.0;
		m = 0.0;
		i = 0.0;
	}
	
}