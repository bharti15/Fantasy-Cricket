<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" import="ckt_selector.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
		function f1(p_id,l_id,m_id,user_id)
		{

var a;
a=new XMLHttpRequest();
a.onreadystatechange=function()
{	
	
	if(a.readyState==4 && a.status==200)
	{
		document.getElementById("playerdiv2").innerHTML=a.responseText;
	}
}
a.open("GET","userplayers.jsp?p_id="+p_id+"&l_id="+l_id+"&m_id="+m_id+"&user_id"+user_id,true);
a.send();
		}
	</script>
</head>
<body>
<% 



response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Expires","0"); 
response.setDateHeader("Expires",-1); 
%> 
<%
	try
	{
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		int m_id=Integer.parseInt(request.getParameter("m_id"));
		//int p_id=Integer.parseInt(request.getParameter("p_id"));
		int at_id1=Integer.parseInt(request.getParameter("at_id1"));
		int at_id2=Integer.parseInt(request.getParameter("at_id2"));
		Players p1=new Players();
		int a[]=p1.getplayers(at_id1,at_id2);
		int p_id;
		ArrayList<String[]> v=p1.matchplayers(a);
		String[] w=v.get(0); p_id=Integer.parseInt(w[0]);
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ckt_slctor","root","");
		Statement stmt=conn.createStatement();
		Statement stmt2=conn.createStatement();
		ResultSet rst=stmt.executeQuery("select * from players");
		

%>
<form class="form-inline">

	<div id="playerdiv1" class="form-group">
	
		<center>
		<table border="1" width="500px">
		<tr><th>Player</th><th>His Specification</th><th>Points</th><th></th></tr>
<%		
	for(int i=0;i<v.size();i++)
	{
%>
		<tr>
<%			
		String s[]=(String [])v.get(i);
		for(int j=1;j<4;j++)
		{
%>
			<td><%=s[j] %></td>
<%				
		}
		int id=Integer.parseInt(s[0]);
%>
			<td><input type="button" onclick="f1(this.value)" class="form-control" text="add" name="player" value="<%=id %>" />ADD</td>
			</tr>
<%
	}
%>
	</table>
	</center>
		<select name="player1" onchange="f1(this.value)" class="form-control" style="width:200px;">
		<span class="caret"></span>
<%
			ResultSet rst2=stmt2.executeQuery("select p_id,p_name,specification,bet_pt from players where p_id="+p_id);
			while(rst2.next())
			{
%>			
				<option value="<%=rst2.getString(1)%>"> 
				<%=rst2.getString(2)%> <%=rst2.getString(3) %></option>
<%
			}
%>
		</select>
	</div>
	<div id="playerdiv2" class="form-group">
		<select name="player2" class="form-control" style="width:200px;">
		<span class="caret"></span>
<%
			while(rst2.next())
			{
%>			
				<option value="<%=rst2.getString(1)%>"> 
				<%=rst2.getString(2)%></option>
<%
			}
%>
		</select>
	</div>
	
<%
		stmt2.close();
		conn.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
</form>

</body>
</html>