<%@ page import="ckt_selector.*" %>
<%@page import="java.sql.*" session="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*" %>
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
		String mode=request.getParameter("mode");
		ckt_selector.League s1=new ckt_selector.League();
		if("display".equals(mode))
		{
			Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>League Details</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Id</th><th>Name</th><th>when</th><th>no of matches</th><th></th><th></th></tr>
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
						<td><a href="league.jsp?admin_name=<%=admin_name%>&l_id=<%=s[0]%>&l_name=<%=s[1]%>&when=<%=s[2]%>&noOfMatches=<%=s[3]%>&mode=edit">Edit</a></td>
						<td><a href="league.jsp?l_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table><br/><br/>
				<a href="league.jsp?admin_name=<%=admin_name%>&mode=add">Add New League</a><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name %>">Go To DashBoard</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			int l_id=Integer.parseInt(request.getParameter("l_id"));
			s1.deleteRecord(l_id);		
		}
		else if("edit".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int l_id=Integer.parseInt(request.getParameter("l_id"));
			String l_name=request.getParameter("l_name");
			String when=request.getParameter("when");
			int noOfMatches=Integer.parseInt(request.getParameter("noOfMatches"));
		%>
			<form action="league.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>League Id </th>
			<td><input type="text" name="l_id" value="<%=l_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>League Name </th>
			<td><input id="editname" type="text" name="l_name"  value="<%=l_name%>" required="required"/></td>
			</tr>
			<tr>
			<th>When </th>
			<td><input id="editname" type="text" name="when"  value="<%=when%>" required="required"/></td>
			</tr>
			<tr>
			<th>No of Matches </th>
			<td><input id="editname" type="text" name="noOfMatches"  value="<%=noOfMatches%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="league.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			int l_id=Integer.parseInt(request.getParameter("l_id"));
			String l_name=request.getParameter("l_name");
			String when=request.getParameter("when");
			int noOfMatches=Integer.parseInt(request.getParameter("noOfMatches"));
			
			int c=s1.updateRecord(l_id,l_name,when,noOfMatches); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			int r=s1.maxId()+1;
			admin_name=request.getParameter("admin_name");
		%>
	
			<form action="league.jsp?admin_name=<%=admin_name%>&mode=save" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<td>League Id</td>
			<td><input type="text" name="l_id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<td>League Name</td>
			<td><input id="addname" type="text" name="l_name" required="required"/></td>
			</tr>
			<tr>
			<td>When</td>
			<td><input id="addname" type="text" name="when" required="required"/></td>
			</tr>
			<tr>
			<td>No of Matches</td>
			<td><input id="addname" type="text" name="noOfMatches" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="save" name="submit" class="btn btn-primary"/></td></tr>
			</tbody>
			</table>
			<a href="league.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			int l_id=Integer.parseInt(request.getParameter("l_id"));
			String l_name=request.getParameter("l_name");
			String when=request.getParameter("when");
			int noOfMatches=Integer.parseInt(request.getParameter("noOfMatches"));
			int c=s1.addRecord(l_id, l_name, when, noOfMatches); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="league.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>
		
				
	
</body>
</html>