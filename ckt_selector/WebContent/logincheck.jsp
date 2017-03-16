<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" session="false" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
<%
		ckt_selector.DConnection db=new ckt_selector.DConnection();
		String mail=request.getParameter("mailid");
		String pass=request.getParameter("pass");
		try
		{
			ResultSet rst=db.executeSelect("select * from user where user_email='"+mail+"' and password='"+pass+"'");
			if(rst.next()) // if authorized
			{
				int user_id=rst.getInt(1);
				HttpSession session=request.getSession();
				session.setAttribute("user_id",user_id);
				session.setAttribute("mail_id",mail);
				String user_name=rst.getString(2);
				session.setAttribute("user_name",user_name);
				db.close();
				response.sendRedirect("userprofile.jsp?mode=normal&user_id="+user_id+"&user_name="+user_name+"&user_email="+mail);
			}
			else //if unauthorized
			{
%>
				<jsp:include page="login.jsp"></jsp:include>
<%				out.print("<center><h1>Invalid user or password</h1></center>"); %>
<%				
			}
		}
		catch(SQLException e)
		{
			out.print(e.getMessage());
		}
	%>
	</body>
</html>