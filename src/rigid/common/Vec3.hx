package rigid.common;

/**
 * ...
 * @author leonaci
 */
private typedef Vec3_ = {
	x:Float,
	y:Float,
	z:Float,
};

@:expose("RHEI.Vec3")
abstract Vec3(Vec3_) from Vec3_ to Vec3_ {
	public var x(get, set):Float;
	inline function get_x():Float return this.x;
    inline function set_x(x:Float):Float return this.x = x;
	
    public var y(get, set):Float;
    inline function get_y():Float return this.y;
    inline function set_y(y:Float):Float return this.y = y;
	
    public var z(get, set):Float;
    inline function get_z():Float return this.z;
    inline function set_z(z:Float):Float return this.z = z;
	
	public inline function new(x:Float, y:Float, z:Float) this = {x:x, y:y, z:z};
	
	public inline function init(?x:Float = 0, ?y:Float = 0, ?z:Float = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	@:op(A + B)
	static public inline function add(v1:Vec3, v2:Vec3):Vec3 return new Vec3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);

	
	@:op(A - B)
	static public inline function sub(v1:Vec3, v2:Vec3):Vec3 return new Vec3(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
	
	@:op(A * B)
	@:commutative
	static public inline function scale(v:Vec3, s:Float):Vec3 return new Vec3(v.x*s, v.y*s, v.z*s);
	
	@:op(A / B)
	static public inline function div(v:Vec3, s:Float):Vec3 return new Vec3(v.x/s, v.y/s, v.z/s);
	
	@:op(A * B)
	static public inline function dot(v1:Vec3, v2:Vec3):Float return v1.x*v2.x + v1.y*v2.y + v1.z*v2.z;
	
	@:op(A ^ B)
	static public inline function cross(v1:Vec3, v2:Vec3):Vec3 return new Vec3(v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x);
	
	public inline function clone():Vec3 {
		return new Vec3(this.x, this.y, this.z);
	}
	
	public function toString():String {
		return '[ ${this.x}, ${this.y} ]';
	}
}