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
		ckt_selector.Teamformat s1=new ckt_selector.Teamformat();
		String mode=request.getParameter("mode");
		if("display".equals(mode))
		{
				Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Team Format</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Min/Max Size</th><th>All Rounder</th><th>Batsmen</th><th>Wicket Keeper</th><th>Bowler</th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(int j=0;j<5;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><a href="teamformat.jsp?admin_name=<%=admin_name%>&limits=<%=s[0]%>&ar=<%=s[1]%>&bt=<%=s[2]%>&wk=<%=s[3]%>&bw=<%=s[4]%>&mode=edit">Edit</a></td>
						
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
			int limits=Integer.parseInt(request.getParameter("limits"));
			int ar=Integer.parseInt(request.getParameter("ar"));
			int bt=Integer.parseInt(request.getParameter("bt"));
			int wk=Integer.parseInt(request.getParameter("wk"));
			int bw=Integer.parseInt(request.getParameter("bw"));
		%>
			<form action="teamformat.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Min/Max Size </th>
			<td><input type="numeric" name="limits" value="<%=limits%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>All Rounder </th>
			<td><input id="editname" type="numeric" name="ar"  value="<%=ar%>" required="required"/></td>
			</tr>
			<tr>
			<th>Batsmen </th>
			<td><input id="editname" type="numeric" name="bt"  value="<%=bt%>" required="required"/></td>
			</tr>
			<tr>
			<th>Wicket Keeper </th>
			<td><input id="editname" type="numeric" name="wk"  value="<%=wk%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bowler </th>
			<td><input id="editname" type="numeric" name="bw"  value="<%=bw%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="teamformat.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int limits=Integer.parseInt(request.getParameter("limits"));
			int ar=Integer.parseInt(request.getParameter("ar"));
			int bt=Integer.parseInt(request.getParameter("bt"));
			int wk=Integer.parseInt(request.getParameter("wk"));
			int bw=Integer.parseInt(request.getParameter("bw"));
			int c=s1.updateRecord(limits, ar, bt, wk, bw); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}

		%>
		<jsp:include page="teamformat.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>

</body>
</html>