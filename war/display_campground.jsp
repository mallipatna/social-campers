<%@page import="nandini.fb.project1.facebook.FacebookUtils"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="java.util.List"%>
<%@page import="nandini.fb.project1.datastore.model.Review"%>
<%@page import="nandini.fb.project1.datastore.model.Park"%>
<%@page import="nandini.fb.project1.datastore.DataRetriever"%>
<%@page import="nandini.fb.project1.datastore.model.Campground"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="social_campers.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
<script>
window.fbAsyncInit = function() {
	FB.init({
		appId      : '1569799286600648',
		xfbml      : true,
		version    : 'v2.2'
	});

	function onLogin(response) {
		if (response.status == 'connected') {
			FB.api('/me?fields=first_name', function(data) {
				var authTokenBlock = document.forms['form1'].elements['access_token'];
				authTokenBlock.value = response.authResponse.accessToken;
			});
		}
	}

	FB.getLoginStatus(function(response) {
		if (response.status == 'connected') {
			onLogin(response);
		} else {
			FB.login(function(response) {
				onLogin(response);
			}, { scope : 'user_friends,publish_stream,publish_actions' });
		}
	});
};

(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
} (document, 'script', 'facebook-jssdk'));

</script>		

<script>

function urlWithAccessToken(url, cgId) {
	var accessToken = document.forms['form1'].elements['access_token'].value;
	 url += '?access_token=' + accessToken;
	 if (cgId != null) {
		 url += '&campgroundId=' + cgId;
	 }
	 window.location.href = url;
}

</script>
	<title>View Campground Info</title>
	</head>
	<body>
	
		<%
			String campgroundId = request.getParameter("campgroundId");
			Campground campground = DataRetriever.displayCampground(campgroundId);
			List<Review> reviews = campground.getReviews(); 
		%>
		<h1>Details for <%=campground.getName()%> Campground</h1><hr>
		<p><label>Number of campsites:</label>&nbsp;&nbsp;&nbsp;<%=campground.getCampsites() %></p>
		<p><label>Is it dog friendly?</label>&nbsp;&nbsp;&nbsp;<%=campground.getDogFriendly() ? "YES!" : "Noooo..." %></p>
		<p><label>What type of bathrooms?</label>&nbsp;&nbsp;&nbsp;<%=campground.getBathrooms() %></p>
		<p><label>Is there shower facility?</label>&nbsp;&nbsp;&nbsp;<%=campground.getShower() ? "Yes" : "No" %></p>
		<p><label>RV hookups?</label>&nbsp;&nbsp;&nbsp;<%=campground.getRvHookup() ? "Available" : "Not available"%></p>
		<p><label>Average rating (on 5): </label>&nbsp;<%=campground.getRating() %></p>

		<form id="form1" name="form1" action="recommend_campground.jsp" method="get">
		<p><input type="button" value="WRITE A REVIEW" onclick="urlWithAccessToken('create_review.jsp','<%=campgroundId%>');" />
		<input type="button" align="middle" value = "HOME" onclick="location.href='index.jsp?'"/>&nbsp;
		<input type="button" align="middle" value = "LIST PARKS" onclick="urlWithAccessToken('list_parks.jsp',null);"/>&nbsp;
		<input type="hidden" id="campgroundId" name="campgroundId" value="<%=campgroundId%>"/>
		<input type="hidden" id="access_token" name="access_token" value=""/>
		<input type="submit" value="RECOMMEND TO A FRIEND WHO USE THE APP"/></p>
		
		<%if(request.getParameter("post_result") != null) {%>
		<p><label>(Post result was <%=request.getParameter("post_result")%>)</label></p>
		<%} %>
		</form>
		
		<div>
		<fieldset>
			<legend>Reviews</legend>
			
			<%if (reviews == null || reviews.isEmpty()) {%>
				<p><label>Oops... No reviews yet for this campground!</label>
				<input type="submit" value="Be the first to review!" onclick="location.href='create_review.jsp?campgroundId=<%=campgroundId%>&access_token=<%=request.getParameter("access_token") %>'" />
				</p>
			<%} %>
			
			<%
				for (Review review : reviews) {
			%>
				<p><%=review.getDate() %></p>
				<p>Rating: <%=review.getRating() %></p>
				<p><%=review.getReview()%></p>
				<p>-<%=review.getUserId() %></p><hr>
			<% } %>
		</fieldset>
		</div>
	</body>
</html>