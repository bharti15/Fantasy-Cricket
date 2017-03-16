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
		ckt_selector.Atplayers s1=new ckt_selector.Atplayers();
		if("display".equals(mode))
		{
			
			Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Actual Match Players</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Team Id</th><th>Player 1</th><th>Player 2</th><th>Player 3</th><th>Player 4</th><th>Player 5</th><th>Player 6</th><th>Player 7</th><th>Player 8</th><th>Player 9</th><th>Player 10</th><th>Player 11</th><th>Player 12</th><th>Player 13</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					int at_id=Integer.parseInt(s[0]);
					String team=s1.getTeam(at_id);
					int n[]=s1.getteamPlayers(at_id);
					String s2[]=s1.getplayerName(n);
					%>
					<td><%=team%></td>
					<%
					for(int j=0;j<13;j++)
					{
		%>
						<td><%=s2[j] %></td>
		<%				
					}
		%>
						<td><a href="atplayers.jsp?admin_name=<%=admin_name %>&at_id=<%=s[0]%>&at_p1=<%=s[1]%>&at_p2=<%=s[2]%>&at_p3=<%=s[3]%>&at_p4=<%=s[4]%>&at_p5=<%=s[5]%>&at_p6=<%=s[6]%>&at_p7=<%=s[7]%>&at_p8=<%=s[8]%>&at_p9=<%=s[9]%>&at_p10=<%=s[10]%>&at_p11=<%=s[11]%>&at_p12=<%=s[12]%>&at_p13=<%=s[13]%>&mode=edit">Edit</a></td>
						<td><a href="atplayers.jsp?at_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="atplayers.jsp?admin_name=<%=admin_name %>&mode=add">Add New Team Players Details</a><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name %>">Go To DashBoard</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			s1.deleteRecord(at_id);		
		}
		else if("edit".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int at_p[]=new int[13];
			for(int i=0;i<13;i++){
				at_p[i]=Integer.parseInt(request.getParameter("at_p"+(i+1)));
			}
			String s2[]=s1.getplayerName(at_p);
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			
		%>
			<form action="atplayers.jsp?admin_name=<%=admin_name %>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Team Id</th>
			<td><input type="text" name="at_id" value="<%=at_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Player 1 id</th>
			<td><input id="editname" type="text" name="at_p1"  value="<%=s2[0]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 2 id</th>
			<td><input id="editname" type="text" name="at_p2"  value="<%=s2[1]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 3 id</th>
			<td><input id="editname" type="text" name="at_p3"  value="<%=s2[2]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 4 id</th>
			<td><input id="editname" type="text" name="at_p4"  value="<%=s2[3]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 5 id</th>
			<td><input id="editname" type="text" name="at_p5"  value="<%=s2[4]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 6 id</th>
			<td><input id="editname" type="text" name="at_p6"  value="<%=s2[5]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 7 id</th>
			<td><input id="editname" type="text" name="at_p7"  value="<%=s2[6]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 8 id</th>
			<td><input id="editname" type="text" name="at_p8"  value="<%=s2[7]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 9 id</th>
			<td><input id="editname" type="text" name="at_p9"  value="<%=s2[8]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 10 id</th>
			<td><input id="editname" type="text" name="at_p10"  value="<%=s2[9]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 11 id</th>
			<td><input id="editname" type="text" name="at_p11"  value="<%=s2[10]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 12 id</th>
			<td><input id="editname" type="text" name="at_p12"  value="<%=s2[11]%>" required="required"/></td>
			</tr>
			<tr>
			<th>Player 13 id</th>
			<td><input id="editname" type="text" name="at_p13"  value="<%=s2[12]%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="atplayers.jsp?admin_name=<%=admin_name %>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			int at_p1=Integer.parseInt(request.getParameter("at_p1"));
			int at_p2=Integer.parseInt(request.getParameter("at_p2"));
			int at_p3=Integer.parseInt(request.getParameter("at_p3"));
			int at_p4=Integer.parseInt(request.getParameter("at_p4"));
			int at_p5=Integer.parseInt(request.getParameter("at_p5"));
			int at_p6=Integer.parseInt(request.getParameter("at_p6"));
			int at_p7=Integer.parseInt(request.getParameter("at_p7"));
			int at_p8=Integer.parseInt(request.getParameter("at_p8"));
			int at_p9=Integer.parseInt(request.getParameter("at_p9"));
			int at_p10=Integer.parseInt(request.getParameter("at_p10"));
			int at_p11=Integer.parseInt(request.getParameter("at_p11"));
			int at_p12=Integer.parseInt(request.getParameter("at_p12"));
			int at_p13=Integer.parseInt(request.getParameter("at_p13"));
			
			int c=s1.updateRecord(at_id,at_p1,at_p2,at_p3,at_p4,at_p5,at_p6,at_p7,at_p8,at_p9,at_p10,at_p11,at_p12,at_p13); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			int r=s1.maxId()+1;
			admin_name=request.getParameter("admin_name");
		%>
	
			<form action="atplayers.jsp?admin_name=<%=admin_name %>&mode=save" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<th>Team Id</th>
			<td><input type="text" name="at_id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Player 1 id</th>
			<td><input id="editname" type="text" name="at_p1"  /></td>
			</tr>
			<tr>
			<th>Player 2 id</th>
			<td><input id="editname" type="text" name="at_p2"  /></td>
			</tr>
			<tr>
			<th>Player 3 id</th>
			<td><input id="editname" type="text" name="at_p3"  /></td>
			</tr>
			<tr>
			<th>Player 4 id</th>
			<td><input id="editname" type="text" name="at_p4"  /></td>
			</tr>
			<tr>
			<th>Player 5 id</th>
			<td><input id="editname" type="text" name="at_p5"  /></td>
			</tr>
			<tr>
			<th>Player 6 id</th>
			<td><input id="editname" type="text" name="at_p6"  /></td>
			</tr>
			<tr>
			<th>Player 7 id</th>
			<td><input id="editname" type="text" name="at_p7"  /></td>
			</tr>
			<tr>
			<th>Player 8 id</th>
			<td><input id="editname" type="text" name="at_p8"  /></td>
			</tr>
			<tr>
			<th>Player 9 id</th>
			<td><input id="editname" type="text" name="at_p9"  /></td>
			</tr>
			<tr>
			<th>Player 10 id</th>
			<td><input id="editname" type="text" name="at_p10" /></td>
			</tr>
			<tr>
			<th>Player 11 id</th>
			<td><input id="editname" type="text" name="at_p11" /></td>
			</tr>
			<tr>
			<th>Player 12 id</th>
			<td><input id="editname" type="text" name="at_p12"  /></td>
			</tr>
			<tr>
			<th>Player 13 id</th>
			<td><input id="editname" type="text" name="at_p13"  /></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="atplayers.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int at_id=Integer.parseInt(request.getParameter("at_id"));
			int at_p1=Integer.parseInt(request.getParameter("at_p1"));
			int at_p2=Integer.parseInt(request.getParameter("at_p2"));
			int at_p3=Integer.parseInt(request.getParameter("at_p3"));
			int at_p4=Integer.parseInt(request.getParameter("at_p4"));
			int at_p5=Integer.parseInt(request.getParameter("at_p5"));
			int at_p6=Integer.parseInt(request.getParameter("at_p6"));
			int at_p7=Integer.parseInt(request.getParameter("at_p7"));
			int at_p8=Integer.parseInt(request.getParameter("at_p8"));
			int at_p9=Integer.parseInt(request.getParameter("at_p9"));
			int at_p10=Integer.parseInt(request.getParameter("at_p10"));
			int at_p11=Integer.parseInt(request.getParameter("at_p11"));
			int at_p12=Integer.parseInt(request.getParameter("at_p12"));
			int at_p13=Integer.parseInt(request.getParameter("at_p13"));
			int c=s1.addRecord(at_id, at_p1,at_p2,at_p3,at_p4,at_p5,at_p6,at_p7,at_p8,at_p9,at_p10,at_p11,at_p12,at_p13); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="atplayers.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>

</body>
</html>