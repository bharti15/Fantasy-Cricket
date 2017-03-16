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
		ckt_selector.Bowlingpts s1=new ckt_selector.Bowlingpts();
		String mode=request.getParameter("mode");
		if("display".equals(mode))
		{
				Vector<String []> v = s1.showRecordAll();
		%>
					<center>
					<b><u>Bowling Points</u></b>
					<br/><br/>
					<table border="1" width="500px">
					<tr><th>bowled</th><th>wickets</th><th>LBW</th><th>Dot Ball</th><th>Maiden Over</th><th>Hattrik</th><th>Bowling StrikeRate(30-39)</th><th>Bowling StrikeRate(40-49)</th><th>Bowling StrikeRate(>50)</th><th>Hit Wicket</th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(int j=0;j<10;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><a href="bowlingpts.jsp?admin_name=<%=admin_name%>&bowled=<%=s[0]%>&wickets=<%=s[1]%>&LBW=<%=s[2]%>&dotBall=<%=s[3]%>&maidenOver=<%=s[4]%>&hattrik=<%=s[5]%>&bowl_sr30_39=<%=s[6]%>&bowl_sr40_49=<%=s[7]%>&bowl_sr50_=<%=s[8]%>&hitWicket=<%=s[9]%>&mode=edit">Edit</a></td>
						
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
			double bowled=Double.parseDouble(request.getParameter("bowled"));
			double wickets=Double.parseDouble(request.getParameter("wickets"));
			double LBW=Double.parseDouble(request.getParameter("LBW"));
			double dotBall=Double.parseDouble(request.getParameter("dotBall"));
			double maidenOver=Double.parseDouble(request.getParameter("maidenOver"));
			double hattrik=Double.parseDouble(request.getParameter("hattrik"));
			double bowl_sr30_39=Double.parseDouble(request.getParameter("bowl_sr30_39"));
			double bowl_sr40_49=Double.parseDouble(request.getParameter("bowl_sr40_49"));
			double bowl_sr50_=Double.parseDouble(request.getParameter("bowl_sr50_"));
			double hitWicket=Double.parseDouble(request.getParameter("hitWicket"));
		%>
			<form action="bowlingpts.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>bowled</th>
			<td><input type="number" step="0.01" name="bowled" value="<%=bowled%>" id="editable" required="required"/></td>
			</tr>
			<tr>
			<th>wickets</th>
			<td><input id="editname" type="number" step="0.01" name="wickets"  value="<%=wickets%>" required="required"/></td>
			</tr>
			<tr>
			<th>LBW</th>
			<td><input id="editname" type="number" step="0.01" name="LBW"  value="<%=LBW%>" required="required"/></td>
			</tr>
			<tr>
			<th>Dot Ball</th>
			<td><input id="editname" type="number" step="0.01" name="dotBall"  value="<%=dotBall%>" required="required"/></td>
			</tr>
			<tr>
			<th>Maiden Over</th>
			<td><input id="editname" type="number" step="0.01" name="maidenOver"  value="<%=maidenOver%>" required="required"/></td>
			</tr>
			<tr>
			<th>Hattrik</th>
			<td><input id="editname" type="number" step="0.01" name="hattrik"  value="<%=hattrik%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bowling StrikeRate 30-39</th>
			<td><input id="editname" type="number" step="0.01" name="bowl_sr30_39"  value="<%=bowl_sr30_39%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bowling StrikeRate 40-49</th>
			<td><input id="editname" type="number" step="0.01" name="bowl_sr40_49"  value="<%=bowl_sr40_49%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bowling StrikeRate >50</th>
			<td><input id="editname" type="number" step="0.01" name="bt_sr200_"  value="<%=bowl_sr50_%>" required="required"/></td>
			</tr>
			<tr>
			<th>Hit Wicket</th>
			<td><input id="editname" type="number" step="0.01" name="hitWicket"  value="<%=hitWicket%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="bowlingpts.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			double bowled=Double.parseDouble(request.getParameter("bowled"));
			double wickets=Double.parseDouble(request.getParameter("wickets"));
			double LBW=Double.parseDouble(request.getParameter("LBW"));
			double dotBall=Double.parseDouble(request.getParameter("dotBall"));
			double maidenOver=Double.parseDouble(request.getParameter("maidenOver"));
			double hattrik=Double.parseDouble(request.getParameter("hattrik"));
			double bowl_sr30_39=Double.parseDouble(request.getParameter("bowl_sr30_39"));
			double bowl_sr40_49=Double.parseDouble(request.getParameter("bowl_sr40_49"));
			double bowl_sr50_=Double.parseDouble(request.getParameter("bowl_sr50_"));
			double hitWicket=Double.parseDouble(request.getParameter("hitWicket"));
			int c=s1.updateRecord(bowled, wickets, LBW, dotBall, maidenOver, hattrik, bowl_sr30_39, bowl_sr40_49, bowl_sr50_,hitWicket); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}

		%>
		<jsp:include page="bowlingpts.jsp">
		<jsp:param value="display" name="mode"/>
	</jsp:include>
	

</body>
</html>