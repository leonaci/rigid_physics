package rigid.common;

/**
 * ...
 * @author leonaci
 */
abstract MFloat(Float) from Float to Float {
	inline function new(f:Float) this = f;
	
	@:op(A + B)
	@:commutative
	static public inline function add(a:MFloat, b:Float):MFloat {
		var a_:Float = a;
		return a_ + b;
	}
	
	@:op(A - B)
	static public inline function sub(a:MFloat, b:Float):MFloat {
		var a_:Float = a;
		return a_ - b;
	}
	
	@:op(A * B)
	@:commutative
	static public inline function mul(a:MFloat, b:Float):MFloat {
		var a_:Float = a;
		return a_ * b;
	}
	
	@:op(A / B)
	static public inline function div(a:Float, b:MFloat):MFloat {
		var b_:Float = b;
		return a * (b_==0? 0 : 1 / b_);
	}
}