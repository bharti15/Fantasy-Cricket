<%@ page import="ckt_selector.*" session="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form name="admin login form" action="admin_login.jsp" method="post">
		<fieldset>
			<legend>LOGIN INFORMATION</legend>
			<table align="center">
				<tr>
					<td>admin name:</td>
					<td><input type="text" name="admin" value="" /></td>
				</tr>
				<tr>
					<td>admin password:</td>
					<td><input type="password" name="admin_password" value="" /></td>
				</tr>
				<tr>
					<td><input type="submit" value="Submit"></td>
				</tr>
			</table>
			<a href="../index.jsp">Cancel</a><br>
		</fieldset>
	</form>
</body>
</html>