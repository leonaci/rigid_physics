package rigid.common;

/**
 * ...
 * @author leonaci
 */
private typedef Vec2_ = {
	x:Float,
	y:Float
};

@:expose("RHEI.Vec2")
abstract Vec2(Vec2_) from Vec2_ to Vec2_ {
	public var x(get, set):Float;
	inline function get_x():Float return this.x;
    inline function set_x(x:Float):Float return this.x = x;
	
    public var y(get, set):Float;
    inline function get_y():Float return this.y;
    inline function set_y(y:Float):Float return this.y = y;
	
	public inline function new(x:Float, y:Float) this = {x:x, y:y};
	
	public inline function init(?x:Float = 0, ?y:Float = 0) {
		this.x = x;
		this.y = y;
	}
	
	@:op(A + B)
	static public inline function add(v1:Vec2, v2:Vec2) return new Vec2(v1.x + v2.x, v1.y + v2.y);

	
	@:op(A - B)
	static public inline function sub(v1:Vec2, v2:Vec2) return new Vec2(v1.x - v2.x, v1.y - v2.y);
	
	@:op(A * B)
	@:commutative
	static public inline function scale(v:Vec2, s:Float) return new Vec2(v.x*s, v.y*s);
	
	@:op(A / B)
	static public inline function div(v:Vec2, s:Float) return new Vec2(v.x/s, v.y/s);
	
	@:op(A * B)
	static public inline function dot(v1:Vec2, v2:Vec2) return v1.x*v2.x + v1.y*v2.y;
	
	@:op(A ^ B)
	static public inline function cross(v1:Vec2, v2:Vec2) return v1.x*v2.y - v1.y*v2.x;
	
	public inline function clone() {
		return new Vec2(this.x, this.y);
	}
	
	public function toString() {
		return '[ ${this.x}, ${this.y} ]';
	}
}