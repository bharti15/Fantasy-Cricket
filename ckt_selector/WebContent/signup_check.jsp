<%@page import="java.sql.*" session="false"%>
<%@page import="ckt_selector.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<jsp:useBean class="ckt_selector.SignupCheck" id="c1"></jsp:useBean>
				<jsp:useBean class="ckt_selector.User" id="c2"></jsp:useBean>
								<jsp:useBean class="ckt_selector.CommonMethods" id="c3"></jsp:useBean>




<%
		String otp= request.getParameter("otp");
		String otp1= request.getParameter("generatedotp");
		
		if(!(otp.equals(otp1)))
		{
%>
			<jsp:forward page="user_signup.jsp"></jsp:forward>
			<b>wrong otp!</b>
<%			
		}

		String name= request.getParameter("sname");
		String pass= request.getParameter("pass");
		String rpass= request.getParameter("retype");
		String mail= request.getParameter("email");
		String contact= request.getParameter("mobile");
		String teamname=request.getParameter("teamname");
		String msg="Welcome Admin your account created\nYour Id is "+mail +" and password is "+ pass;
		ckt_selector.CommonMethods cm=new ckt_selector.CommonMethods();
		//int sid=cm.getStateId(state);
		//c3.getStateId(state);
		//int cid=cm.getCityId(city);
		//c3.getCityId(city);
		//System.out.println(sid+","+cid+name);

		
		int cnt=cm.count(mail);
		int cnt1=cm.count1(contact);
		 
		 
		 	if(cnt== 0 && cnt1==0)// if authorized
		 	{
		 		c1.addUser(name,pass,mail,contact,teamname);
%>
				<jsp:include page="mail.jsp">
					<jsp:param name="email" value="<%=mail%>" />
					<jsp:param name="subject" value="Account Created" />
					<jsp:param name="msg" value="<%=msg%>" />
				</jsp:include>
				<jsp:include page="login.jsp"></jsp:include>
<%	 		
		 	}	 	
%>
	
</body>
</html>