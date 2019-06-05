package util;
import haxe.macro.Expr;

/**
 * ...
 * @author leonaci
 */
class Util
{
	public static macro function profile(result:Expr, main:Expr) {
		return macro {
			#if js
				var a:Float = js.Browser.window.performance.now() / 1000;
			#else
				var a:Float = haxe.Timer.stamp();
			#end
			$main;
			#if js
				var b:Float = js.Browser.window.performance.now() / 1000;
			#else
				var b:Float = haxe.Timer.stamp();
			#end
			$result = (b - a) * 1000;
		};
	}	
}