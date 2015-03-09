<%@page import="nandini.fb.project1.facebook.FacebookUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="social_campers.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="core.js"></script>
<title>Main page</title>
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
				var authTokenBlock = document.forms['form1'].elements['access_token'];
				authTokenBlock.value = response.authResponse.accessToken;
				var nameElement = document.getElementById['userName'];
				//nameElement.innerHtml = data.first_name;
				//nameElement.value = data.first_name;
				if (data.first_name == "Nandini") {
					document.forms['form1'].elements['create_park'].style.visibility = 'visible';
					document.forms['form1'].elements['create_campground'].style.visibility = 'visible';
				} else {
					document.forms['form1'].elements['create_park'].style.visibility = 'hidden';
					document.forms['form1'].elements['create_campground'].style.visibility = 'hidden';
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

function redirectWithAuthToken(page) {
	var accessToken = document.forms['form1'].elements['access_token'].value;
	window.location.href = page + "?access_token=" + accessToken;
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

		<form id="form1" name="form1">
		<h1 id="userName">Welcome to Social Campers App</h1><hr>
		<h2>With this app, you can do the following:</h2>
		<div>
		<ul>
			<li> Browse available national parks and its details.
			<li> View all campgrounds for a park.
			<li> View details of the campground to help you decide camping.
			<li> View all reviews and ratings for a campground.
			<li> Create your own review for a campground.
			<li> Post a review to your message feed to show to your friends.
			<li> Recommend campgrounds to your friends who also use the app.
			<li> Send a private message to your friend and invite them to use the app.
		</ul>
		</div>
		<h2>Get started:</h2>
			<input type="hidden" id="access_token" name="access_token">
			<input type="button" align="middle" value="LIST PARKS" onclick="redirectWithAuthToken('list_parks.jsp');"/>&nbsp;
			<input type="button" align="middle" value="INVITE FRIENDS" onclick="appRequest();"/>
			
				<input type="button" style="visibility: hidden" align="middle" name="create_park" id="create_park" value="CREATE PARK" onclick="redirectWithAuthToken('create_park.jsp');" />&nbsp;
				<input type="button" style="visibility: hidden" align="middle" name="create_campground" id="create_campground" value="CREATE CAMPGROUND" onclick="redirectWithAuthToken('create_campground.jsp');"/>&nbsp;
		
		</form>
	</body>
</html>