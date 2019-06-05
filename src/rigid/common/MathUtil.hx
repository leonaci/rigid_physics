package rigid.common;

/**
 * ...
 * @author leonaci
 */

@:expose("RHEI.MathUtil")
class MathUtil {
	static public inline var PI = 3.14159265358979;
	
	static public inline function sin(v:Float) return Math.sin(v);
	
	static public inline function cos(v:Float) return Math.cos(v);
	
	static public inline function tan(v:Float) return Math.tan(v);
	
	static public inline function asin(v:Float) return Math.asin(v);
	
	static public inline function acos(v:Float) return Math.acos(v);
	
	static public inline function atan(v:Float) return Math.atan(v);
	
	static public inline function atan2(y:Float, x:Float) return Math.atan2(y, x);
	
	static public inline function abs(v:Float) return Math.abs(v);
	
	static public inline function sqrt(v:Float) return Math.sqrt(v);
	
	static public inline function max(a:Float, b:Float) return Math.max(a, b);
	
	static public inline function min(a:Float, b:Float) return Math.min(a, b);
	
	static public inline function clamp(v:Float, min:Float, max:Float) return Math.min(Math.max(v, min),max);
	
	static public inline function rnd() return Math.random();
	
}