<%@page import="nandini.fb.project1.datastore.DataRetriever"%>
<%@page import="java.util.List"%>
<%@page import="com.restfb.types.User"%>
<%@page import="nandini.fb.project1.facebook.FacebookUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="social_campers.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Recommend to friend</title>
</head>
<body>

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
				if (data.first_name == "Nandini") {
					//document.forms['form1'].elements['admin'].style.display = 'block';
				}
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

function getFriendsChecked() {
	var checkboxes = document.getElementsByClassName("friendId");
	var friends = '';
	for (var i=0; i<checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			if (i == 0) {
				friends += checkboxes[i].value;
			} else {
				friends += (',' + checkboxes[i].value);
			}
		}
	}
	return friends;
}

function sendMessage() {
	var cgId = '<%=request.getParameter("campgroundId")%>';
	var friends = getFriendsChecked();
	if (friends != null && friends.length > 0) {
		FB.ui({
			method: 'send',
			link: 'https://apps.facebook.com/social-campers/display_campground.jsp?campgroundId=' + cgId,
			to: friends,
		});
	}
}

function appRequest() {
	FB.ui({
		method: 'apprequests',
		message: 'Nandini invites you to try Social Campers',
		link: 'https://apps.facebook.com/social-campers/',
		redirect_uri: 'https://apps.facebook.com/social-campers/',
	});
}
</script>

		<input type="hidden" name="access_token" value=<%=request.getParameter("access_token") %>>
		<h1>Recommend campground <%=DataRetriever.displayCampground(request.getParameter("campgroundId")).getName()%> to a Friend</h1><hr>
		<input type="hidden" name="campgroundId" value="<%=request.getParameter("campgroundId")%>" />
		<h2>Select a friend:</h2>
			<%
			List<User> friends = FacebookUtils.getFriendsAsUser(request);
			if (friends == null || friends.isEmpty()) { 
			%>
				<label>Sorry! No friends are using the APP</label><br><br>
				<input type="button" align="middle" value = "INVITE FRIENDS" onclick="appRequest();"/>
			<%
			} else {
				for (User friend : FacebookUtils.getFriendsAsUser(request)) {
			%>
				<p><input type="checkbox" class="friendId" id="friendId" name="friendId" value="<%=friend.getId()%>"><%=friend.getName()%></p>
			<%
				}
			%>
				<p><input type="button" value="RECOMMEND" onclick="sendMessage();"/></p>
			<%
			}
			%>
	<br><hr><input type="button" value="BACK TO CAMPGROUND" onclick="location.href='display_campground.jsp?campgroundId=<%=request.getParameter("campgroundId")%>&access_token=<%=request.getParameter("access_token") %>'" />

</body>
</html>