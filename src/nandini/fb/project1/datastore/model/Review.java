package nandini.fb.project1.datastore.model;

import java.util.Comparator;
import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

/**
 * The datastore review entity model.
 * 
 * @author nandinivishwas
 */
@PersistenceCapable(table = "review")
public class Review implements Comparator<Review>, Comparable<Review> {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key id;

	@Persistent
	private String review;

	@Persistent
	private int rating;

	@Persistent(column = "user_id")
	private String userId;

	@Persistent(serialized = "true")
	private Date date;

	public Key getId() {
		return id;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Override
	public int compare(Review o1, Review o2) {
		if (o1 == null || o2 == null) {
			return 0;
		}
		if (o1.date == null) {
			return -1;
		}
		if (o2.date == null) {
			return 1;
		}
		return o1.date.after(o2.date) ? -1 : 1;
	}

	@Override
	public int compareTo(Review o) {
		return this.date.after(o.getDate()) ? -1 : 1;
	}

}
