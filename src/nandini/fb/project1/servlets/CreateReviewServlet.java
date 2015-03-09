package nandini.fb.project1.servlets;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nandini.fb.project1.datastore.DataRetriever;
import nandini.fb.project1.datastore.StoreOperation;
import nandini.fb.project1.datastore.model.Campground;
import nandini.fb.project1.datastore.model.Review;
import nandini.fb.project1.facebook.FacebookUtils;

/**
 * Fetches the user entered data from the web page for review and creates a
 * datastore entity.
 * 
 * @author nandinivishwas
 */
public class CreateReviewServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			// Get parameter values from review.html
			String reviewText = req.getParameter("review");
			String ratingText = req.getParameter("rating");

			String campgroundId = req.getParameter("campgroundId");
			Campground campground = DataRetriever.displayCampground(campgroundId);
			String post = req.getParameter("post");
			if (reviewText == null || reviewText.trim().isEmpty()) {
				res.getWriter().println("<html><body>");
				res.getWriter().println("Please supply some review text!");
				res.getWriter().println("</body></html>");
				return;
			}
			if (ratingText == null || ratingText.trim().isEmpty()) {
				res.getWriter().println("<html><body>");
				res.getWriter().println("Please supply a rating from 1-5!");
				res.getWriter().println("</body></html>");
				return;
			}
			Integer rating = Integer.parseInt(ratingText);
			// Create an object of type review and set values
			Review review = new Review();
			review.setReview(reviewText);
			review.setRating(rating);
			review.setUserId(FacebookUtils.getUserName(req));
			review.setDate(new Date());
			// Call insertReview method to insert the above set values to the
			// review entity
			StoreOperation.insertReview(review, campgroundId);
			if ("post_checked".equals(post)) {
				try {
					FacebookUtils.postMessageOnTimeline(req, "My review for campground " + campground.getName() + ": " + reviewText);
					res.sendRedirect("display_campground.jsp?campgroundId=" + campgroundId + "&access_token=" + req.getParameter("access_token")
							+ "&post_result=success");
					return;
				} catch (Throwable t) {
					res.sendRedirect("display_campground.jsp?campgroundId=" + campgroundId + "&access_token=" + req.getParameter("access_token")
							+ "&post_result=failure");
					return;
				}
			}
			res.sendRedirect("display_campground.jsp?campgroundId=" + campgroundId + "&access_token=" + req.getParameter("access_token"));
		} catch (Throwable t) {
			t.printStackTrace(res.getWriter());
		}
	}
}
