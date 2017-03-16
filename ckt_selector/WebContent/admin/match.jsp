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
		if(session==null)
		{
	%>
			<jsp:forward page="index.jsp"></jsp:forward>
	<%	
			return;		
		}
		String mode=request.getParameter("mode");
		ckt_selector.Match s1=new ckt_selector.Match();
		if("display".equals(mode))
		{
			Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<u><b>Match Details</b></u><br/>
					<br/>
					<table border="1" width="500px">
					<tr><th>Match Id</th><th>Match Name</th><th>Date</th><th>Time</th><th>where</th><th>Team 1 id</th><th>Team 2 id</th><th>League id</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					String team1=s1.getTeam(Integer.parseInt(s[5]));
					String team2=s1.getTeam(Integer.parseInt(s[6]));
					String league=s1.getLeague(Integer.parseInt(s[7]));
					for(int j=0;j<5;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><%=team1%></td>
		<%	
		%>
						<td><%=team2%></td>
		<%
		%>
						<td><%=league%></td>
		<%
		%>
						<td><a href="match.jsp?admin_name=<%=admin_name%>&m_id=<%=s[0]%>&m_name=<%=s[1]%>&m_date=<%=s[2]%>&m_time=<%=s[3]%>&m_where=<%=s[4]%>&at_id1=<%=s[5]%>&at_id2=<%=s[6]%>&l_id=<%=s[7]%>&mode=edit">Edit</a></td>
						<td><a href="match.jsp?m_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="match.jsp?admin_name=<%=admin_name%>&mode=add">Add New Match</a><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name %>">Go To DashBoard</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			int m_id=Integer.parseInt(request.getParameter("m_id"));
			s1.deleteRecord(m_id);		
		}
		else if("edit".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int m_id=Integer.parseInt(request.getParameter("m_id"));
			String m_name=request.getParameter("m_name");
			String m_date=request.getParameter("m_date");
			String m_time=request.getParameter("m_time");
			String m_where=request.getParameter("m_where");
			int at_id1=Integer.parseInt(request.getParameter("at_id1"));
			int at_id2=Integer.parseInt(request.getParameter("at_id2"));
			int l_id=Integer.parseInt(request.getParameter("l_id"));
			String team1=s1.getTeam(at_id1);
			String team2=s1.getTeam(at_id2);
			String league=s1.getLeague(l_id);
		%>
			<form action="match.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Match Id</th>
			<td><input type="text" name="m_id" value="<%=m_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Match name</th>
			<td><input id="editname" type="text" name="m_name"  value="<%=m_name%>" required="required"/></td>
			</tr>
			<tr>
			<th>date</th>
			<td><input id="editname" type="text" name="m_date"  value="<%=m_date%>" required="required" placeholder="yyyy-mm-dd"/></td>
			</tr>
			<tr>
			<th>time</th>
			<td><input id="editname" type="text" name="m_time"  value="<%=m_time%>" required="required" placeholder="hh:mm:ss"/></td>
			</tr>
			<tr>
			<th>where</th>
			<td><input id="editname" type="text" name="m_where"  value="<%=m_where%>" required="required"/></td>
			</tr>
			<tr>
			<th>team 1 id</th>
			<td><input id="editname" type="text" name="team1"  value="<%=team1%>" required="required"/></td>
			</tr>
			<tr>
			<th>team 2 id</th>
			<td><input id="editname" type="text" name="team2"  value="<%=team2%>" required="required"/></td>
			</tr>
			<tr>
			<th>league id</th>
			<td><input id="editname" type="text" name="league"  value="<%=league%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="match.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int m_id=Integer.parseInt(request.getParameter("m_id"));
			String m_name=request.getParameter("m_name");
			String m_date=request.getParameter("m_date");
			String m_time=request.getParameter("m_time");
			String m_where=request.getParameter("m_where");
			String team1=request.getParameter("team1");
			String team2=request.getParameter("team2");
			String league=request.getParameter("league");
			int at_id1=s1.getTeamid(team1);
			int at_id2=s1.getTeamid(team2);
			int l_id=s1.getLeagueid(league);
			
			int c=s1.updateRecord(m_id, m_name, m_date, m_time, m_where, at_id1, at_id2, l_id); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int r=s1.maxId()+1;
		%>
	
			<form action="match.jsp?admin_name=<%=admin_name%>&mode=save" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<th>Match Id</th>
			<td><input type="text" name="m_id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Match name</th>
			<td><input id="editname" type="text" name="m_name" required="required" /></td>
			</tr>
			<tr>
			<th>date</th>
			<td><input id="editname" type="text" name="m_date" required="required" placeholder="yyyy-mm-dd"/></td>
			</tr>
			<tr>
			<th>time</th>
			<td><input id="editname" type="text" name="m_time" required="required" placeholder="hh:mm:ss"/></td>
			</tr>
			<tr>
			<th>where</th>
			<td><input id="editname" type="text" name="m_where" required="required" /></td>
			</tr>
			<tr>
			<th>team 1</th>
			<td><input id="editname" type="text" name="team1" required="required" /></td>
			</tr>
			<tr>
			<th>team 2</th>
			<td><input id="editname" type="text" name="team2"  required="required"/></td>
			</tr>
			<tr>
			<th>league </th>
			<td><input id="editname" type="text" name="league"  required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="add" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="match.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int m_id=Integer.parseInt(request.getParameter("m_id"));
			String m_name=request.getParameter("m_name");
			String m_date=request.getParameter("m_date");
			String m_time=request.getParameter("m_time");
			String m_where=request.getParameter("m_where");
			int at_id1=s1.getTeamid(request.getParameter("team1"));
			int at_id2=s1.getTeamid(request.getParameter("team2"));
			int l_id=s1.getLeagueid(request.getParameter("league"));
			int c=s1.addRecord(m_id, m_name, m_date, m_time, m_where, at_id1, at_id2, l_id); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="match.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>

</body>
</html>