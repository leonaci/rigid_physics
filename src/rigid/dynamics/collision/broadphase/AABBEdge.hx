package rigid.dynamics.collision.broadphase;

/**
 * ...
 * @author leonaci
 */
@:forward(aabb, pos, theOther, id, entry)
abstract AABBEdge({aabb:AABB, pos:Float, entry:Bool, ?theOther:AABBEdge, ?id:Int}) {
    public var theOther(get, set):AABBEdge;
    inline function get_theOther():AABBEdge return this.theOther;
    @:allow(rigid.dynamics.collision.broadphase.AABB)
    inline function set_theOther(theOther:AABBEdge):AABBEdge return this.theOther = theOther;
    
    public inline function new(aabb:AABB, pos:Float, entry:Bool) {
        this = {
            aabb: aabb,
            pos: pos,
            entry: entry,
        }
    }
}
