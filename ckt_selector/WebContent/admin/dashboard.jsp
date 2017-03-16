<%@ page import="ckt_selector.*" %>
<%@page import="java.sql.SQLException" session="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Dashboard</title>
</head>
<body>
	<%
		HttpSession session=request.getSession(false);
		if(session==null)
		{
	%>
			<jsp:forward page="index.jsp"></jsp:forward>
	<%	
			return;		
		}
		DConnection db=new DConnection();
		int c=db.UpdateUserTransfer();System.out.println("UpdateUserTransfer() ran?"+c);
		if(c>0){
			out.println("updated");
		}
		else{
			out.println("not updated");
		}
	%>
	<%
		String admin_name=request.getParameter("admin_name");
		//out.println("<center>"+admin_name+"</center>");
		//String admin_id=request.getParameter("admin_id");
	%>
	<B><U>Actual Match Details:</U></B><br/>
	1.<a href="acteam.jsp?admin_name=<%=admin_name%>">Actual Match Teams</a><br>
    2.<a href="atplayers.jsp?admin_name=<%=admin_name%>">Actual Match Players</a><br>
   
    <br/><br/>
    <B><U>League and Match Details:</U></B><br/>
    1.<a href="league.jsp?admin_name=<%=admin_name%>">League Details</a><br>
    2.<a href="match.jsp?admin_name=<%=admin_name%>">Match Details</a><br>
    3.<a href="matchresult.jsp?admin_name=<%=admin_name%>">Match Result</a><br>
    <br/><br/>
    <B><U>Points Details:</U></B><br/>
    1.<a href="batingpts.jsp?admin_name=<%=admin_name%>">Bating Points </a><br>
    2.<a href="bowlingpts.jsp?admin_name=<%=admin_name%>">Bowling Points </a><br>
    3.<a href="fieldpts.jsp?admin_name=<%=admin_name%>">Fielding Points </a><br>
    4.<a href="bonuspts.jsp?admin_name=<%=admin_name%>">Bonus Points </a><br>
    Captain Points: each point doubles
    <br/><br/>
    <B><U>Player Details:</U></B><br/>
    1.<a href="players.jsp?admin_name=<%=admin_name%>">To change Player Details </a><br>
    2.<a href="playersupdate.jsp?admin_name=<%=admin_name%>">To update player details after each match </a><br>
    <br/><br/>
    <B><U>Other Details:</U></B><br/>
    <a href="specificationId.jsp?admin_name=<%=admin_name%>">Specification Id </a><br>
    <a href="teamformat.jsp?admin_name=<%=admin_name%>">Team Format </a><br>
    <br/><br/>
    
    
    <br/><br/>
    <a href="admin_index.jsp">LOGOUT </a><br>
    
</body>
</html>