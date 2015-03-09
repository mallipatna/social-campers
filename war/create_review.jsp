<%@page import="nandini.fb.project1.facebook.FacebookUtils"%>
<%@page import="nandini.fb.project1.datastore.DataRetriever"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="social_campers.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Enter review data</title>
</head>
	<body>
		<form method="get" action="create_review">
			<input type="hidden" name="access_token" value="<%=request.getParameter("access_token") %>" />
			<input type="hidden" name="campgroundId" value="<%=request.getParameter("campgroundId") %>" />
			<h1>Review campground <%=DataRetriever.displayCampground(request.getParameter("campgroundId")).getName() %></h1><hr>
			<h2>My Review:</h2><p><textarea rows="15" cols="100" name="review" id="review"></textarea></p>
				<h2>My Rating:
				<select name="rating" id="rating">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>
				</h2>
			<p><input type="checkbox" name="post" id="post" value="post_checked"/>Post on my timeline!</p>
			<p><input type="submit" value="SUBMIT REVIEW" /> &nbsp;
			<input type="button" value="BACK TO CAMPGROUND" onclick="location.href='display_campground.jsp?campgroundId=<%=request.getParameter("campgroundId")%>&access_token=<%=request.getParameter("access_token") %>'" /></p>
		</form>
	</body>
</html>