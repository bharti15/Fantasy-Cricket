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
	int l_id=Integer.parseInt(request.getParameter("l_id"));
	int m_id=Integer.parseInt(request.getParameter("m_id"));
	int user_id=Integer.parseInt(request.getParameter("user_id"));
	int ut_id=Integer.parseInt(request.getParameter("ut_id"));
	int removeId=Integer.parseInt(request.getParameter("removeId"));
	int addId=Integer.parseInt(request.getParameter("addId"));
	out.println("rid: "+removeId);
	out.println("aid: "+addId);
	Transfer tf=new Transfer();
	tf.replace(removeId, addId, ut_id);
%>

		<jsp:include page="userprofile.jsp">
			<jsp:param name="mode" value="create1"/>
			<jsp:param name="l_id" value="<%=l_id%>"/>
			<jsp:param name="user_id" value="<%=user_id%>"/>
			<jsp:param name="m_id" value="<%=m_id%>"/>
			
    	</jsp:include>

</body>
</html>