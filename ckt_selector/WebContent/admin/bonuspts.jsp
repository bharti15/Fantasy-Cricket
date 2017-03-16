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
		ckt_selector.Bonuspts s1=new ckt_selector.Bonuspts();
		String mode=request.getParameter("mode");
		if("display".equals(mode))
		{
				Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Bonus Points</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>ManOfMatch pts to player</th><th>ManOfMatch pts to team</th><th>Victory pts to player/team</th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(int j=0;j<3;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><a href="bonuspts.jsp?admin_name=<%=admin_name%>&man_player=<%=s[0]%>&man_team=<%=s[1]%>&victory_player=<%=s[2]%>&mode=edit">Edit</a></td>
						
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
			double man_player=Double.parseDouble(request.getParameter("man_player"));
			double man_team=Double.parseDouble(request.getParameter("man_team"));
			double victory_player=Double.parseDouble(request.getParameter("victory_player"));
		%>
			<form action="bonuspts.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>ManOfMatch pts to player</th>
			<td><input type="number" step="0.01" name="man_player" value="<%=man_player%>" id="editable" required="required"/></td>
			</tr>
			<tr>
			<th>ManOfMatch pts to team</th>
			<td><input id="editname" type="number" step="0.01" name="man_team"  value="<%=man_team%>" required="required"/></td>
			</tr>
			<tr>
			<th>Victory pts to player/team</th>
			<td><input id="editname" type="number" step="0.01" name="victory_player"  value="<%=victory_player%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="bonuspts.jsp?admin_name=<%=admin_name %>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			double man_player=Double.parseDouble(request.getParameter("man_player"));
			double man_team=Double.parseDouble(request.getParameter("man_team"));
			double victory_player=Double.parseDouble(request.getParameter("victory_player"));
			int c=s1.updateRecord(man_player, man_team, victory_player); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}

		%>
		<jsp:include page="bonuspts.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name%>" name="admin_name"/>
	</jsp:include>
	

</body>
</html>