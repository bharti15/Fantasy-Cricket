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
		ckt_selector.Bwscorecard s1=new ckt_selector.Bwscorecard();
		if("display".equals(mode))
		{
			Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Bowling Scoreguard</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Player Id</th><th>runs_given</th><th>wickets</th><th>bowling strike rate</th><th>team id</th><th></th><th></th></tr>
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

					for(int j=1;j<4;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><%=team%></td>
						<td><a href="bwscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id %>&l_id=<%=l_id %>&p_id=<%=s[0]%>&runs_given=<%=s[1]%>&wickets=<%=s[2]%>&bowlingSR=<%=s[3]%>&at_id=<%=s[4]%>&mode=edit">Edit</a></td>
						<td><a href="bwscorecard.jsp?p_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="bwscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id %>&l_id=<%=l_id %>&mode=add">Add New Player</a><br/>
				<a href="matchresult.jsp?admin_name=<%=admin_name%>">Back</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			s1.deleteRecord(p_id);		
		}
		else if("edit".equals(mode))
		{
			m_id=Integer.parseInt(request.getParameter("m_id"));
			l_id=Integer.parseInt(request.getParameter("l_id"));
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			String pname=s1.getplayername(p_id);
			int runs_given=Integer.parseInt(request.getParameter("runs_given"));
			int wickets=Integer.parseInt(request.getParameter("wickets"));
			double bowlingSR=Double.parseDouble(request.getParameter("bowlingSR"));
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			String team=s1.getTeam(at_id);
		%>
			<form action="bwscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id %>&l_id=<%=l_id %>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Player id</th>
			<td><input type="text" name="p_id" value="<%=p_id%>" readonly="readonly" required="required"/></td>
			</tr>
			<tr>
			<th>Player</th>
			<td><input type="text" name="p_id" value="<%=pname%>" id="editname" required="required"/></td>
			</tr>
			<tr>
			<th>runs given</th>
			<td><input id="editname" type="number" name="runs_given"  value="<%=runs_given%>" required="required"/></td>
			</tr>
			<tr>
			<th>wickets</th>
			<td><input id="editname" type="number" name="wickets"  value="<%=wickets%>" required="required"/></td>
			</tr>
			<tr>
			<th>bowling strike rate</th>
			<td><input id="editname" type="number" step="0.01" name="bowlingSR"  value="<%=bowlingSR%>" required="required"/></td>
			</tr>
			<tr>
			<th>team</th>
			<td><input id="editname" type="text" name="team"  value="<%=team%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="bwscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id %>&l_id=<%=l_id %>&mode=display"> Back </a>

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
			int runs_given=Integer.parseInt(request.getParameter("runs_given"));
			int wickets=Integer.parseInt(request.getParameter("wickets"));
			double bowlingSR=Double.parseDouble(request.getParameter("bowlingSR"));
			int at_id=s1.getTeamid(request.getParameter("team"));
			
			int c=s1.updateRecord(p_id, runs_given, wickets, bowlingSR, at_id,m_id,l_id); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			m_id=Integer.parseInt(request.getParameter("m_id"));
			l_id=Integer.parseInt(request.getParameter("l_id"));
			int r=s1.maxId()+1;
			admin_name=request.getParameter("admin_name");
		%>
	
			<form action="bwscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id %>&l_id=<%=l_id %>&mode=save" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<th>Player Id</th>
			<td><input type="text" name="p_id" id="editname" required="required"/></td>
			</tr>
			<tr>
			<th>Player</th>
			<td><input type="text" name="pname" id="editname" required="required"/></td>
			</tr>
			<tr>
			<th>runs given</th>
			<td><input id="editname" type="number" name="runs_given"  required="required"/></td>
			</tr>
			<tr>
			<th>wickets</th>
			<td><input id="editname" type="number" name="wickets"   required="required"/></td>
			</tr>
			<tr>
			<th>bowling strike rate</th>
			<td><input id="editname" type="number" step="0.01" name="bowlingSR"  required="required" /></td>
			</tr>
			<tr>
			<th>team</th>
			<td><input id="editname" type="text" name="team"  required="required" /></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="bwscorecard.jsp?admin_name=<%=admin_name%>&m_id=<%=m_id %>&l_id=<%=l_id %>"> Back </a>
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
			int runs_given=Integer.parseInt(request.getParameter("runs_given"));
			int wickets=Integer.parseInt(request.getParameter("wickets"));
			double bowlingSR=Double.parseDouble(request.getParameter("bowlingSR"));
			int at_id=s1.getTeamid(request.getParameter("team"));
			int c=s1.addRecord(p_id, runs_given, wickets, bowlingSR, at_id, m_id, l_id); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="bwscorecard.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
		<jsp:param value="<%=m_id %>" name="m_id"/>
		<jsp:param value="<%=l_id %>" name="l_id"/>
	</jsp:include>

</body>
</html>