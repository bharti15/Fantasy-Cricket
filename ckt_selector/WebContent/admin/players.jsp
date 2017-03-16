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
		ckt_selector.Players s1=new ckt_selector.Players();
		if("display".equals(mode))
		{
			Vector<String []> v = s1.showRecordAll();
		%>
		
		## Note:<br/>
	1. Specification Id for:<br/>
		- Batsman: 01<br/>
		- Bowler: 02<br/>
		- All Rounder: 03<br/>
		- Wicket Keeper: 04
		<br/><br/>
					<b><u>Change Player Details:</u></b>
					<br><br>
					<center>
					<table border="1" width="500px">
					<tr><th>Id</th><th>Name</th><th>Total runs</th><th>Maximum Bating StrikeRate</th><th>Current Bating StrikeRate</th><th>Total Wickets</th><th>Total Catchout</th><th>Half Century</th><th>century</th><th> Maximum Runrate</th><th>No. of 6</th><th>No. of 4</th><th>Maximum Bowling StrikeRate</th><th>Stumps Taken</th><th>Bowled</th><th>Total Catches Taken</th><th>Total Runouts</th><th>Direct Hits</th><th>LBW</th><th>Dot Ball</th><th>Maiden Over</th><th>Hattrik</th><th>Duck</th><th>Total Points</th><th>His Betting Points</th><th>His specification</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(int j=0;j<26;j++)
					{
						if(j!=23){
		%>
						<td><%=s[j] %></td>
		<%
						}
					}
					if("1".equals(s[23])){
						%>
						<td>Batsman</td>
						<%
					}
					else if("2".equals(s[23])){
						%>
						<td>Bowler</td>
						<%
					}
					else if("3".equals(s[23])){
						%>
						<td>All Rounder</td>
						<%
					}
					else if("4".equals(s[23])){
						%>
						<td>Wicket Keeper</td>
						<%
					}
		%>
						<td><a href="players.jsp?admin_name=<%=admin_name%>&p_id=<%=s[0]%>&p_name=<%=s[1]%>&tot_runs=<%=s[2]%>&max_sr=<%=s[3]%>&curr_sr=<%=s[4]%>&tot_wk=<%=s[5]%>&tot_catchout=<%=s[6]%>&halfCentury=<%=s[7]%>&century=<%=s[8]%>&max_runrate=<%=s[9]%>&noOf6=<%=s[10]%>&noOf4=<%=s[11]%>&max_bowlsr=<%=s[12]%>&stumpsTaken=<%=s[13]%>&bowled=<%=s[14]%>&tot_catchesTaken=<%=s[15]%>&tot_runouts=<%=s[16]%>&directHits=<%=s[17]%>&LBW=<%=s[18]%>&dotBall=<%=s[19]%>&maidenOver=<%=s[20]%>&hattrik=<%=s[21]%>&duck=<%=s[22]%>&specification=<%=s[23]%>&tot_pts=<%=s[24]%>&bet_pt=<%=s[25]%>&mode=edit">Edit</a></td>
						<td><a href="players.jsp?admin_name=<%=admin_name%>&p_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<br/><br/>
				<a href="players.jsp?admin_name=<%=admin_name%>&mode=add">Add New Player</a><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name %>">Go To DashBoard</a>
				</center>
		<%
				return;
		}
		else if("delete".equals(mode))
		{
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			s1.deleteRecord(p_id);		
		}
		else if("edit".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			String p_name=request.getParameter("p_name");
			int tot_runs=Integer.parseInt(request.getParameter("tot_runs"));
			double max_sr=Double.parseDouble(request.getParameter("max_sr"));
			double curr_sr=Double.parseDouble(request.getParameter("curr_sr"));
			int tot_wk=Integer.parseInt(request.getParameter("tot_wk"));
			int tot_catchout=Integer.parseInt(request.getParameter("tot_catchout"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double max_runrate=Double.parseDouble(request.getParameter("max_runrate"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			double max_bowlsr=Double.parseDouble(request.getParameter("max_bowlsr"));
			int stumpsTaken=Integer.parseInt(request.getParameter("stumpsTaken"));
			int bowled=Integer.parseInt(request.getParameter("bowled"));
			int tot_catchesTaken=Integer.parseInt(request.getParameter("tot_catchesTaken"));
			int tot_runouts=Integer.parseInt(request.getParameter("tot_runouts"));
			int directHits=Integer.parseInt(request.getParameter("directHits"));
			int LBW=Integer.parseInt(request.getParameter("LBW"));
			int dotBall=Integer.parseInt(request.getParameter("dotBall"));
			int maidenOver=Integer.parseInt(request.getParameter("maidenOver"));
			int hattrik=Integer.parseInt(request.getParameter("hattrik"));
			int duck=Integer.parseInt(request.getParameter("duck"));
			int specification=Integer.parseInt(request.getParameter("specification"));
			double tot_pts=Double.parseDouble(request.getParameter("tot_pts"));
			double bet_pt=Double.parseDouble(request.getParameter("bet_pt"));
		%>
		## Note:<br/>
	1. Specification Id for:<br/>
		- Batsman: 01<br/>
		- Bowler: 02<br/>
		- All Rounder: 03<br/>
		- Wicket Keeper: 04
		<br/><br/>
			<form action="players.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Player Id </th>
			<td><input type="text" name="p_id" value="<%=p_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Player Name </th>
			<td><input id="editname" type="text" name="p_name"  value="<%=p_name%>" required="required"/></td>
			</tr>
			<tr>
			<th>Total Runs</th>
			<td><input id="editname" type="numeric" name="tot_runs"  value="<%=tot_runs%>" required="required"/></td>
			</tr>
			<tr>
			<th>Maximum StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="max_sr"  value="<%=max_sr%>" required="required"/></td>
			</tr>
			<tr>
			<th>Current StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="curr_sr"  value="<%=curr_sr%>" required="required"/></td>
			</tr>
			<tr>
			<th>Total Wickets</th>
			<td><input id="editname" type="numeric" name="tot_wk"  value="<%=tot_wk%>" required="required"/></td>
			</tr>
			<tr>
			<th>Total Catchouts</th>
			<td><input id="editname" type="numeric" name="tot_catchout"  value="<%=tot_catchout%>" required="required"/></td>
			</tr>
			<tr>
			<th>Half Century</th>
			<td><input id="editname" type="numeric" name="halfCentury"  value="<%=halfCentury%>" required="required"/></td>
			</tr>
			<tr>
			<th>Century</th>
			<td><input id="editname" type="numeric" name="century"  value="<%=century%>" required="required"/></td>
			</tr>
			<tr>
			<th>Maximum RunRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="max_runrate"  value="<%=max_runrate%>" required="required"/></td>
			</tr>
			<tr>
			<th>No. of 6</th>
			<td><input id="editname" type="numeric" name="noOf6"  value="<%=noOf6%>" required="required"/></td>
			</tr>
			<tr>
			<th>No. of 4</th>
			<td><input id="editname" type="numeric" name="noOf4"  value="<%=noOf4%>" required="required"/></td>
			</tr>
			<tr>
			<th>Maximum Bowling StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="max_bowlsr"  value="<%=max_bowlsr%>" required="required"/></td>
			</tr>
			<tr>
			<th>Stumps Taken</th>
			<td><input id="editname" type="numeric" name="stumpsTaken"  value="<%=stumpsTaken%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bowled</th>
			<td><input id="editname" type="numeric" name="bowled"  value="<%=bowled%>" required="required"/></td>
			</tr>
			<tr>
			<th>Total Catches Taken</th>
			<td><input id="editname" type="numeric" name="tot_catchesTaken"  value="<%=tot_catchesTaken%>" required="required"/></td>
			</tr>
			<tr>
			<th>Total runouts</th>
			<td><input id="editname" type="numeric" name="tot_runouts"  value="<%=tot_runouts%>" required="required"/></td>
			</tr>
			<tr>
			<th>Direct Hits</th>
			<td><input id="editname" type="numeric" name="directHits"  value="<%=directHits%>" required="required"/></td>
			</tr>
			<tr>
			<th>LBW</th>
			<td><input id="editname" type="numeric" name="LBW"  value="<%=LBW%>" required="required"/></td>
			</tr>
			<tr>
			<th>Dot Ball</th>
			<td><input id="editname" type="numeric" name="dotBall"  value="<%=dotBall%>" required="required"/></td>
			</tr>
			<tr>
			<th>Maiden Over</th>
			<td><input id="editname" type="numeric" name="maidenOver"  value="<%=maidenOver%>" required="required"/></td>
			</tr>
			<tr>
			<th>Hattrik</th>
			<td><input id="editname" type="numeric" name="hattrik"  value="<%=hattrik%>" required="required"/></td>
			</tr>
			<tr>
			<th>Duck</th>
			<td><input id="editname" type="numeric" name="duck"  value="<%=duck%>" required="required"/></td>
			</tr>
			<tr>
			<th>Specification</th>
			<td><input id="editname" type="numeric" name="specification"  value="<%=specification%>" required="required"/></td>
			</tr>
			<tr>
			<th>Total Points</th>
			<td><input id="editname" type="numeric" step="0.01" name="tot_pts"  value="<%=tot_pts%>" required="required"/></td>
			</tr>
			<tr>
			<th>Betting Points</th>
			<td><input id="editname" type="numeric" step="0.01" name="bet_pt"  value="<%=bet_pt%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="players.jsp?admin_name=<%=admin_name%>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			String p_name=request.getParameter("p_name");
			int tot_runs=Integer.parseInt(request.getParameter("tot_runs"));
			double max_sr=Double.parseDouble(request.getParameter("max_sr"));
			double curr_sr=Double.parseDouble(request.getParameter("curr_sr"));
			int tot_wk=Integer.parseInt(request.getParameter("tot_wk"));
			int tot_catchout=Integer.parseInt(request.getParameter("tot_catchout"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double max_runrate=Double.parseDouble(request.getParameter("max_runrate"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			double max_bowlsr=Double.parseDouble(request.getParameter("max_bowlsr"));
			int stumpsTaken=Integer.parseInt(request.getParameter("stumpsTaken"));
			int bowled=Integer.parseInt(request.getParameter("bowled"));
			int tot_catchesTaken=Integer.parseInt(request.getParameter("tot_catchesTaken"));
			int tot_runouts=Integer.parseInt(request.getParameter("tot_runouts"));
			int directHits=Integer.parseInt(request.getParameter("directHits"));
			int LBW=Integer.parseInt(request.getParameter("LBW"));
			int dotBall=Integer.parseInt(request.getParameter("dotBall"));
			int maidenOver=Integer.parseInt(request.getParameter("maidenOver"));
			int hattrik=Integer.parseInt(request.getParameter("hattrik"));
			int duck=Integer.parseInt(request.getParameter("duck"));
			int specification=Integer.parseInt(request.getParameter("specification"));
			double tot_pts=Double.parseDouble(request.getParameter("tot_pts"));
			double bet_pt=Double.parseDouble(request.getParameter("bet_pt"));
			
			int c=s1.updateRecord(p_id, p_name, tot_runs, max_sr, curr_sr, tot_wk, tot_catchout, halfCentury, century, max_runrate, noOf6, noOf4, max_bowlsr, stumpsTaken, bowled, tot_catchesTaken, tot_runouts, directHits, LBW, dotBall, maidenOver, hattrik, duck, specification, tot_pts, bet_pt); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}
		else if("add".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int r=s1.maxId()+1;
		%>
	## Note:<br/>
	1. Specification Id for:<br/>
		- Batsman: 01<br/>
		- Bowler: 02<br/>
		- All Rounder: 03<br/>
		- Wicket Keeper: 04
		<br/><br/>
			<form action="players.jsp?admin_name=<%=admin_name%>&mode=save" method="post" name="addform">
			<table>
			<tbody>
			<tr>
			<th>Player Id </th>
			<td><input type="text" name="p_id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Player Name </th>
			<td><input id="editname" type="text" name="p_name"  required="required"/></td>
			</tr>
			<tr>
			<th>Total Runs</th>
			<td><input id="editname" type="numeric" name="tot_runs" required="required" /></td>
			</tr>
			<tr>
			<th>Maximum StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="max_sr" required="required" /></td>
			</tr>
			<tr>
			<th>Current StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="curr_sr"  required="required"/></td>
			</tr>
			<tr>
			<th>Total Wickets</th>
			<td><input id="editname" type="numeric" name="tot_wk" required="required" /></td>
			</tr>
			<tr>
			<th>Total Catchouts</th>
			<td><input id="editname" type="numeric" name="tot_catchout" required="required" /></td>
			</tr>
			<tr>
			<th>Half Century</th>
			<td><input id="editname" type="numeric" name="halfCentury" required="required" /></td>
			</tr>
			<tr>
			<th>Century</th>
			<td><input id="editname" type="numeric" name="century" required="required" /></td>
			</tr>
			<tr>
			<th>Maximum RunRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="max_runrate"  required="required"/></td>
			</tr>
			<tr>
			<th>No. of 6</th>
			<td><input id="editname" type="numeric" name="noOf6" required="required"/></td>
			</tr>
			<tr>
			<th>No. of 4</th>
			<td><input id="editname" type="numeric" name="noOf4" required="required" /></td>
			</tr>
			<tr>
			<th>Maximum Bowling StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="max_bowlsr" required="required" /></td>
			</tr>
			<tr>
			<th>Stumps Taken</th>
			<td><input id="editname" type="numeric" name="stumpsTaken" required="required" /></td>
			</tr>
			<tr>
			<th>Bowled</th>
			<td><input id="editname" type="numeric" name="bowled" required="required" /></td>
			</tr>
			<tr>
			<th>Total Catches Taken</th>
			<td><input id="editname" type="numeric" name="tot_catchesTaken" required="required" /></td>
			</tr>
			<tr>
			<th>Total runouts</th>
			<td><input id="editname" type="numeric" name="tot_runouts" required="required" /></td>
			</tr>
			<tr>
			<th>Direct Hits</th>
			<td><input id="editname" type="numeric" name="directHits" required="required" /></td>
			</tr>
			<tr>
			<th>LBW</th>
			<td><input id="editname" type="numeric" name="LBW" required="required" /></td>
			</tr>
			<tr>
			<th>Dot Ball</th>
			<td><input id="editname" type="numeric" name="dotBall" required="required" /></td>
			</tr>
			<tr>
			<th>Maiden Over</th>
			<td><input id="editname" type="numeric" name="maidenOver" required="required" /></td>
			</tr>
			<tr>
			<th>Hattrik</th>
			<td><input id="editname" type="numeric" name="hattrik" required="required" /></td>
			</tr>
			<tr>
			<th>Duck</th>
			<td><input id="editname" type="numeric" name="duck" required="required" /></td>
			</tr>
			<tr>
			<th>Specification</th>
			<td><input id="editname" type="numeric" name="specification" required="required" /></td>
			</tr>
			<tr>
			<th>Total Points</th>
			<td><input id="editname" type="numeric" step="0.01" name="tot_pts" required="required" /></td>
			</tr>
			<tr>
			<th>Betting Points</th>
			<td><input id="editname" type="numeric" step="0.01" name="bet_pt" required="required" /></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="players.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			String p_name=request.getParameter("p_name");
			int tot_runs=Integer.parseInt(request.getParameter("tot_runs"));
			double max_sr=Double.parseDouble(request.getParameter("max_sr"));
			double curr_sr=Double.parseDouble(request.getParameter("curr_sr"));
			int tot_wk=Integer.parseInt(request.getParameter("tot_wk"));
			int tot_catchout=Integer.parseInt(request.getParameter("tot_catchout"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double max_runrate=Double.parseDouble(request.getParameter("max_runrate"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			double max_bowlsr=Double.parseDouble(request.getParameter("max_bowlsr"));
			int stumpsTaken=Integer.parseInt(request.getParameter("stumpsTaken"));
			int bowled=Integer.parseInt(request.getParameter("bowled"));
			int tot_catchesTaken=Integer.parseInt(request.getParameter("tot_catchesTaken"));
			int tot_runouts=Integer.parseInt(request.getParameter("tot_runouts"));
			int directHits=Integer.parseInt(request.getParameter("directHits"));
			int LBW=Integer.parseInt(request.getParameter("LBW"));
			int dotBall=Integer.parseInt(request.getParameter("dotBall"));
			int maidenOver=Integer.parseInt(request.getParameter("maidenOver"));
			int hattrik=Integer.parseInt(request.getParameter("hattrik"));
			int duck=Integer.parseInt(request.getParameter("duck"));
			int specification=Integer.parseInt(request.getParameter("specification"));
			double tot_pts=Double.parseDouble(request.getParameter("tot_pts"));
			double bet_pt=Double.parseDouble(request.getParameter("bet_pt"));
			int c=s1.addRecord(p_id, p_name, tot_runs, max_sr, curr_sr, tot_wk, tot_catchout, halfCentury, century, max_runrate, noOf6, noOf4, max_bowlsr, stumpsTaken, bowled, tot_catchesTaken, tot_runouts, directHits, LBW, dotBall, maidenOver, hattrik, duck, specification, tot_pts, bet_pt); 
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
		}	

		%>
	<jsp:include page="players.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>
	
</body>
</html>