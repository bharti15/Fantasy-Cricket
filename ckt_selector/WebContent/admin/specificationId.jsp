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
		ckt_selector.SpecificationId s1=new ckt_selector.SpecificationId();
		String mode=request.getParameter("mode");
		if("display".equals(mode))
		{
				Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Specification Id's of Player</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>Id</th><th>Value</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(int j=0;j<2;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><a href="specificationId.jsp?admin_name=<%=admin_name%>&id=<%=s[0]%>&value=<%=s[1]%>&mode=edit">Edit</a></td>
						<td><a href="specificationId.jsp?id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="specificationId.jsp?admin_name=<%=admin_name%>&mode=add">Add New Specification</a><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name%>">Go To DashBoard</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			int id=Integer.parseInt(request.getParameter("id"));
			s1.deleteRecord(id);		
		}
		else if("edit".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int id=Integer.parseInt(request.getParameter("id"));
			String value=request.getParameter("value");
		%>
			<form action="specificationId.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Id </th>
			<td><input type="text" name="id" value="<%=id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Value </th>
			<td><input id="editname" type="text" name="value"  value="<%=value%>"  required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="specificationId.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int id=Integer.parseInt(request.getParameter("id"));
			String value=request.getParameter("value");
			int c=s1.updateRecord(id,value); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int r=s1.maxId()+1;
		%>
	
			<form action="specificationId.jsp?admin_name=<%=admin_name%>&mode=save" method="post" name="addform">
			<table border="1" >
			<tbody>
			<tr>
			<td>Id</td>
			<td><input type="text" name="id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<td>Value</td>
			<td><input id="addname" type="text" name="value"  required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="save" name="submit" class="btn btn-primary"/></td></tr>
			</tbody>
			</table>
			<a href="specificationId.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int id=Integer.parseInt(request.getParameter("id"));
			String value=request.getParameter("value");
			int c=s1.addRecord(id, value); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="specificationId.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>
		
	
</body>
</html>