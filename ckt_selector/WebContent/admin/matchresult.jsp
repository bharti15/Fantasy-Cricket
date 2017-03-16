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
		ckt_selector.MatchResult s1=new ckt_selector.MatchResult();
		if("display".equals(mode))
		{
			Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Match Result</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Match</th><th>status</th><th>league</th><th>won</th><th>lost</th><th>Bating Scorecard</th><th>Bowling Scorecard</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					String match=s1.getMatch(Integer.parseInt(s[0]));
					String won=s1.getTeam(Integer.parseInt(s[3]));
					String lost=s1.getTeam(Integer.parseInt(s[4]));
					String league=s1.getLeague(Integer.parseInt(s[2]));
		%>
					<td><%=match%></td>
					<td><%=s[1]%></td>
					<td><%=league%></td>
					<td><%=won%></td>
					<td><%=lost%></td>
					<td><a href="btscorecard.jsp?m_id=<%=s[0]%>&l_id=<%=s[2]%>&admin_name=<%=admin_name%>">click here</a></td>
					<td><a href="bwscorecard.jsp?m_id=<%=s[0]%>&l_id=<%=s[2]%>&admin_name=<%=admin_name%>">click here</a></td>
						<td><a href="matchresult.jsp?m_id=<%=s[0]%>&status=<%=s[1]%>&l_id=<%=s[2]%>&won=<%=s[3]%>&lost=<%=s[4]%>&mode=edit&admin_name=<%=admin_name%>">Edit</a></td>
						<td><a href="matchresult.jsp?m_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="matchresult.jsp?admin_name=<%=admin_name %>&mode=add">Enter Next Match Result</a><br/>
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
			String status=request.getParameter("status");
			int won=Integer.parseInt(request.getParameter("won"));
			int lost=Integer.parseInt(request.getParameter("lost"));
			int l_id=Integer.parseInt(request.getParameter("l_id"));
			String won1=s1.getTeam(won);
			String lost1=s1.getTeam(lost);
			String league1=s1.getLeague(l_id);
		%>
			<form action="matchresult.jsp?mode=update&admin_name=<%=admin_name%>" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Match</th>
			<td><input type="text" name="m_id" value="<%=m_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>status</th>
			<td><input id="editname" type="text" name="status"  value="<%=status%>" required="required"/></td>
			</tr>
			<tr>
			<th>league</th>
			<td><input id="editname" type="text" name="league1"  value="<%=league1%>" required="required"/></td>
			</tr>
			<th>won</th>
			<td><input id="editname" type="text" name="won1"  value="<%=won1%>" required="required"/></td>
			</tr>
			<tr>
			<th>lost</th>
			<td><input id="editname" type="text" name="lost1"  value="<%=lost1%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="matchresult.jsp?admin_name=<%=admin_name %>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			int m_id=Integer.parseInt(request.getParameter("m_id"));
			String status=request.getParameter("status");
			String won1=request.getParameter("won1");
			String lost1=request.getParameter("lost1");
			String league1=request.getParameter("league1");
			int won=s1.getTeamid(won1);
			int lost=s1.getTeamid(lost1);
			int l_id=s1.getLeagueid(league1);
			
			int c=s1.updateRecord(m_id, status, won, lost, l_id);
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			
		%>
	
			<form action="matchresult.jsp?mode=save&admin_name=<%=admin_name%>" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<th>Match</th>
			<td><input id="editname" type="text" name="match" required="required" ></td>
			</tr>
			<tr>
			<th>status</th>
			<td><input id="editname" type="text" name="status" required="required" /></td>
			</tr>
			<tr>
			<th>won</th>
			<td><input id="editname" type="text" name="won" required="required" /></td>
			</tr>
			<th>lost</th>
			<td><input id="editname" type="text" name="lost"  required="required"/></td>
			</tr>
			<tr>
			<th>league</th>
			<td><input id="editname" type="text" name="league" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="add" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="matchresult.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int m_id=s1.getMatchid(request.getParameter("match"));
			String status=request.getParameter("status");
			int won=s1.getTeamid(request.getParameter("won"));
			int lost=s1.getTeamid(request.getParameter("lost"));
			int l_id=s1.getLeagueid(request.getParameter("league"));
			int c=s1.addRecord(m_id, status, l_id, won, lost); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="matchresult.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>
	

</body>
</html>