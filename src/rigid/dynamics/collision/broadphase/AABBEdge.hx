package rigid.dynamics.collision.broadphase;

/**
 * ...
 * @author leonaci
 */
@:forward(aabb, pos, theOther, id, entry)
abstract AABBEdge({aabb:AABB, pos:Float, entry:Bool, ?id:Int}) {
    public inline function new(aabb:AABB, pos:Float, entry:Bool) {
        this = {
            aabb: aabb,
            pos: pos,
            entry: entry,
        }
    }
}
