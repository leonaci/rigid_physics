package rigid.dynamics.collision.broadphase.sweepandprune;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Contact;
import rigid.dynamics.collision.broadphase.BroadPhase;
import rigid.dynamics.collision.narrowphase.Detector;

/**
 * ...
 * @author leonaci
 */
class SweepAndPruneBroadPhase extends BroadPhase
{
	private var axisX:AABBEdgeList;
	private var axisY:AABBEdgeList;
	private var activeAABBs:Array<AABB>;

	public function new() 
	{
		super();
		
		axisX = new AABBEdgeList();
		axisY = new AABBEdgeList();
		activeAABBs = [];
	}
	
	override public function addBody(body:Body) {
		super.addBody(body);
		axisX.insert(body.aabb.edgeMinX);
		axisY.insert(body.aabb.edgeMinY);
		axisX.insert(body.aabb.edgeMaxX);
		axisY.insert(body.aabb.edgeMaxY);
	}
	
	override public function removeBody(body:Body) {
		super.removeBody(body);
		axisX.remove(body.aabb.edgeMinX);
		axisY.remove(body.aabb.edgeMinY);
		axisX.remove(body.aabb.edgeMaxX);
		axisY.remove(body.aabb.edgeMaxY);
	}
	
	override public function updatePairs():Void {
		var axis:AABBEdgeList = selectAxis();
		
		activeAABBs[0] = axis[0].aabb;
		for (i in 1...axis.length) {
			var aabb1:AABB = axis[i].aabb;
			if (axis[i].entry) {
				for (aabb2 in activeAABBs) {
					if (overlap(aabb1, aabb2)) {
						var pair = new Pair();
						pair.s1 = aabb1.shape;
						pair.s2 = aabb2.shape;
						addPair(pair);
					}
				}
				activeAABBs.push(aabb1);
			}
			else activeAABBs.remove(aabb1);
		}
	}
	
	private inline function selectAxis():AABBEdgeList {
		var sumX = 0;
		var ptX = 0;
		
		axisX.sort();
		for (e in axisX.iterator()) {
			switch(e.entry) {
				case true:
				{
					sumX += ptX;
					ptX++;
				}
				case false: ptX--;
			}
		}
		
		var sumY = 0;
		var ptY = 0;
		
		axisY.sort();
		for (e in axisY.iterator()) {
			switch(e.entry) {
				case true: 
				{
					sumY += ptY;
					ptY++;
				}
				case false: ptY--;
			}
		}
		
		return sumX < sumY? axisX: axisY;
	}
}