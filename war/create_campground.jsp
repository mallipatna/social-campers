<%@page import="nandini.fb.project1.datastore.DataRetriever"%>
<%@page import="nandini.fb.project1.datastore.model.Park"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="social_campers.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Enter Campground Data</title>
	</head>
	<body>
		<form method="get" action="create_campground">
			<input type="hidden" name="access_token" value="<%=request.getParameter("access_token") %>">
			<h1>Enter campground information</h1>
			<p><label>Select a park: </label> 
				<select name="parkId">
					<% for(Park park : DataRetriever.listParks()) { %>
						<option value="<%=park.getId().getId()%>" id="<%=park.getId().getId()%>"><%=park.getName()%></option>
					<% } %>
				</select>
			</p>
			<p>Campground name: <input type="text" name="cname" id="cname" /></p>
			<p>Number of camp sites: <input type="text" name="nofc" id="nofc" /></p>
			
			<div>
			<fieldset>
				<legend>Facilities</legend>
				<p>Bathroom: 
					<select name="bathroom" id="bathroom">
						<option value="Flush">Flush</option>
						<option value="Pit">Pit</option>	
					</select>
				</p>
				<p>
					<label>Dog friendly? </label>
					<input type="radio" name="df" id="df" value="true"/>Yes
					<input type="radio" name="df" id="df" value="false" checked="checked"/>No  
				</p>
				<p>
					<label>Shower? </label> 
					<input type="radio" name="shower" id="shower" value="true" />Yes 
					<input type="radio" name="shower" id="shower" value="false" checked="checked"/>No
				</p>
				<p>
					<label>RV Hookup? </label> 
					<input type="radio" name="rvhookup" id="rvhookup" value="true" />Yes 
					<input type="radio" name="rvhookup" id="rvhookup" value="false" checked="checked"/>No
				</p>
			</fieldset>
			</div>
			<p><input type="submit" value="SUBMIT" /></p>
		</form>
		<br><hr>
			<input type="button" value="HOME" onclick="location.href='index.jsp?access_token=<%=request.getParameter("access_token") %>'"/>
	</body>
</html>