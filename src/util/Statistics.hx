package util;
import rigid.dynamics.World;

/**
 * ...
 * @author leonaci
 */
@:expose('RHEI.Statistics')
class Statistics
{
	public static var broadphaseProcessElapsedTime:Float;
	public static var narrowphaseProcessElapsedTime:Float;
	public static var resolutionProcessElapsedTime:Float;
	public static var integrationProcessElapsedTime:Float;
	public static var totalElapsedTime:Float;
	public static var renderingElapsedTime:Float;
}