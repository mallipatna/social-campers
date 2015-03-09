package nandini.fb.project1.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nandini.fb.project1.datastore.StoreOperation;
import nandini.fb.project1.datastore.model.Campground;
import nandini.fb.project1.datastore.model.Park;

/**
 * Fetches the user entered data from the web page for park and creates a
 * datastore entity.
 * 
 * @author nandinivishwas
 */
public class CreateParkServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			// Get parameter values from create_park.html
			String name = req.getParameter("name");
			String location = req.getParameter("location");
			String visit = req.getParameter("visit");
			String todo = req.getParameter("todo");
			String imageLocation = req.getParameter("image_location");
			// Create an object of type park and set values
			Park park = new Park();
			park.setName(name);
			park.setLocation(location);
			park.setBestTimeToVisit(visit);
			park.setThingsToDo(todo);
			park.setImageLocation(imageLocation);
			park.setCampgrounds(new ArrayList<Campground>());
			// Call insertPark method to insert the above set values to the park
			// entity
			StoreOperation.insertPark(park);
			res.sendRedirect("create_park.jsp?access_token=" + req.getParameter("access_token"));
		} catch (Throwable t) {
			t.printStackTrace(res.getWriter());
		}
	}
}
