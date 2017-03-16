<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Expires","0"); 
response.setDateHeader("Expires",-1); 
%>
<%
	try
	{
		int p_id=Integer.parseInt(request.getParameter("p_id"));
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		int m_id=Integer.parseInt(request.getParameter("m_id"));;
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ckt_slctor","root","");
		Statement stmt=conn.createStatement();
		ResultSet rst=stmt.executeQuery("select * from players where p_id="+p_id);
%>
<form class="form-inline">

		<select name="player2" class="form-control" style="width:200px;">
		<span class="caret"></span>
<%		
			while(rst.next())
			{
%>
				<option value="<%=rst.getString(1)%>">
					<%=rst.getString(2)%>
				</option>
<%				
			}
%>
		</select>
<%
		stmt.close();
		conn.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
</form>

</body>
</html>