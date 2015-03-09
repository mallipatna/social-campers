package nandini.fb.project1.datastore;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManagerFactory;

import com.google.appengine.api.NamespaceManager;

// adapted from https://cloud.google.com/appengine/docs/java/datastore/jdo/overview
public final class PMF {

	private static final PersistenceManagerFactory pmfInstance = JDOHelper
			.getPersistenceManagerFactory("transactions-optional");

	private PMF() {
	}

	public static PersistenceManagerFactory get() {
		NamespaceManager.set("nandini.ye5386");
		return pmfInstance;
	}
}
