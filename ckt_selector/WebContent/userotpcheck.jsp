<%@page import="ckt_selector.MailVerification"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import ="java.sql.* "%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>In</title>
	</head>
	<body>
		<jsp:useBean class="ckt_selector.User" id="u1"></jsp:useBean>
	
<%
		String otp= request.getParameter("otp");
		String newpass= request.getParameter("newpass");
		String otp1= request.getParameter("generatedotp");//from hidden input
		
		
		if(!(otp.equals(otp1)))
		{
%>
		<jsp:forward page="login.jsp"></jsp:forward>
<%			
		}
		
		String name= request.getParameter("sname");
		String userid= request.getParameter("mailid");
		String msg="\nYour Id is "+userid +" and your new password is "+ newpass;
		
		
		u1.updateViaMailId(name,newpass,userid);
			
		
%>



	<jsp:include page="mail.jsp">
		<jsp:param name="email" value="<%=userid%>" />
		<jsp:param name="subject" value="Recover Password" />
		<jsp:param name="msg" value="<%=msg%>" />
	</jsp:include>
	
	<jsp:include page="index.jsp"></jsp:include>

	</body>
</html>