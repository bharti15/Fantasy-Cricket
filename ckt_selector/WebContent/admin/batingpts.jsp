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
		ckt_selector.Batingpts s1=new ckt_selector.Batingpts();
		String mode=request.getParameter("mode");
		if("display".equals(mode))
		{
				Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Bating Points</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>1 run</th><th>6 run</th><th>4 run</th><th>Duck</th><th>Half Century</th><th>Century</th><th>Bating StrikeRate(100-149)</th><th>Bating StrikeRate(150-199)</th><th>Bating StrikeRate(>200)</th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(int j=0;j<9;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><a href="batingpts.jsp?admin_name=<%=admin_name%>&run1=<%=s[0]%>&run6=<%=s[1]%>&run4=<%=s[2]%>&duck=<%=s[3]%>&halfCentury=<%=s[4]%>&century=<%=s[5]%>&bt_sr100_149=<%=s[6]%>&bt_sr150_199=<%=s[7]%>&bt_sr200_=<%=s[8]%>&mode=edit">Edit</a></td>
						
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="dashboard.jsp?admin_id=<%=admin_name%>">Go To DashBoard</a>
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
			double run1=Double.parseDouble(request.getParameter("run1"));
			double run6=Double.parseDouble(request.getParameter("run6"));
			double run4=Double.parseDouble(request.getParameter("run4"));
			double duck=Double.parseDouble(request.getParameter("duck"));
			double halfCentury=Double.parseDouble(request.getParameter("halfCentury"));
			double century=Double.parseDouble(request.getParameter("century"));
			double bt_sr100_149=Double.parseDouble(request.getParameter("bt_sr100_149"));
			double bt_sr150_199=Double.parseDouble(request.getParameter("bt_sr150_199"));
			double bt_sr200_=Double.parseDouble(request.getParameter("bt_sr200_"));
		%>
			<form action="batingpts.jsp?mode=update&admin_name=<%=admin_name%>" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>1 Run</th>
			<td><input type="number" step="0.01" name="run1" value="<%=run1%>" id="editable" required="required"/></td>
			</tr>
			<tr>
			<th>6 Run</th>
			<td><input id="editname" type="number" step="0.01" name="run6"  value="<%=run6%>" required="required" /></td>
			</tr>
			<tr>
			<th>4 Run</th>
			<td><input id="editname" type="number" step="0.01" name="run4"  value="<%=run4%>" required="required"/></td>
			</tr>
			<tr>
			<th>Duck</th>
			<td><input id="editname" type="number" step="0.01" name="duck"  value="<%=duck%>" required="required"/></td>
			</tr>
			<tr>
			<th>Half Century</th>
			<td><input id="editname" type="number" step="0.01" name="halfCentury"  value="<%=halfCentury%>" required="required"/></td>
			</tr>
			<tr>
			<th>Century</th>
			<td><input id="editname" type="number" step="0.01" name="century"  value="<%=century%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bating StrikeRate 100-149</th>
			<td><input id="editname" type="number" step="0.01" name="bt_sr100_149"  value="<%=bt_sr100_149%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bating StrikeRate 150-199</th>
			<td><input id="editname" type="number" step="0.01" name="bt_sr150_199"  value="<%=bt_sr150_199%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bating StrikeRate >200</th>
			<td><input id="editname" type="number" step="0.01"s name="bt_sr200_"  value="<%=bt_sr200_%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="batingpts.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			double run1=Double.parseDouble(request.getParameter("run1"));
			double run6=Double.parseDouble(request.getParameter("run6"));
			double run4=Double.parseDouble(request.getParameter("run4"));
			double duck=Double.parseDouble(request.getParameter("duck"));
			double halfCentury=Double.parseDouble(request.getParameter("halfCentury"));
			double century=Double.parseDouble(request.getParameter("century"));
			double bt_sr100_149=Double.parseDouble(request.getParameter("bt_sr100_149"));
			double bt_sr150_199=Double.parseDouble(request.getParameter("bt_sr150_199"));
			double bt_sr200_=Double.parseDouble(request.getParameter("bt_sr200_"));
			int c=s1.updateRecord(run1, run6, run4, duck, halfCentury, century, bt_sr100_149, bt_sr150_199, bt_sr200_); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}

		%>
		<jsp:include page="batingpts.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>
	

</body>
</html>