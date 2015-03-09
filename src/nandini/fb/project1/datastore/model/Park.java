package nandini.fb.project1.datastore.model;

import java.util.List;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

/**
 * The datastore park entity model.
 * 
 * @author nandinivishwas
 */
@PersistenceCapable(table = "park")
public class Park {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key id;

	@Persistent
	private String name;

	@Persistent
	private String location;

	@Persistent(column = "image_location")
	private String imageLocation;

	@Persistent(column = "best_time_to_visit")
	private String bestTimeToVisit;

	@Persistent(column = "things_to_do")
	private String thingsToDo;

	@Persistent(defaultFetchGroup = "true")
	private List<Campground> campgrounds;

	public Key getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getImageLocation() {
		return imageLocation;
	}

	public void setImageLocation(String imageLocation) {
		this.imageLocation = imageLocation;
	}

	public String getBestTimeToVisit() {
		return bestTimeToVisit;
	}

	public void setBestTimeToVisit(String bestTimeToVisit) {
		this.bestTimeToVisit = bestTimeToVisit;
	}

	public String getThingsToDo() {
		return thingsToDo;
	}

	public void setThingsToDo(String thingsToDo) {
		this.thingsToDo = thingsToDo;
	}

	public List<Campground> getCampgrounds() {
		return campgrounds;
	}

	public void setCampgrounds(List<Campground> campgrounds) {
		this.campgrounds = campgrounds;
	}

}
