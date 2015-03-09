package nandini.fb.project1.facebook;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.Version;
import com.restfb.types.FacebookType;
import com.restfb.types.User;

/**
 * Contains helper methods to access information of the user from facebook. Uses
 * restFB API for java.
 * 
 * @author nandinivishwas
 */
public class FacebookUtils {

	public static final String APP_ID = "1569799286600648";
	public static final String APP_SECRET = "fd11edfa3c8ae7cb398dda4ff107eaa2";
	public static final String SCOPE = "user_friends,publish_stream,publish_actions";

	/**
	 * Gets the user name of the current logged in user by looking up
	 * access_token from request.
	 */
	public static String getUserName(HttpServletRequest session) {
		FacebookClient client = getClient(session);
		User user = client.fetchObject("me", User.class);
		return user.getFirstName() + " " + user.getLastName();
	}

	/**
	 * Gets lists of friends who also use the app.
	 */
	public static List<User> getFriendsAsUser(HttpServletRequest session) {
		FacebookClient client = getClient(session);
		List<User> friends = new ArrayList<>();
		friends.addAll(client.fetchConnection("me/friends", User.class).getData());
		return friends;
	}

	/**
	 * Gets list of friend names of the logged in user. This gives all friends
	 * including ones who do not use the app. This is used for sending app
	 * invites.
	 */
	public static List<String> getFriends(HttpServletRequest session) {
		FacebookClient client = getClient(session);
		List<String> friends = new ArrayList<>();
		friends.addAll(getFriendNames(client.fetchConnection("me/friends", User.class)));
		friends.addAll(getFriendNames(client.fetchConnection("me/invitable_friends", User.class)));
		return friends;
	}

	/**
	 * Post a message on user's timeline. The user should have given
	 * publish_stream and publish_activity permissions. Note that if the user is
	 * not a developer, its not possible to post because Facebook restricts it
	 * unless the app is reviewed.
	 */
	public static void postMessageOnTimeline(HttpServletRequest session, String message) {
		FacebookClient client = getClient(session);
		client.publish("me/feed", FacebookType.class, Parameter.with("message", message));
	}

	private static List<String> getFriendNames(Connection<User> friendConnections) {
		List<String> friends = new ArrayList<>();

		for (User user : friendConnections.getData()) {
			friends.add(user.getName());
		}
		return friends;
	}

	private static FacebookClient getClient(HttpServletRequest session) {
		return new DefaultFacebookClient(session.getParameter("access_token"), APP_SECRET, Version.VERSION_2_2);
	}

}
