package rigid.dynamics.collision.broadphase.sweepandprune;

/**
 * ...
 * @author leonaci
 */
@:forward(length, iterator)
abstract AABBEdgeList(Array<AABBEdge>) to Array<AABBEdge> {
	public inline function new() this = [];
	
	public inline function push(edge:AABBEdge):Void {
		edge.id = this.length;
		this.push(edge);
	}
	
	public inline function remove(edge:AABBEdge):Void {
		(this[edge.id] = this.pop()).id = edge.id;
		edge.id = null;
	}
	
	// insertion sort
	public function sort():Void {
		for (i in 1...this.length) {
			var tmp = this[i];
			if (this[i - 1].pos > tmp.pos) {
				var j = i;
				do this[j] = this[--j]
				while (j > 0 && this[j - 1].pos > tmp.pos);
				this[j] = tmp;
			}
		}
	}
}