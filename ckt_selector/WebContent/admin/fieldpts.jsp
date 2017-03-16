<%@ page import="ckt_selector.*" %>
<%@page import="java.sql.SQLException" session="false" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
		HttpSession session=request.getSession(false);
		String admin_name=request.getParameter("admin_name");
		if(session==null)
		{
	%>
			<jsp:forward page="index.jsp"></jsp:forward>
	<%	
			return;		
		}
		ckt_selector.Fieldpts s1=new ckt_selector.Fieldpts();
		String mode=request.getParameter("mode");
		if("display".equals(mode))
		{
				Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Fielding Points</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Catch Out</th><th>Fielding stumps</th><th>Run Out</th><th>Direct Hit</th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(int j=0;j<4;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><a href="fieldpts.jsp?admin_name=<%=admin_name%>&catch_out=<%=s[0]%>&f_stumps=<%=s[1]%>&run_out=<%=s[2]%>&directHit=<%=s[3]%>&mode=edit">Edit</a></td>
						
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name%>">Go To DashBoard</a>
				</center>
		<%
				return;
		}
		/*else if("delete".equals(mode))
		{
			int id=Integer.parseInt(request.getParameter("id"));
			s1.deleteRecord();		
		}*/
		else if("edit".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			double catch_out=Double.parseDouble(request.getParameter("catch_out"));
			double f_stumps=Double.parseDouble(request.getParameter("f_stumps"));
			double run_out=Double.parseDouble(request.getParameter("run_out"));
			double directHit=Double.parseDouble(request.getParameter("directHit"));
			
		%>
			<form action="fieldpts.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Catch Out</th>
			<td><input type="text" name="catch_out" value="<%=catch_out%>" id="editable" required="required"/></td>
			</tr>
			<tr>
			<th>Field stumps</th>
			<td><input id="editname" type="text" name="f_stumps"  value="<%=f_stumps%>" required="required"/></td>
			</tr>
			<tr>
			<th>Run Out</th>
			<td><input id="editname" type="text" name="run_out"  value="<%=run_out%>" required="required"/></td>
			</tr>
			<tr>
			<th>Direct Hit</th>
			<td><input id="editname" type="text" name="directHit"  value="<%=directHit%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="fieldpts.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			double catch_out=Double.parseDouble(request.getParameter("catch_out"));
			double f_stumps=Double.parseDouble(request.getParameter("f_stumps"));
			double run_out=Double.parseDouble(request.getParameter("run_out"));
			double directHit=Double.parseDouble(request.getParameter("directHit"));
			int c=s1.updateRecord(catch_out, f_stumps, run_out, directHit); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}

		%>
		<jsp:include page="fieldpts.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>
	

</body>
</html>