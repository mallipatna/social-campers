<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<link rel="stylesheet" type="text/css" href="social_campers.css">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>Enter park data</title>
	</head>
	<body>
		<form method="get" action="create_park">
			<input type="hidden" name="access_token" value="<%=request.getParameter("access_token") %>">
			<h1>Enter park information</h1>
			<p>Park name: <input type="text" name="name" id="name" /><br/></p>
			<p>Location: <input type="text" name="location" id="location" /><br/></p>
			<p>Best time to visit: <input type="text" name="visit" id="visit" /><br/></p> 
			<p>Things to do: <input type="text" name="todo" id="todo" /><br/></p> 
			<p>Image Location: <br><textarea rows="5" cols="100" name="image_location" id="image_location"></textarea><br/></p>
			<input type="submit" value="SUBMIT" />&nbsp;
		</form>
		<br><hr>
			<input type="button" value="HOME" onclick="location.href='index.jsp?access_token=<%=request.getParameter("access_token") %>'"/>
	</body>
</html>
