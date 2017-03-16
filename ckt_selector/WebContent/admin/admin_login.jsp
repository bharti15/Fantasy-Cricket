<%@ page import="ckt_selector.*" session="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.* "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		ckt_selector.DConnection db=new ckt_selector.DConnection();
		//String admin_id=request.getParameter("admin_id");
		String admin_name=request.getParameter("admin");
		String admin_password=request.getParameter("admin_password");
		try
		{
			ResultSet rst=db.executeSelect("select * from admin_login where admin_name='"+admin_name+"' and password='"+admin_password+"'");
			if(rst.next()) // if authorized
			{
				//out.print("<center><h1>You have been succcessfully logged in!!</h1></center>");
				//admin_id=rst.getString(1);
				admin_name=rst.getString(2);
				HttpSession session=request.getSession();
				//session.setAttribute("admin_id",admin_id);
				//session.setAttribute("user_type","admin");
				session.setAttribute("admin_name",admin_name);
				db.close();		
				response.sendRedirect("dashboard.jsp?admin_name="+admin_name);
			}
			else //if unauthorized
			{
%>
				<jsp:include page="admin_index.jsp"></jsp:include>
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