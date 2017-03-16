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
		int m_id=Integer.parseInt(request.getParameter("m_id"));
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		if(session==null)
		{
	%>
			<jsp:forward page="index.jsp"></jsp:forward>
	<%	
			return;		
		}
		String mode=request.getParameter("mode");
		ckt_selector.Btscorecard s1=new ckt_selector.Btscorecard();
		if("display".equals(mode))
		{
			Vector<String []> v = s1.showRecordAll(m_id);
		%>
					<center>
					<b><u>Bating Scorecard</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Player</th><th>runs</th><th>no of balls played</th><th>no of 4</th><th>no of 6</th><th>half century</th><th>century</th><th>batting strike rate</th><th>team</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					String pname=s1.getplayername(Integer.parseInt(s[0]));
					String team=s1.getTeam(Integer.parseInt(s[4]));
		%>
					<td><%=pname%></td>
	    <%
					for(int j=1;j<8;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><%=team%></td>
						<td><a href="btscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id%>&l_id=<%=l_id%>&p_id=<%=s[0]%>&runs=<%=s[1]%>&noOfBallsPlayed=<%=s[2]%>&noOf4=<%=s[3]%>&noOf6=<%=s[4]%>&halfCentury=<%=s[5]%>&century=<%=s[6]%>&battingSR=<%=s[7]%>&at_id=<%=s[8]%>&mode=edit&admin_name=<%=admin_name%>">Edit</a></td>
						<td><a href="btscorecard.jsp?p_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="btscorecard.jsp?mode=add&admin_name=<%=admin_name%>&m_id=<%=m_id%>&l_id=<%=l_id%>">Add New Player</a><br/>
				<a href="matchresult.jsp?admin_name=<%=admin_name %>">Back</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			//m_id=Integer.parseInt(request.getParameter("m_id"));
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			s1.deleteRecord(p_id,m_id);		
		}
		else if("edit".equals(mode))
		{
			m_id=Integer.parseInt(request.getParameter("m_id"));
			l_id=Integer.parseInt(request.getParameter("l_id"));
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			String pname=s1.getplayername(p_id);
			int runs=Integer.parseInt(request.getParameter("runs"));
			int noOfBallsPlayed=Integer.parseInt(request.getParameter("noOfBallsPlayed"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double battingSR=Double.parseDouble(request.getParameter("battingSR"));
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			String team=s1.getTeam(at_id);
		%>
			<form action="btscorecard.jsp?mode=update&admin_name=<%=admin_name%>&m_id=<%=m_id%>&l_id=<%=l_id%>" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Player Id</th>
			<td><input type="numeric" name="p_id" value="<%=p_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Player</th>
			<td><input type="text" value="<%=pname%>" id="editname" required="required"/></td>
			</tr>
			<tr>
			<th>runs</th>
			<td><input id="editname" type="number"  name="runs"  value="<%=runs%>" required="required"/></td>
			</tr>
			<tr>
			<th>no of balls played</th>
			<td><input id="editname" type="number"  name="noOfBallsPlayed"  value="<%=noOfBallsPlayed%>" required="required"/></td>
			</tr>
			<tr>
			<th>no of 4</th>
			<td><input id="editname" type="number"  name="noOf4"  value="<%=noOf4%>" required="required"/></td>
			</tr>
			<tr>
			<th>no of 6</th>
			<td><input id="editname" type="number"  name="noOf6"  value="<%=noOf6%>" required="required"/></td>
			</tr>
			<tr>
			<th>half century</th>
			<td><input id="editname" type="number"  name="halfCentury"  value="<%=halfCentury%>" required="required"/></td>
			</tr>
			<tr>
			<th>century</th>
			<td><input id="editname" type="number"  name="century"  value="<%=century%>" required="required"/></td>
			</tr>
			<tr>
			<th>bating strike rate</th>
			<td><input id="editname" type="number" step="0.01" name="battingSR"  value="<%=battingSR%>" required="required"/></td>
			</tr>
			<tr>
			<th>team</th>
			<td><input id="editname" type="text" name="team"  value="<%=team%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="btscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id%>&l_id=<%=l_id%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			m_id=Integer.parseInt(request.getParameter("m_id"));
			l_id=Integer.parseInt(request.getParameter("l_id"));
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			int runs=Integer.parseInt(request.getParameter("runs"));
			int noOfBallsPlayed=Integer.parseInt(request.getParameter("noOfBallsPlayed"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double battingSR=Double.parseDouble(request.getParameter("battingSR"));
			int at_id=s1.getTeamid(request.getParameter("team"));
			
			int c=s1.updateRecord(p_id, runs, noOfBallsPlayed, noOf4, noOf6, halfCentury, century, battingSR, at_id, m_id, l_id); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			int r=s1.maxId()+1;
			m_id=Integer.parseInt(request.getParameter("m_id"));
			l_id=Integer.parseInt(request.getParameter("l_id"));
			admin_name=request.getParameter("admin_name");
		%>
	
			<form action="btscorecard.jsp?mode=save&admin_name=<%=admin_name%>&m_id=<%=m_id%>&l_id=<%=l_id%>" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<th>Player Id</th>
			<td><input type="numeric" name="p_id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Player</th>
			<td><input type="text" name="pname" id="editname" required="required"/></td>
			</tr>
			<tr>
			<th>runs</th>
			<td><input id="editname" type="number" name="runs"  required="required" /></td>
			</tr>
			<tr>
			<th>no of balls played</th>
			<td><input id="editname" type="number" name="noOfBallsPlayed"  required="required" /></td>
			</tr>
			<tr>
			<th>no of 4</th>
			<td><input id="editname" type="number" name="noOf4"  required="required" /></td>
			</tr>
			<tr>
			<th>no of 6</th>
			<td><input id="editname" type="number" name="noOf6"  required="required" /></td>
			</tr>
			<tr>
			<th>half century</th>
			<td><input id="editname" type="number" name="halfCentury"  required="required" /></td>
			</tr>
			<tr>
			<th>century</th>
			<td><input id="editname" type="number" name="century"  required="required" /></td>
			</tr>
			<tr>
			<th>bating strike rate</th>
			<td><input id="editname" type="number" step="0.01" name="battingSR" required="required" /></td>
			</tr>
			<tr>
			<th>team</th>
			<td><input id="editname" type="text" name="team"  required="required" /></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="add" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="btscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id%>&l_id=<%=l_id%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			m_id=Integer.parseInt(request.getParameter("m_id"));
			l_id=Integer.parseInt(request.getParameter("l_id"));
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			int runs=Integer.parseInt(request.getParameter("runs"));
			int noOfBallsPlayed=Integer.parseInt(request.getParameter("noOfBallsPlayed"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double battingSR=Double.parseDouble(request.getParameter("battingSR"));
			int at_id=s1.getTeamid(request.getParameter("team"));
			int c=s1.addRecord(p_id, runs, noOfBallsPlayed, noOf4, noOf6, halfCentury, century, battingSR, at_id, m_id, l_id); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="btscorecard.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
		<jsp:param value="<%=m_id %>" name="m_id"/>
		<jsp:param value="<%=l_id %>" name="l_id"/>
	</jsp:include>

</body>
</html>