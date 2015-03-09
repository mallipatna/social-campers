<%@page import="nandini.fb.project1.facebook.FacebookUtils"%>
<%@page import="nandini.fb.project1.datastore.DataRetriever"%>
<%@page import="nandini.fb.project1.datastore.model.Park"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="social_campers.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Parks list</title>
</head>
<body>
	<h1>List of Parks</h1><hr>
	<%
		List<Park> parks = DataRetriever.listParks();
	%>
	<h2>Total number of parks in the applications: <%=parks.size()%></h2>
	<table border="1">
		<tr>
			<th><h3>Click on the park name to view information about the park:</h3></th>
		</tr>
		<%
			for (Park park : parks) {
		%>
		<tr>
			<td><a href="display_park.jsp?parkid=<%=park.getId().getId()%>&access_token=<%=request.getParameter("access_token")%>"> <%=park.getName()%></a></td>
		</tr>
		<%
			}
		%>
	</table>
	<br><hr><input type="submit" value = "HOME" onclick="location.href='index.jsp?access_token=<%=request.getParameter("access_token") %>'"/>&nbsp;
</body>
</html>