<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.text.SimpleDateFormat" import="java.util.Date" import="java.sql.*" session="false" import="ckt_selector.*" import="java.util.*" import="java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String []array = request.getParameter("array").split(",");
	double leftpts=Double.parseDouble(request.getParameter("array1"));
	int pbatsman=Integer.parseInt(request.getParameter("pbatsman"));
	int pbowler=Integer.parseInt(request.getParameter("pbowler"));
	int pwk=Integer.parseInt(request.getParameter("pwk"));
	int par=Integer.parseInt(request.getParameter("par"));
	int l_id=Integer.parseInt(request.getParameter("l_id"));
	int m_id=Integer.parseInt(request.getParameter("m_id"));
	int user_id=Integer.parseInt(request.getParameter("user_id"));
	int at_id1=Integer.parseInt(request.getParameter("at_id1"));
	int at_id2=Integer.parseInt(request.getParameter("at_id2"));
	User1 u1=new User1();
	
	// To update user no of teams:
	int c=u1.userNoOfTeam(user_id);
	//out.println("c: "+c);
	
	// To add new team details:
	// This method will return ut_id
	int ut_id=u1.userDetails(leftpts, m_id, l_id, user_id);
	//out.println("ut_id: "+ut_id);
	
	// To add new user performance:
	int c1=u1.userPerformance(ut_id, user_id, m_id, l_id);
	//out.println("c1: "+c1);
	
	// To players in its team:
	java.util.Date date = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String curdate = formatter.format(date);
	int c2=u1.userPlayers(ut_id, array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10], curdate, curdate);
	//out.println("c2: "+c2);
	
	// To user player specifiaction details:
	int c3=u1.userPlayerSpecification(ut_id, pbatsman, pbowler, pwk, par);
	//out.println("c3: "+c3);
	
	// Transfer Details:
	int c4=u1.userTransferDetails(ut_id);
	//out.println("c4: "+c4);
	
	// To update user no of teams:
	int c5=u1.userNoOfTeam(user_id);
	
	
	out.println("<center><b>Team Created!</b></center>");
%>

		<jsp:include page="userprofile.jsp">
			<jsp:param name="mode" value="create1"/>
			<jsp:param name="l_id" value="<%=l_id%>"/>
			<jsp:param name="user_id" value="<%=user_id%>"/>
			<jsp:param name="m_id" value="<%=m_id%>"/>
			<jsp:param name="at_id1" value="<%=at_id1%>"/>
			<jsp:param name="at_id2" value="<%=at_id2%>"/>
    	</jsp:include>	
</body>
</html>