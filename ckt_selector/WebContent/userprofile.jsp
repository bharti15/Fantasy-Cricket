<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" session="false" import="ckt_selector.*" import="java.util.*" import="java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>FANTACY CRICKET</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    	<!-- CUSTOM -->
    	<link href='https://fonts.googleapis.com/css?family=Oswald|Open+Sans' rel='stylesheet' type='text/css'>
    		
    		
     <link href="css/Custom.css" rel="stylesheet">
     	
     	<link href="css/font-awesome.min.css" rel="stylesheet">
     	<script type="text/javascript">
			function validation()
			{
       // var sid=document.forms.form1.state.value;
        // var cid=document.forms.form1.city.value;


				if(document.forms.form1.sname.value.trim()=="")
				{
					alert("Type your name");
					return false;
				}
        
				else if(document.forms.form1.pass.value=="")
				{
					alert("Type your password");
					return false;
				}
				else if(document.forms.form1.retype.value=="")
				{
					alert("ReType your password");
					return false;
				}
				else if(document.forms.form1.pass.value != document.forms.form1.retype.value)
				{
					alert("password & retype password mismatch");
					return false;
				}
      

			}
			</script>
      
  </head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/w3.css">
<link rel="stylesheet" href="css/w3-theme-black.css">
<link rel="stylesheet" href="css/css.css">
<link rel="stylesheet" href="css/font-awesome2.min.css">
<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif}
.w3-sidenav a,.w3-sidenav h4{padding:12px;}
.w3-navbar a{padding-top:12px !important;padding-bottom:12px !important;}
</style>
<body>
	<%
	HttpSession session=request.getSession(false);
	if(session==null)
	{
%>
		<jsp:forward page="login.jsp"></jsp:forward>
<%	
		return;		
	}
	String mode = request.getParameter("mode");
	User u1=new User();
	League l1=new League();
	
	
	if("normal".equals(mode)){
		String user_email=request.getParameter("user_email");
		int user_id=u1.getuser_id(user_email);
		String user_name=u1.getuser_name(user_email);
		int tot_teams=u1.getTeams(user_email);
		String password=u1.getpassword(user_email);
		String user_contact=u1.getcontact(user_email);
		%>
		
		<center>
		<b><u>Welcome <%=user_name%> !</u></b><br/>
		<%=user_email%><br/>
		Total teams:<%=tot_teams%><br/>
		<a href="userprofile.jsp?mode=edit&user_id=<%=user_id%>&user_name=<%=user_name%>&user_email=<%=user_email%>&password=<%=password%>&user_contact=<%=user_contact%>">Edit Profile</a><br/>
		<a href="login.jsp">Logout</a><br/>
		</center>
		<br/><br/>
		<b><u>RULES:</u></b><br/>
		1. You can only have one team in a league.
		<br/><br/>
		<b><u>Your League Details:</u></b><br/>
		<%
				ArrayList<Integer> v = u1.userLeague(user_id);
				
					%>
					<center>
					<table border="1" width="500px">
					<tr><th>SNo.</th><th>League Name</th><th>View Performance</th></tr>
		<%		
					for(int i=0;i<v.size();i++){
		%>
					<tr><td><%=i+1 %></td>
		<%		
					int j=v.get(i);
					String s=u1.league_name(j);
		%>
					<td><%=s %></td>
					<td><a href="userprofile.jsp?mode=performance&l_id=<%=j%>&l_name=<%=s%>&user_id=<%=user_id%>&user_name=<%=user_name%>&user_email=<%=user_email%>">Click here</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<a href="userprofile.jsp?mode=joinmatch&user_id=<%=user_id%>&user_email=<%=user_email%>">Join a Match</a>
				</center>
	<%
	}
	else if("edit".equals(mode)){
			int user_id=Integer.parseInt(request.getParameter("user_id"));
			String user_name=request.getParameter("user_name");
			String user_email=request.getParameter("user_email");
			String user_contact=request.getParameter("user_contact");
			String password=request.getParameter("password");
		%>
			<form action="userprofile.jsp?mode=update" method="post">
			<table border="1" >
			<tbody>
			<tr>
			<th>Your Id </th>
			<td><input type="text" name="user_id" value="<%=user_id%>" readonly="readonly" required="required"/></td>
			</tr>
			<tr>
			<th>Name </th>
			<td><input id="editname" type="text" name="user_name"  value="<%=user_name%>" required="required"/></td>
			</tr>
			<tr>
			<th>Email id </th>
			<td><input id="editname" type="text" name="user_email"  value="<%=user_email%>" required="required"/></td>
			</tr>
			<tr>
			<th>Contact </th>
			<td><input id="editname" type="text" name="user_contact"  value="<%=user_contact%>" required="required"/></td>
			</tr>
			<tr>
			<th>Password </th>
			<td><input id="editname" type="text" name="password"  value="<%=password%>" required="required"/></td>
			</tr>
			<tr><td colspan="2" align="center"><input type="submit" value="update" name="submit" class="btn btn-primary"  /></td></tr>
			</tbody>
			</table>
			<a href="userprofile.jsp?&mode=normal&user_id=<%=user_id%>&user_name=<%=user_name%>&user_email=<%=user_email%>&password=<%=password%>&user_contact=<%=user_contact%>"> Back </a>

			</form>
		<%
			return;
	}
	else if("update".equals(mode))
	{
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		String user_name=request.getParameter("user_name");
		String user_email=request.getParameter("user_email");
		String password=request.getParameter("password");
		String user_contact=request.getParameter("user_contact");
		if(user_name==null){
			out.println("<center>User name cannot be empty!</center>");
		}
		else if(user_email==null){
			out.println("<center>User email is not entered!</center>");
		}
		else if(password==null){
			out.println("<center>It is compulsory to give a password!</center>");
		}
		else if(user_contact==null){
			out.println("<center>User contact cannot be empty!</center>");
		}
		else{
			u1.updateRecord(user_id, user_name, user_email, user_contact, password);
		
		 
	%>
		<jsp:include page="userprofile.jsp">
		<jsp:param value="normal" name="mode"/>
		<jsp:param value="<%=user_id %>" name="user_id"/>
		<jsp:param value="<%=user_name %>" name="user_name"/>
		<jsp:param value="<%=user_email %>" name="user_email"/>
		<jsp:param value="<%=password %>" name="password"/>
		<jsp:param value="<%=user_contact %>" name="user_contact"/>
	</jsp:include>
	<%
		}
	}
	else if("performance".equals(mode)){
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		String user_name=request.getParameter("user_name");
		String user_email=request.getParameter("user_email");
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		Performance p=new Performance();
		ArrayList<String[]> v=p.matchdetails(user_id, l_id);
		int ut_id, mid;
		
		//String s1[]=(String [])v.get(0);
		// ut_id=Integer.parseInt(s1[0]);
		//int mid=Integer.parseInt(s1[2]);
		%>
		
		<center>
		<b><u>MATCH PERFORMANCE</u></b><br/><br/><br/><br/>
		<table border="1" width="500px">
		<tr><th>Sno.</th><th>Name</th><th>Match</th><th>League</th><th>Period/Match Points</th><th>Total/League Points</th><th>Transfers Left</th><th>Captain</th><th>Change Captain</th><th>Change Player</th><th></th><th></th></tr>
<%		
	for(int i=0;i<v.size();i++)
	{
		int j=2;
%>
		<tr>
		<td>Team <%=i+1 %></td>
		<td><%=user_name%></td>
<%			
		
		String s[]=(String [])v.get(i);
		ut_id=Integer.parseInt(s[0]);
		mid=Integer.parseInt(s[j]);j++;
		String match=p.getmatchname(mid);
		int lid=Integer.parseInt(s[j]);j++;
		String league=l1.getname(lid);
		int tl=p.leftTransfers(ut_id);
		int cap_id=p.getcapId(ut_id);
		String s1[]=p.capInfo(cap_id);
		%>
		<td><%=match%></td>
		<td><%=league%></td>
<%
		for(j=4;j<6;j++)
		{
%>
			<td><%=s[j] %></td>
<%				
		}
		
%>
		<td><%=tl %></td>
		<td><%=s1[0] %></td>
		<td><a href="userprofile.jsp?mode=changecaptain&l_id=<%=l_id%>&user_id=<%=user_id%>&user_email=<%=user_email%>&user_name=<%=user_name%>&ut_id=<%=ut_id%>">CHANGE CAPTAIN</a></td>
		
		<td><a href="userprofile.jsp?mode=changePlayer&ut_id=<%=ut_id%>&m_id=<%=mid%>&l_id=<%=lid%>&user_id=<%=user_id%>&user_email=<%=user_email%>">Change Player</a></td>
	</tr>
<%
	}
%>
	</table>
	<br/>
	<a href="userprofile.jsp?mode=normal&user_email=<%=user_email%>">Back</a>
	</center>
<%
	return;
	}
	
	else if("joinmatch".equals(mode)){
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		String user_email=request.getParameter("user_email");
		//out.println(user_email);
		Match m1=new Match();
		Acteam ac=new Acteam();
		//int l_id=Integer.parseInt(request.getParameter("l_id"));
		Vector<String []> v = m1.showRecordAll();
		%>
					<center>
					<table border="1" width="500px">
					<tr><th>Sno.</th><th>Match Name</th><th>Date</th><th>Time</th><th>where</th><th>Team 1</th><th>Team 2</th><th>League</th><th></th><th></th></tr>
		<%		
				for(int i=0;i<v.size();i++)
				{
					int j;
		%>
					<tr>
					<td><%=i+1 %></td>
		<%			
					String s[]=(String [])v.elementAt(i);
					for(j=1;j<5;j++)
					{
		%>
						<td><%=s[j] %></td>
		<%				
					}
					int team1=Integer.parseInt(s[j]);j++;
					String teamone=ac.getname(team1);
					int team2=Integer.parseInt(s[j]);j++;
					String teamtwo=ac.getname(team2);
					int lid=Integer.parseInt(s[j]);j++;
					String league=l1.getname(lid);
		%>
					<td><%=teamone %></td>
					<td><%=teamtwo %></td>
					<td><%=league %></td>
						<td><a href="userprofile.jsp?mode=create1&m_id=<%=s[0]%>&m_name=<%=s[1]%>&user_id=<%=user_id%>&at_id1=<%=team1%>&at_id2=<%=team2%>&l_id=<%=lid%>">Join</a></td>
					</tr>
		<%
				}
		%>
				</table>
				<a href="userprofile.jsp?mode=normal&user_email=<%=user_email%>">Go to Main Page</a>
				</center>
		<%
				return;
	}
	else if("createteam".equals(mode)){
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		int m_id=Integer.parseInt(request.getParameter("m_id"));
		int at_id1=Integer.parseInt(request.getParameter("at_id1"));
		int at_id2=Integer.parseInt(request.getParameter("at_id2"));
		Players p1=new Players();
		ArrayList<Integer> a=p1.getplayers(at_id1,at_id2);
		
		ArrayList<String[]> v=p1.matchplayers(a);
		
		%>
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
		String p_id=s[0];
%>
			<td><a href="userprofile.jsp?mode=create1&m_id=<%=m_id%>&user_id=<%=user_id%>&p_id=<%=s[0]%>&l_id=<%=l_id%>">ADD</a></td>
			</tr>
<%
	}
%>
	</table>
	</center>
<%
	return;
	}
	else if("create1".equals(mode)){
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		int m_id=Integer.parseInt(request.getParameter("m_id"));
		int at_id1=Integer.parseInt(request.getParameter("at_id1"));
		int at_id2=Integer.parseInt(request.getParameter("at_id2"));
		Players p1=new Players();
		ArrayList<Integer> a=p1.getplayers(at_id1,at_id2);
		ArrayList<String[]> v=p1.matchplayers(a);
		int betpt=0;
		Teamformat tf=new Teamformat();
		Vector<String[]> v2=tf.showRecordAll();
		for(int i=0;i<v2.size();i++){
			String s[]=(String [])v2.elementAt(i);
			betpt=Integer.parseInt(s[3]);		
		}
	//	int p_id=Integer.parseInt(request.getParameter("p_id"));
%>
## Note:<br/>
	1. Specification Id for:<br/>
		- Batsman: 01<br/>
		- Bowler: 02<br/>
		- All Rounder: 03<br/>
		- Wicket Keeper: 04
		<br/><br/>
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
			<td><input type="button" id="<%=id %>" class="add-row" onclick="addPlayer(<%=s[0] %>,'<%=s[1]%>',<%=s[2] %>,<%=s[3] %>)" value="Add Row" text="add" name="player" /></td>
			</tr>
<%
	}
%>
	</table>
	</center>
	
	<p class="betting-point"></p>
	<p class="batsmanlimit"></p>
	<p class="bowlerlimit"></p>
	<p class="wklimit"></p>
	<p class="arlimit"></p>
	<p class="noOfPlayer"></p>
	<div class="player-table">
	
	</div>
	<form action="createteam.jsp?user_id=<%=user_id%>&l_id=<%=l_id%>&m_id=<%=m_id%>&at_id1=<%=at_id1%>&at_id2=<%=at_id2%>" method="POST" >
  	
  	<input class="teamplayer-input" type="hidden" value="123" name="array" />
  	<input class="teamplayer-pt" type="hidden" value="123" name="array1" />
  	<input class="pbatsman" type="hidden" value="123" name="pbatsman" />
  	<input class="pbowler" type="hidden" value="123" name="pbowler" />
  	<input class="pwk" type="hidden" value="123" name="pwk" />
  	<input class="par" type="hidden" value="123" name="par" />
  <!--   <input type="hidden" name="mpk[]" value="x" class="mpk"/>
    <input type="hidden" name="mpk[]" value="y" class="mpk"/>-->
   <input type="submit" class="button-submit" />
		</form>
		
		<button onclick="submitTeam()" >Submit Team</button>
	<p id="demo"></p>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script>
		<%
		String s1[]=(String [])v2.elementAt(0);
		int min[]=new int[5];
		for(int i=0;i<s1.length;i++){
			min[i]=Integer.parseInt(s1[i]);
		}
		String s2[]=(String [])v2.elementAt(1);
		int max[]=new int[5];
		for(int i=0;i<s1.length;i++){
			max[i]=Integer.parseInt(s2[i]);
		}
		
		%>
		var batsmanlimit=[<%=min[2]%>, <%=max[2]%>];
		var bowlerlimit=[<%=min[4]%>, <%=max[4]%>];
		var wklimit=[<%=min[3]%>, <%=max[3]%>];
		var arlimit=[<%=min[1]%>, <%=max[1]%>];
		var maxpt=100;
		var pbatsman=0,
			pbowler=0,
			pwk=0,
			par=0;
		var finalplayer=[];
		
		
		function addPlayer(id,name,speci,betpt){
			//debugger;
			var k=0;
			if(maxpt<betpt){
				alert("sorry you cant afford this player");
				return;
			}
			if(finalplayer.length > 10){
				alert("Maximum size of a team is 11! If you have selected 11 players then click on CREATE TEAM");
				return;
			}
			if(finalplayer.indexOf(id)!== -1){
				alert("You have already added this player!");
				return;
			}
			switch(speci){
				case 1:
					if(pbatsman===batsmanlimit[1]){
						alert("maximum limit of batsman is 5");
						return;
					}break;
				case 2:
					if(pbowler===bowlerlimit[1]){
						alert("maximum limit of bowler is 5");
						return;
					}break;
				case 3:
					if(par===arlimit[1]){
						alert("maximum limit of all rounder is 3");
						return;
					}break;
				case 4:
					if(pwk===wklimit[1]){
						alert("maximum limit of wicket keeper is 1");
						return;
					}break;
				default:
					return;
			}
			finalplayer.push(id);
			maxpt = maxpt - betpt;
			var markup = "<div id='player-table-"+id+"'>" + name + "," + speci + "<button onclick='removeplayer(" + id+","+speci+","+betpt + ")'>Remove</button></div>";
			$(".player-table").append(markup);
						
			if(speci==1){
				pbatsman++;
			}
			if(speci==2){
				pbowler++;
			}
			if(speci==3){
				par++;
			}
			if(speci==4){
				pwk++;
			}
			$(".betting-point").text("Beting points: "+maxpt);
			if((batsmanlimit[0]-pbatsman)>0)
				$(".batsmanlimit").text("Minimum batsman required:"+(batsmanlimit[0]-pbatsman));
			else
				$(".batsmanlimit").text("Minimum batsman required:"+0);
			if((batsmanlimit[0]-pbatsman)>0)
				$(".bowlerlimit").text("Minimum bowler required:"+(bowlerlimit[0]-pbowler));
			else
				$(".bowlerlimit").text("Minimum bowler required:"+0);
			if((batsmanlimit[0]-pbatsman)>0)
				$(".wklimit").text("Minimum wicket keeper required:"+(wklimit[0]-pwk));
			else
				$(".wklimit").text("Minimum wicket keeper required:"+0);
			if((batsmanlimit[0]-pbatsman)>0)
				$(".arlimit").text("Minimum all rounder required:"+(arlimit[0]-par));
			else
				$(".arlimit").text("Minimum all rounder required:"+0);
			
			$(".noOfPlayer").text("No of players added:"+(finalplayer.length));
		}
		
		function submitTeam(){
			
			if((batsmanlimit[0]-pbatsman)>0){
				alert("you required minimum "+(batsmanlimit[0]-pbatsman)+" batsman");
				return;
			}
			if((bowlerlimit[0]-pbowler)>0){
				alert("you required minimum "+(bowlerlimit[0]-pbowler)+" bowler");
				return;
			}
			if((wklimit[0]-pwk)>0){
				alert("you required minimum "+(wklimit[0]-pwk)+" wicket keeper");
				return;
			}
			if((arlimit[0]-par)>0){
				alert("you required minimum "+(arlimit[0]-par)+" all rounder");
				return;
			}
			if(finalplayer.length<11){
				alert("you need "+(11-finalplayer.length)+" player to create a team!");
				return;
			}
			$('.teamplayer-input').val(finalplayer);
			$('.teamplayer-pt').val(maxpt);
			$('.pbatsman').val(pbatsman);
			$('.pbowler').val(pbowler);
			$('.pwk').val(pwk);
			$('.par').val(par);
			//debugger;
			
			$('.button-submit').trigger("click");
			
		}
		
		function removeplayer(id,speci,betpt){
			debugger;
			var index=finalplayer.indexOf(id);
			finalplayer.splice(index,1);
			$('#player-table-' + id ).remove();
			maxpt=maxpt+betpt;
			$(".betting-point").text("Beting points: "+maxpt);
			if(speci==1){
				pbatsman--;
			}
			if(speci==2){
				pbowler--;
			}
			if(speci==3){
				par--;
			}
			if(speci==4){
				pwk--;
			}
			if((batsmanlimit[0]-pbatsman)>0)
				$(".batsmanlimit").text("Minimum batsman required:"+(batsmanlimit[0]-pbatsman));
			else
				$(".batsmanlimit").text("Minimum batsman required:"+0);
			if((batsmanlimit[0]-pbatsman)>0)
				$(".bowlerlimit").text("Minimum bowler required:"+(bowlerlimit[0]-pbowler));
			else
				$(".bowlerlimit").text("Minimum bowler required:"+0);
			if((batsmanlimit[0]-pbatsman)>0)
				$(".wklimit").text("Minimum wicket keeper required:"+(wklimit[0]-pwk));
			else
				$(".wklimit").text("Minimum wicket keeper required:"+0);
			if((batsmanlimit[0]-pbatsman)>0)
				$(".arlimit").text("Minimum all rounder required:"+(arlimit[0]-par));
			else
				$(".arlimit").text("Minimum all rounder required:"+0);
		}
	
		
		</script>
		<center><a href="userprofile.jsp?mode=joinmatch&user_id=<%=user_id%>">Go to Back</a></center>
		
		
		
<%
	}
	else if("changecaptain".equals(mode)){
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		//int m_id=Integer.parseInt(request.getParameter("m_id"));
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		String user_name=request.getParameter("user_name");
		String user_email=request.getParameter("user_email");
		int ut_id=Integer.parseInt(request.getParameter("ut_id"));
		Performance p1=new Performance();
		ArrayList<Integer> n=p1.getteamPlayers(ut_id);
		String s[]=p1.getplayerName(n);
		%>
		
		<b><u>Captain Information:</u></b><br/>
	<%
	int cap_id=p1.getcapId(ut_id);
	String s1[]=p1.capInfo(cap_id);
	
	for(int k=0;k<s1.length;k++){
		if(s1[k]==null){
			s1[k]="0";
		}
	}
	%>
	- Captain: <%=s1[0] %><br/>
	- Total Points: <%=s1[1] %><br/>
	- Current Match Points: <%=s1[2] %><br/>
		
		<form action="userprofile.jsp?mode=update" method="post">
		<table border="1" >
		<tbody>
		<tr>
		<th>Current Captian</th>
		<td><input type="text" name="captian" value="<%=s[0]%>" readonly="readonly"/></td>
		</tr>
		<tr>
		<th>Player 1</th>
		<td><input id="editname" type="text" name="p1"  value="<%=s[1]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(1)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 2</th>
		<td><input id="editname" type="text" name="p2"  value="<%=s[2]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(2)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 3</th>
		<td><input id="editname" type="text" name="p3"  value="<%=s[3]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(3)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 4</th>
		<td><input id="editname" type="text" name="p4"  value="<%=s[4]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(4)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 5</th>
		<td><input id="editname" type="text" name="p5"  value="<%=s[5]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(5)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 6</th>
		<td><input id="editname" type="text" name="p6"  value="<%=s[6]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(6)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 7</th>
		<td><input id="editname" type="text" name="p7"  value="<%=s[7]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(7)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 8</th>
		<td><input id="editname" type="text" name="p8"  value="<%=s[8]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(8)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 9</th>
		<td><input id="editname" type="text" name="p9"  value="<%=s[9]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_email=<%=user_email%>&user_id=<%=user_id%>&user_name=<%=user_name%>&p_id=<%=n.get(9)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		<tr>
		<th>Player 10</th>
		<td><input id="editname" type="text" name="p10"  value="<%=s[10]%>" readonly="readonly"/></td>
		<td><a href="userprofile.jsp?mode=updatecaptian&l_id=<%=l_id%>&user_id=<%=user_id%>&user_email=<%=user_email%>&user_name=<%=user_name%>&p_id=<%=n.get(10)%>&ut_id=<%=ut_id%>">click to choose</a></td>
		</tr>
		</tbody>
		</table>
		<a href="userprofile.jsp?mode=performance&l_id=<%=l_id%>&user_id=<%=user_id%>&user_email=<%=user_email%>&ut_id=<%=ut_id%>"> Back </a>

		</form>
	<%
		
	}
	
	else if("changePlayer".equals(mode)){
		
		//int p_id=Integer.parseInt(request.getParameter("p_id"));
		int ut_id=Integer.parseInt(request.getParameter("ut_id"));
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		String user_email=request.getParameter("user_email");
		int m_id=Integer.parseInt(request.getParameter("m_id"));
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		Performance p2=new Performance();
		ArrayList<Integer> n=p2.getteamPlayers(ut_id);
		String s[]=p2.getplayerName(n);
		Players p1=new Players();
		Match m1=new Match();
		int teamids[]=m1.matchTeams(m_id);
		ArrayList<Integer> a=p1.getplayers(teamids[0],teamids[1]);// ids of all players of actual teams
		/*out.println("a: "+a.size());
		for(int l=0;l<a.size();l++){
			out.println(a.get(l)+" ");
		}
		out.println("n: "+n.size());
		for(int l=0;l<n.size();l++){
			out.println(n.get(l)+" ");
		}*/
		ArrayList<String[]> v=p1.matchplayers(a);
		ArrayList<Integer> ids=new ArrayList<Integer>();// these are the players from where the user will change
		int i=0;
		for(int k=0;k<a.size();k++){
			if(k<a.size()){
				if(n.indexOf(a.get(k))>=0){
					continue;
				}
			}
			ids.add(a.get(k));
			i++;	
		}
		//out.println("that worked!");
		String pn[]=p2.getplayerName1(ids);
		
		/*out.println("ids: "+ids.size());
		for(int l=0;l<ids.size();l++){
			out.println(ids.get(l)+" ");
		}
		out.println("pn: "+pn.length);
		for(int l=0;l<pn.length;l++){
			out.println(pn[l]+" ");
		}*/
		
		%>		
		<center>Select Player which you want to change:</center>
		
		<table border="1" >
		<tbody>
		<tr>
		<th>Player 1</th>
		<td><input type="text" name="<%=n.get(0)%>" value="<%=s[0]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(0)%>" class="remove-row" onclick="removePlayer(<%=n.get(0)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 2</th>
		<td><input id="editname" type="text" name="<%=n.get(1)%>"  value="<%=s[1]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(1)%>" class="remove-row" onclick="removePlayer(<%=n.get(1)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 3</th>
		<td><input id="editname" type="text" name="<%=n.get(2)%>"  value="<%=s[2]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(2)%>" class="remove-row" onclick="removePlayer(<%=n.get(2)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 4</th>
		<td><input id="editname" type="text" name="<%=n.get(3)%>"  value="<%=s[3]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(3)%>" class="remove-row" onclick="removePlayer(<%=n.get(3)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 5</th>
		<td><input id="editname" type="text" name="<%=n.get(4)%>"  value="<%=s[4]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(4)%>" class="remove-row" onclick="removePlayer(<%=n.get(4)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 6</th>
		<td><input id="editname" type="text" name="<%=n.get(5)%>"  value="<%=s[5]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(5)%>" class="remove-row" onclick="removePlayer(<%=n.get(5)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 7</th>
		<td><input id="editname" type="text" name="<%=n.get(6)%>"  value="<%=s[6]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(6)%>" class="remove-row" onclick="removePlayer(<%=n.get(6)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 8</th>
		<td><input id="editname" type="text" name="<%=n.get(7)%>"  value="<%=s[7]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(7)%>" class="remove-row" onclick="removePlayer(<%=n.get(7)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 9</th>
		<td><input id="editname" type="text" name="<%=n.get(8)%>"  value="<%=s[8]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(8)%>" class="remove-row" onclick="removePlayer(<%=n.get(8)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 10</th>
		<td><input id="editname" type="text" name="<%=n.get(9)%>"  value="<%=s[9]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(9)%>" class="remove-row" onclick="removePlayer(<%=n.get(9)%>)" value="Remove Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 11</th>
		<td><input id="editname" type="text" name="<%=n.get(10)%>"  value="<%=s[10]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=n.get(10)%>" class="remove-row" onclick="removePlayer(<%=n.get(10)%>)" value="Remove Player" name="player" /></td>
		</tr>
		
		</tbody>
		</table>
		
		
		
		<center>Select Player with which you want to change:</center>
		<table border="1" >
		<tbody>
		<tr>
		<th>Player 1</th>
		<td><input type="text" name="p1" value="<%=pn[0]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(0)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(0)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 2</th>
		<td><input id="editname" type="text" name="p2"  value="<%=pn[1]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(1)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(1)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 3</th>
		<td><input id="editname" type="text" name="p3"  value="<%=pn[2]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(2)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(2)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 4</th>
		<td><input id="editname" type="text" name="p4"  value="<%=pn[3]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(3)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(3)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 5</th>
		<td><input id="editname" type="text" name="p5"  value="<%=pn[4]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(4)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(4)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 6</th>
		<td><input id="editname" type="text" name="p6"  value="<%=pn[5]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(5)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(5)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 7</th>
		<td><input id="editname" type="text" name="p7"  value="<%=pn[6]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(6)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(6)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 8</th>
		<td><input id="editname" type="text" name="p8"  value="<%=pn[7]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(7)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(7)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 9</th>
		<td><input id="editname" type="text" name="p9"  value="<%=pn[8]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(8)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(8)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 10</th>
		<td><input id="editname" type="text" name="p10"  value="<%=pn[9]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(9)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(9)%>)" value="Add Player" name="player" /></td>
		</tr>
		<tr>
		<th>Player 11</th>
		<td><input id="editname" type="text" name="p11"  value="<%=pn[10]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(10)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(10)%>)" value="Add Player" name="player" /></td>
		</tr>
		<th>Player 12</th>
		<td><input id="editname" type="text" name="p12"  value="<%=pn[11]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(11)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(11)%>)" value="Add Player" name="player" /></td>
		</tr>
		<th>Player 13</th>
		<td><input id="editname" type="text" name="p13"  value="<%=pn[12]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(12)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(12)%>)" value="Add Player" name="player" /></td>
		</tr>
		<th>Player 14</th>
		<td><input id="editname" type="text" name="p14"  value="<%=pn[13]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(13)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(13)%>)" value="Add Player" name="player" /></td>
		</tr>
		<th>Player 15</th>
		<td><input id="editname" type="text" name="p15"  value="<%=pn[14]%>" readonly="readonly"/></td>
		<td><input type="button" id="<%=ids.get(14)%>" class="remove-row" onclick="replacePlayer(<%=ids.get(14)%>)" value="Add Player" name="player" /></td>
		</tr>
		
		</tbody>
		</table>
		<a href="userprofile.jsp?mode=performance&l_id=<%=l_id%>&user_id=<%=user_id%>&user_email=<%=user_email%>&ut_id=<%=ut_id%>"> Back </a>
		
		<form action="changePlayer.jsp?user_id=<%=user_id%>&l_id=<%=l_id%>&m_id=<%=m_id%>&ut_id=<%=ut_id%>" method="POST" >
  	
  	
  	<input class="removeId" type="hidden" value="123" name="removeId" />
  	<input class="addId" type="hidden" value="123" name="addId" />
  <!--   <input type="hidden" name="mpk[]" value="x" class="mpk"/>
    <input type="hidden" name="mpk[]" value="y" class="mpk"/>-->
   <input type="submit" class="button-submit1" />
		</form>
		
		<button onclick="replace()" >Submit Team</button>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script>
		
		var removeId=0;
		var addId=0;
		
		function removePlayer(id){
			removeId=id;
		}
		function replacePlayer(id){
			addId=id;
		}
		
		function replace(){
			$('.removeId').val(removeId);
			$('.addId').val(addId);
			$('.button-submit1').trigger("click");
		}
		</script>
		
		
	<%

		
	}
	else if("updatecaptian".equals(mode)){
		int p_id=Integer.parseInt(request.getParameter("p_id"));
		int ut_id=Integer.parseInt(request.getParameter("ut_id"));
		int user_id=Integer.parseInt(request.getParameter("user_id"));
		String user_name=request.getParameter("user_name");
		String user_email=request.getParameter("user_email");
		int l_id=Integer.parseInt(request.getParameter("l_id"));
		Performance p2=new Performance();
		p2.changecaptian(p_id,ut_id);
	%>
		
		<jsp:include page="userprofile.jsp">
			<jsp:param name="mode" value="performance"/>
			<jsp:param name="l_id" value="<%=l_id%>"/>
			<jsp:param name="user_id" value="<%=user_id%>"/>
			<jsp:param name="user_name" value="<%=user_name%>"/>
			<jsp:param name="user_email" value="<%=user_email%>"/>
    	</jsp:include>	
	<%
		
		
	}
	%>
	
	
	
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
	 
</body>
</html>