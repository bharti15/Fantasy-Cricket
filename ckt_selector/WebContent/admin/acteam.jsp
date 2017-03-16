<%@ page import="ckt_selector.*" %>
<%@page import="java.sql.*" session="false" %>
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
	//out.println(admin_name);
		if(session==null)
		{
	%>
			<jsp:forward page="index.jsp"></jsp:forward>
	<%	
			return;		
		}
		String mode=request.getParameter("mode");
		
		ckt_selector.Acteam s1=new ckt_selector.Acteam();
		if("display".equals(mode))
		{
			
			//out.println(admin_name);
			Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Actual Match Team</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Team Id</th><th>Team Name</th><th>Team belongs to</th><th>Current Team Rank</th><th></th><th></th></tr>
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
						<td><a href="acteam.jsp?admin_name=<%=admin_name%>&at_id=<%=s[0]%>&at_name=<%=s[1]%>&belongsTo=<%=s[2]%>&curRank=<%=s[3]%>&mode=edit">Edit</a></td>
						<td><a href="acteam.jsp?admin_name=<%=admin_name%>&at_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				
				<br/><br/>
				<a href="acteam.jsp?admin_name=<%=admin_name%>&mode=add">Add New Team</a><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name%>">Go To DashBoard</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			int c=s1.deleteRecord(at_id);
			if(c>0){
				out.println("<center>Deleted!</center>");
			}
			else {
				out.println("<center>1st delete its entry from Actual Match Players</center>");
			}
		}
		else if("edit".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			String at_name=request.getParameter("at_name");
			String belongsTo=request.getParameter("belongsTo");
			int curRank=Integer.parseInt(request.getParameter("curRank"));
		%>
			<form action="acteam.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Team Id</th>
			<td><input type="numeric" name="at_id" value="<%=at_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Team Name</th>
			<td><input id="editname" type="text" name="at_name"  value="<%=at_name%>" required="required"/></td>
			</tr>
			<tr>
			<th>Team belongs to</th>
			<td><input id="editname" type="text" name="belongsTo"  value="<%=belongsTo%>" required="required"/></td>
			</tr>
			<tr>
			<th>Current Team Rank</th>
			<td><input id="editname" type="numeric" name="curRank"  value="<%=curRank%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="acteam.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			String at_name=request.getParameter("at_name");
			String belongsTo=request.getParameter("belongsTo");
			int curRank=Integer.parseInt(request.getParameter("curRank"));
			
			int c=s1.updateRecord(at_id,at_name,belongsTo,curRank); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int r=s1.maxId()+1;
		%>
	
			<form action="acteam.jsp?admin_name=<%=admin_name%>&mode=save" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<th>Team Id</th>
			<td><input type="numeric" name="at_id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Team Name</th>
			<td><input id="editname" type="text" name="at_name" required="required" /></td>
			</tr>
			<tr>
			<th>Team belongs to</th>
			<td><input id="editname" type="text" name="belongsTo" required="required"/></td>
			</tr>
			<tr>
			<th>Current Team Rank</th>
			<td><input id="editname" type="numeric" name="curRank"  required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="acteam.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			String at_name=request.getParameter("at_name");
			String belongsTo=request.getParameter("belongsTo");
			int curRank=Integer.parseInt(request.getParameter("curRank"));
			int c=s1.addRecord(at_id, at_name, belongsTo, curRank); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="acteam.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="admin_name" name="admin_name"/>
	</jsp:include>

</body>
</html>