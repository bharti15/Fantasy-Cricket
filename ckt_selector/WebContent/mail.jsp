<html>
<head>
<title>JSP JavaMail Example </title>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%   
{
	
	String subject="",msg="",email="";	
	email=request.getParameter("email");
	subject=request.getParameter("subject");
	msg=request.getParameter("msg");
	String host = "smtp.gmail.com";
	String from = "itsbhartitime2@gmail.com";//dummy mail 
	String pass = "bhartitime";//dummy pass
	Properties props = System.getProperties();
	props.put("mail.smtp.starttls.enable", "true"); 
	props.put("mail.smtp.host", host);
	props.put("mail.smtp.user", from);
	props.put("mail.smtp.password", pass);
	props.put("mail.smtp.port", "587");
	props.put("mail.smtp.auth", "true");
	String[] to =new String[1];
	to[0]=email;
	Session session2 = Session.getDefaultInstance(props, null);
	MimeMessage message = new MimeMessage(session2);
	message.setFrom(new InternetAddress(from));
	InternetAddress[] toAddress = new InternetAddress[to.length];
	
 
	// To get the array of addresses
	for( int i=0; i < to.length; i++ ) 
	{ 
		// changed from a while loop
		toAddress[i] = new InternetAddress(to[i]);
	}
 
 	for( int i=0; i < toAddress.length; i++) 
	{ 
		// changed from a while loop
		message.addRecipient(Message.RecipientType.TO, toAddress[i]);
	}
	message.setSubject(subject);
	message.setText(msg);
	Transport transport = session2.getTransport("smtp");
	transport.connect(host, from, pass);
	transport.sendMessage(message, message.getAllRecipients());
	transport.close();
}
%>
Message Send Successfully
<br>
<a href="index.jsp">Back</a>
</body>
</html>
