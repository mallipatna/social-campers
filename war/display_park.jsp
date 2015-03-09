<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="com.google.appengine.repackaged.com.google.api.client.util.Data"%>
<%@page import="java.util.List"%>
<%@page import="nandini.fb.project1.datastore.model.Campground"%>
<%@page import="nandini.fb.project1.datastore.model.Park"%>
<%@page import="nandini.fb.project1.datastore.DataRetriever"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="social_campers.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>View Park Info</title>
	</head>
	<body>
		<%
			String parkId = request.getParameter("parkid");
			Park park = DataRetriever.displayPark(parkId);
			List<Campground> campgrounds = park.getCampgrounds();
		%>
		<h1>Details for <%=park.getName()%></h1><hr>
		<table><tr><td>
			<h3>Name:
				&nbsp;&nbsp;<label><%=park.getName() %></label></h3>
			<h3>Location:
				&nbsp;&nbsp;<label><%=park.getLocation() %></label></h3>
			<h3>Best time to visit:
				&nbsp;&nbsp;<label><%=park.getBestTimeToVisit() %></label></h3>
			<h3>Things to do:
				&nbsp;&nbsp;<label><%=park.getThingsToDo() %></label></h3>
		<table>
			<tr>
				<th><h3>List of campgrounds in this park:</h3></th>
			</tr>
			<%if (campgrounds == null || campgrounds.isEmpty()) {%>
			<tr>
				<td>Oops! No campgrounds are available in this park yet!</td>
			</tr>
			<%} %>
			<%
				for (Campground campground : campgrounds) {
			%>
			<tr>
				<td><a href="display_campground.jsp?campgroundId=<%=KeyFactory.keyToString(campground.getId())%>&access_token=<%=request.getParameter("access_token")%>"><%=campground.getName() %></a></td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
		<%if(park.getImageLocation() != null) { %>
		<td>
			<img alt="" src=<%=park.getImageLocation() %> height="200px" width="200px" >
		</td>
		<%} %>
		</tr></table>
		<br><hr><input type="submit" align="middle" value = "HOME" onclick="location.href='index.jsp?access_token=<%=request.getParameter("access_token") %>'"/>&nbsp;
		<input type="submit" align="middle" value = "LIST PARKS" onclick="location.href='list_parks.jsp?access_token=<%=request.getParameter("access_token") %>'"/>&nbsp;
	</body>
</html>