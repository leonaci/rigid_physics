package rigid.dynamics.collision.broadphase.sweepandprune;

/**
 * ...
 * @author leonaci
 */
@:forward(length, iterator)
abstract AABBEdgeList(Array<AABBEdge>) to Array<AABBEdge> {
	static private var UID:Int = 0;
	
	public inline function new() this = [];
	
	public inline function insert(edge:AABBEdge):Void {
		edge.id = this.length;
		this.push(edge);
	}
	
	public inline function remove(edge:AABBEdge):Void {
		(this[edge.id] = this.pop()).id = edge.id;
		edge.id = null;
	}
	
	// insertion sort
	public function sort():Void {
		var c = 0;
		for (i in 1...this.length) {
			var tmp = this[i];
			if (this[i - 1].pos > tmp.pos) {
				var j = i;
				do {
					this[j] = this[--j];
					c++;
				}
				while (j > 0 && this[j - 1].pos > tmp.pos);
				this[j] = tmp;
			}
		}
		trace(c);
	}
}