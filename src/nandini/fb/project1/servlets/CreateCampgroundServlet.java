package nandini.fb.project1.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nandini.fb.project1.datastore.StoreOperation;
import nandini.fb.project1.datastore.model.Campground;
import nandini.fb.project1.datastore.model.Review;

/**
 * Fetches the user entered data from the web page for campground and creates a
 * datastore entity.
 * 
 * @author nandinivishwas
 */
public class CreateCampgroundServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			// Get parameter values from create_campground.jsp
			String cname = req.getParameter("cname");
			Integer nofc = Integer.parseInt(req.getParameter("nofc"));
			String bathroom = req.getParameter("bathroom");
			Boolean df = Boolean.parseBoolean(req.getParameter("df"));
			Boolean shower = Boolean.parseBoolean(req.getParameter("shower"));
			Boolean rvHookup = Boolean.parseBoolean(req.getParameter("rvhookup"));
			Long parkId = Long.parseLong(req.getParameter("parkId"));
			// Create an object of type campground and set values
			Campground campground = new Campground();
			campground.setName(cname);
			campground.setCampsites(nofc);
			campground.setBathrooms(bathroom);
			campground.setDogFriendly(df);
			campground.setRvHookup(rvHookup);
			campground.setShower(shower);
			campground.setReviews(new ArrayList<Review>());
			// Call insert method to insert the above set values to the
			// campground entity
			StoreOperation.insertCampground(campground, parkId);
			res.sendRedirect("create_campground.jsp?access_token=" + req.getParameter("access_token"));
		} catch (Throwable t) {
			t.printStackTrace(res.getWriter());
		}
	}

}
