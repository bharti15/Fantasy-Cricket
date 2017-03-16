<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">!-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Login</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    	<!-- CUSTOM -->
    	<link href='https://fonts.googleapis.com/css?family=Oswald|Open+Sans' rel='stylesheet' type='text/css'>
    		
    		
     <link href="css/Custom.css" rel="stylesheet">
     	
     	<link href="css/font-awesome.min.css" rel="stylesheet">
     
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<body>
		<jsp:useBean class="ckt_selector.AdminSignupCheck" id="c1"></jsp:useBean>
<%
		String x=String.valueOf(ckt_selector.MailVerification.Random());
		
		//String x="1234"; for testing		

		String name= request.getParameter("sname");
		String pass= request.getParameter("pass");
		String rpass= request.getParameter("retype");
		String mail= request.getParameter("email");
		String teamname=request.getParameter("teamname");
		String contact= request.getParameter("mobile");
		
		
		String msg="Enter this One Time Password to verify your email "+x ;
		ckt_selector.CommonMethods cm=new ckt_selector.CommonMethods();
		
		
		int cnt=cm.count(mail);
		int cnt1=cm.count1(contact);
		
		 if(cnt !=0 && cnt1!=0) //if unauthorized
			{
%>
				<jsp:include page="user_signup.jsp"></jsp:include>
<%				out.print("<center><h1>Mobile no already and mail id exists</h1></center><br><br>"); 				
			}	
			
		else if(cnt != 0)//if unauthorized
		{
%>
			<jsp:include page="user_signup.jsp"></jsp:include>
<%				out.print("<center><h1>Mail id   already exists</h1></center><br><br>"); 
			
		}
		 else  if(cnt1 != 0)//if unauthorized
		{
%>
			<jsp:include page="user_signup.jsp"></jsp:include>
			
<%				out.print("<center><h1>Mobile no already exists</h1></center><br><br>"); 
				
		}	
		

		else
		{
%>


	<jsp:include page="mail.jsp">
		<jsp:param name="email" value="<%=mail%>" />
		<jsp:param name="subject" value="Verification" />
		<jsp:param name="msg" value="<%=msg%>" />
	</jsp:include>

	<ul class="dropdown-menu" aria-labelledby="dropdownMenuDivider">
  ...
  <li role="separator" class="divider"></li>
  ...
</ul>


   <div class="modal-dialog">
      <div class="madal-content">
        <div class="modal-header">
          <h1 class="text-center">Verify Email</h1>

        </div>
        <div class="modal-body">
        
          <form class="col-md-12 center-block" action="signup_check.jsp">
            
            
            <div class="form-group">
              <div class="input-group">
            <span class="input-group-addon">
          <span class="glyphicon glyphicon-lock"></span>
        </span>
              <input type="text" name="otp" class="form-control input-lg" placeholder="One Time Password" required="required">
            </div>
            </div>
			
			
						
            <div class="form-group">
						
			<input type="hidden" name="generatedotp" value="<%=x%>">
			<input type="hidden" name="sname" value="<%=name%>">
			<input type="hidden" name="pass" value="<%=pass%>">
			<input type="hidden" name="email" value="<%=mail%>">
			<input type="hidden" name="mobile" value="<%=contact%>">
			<input type="hidden" name="teamname" value="<%=teamname%>">
            <input type="submit" name="b1" class="btn btn-block btn-lg btn-primary" value="Submit">
                
            </div>
            
          </form>
          <div class="modal-footer">
            <div class="col-md-12">
              <a href="index.jsp"><button class="btn">Cancel</button></a>
  
            </div>
            
          </div>
        </div>
    
      </div>
    
    </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>

<%
		}
%>


</body>
</html>