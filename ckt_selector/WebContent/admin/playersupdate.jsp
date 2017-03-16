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
		ckt_selector.Playersupdate s1=new ckt_selector.Playersupdate();
		ckt_selector.Players s2=new ckt_selector.Players();
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
					<b><u>Update Player Details After each Match:</u></b>
					<br/><br/>
					<center>
					<table border="1" width="500px">
					<tr><th>Player</th><th>Specification of Player</th><th>Bating StrikeRate</th><th>Wickets Taken</th><th>Catchouts</th><th>Half Century</th><th>Century</th><th>Runrate</th><th>No. of 6</th><th>No. of 4</th><th>Bowling StrikeRate</th><th>Stumps Taken</th><th>Bowled</th><th>Runouts</th><th>Direct Hits</th><th>LBW</th><th>Dot Ball</th><th>Maiden Over</th><th>Hattrik</th><th>Duck</th><th>Match Points</th><th>tot_runs</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
		%>
					<tr>
		<%			
					
					String s[]=(String [])v.elementAt(i);
					String pname=s2.playerName(Integer.parseInt(s[0]));
					%>
					<td><%=pname%></td>
					<%
					if("1".equals(s[1])){
						%>
						<td>Batsman</td>
						<%
					}
					else if("2".equals(s[1])){
						%>
						<td>Bowler</td>
						<%
					}
					else if("3".equals(s[1])){
						%>
						<td>All Rounder</td>
						<%
					}
					else if("4".equals(s[1])){
						%>
						<td>Wicket Keeper</td>
						<%
					}	
					for(int j=2;j<22;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
		%>
						<td><a href="playersupdate.jsp?admin_name=<%=admin_name %>&p_id=<%=s[0]%>&specification=<%=s[1]%>&m_batingsr=<%=s[2]%>&m_wicketTaken=<%=s[3]%>&m_catchout=<%=s[4]%>&halfCentury=<%=s[5]%>&century=<%=s[6]%>&m_runRate=<%=s[7]%>&noOf6=<%=s[8]%>&noOf4=<%=s[9]%>&m_bowlsr=<%=s[10]%>&stumpsTaken=<%=s[11]%>&bowled=<%=s[12]%>&runout=<%=s[13]%>&directHit=<%=s[14]%>&LBW=<%=s[15]%>&dotBall=<%=s[16]%>&maidenOver=<%=s[17]%>&hattrik=<%=s[18]%>&duck=<%=s[19]%>&m_pts=<%=s[20]%>&tot_runs=<%=s[21]%>&mode=edit">Edit</a></td>
						<td><a href="playersupdate.jsp?p_id=<%=s[0] %>&mode=delete">Delete</a></td>
					</tr>
		<%
				}
		
		
		%>
				</table>
				<br/><br/>
				<a href="playersupdate.jsp?admin_name=<%=admin_name%>&mode=add">Add New Player</a><br/>
				<a href="dashboard.jsp?admin_name=<%=admin_name %>">Go To DashBoard</a>
				<br/><br/>After the details have entered, click here for calculation
				<a href="playersupdate.jsp?mode=calculation&admin_name=<%=admin_name %>">click here</a>
				</center>
				
		<%
				return;
		}
		else if("calculation".equals(mode)){
			admin_name=request.getParameter("admin_name");
				//------------------------->check4
			Calculation c1=new Calculation();
			Vector<String []> v = s1.showRecordAll();
			//out.println("check3: v size="+v.size());//------------------------->check3
			for(int i=0;i<v.size();i++){
				String s[]=(String [])v.elementAt(i);
				int a=Integer.parseInt(s[0]);
				//out.println("check2: p_id="+a);//------------------------->check2
				double b=Double.parseDouble(s[2]);
				int c=Integer.parseInt(s[3]);
				int d=Integer.parseInt(s[4]);
				int e=Integer.parseInt(s[5]);
				int f=Integer.parseInt(s[6]);
				double g=Double.parseDouble(s[7]);
				int h=Integer.parseInt(s[8]);
				int t=Integer.parseInt(s[9]);//"t"
				double j=Double.parseDouble(s[10]);
				int k=Integer.parseInt(s[11]);
				int l=Integer.parseInt(s[12]);
				int m=Integer.parseInt(s[13]);
				int n=Integer.parseInt(s[14]);
				int o=Integer.parseInt(s[15]);
				int p=Integer.parseInt(s[16]);
				int q=Integer.parseInt(s[17]);
				int r=Integer.parseInt(s[18]);
				int u=Integer.parseInt(s[19]);//"u"
				int w=Integer.parseInt(s[21]);//"w"
				c1.playerUpdate(a,b,c,d,e,f,g,h,t,j,k,l,m,n,o,p,q,r,u,w);
				
				//user:
				ArrayList<Integer> ids=c1.utIds();
				c1.getUserPoints(ids);
			}
			%>
			<a href="playersupdate.jsp?admin_name=<%=admin_name%>&mode=display">Go To Back</a>
			
			<%
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
			int specification=Integer.parseInt(request.getParameter("specification"));
			double m_batingsr=Double.parseDouble(request.getParameter("m_batingsr"));
			int m_wicketTaken=Integer.parseInt(request.getParameter("m_wicketTaken"));
			int m_catchout=Integer.parseInt(request.getParameter("m_catchout"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double m_runRate=Double.parseDouble(request.getParameter("m_runRate"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			double m_bowlsr=Double.parseDouble(request.getParameter("m_bowlsr"));
			int stumpsTaken=Integer.parseInt(request.getParameter("stumpsTaken"));
			int bowled=Integer.parseInt(request.getParameter("bowled"));
			int runout=Integer.parseInt(request.getParameter("runout"));
			int directHit=Integer.parseInt(request.getParameter("directHit"));
			int LBW=Integer.parseInt(request.getParameter("LBW"));
			int dotBall=Integer.parseInt(request.getParameter("dotBall"));
			int maidenOver=Integer.parseInt(request.getParameter("maidenOver"));
			int hattrik=Integer.parseInt(request.getParameter("hattrik"));
			int duck=Integer.parseInt(request.getParameter("duck"));
			double m_pts=Double.parseDouble(request.getParameter("m_pts"));
			int tot_runs=Integer.parseInt(request.getParameter("tot_runs"));
		%>
		## Note:<br/>
	1. Specification Id for:<br/>
		- Batsman: 01<br/>
		- Bowler: 02<br/>
		- All Rounder: 03<br/>
		- Wicket Keeper: 04
		<br/><br/>
			<form action="playersupdate.jsp?admin_name=<%=admin_name%>&mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Player Id </th>
			<td><input type="text" name="p_id" value="<%=p_id%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Specification of Player </th>
			<td><input id="editname" type="numeric" name="specification"  value="<%=specification%>" required="required"/></td>
			</tr>
			<tr>
			<th>Bating StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="m_batingsr"  value="<%=m_batingsr%>" required="required"/></td>
			</tr>
			<tr>
			<th>Wickets Taken</th>
			<td><input id="editname" type="numeric" name="m_wicketTaken"  value="<%=m_wicketTaken%>" required="required"/></td>
			</tr>
			<tr>
			<th>Catchouts</th>
			<td><input id="editname" type="numeric" name="m_catchout"  value="<%=m_catchout%>" required="required"/></td>
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
			<th>RunRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="m_runRate"  value="<%=m_runRate%>" required="required"/></td>
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
			<th>Bowling StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="m_bowlsr"  value="<%=m_bowlsr%>" required="required"/></td>
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
			<th>Runouts</th>
			<td><input id="editname" type="numeric" name="runout"  value="<%=runout%>" required="required"/></td>
			</tr>
			<tr>
			<th>Direct Hits</th>
			<td><input id="editname" type="numeric" name="directHit"  value="<%=directHit%>" required="required"/></td>
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
			<th>Match Points</th>
			<td><input id="editname" type="numeric" step="0.01" name="m_pts"  value="<%=m_pts%>" required="required"/></td>
			</tr>
			<tr>
			<th>Total Runs</th>
			<td><input id="editname" type="numeric" name="tot_runs"  value="<%=tot_runs%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="playersupdate.jsp?admin_name=<%=admin_name %>&mode=display"> Back </a>

			</form>
		<%
			return;
		}
		else if("update".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			int specification=Integer.parseInt(request.getParameter("specification"));
			double m_batingsr=Double.parseDouble(request.getParameter("m_batingsr"));
			int m_wicketTaken=Integer.parseInt(request.getParameter("m_wicketTaken"));
			int m_catchout=Integer.parseInt(request.getParameter("m_catchout"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double m_runRate=Double.parseDouble(request.getParameter("m_runRate"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			double m_bowlsr=Double.parseDouble(request.getParameter("m_bowlsr"));
			int stumpsTaken=Integer.parseInt(request.getParameter("stumpsTaken"));
			int bowled=Integer.parseInt(request.getParameter("bowled"));
			int runout=Integer.parseInt(request.getParameter("runout"));
			int directHit=Integer.parseInt(request.getParameter("directHit"));
			int LBW=Integer.parseInt(request.getParameter("LBW"));
			int dotBall=Integer.parseInt(request.getParameter("dotBall"));
			int maidenOver=Integer.parseInt(request.getParameter("maidenOver"));
			int hattrik=Integer.parseInt(request.getParameter("hattrik"));
			int duck=Integer.parseInt(request.getParameter("duck"));
			double m_pts=Double.parseDouble(request.getParameter("m_pts"));
			int tot_runs=Integer.parseInt(request.getParameter("tot_runs"));
			
			int c=s1.updateRecord(p_id, specification, m_batingsr, m_wicketTaken, m_catchout, halfCentury, century, m_runRate, noOf6, noOf4, m_bowlsr, stumpsTaken, bowled, runout, directHit, LBW, dotBall, maidenOver, hattrik, duck, m_pts, tot_runs); 
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
			<form action="playersupdate.jsp?admin_name=<%=admin_name%>&mode=save" method="post" name="addform">
			<table>
			<tbody>
			<tr>
			<th>Player Id </th>
			<td><input type="text" name="p_id" value="<%=r%>" readonly="readonly"/></td>
			</tr>
			<tr>
			<th>Specification of Player </th>
			<td><input id="editname" type="numeric" name="specification"  required="required" /></td>
			</tr>
			<tr>
			<th>Bating StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="m_batingsr"  required="required" /></td>
			</tr>
			<tr>
			<th>Wickets Taken</th>
			<td><input id="editname" type="numeric" name="m_wicketTaken"  required="required" /></td>
			</tr>
			<tr>
			<th>Catchouts</th>
			<td><input id="editname" type="numeric" name="m_catchout" required="required"  /></td>
			</tr>
			<tr>
			<th>Half Century</th>
			<td><input id="editname" type="numeric" name="halfCentury"   required="required"/></td>
			</tr>
			<tr>
			<th>Century</th>
			<td><input id="editname" type="numeric" name="century"  required="required" /></td>
			</tr>
			<tr>
			<th>RunRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="m_runRate"  required="required" /></td>
			</tr>
			<tr>
			<th>No. of 6</th>
			<td><input id="editname" type="numeric" name="noOf6"  required="required" /></td>
			</tr>
			<tr>
			<th>No. of 4</th>
			<td><input id="editname" type="numeric" name="noOf4" required="required"  /></td>
			</tr>
			<tr>
			<th>Bowling StrikeRate</th>
			<td><input id="editname" type="numeric" step="0.01" name="m_bowlsr" required="required"  /></td>
			</tr>
			<tr>
			<th>Stumps Taken</th>
			<td><input id="editname" type="numeric" name="stumpsTaken"  required="required" /></td>
			</tr>
			<tr>
			<th>Bowled</th>
			<td><input id="editname" type="numeric" name="bowled"  required="required" /></td>
			</tr>
			<tr>
			<th>Runouts</th>
			<td><input id="editname" type="numeric" name="runout"  required="required" /></td>
			</tr>
			<tr>
			<th>Direct Hits</th>
			<td><input id="editname" type="numeric" name="directHit" required="required"  /></td>
			</tr>
			<tr>
			<th>LBW</th>
			<td><input id="editname" type="numeric" name="LBW"  required="required" /></td>
			</tr>
			<tr>
			<th>Dot Ball</th>
			<td><input id="editname" type="numeric" name="dotBall"  required="required" /></td>
			</tr>
			<tr>
			<th>Maiden Over</th>
			<td><input id="editname" type="numeric" name="maidenOver" required="required"  /></td>
			</tr>
			<tr>
			<th>Hattrik</th>
			<td><input id="editname" type="numeric" name="hattrik"  required="required" /></td>
			</tr>
			<tr>
			<th>Duck</th>
			<td><input id="editname" type="numeric" name="duck"  required="required" /></td>
			</tr>
			<tr>
			<th>Match Points</th>
			<td><input id="editname" type="numeric" name="m_pts"  required="required" /></td>
			</tr>
			<tr>
			<th>Total Runs</th>
			<td><input id="editname" type="numeric" name="tot_runs"  required="required" /></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary" /></td></tr>
			</tbody>
			</table>
			<a href="playersupdate.jsp?admin_name=<%=admin_name%>"> Back </a>
			</form>
		<%
			return;
		}
		else if("save".equals(mode))
		{
			admin_name=request.getParameter("admin_name");
			int p_id=Integer.parseInt(request.getParameter("p_id"));
			int specification=Integer.parseInt(request.getParameter("specification"));
			double m_batingsr=Double.parseDouble(request.getParameter("m_batingsr"));
			int m_wicketTaken=Integer.parseInt(request.getParameter("m_wicketTaken"));
			int m_catchout=Integer.parseInt(request.getParameter("m_catchout"));
			int halfCentury=Integer.parseInt(request.getParameter("halfCentury"));
			int century=Integer.parseInt(request.getParameter("century"));
			double m_runRate=Double.parseDouble(request.getParameter("m_runRate"));
			int noOf6=Integer.parseInt(request.getParameter("noOf6"));
			int noOf4=Integer.parseInt(request.getParameter("noOf4"));
			double m_bowlsr=Double.parseDouble(request.getParameter("m_bowlsr"));
			int stumpsTaken=Integer.parseInt(request.getParameter("stumpsTaken"));
			int bowled=Integer.parseInt(request.getParameter("bowled"));
			int runout=Integer.parseInt(request.getParameter("runout"));
			int directHit=Integer.parseInt(request.getParameter("directHit"));
			int LBW=Integer.parseInt(request.getParameter("LBW"));
			int dotBall=Integer.parseInt(request.getParameter("dotBall"));
			int maidenOver=Integer.parseInt(request.getParameter("maidenOver"));
			int hattrik=Integer.parseInt(request.getParameter("hattrik"));
			int duck=Integer.parseInt(request.getParameter("duck"));
			double m_pts=Double.parseDouble(request.getParameter("m_pts"));
			int tot_runs=Integer.parseInt(request.getParameter("tot_runs"));
			
			int c=s1.addRecord(p_id, specification, m_batingsr, m_wicketTaken, m_catchout, halfCentury, century, m_runRate, noOf6, noOf4, m_bowlsr, stumpsTaken, bowled, runout, directHit, LBW, dotBall, maidenOver, hattrik, duck, m_pts, tot_runs);
			if(c<=0){
				out.println("<center>Please check the values you entered!</center>");
			}
			 
		}	

		%>
	<jsp:include page="playersupdate.jsp">
		<jsp:param value="display" name="mode"/>
		<jsp:param value="<%=admin_name %>" name="admin_name"/>
	</jsp:include>
		
</body>
</html>