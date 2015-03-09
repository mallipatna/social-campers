package nandini.fb.project1.datastore.model;

import java.util.Collections;
import java.util.List;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

/**
 * The datastore campground entity model.
 * 
 * @author nandinivishwas
 */
@PersistenceCapable(table = "campground")
public class Campground {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key id;

	@Persistent
	private String name;

	@Persistent
	private int campsites;

	@Persistent(column = "dog_friendly")
	private Boolean dogFriendly;

	@Persistent
	private Boolean shower;

	@Persistent
	private String bathrooms;

	@Persistent(column = "rv_hookup")
	private Boolean rvHookup;

	@Persistent(defaultFetchGroup = "true")
	private List<Review> reviews;

	public Key getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCampsites() {
		return campsites;
	}

	public void setCampsites(int campsites) {
		this.campsites = campsites;
	}

	public Boolean getDogFriendly() {
		return dogFriendly;
	}

	public void setDogFriendly(Boolean dogFriendly) {
		this.dogFriendly = dogFriendly;
	}

	public int getRating() {
		if (reviews == null) {
			return 0;
		} else {
			int totalRating = 0;
			for (Review review : reviews) {
				totalRating += review.getRating();
			}
			return (int) ((double) totalRating / reviews.size());
		}
	}

	public Boolean getShower() {
		return shower;
	}

	public void setShower(Boolean shower) {
		this.shower = shower;
	}

	public String getBathrooms() {
		return bathrooms;
	}

	public void setBathrooms(String bathrooms) {
		this.bathrooms = bathrooms;
	}

	public Boolean getRvHookup() {
		return rvHookup;
	}

	public void setRvHookup(Boolean rvHookup) {
		this.rvHookup = rvHookup;
	}

	public List<Review> getReviews() {
		if (reviews != null) {
			Collections.sort(reviews);
		}
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

}
