package rigid.dynamics.collision;
import rigid.dynamics.collision.narrowphase.Detector;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * @author leonaci
 */
enum Contact {
	YET(detector:Detector);
	TRUE(contactConstraint:ContactConstraint);
	FALSE;
}