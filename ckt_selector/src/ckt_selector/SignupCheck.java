package ckt_selector;
import java.sql.*;
public class SignupCheck 
{

	private DConnection db=new DConnection();
	public void addUser(String name,String password,String mail_id,String contact,String teamname)
	{	
		db.executeOther("insert into user(user_name,user_email,user_contact,user_teamName,user_noOfTeam,password) values('"+name+"','"+mail_id+"','"+contact+"','"+teamname+"',"+0+",'"+password+"')");
		db.close();
	}	
}
