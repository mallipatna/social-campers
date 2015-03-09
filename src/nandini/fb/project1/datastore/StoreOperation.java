package nandini.fb.project1.datastore;

import javax.jdo.PersistenceManager;

import nandini.fb.project1.datastore.model.Campground;
import nandini.fb.project1.datastore.model.Park;
import nandini.fb.project1.datastore.model.Review;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

/**
 * This class contains helper methods to store data entity into Google App Engine Datastore.
 * 
 * @author nandinivishwas
 */
public class StoreOperation {

	/**
	 * Creates a new park record in datastore.
	 */
	public static void insertPark(Park park) {
		// Insert property values into park entity
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(park);
		} finally {
			pm.close();
		}
	}

	/**
	 * Creates a new campground entity in datastore for the park.
	 */
	public static void insertCampground(Campground campground, Long parkId) {
		// Insert campground entity property values which belongs to a pre defined park entity
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Park park = pm.getObjectById(Park.class, parkId);
			park.getCampgrounds().add(campground);
			pm.makePersistent(park);
		} finally {
			pm.close();
		}
	}

	/**
	 * Creates a new review entity for the campground.
	 */
	public static void insertReview(Review review, String campgroundId) {
		//Insert review entity property values which belongs to a pre defined campground entity
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Key key = KeyFactory.stringToKey(campgroundId);
			Campground campground = pm.getObjectById(Campground.class, key);
			campground.getReviews().add(review);
			pm.makePersistent(campground);
		} finally {
			pm.close();
		}
	}

}
