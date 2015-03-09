package nandini.fb.project1.datastore;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import nandini.fb.project1.datastore.model.Campground;
import nandini.fb.project1.datastore.model.Park;
import nandini.fb.project1.datastore.model.Review;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

/**
 * This class contains helper methods to retrieve information from Google App
 * Engine Datastore.
 * 
 * @author nandinivishwas
 */
public class DataRetriever {

	/**
	 * Gets list of parks from the datastore.
	 */
	public static List<Park> listParks() {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Query query = pm.newQuery(Park.class);
			List<Park> newList = new ArrayList<>();
			@SuppressWarnings("unchecked")
			List<Park> queryList = (List<Park>) query.execute();
			for (Park t : queryList) {
				newList.add(t);
			}
			query.closeAll();
			return newList;
		} finally {
			pm.close();
		}
	}

	/**
	 * Gets the park information and associated campgrounds for the park from
	 * the datastore.
	 */
	public static Park displayPark(String parkId) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Key key = KeyFactory.createKey("park", Long.parseLong(parkId));
			Park park = pm.getObjectById(Park.class, key);
			if (park.getCampgrounds() == null) {
				park.setCampgrounds(new ArrayList<Campground>());
			} else {
				fetchCampgrounds(park.getCampgrounds());
			}
			return park;
		} finally {
			pm.close();
		}
	}

	/**
	 * Gets the campground information and associated reviews for the campground
	 * from the datastore.
	 */
	public static Campground displayCampground(String campgroundId) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Key key = KeyFactory.stringToKey(campgroundId);
			Campground campground = pm.getObjectById(Campground.class, key);
			if (campground.getReviews() == null) {
				campground.setReviews(new ArrayList<Review>());
			} else {
				fetchReviews(campground.getReviews());
			}
			return campground;
		} finally {
			pm.close();
		}
	}

	private static void fetchCampgrounds(List<Campground> campgrounds) {
		if (campgrounds == null) {
			return;
		}
		for (Campground campground : campgrounds) {
			campground.getBathrooms();
			campground.getCampsites();
			campground.getId();
			campground.getName();
			campground.getRating();
			campground.getDogFriendly();
			campground.getRvHookup();
			campground.getShower();
			fetchReviews(campground.getReviews());
		}
	}

	private static void fetchReviews(List<Review> reviews) {
		if (reviews == null) {
			return;
		}
		for (Review review : reviews) {
			review.getDate();
			review.getId();
			review.getRating();
			review.getReview();
			review.getUserId();
		}
	}

}
