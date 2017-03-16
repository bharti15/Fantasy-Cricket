package ckt_selector;
import java.sql.*;
import java.util.*;

import javax.servlet.RequestDispatcher;

import ckt_selector.DConnection;
public class User {
	ResultSet rst;
	private int user_id;
	public int getUser_id() {
		return user_id;
	}
	private int state_id;
	private int city_id;
		
	public void updateRecord(int user_id,String user_name,String user_email,String  user_contact,String password)
	{
		DConnection db=new DConnection();
		db.executeOther("update user set user_name='"+user_name+"', user_email='"+user_email+"',user_contact='"+user_contact+"',password='"+password+"' where user_id="+user_id);
		db.close();
	}
	public void deleteAccount(int user_id)
	{
		DConnection db=new DConnection();
		db.executeOther("delete from users where user_id="+user_id);
		db.close();
	}
	
	public int getTeams(String user_email)
	{
		DConnection db=new DConnection();
		int i=0;
		try{
			ResultSet rst=db.executeSelect("select * from user where user_email='"+user_email.trim()+"'");
			rst.next();
			i=rst.getInt(6);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return i;
		
	}
	public ArrayList<Integer> userLeague(int user_id)
	{	DConnection db=new DConnection();
		ArrayList<Integer> s1=new ArrayList<Integer>();
		
		try
		{	rst=db.executeSelect("select l_id from userleague where user_id="+user_id);
			while(rst.next())
			{
				s1.add(rst.getInt(1));
			}
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		db.close();
		return s1;
		
	}
		public String league_name(int l_id)
	{
		DConnection db=new DConnection();
		String sb="";
		try{
			ResultSet rst=db.executeSelect("select l_name from league where l_id="+l_id);
			rst.next();
			sb=rst.getString(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return sb;
		
	}
	public int getuser_id(String user_email)
	{
		DConnection db=new DConnection();
		int i=0;
		try{
			ResultSet rst=db.executeSelect("select user_id from user where user_email='"+user_email.trim()+"'");
			rst.next();
			i=rst.getInt(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return i;
		
	}
	
	public Vector showContactDetails(int user_id)
	{	DConnection db=new DConnection();
		Vector<String []> v1=new Vector<>();
		String s1[]=new String[8];
		try
		{	rst=db.executeSelect("select * from users where user_id="+user_id+"");
			if(rst.next())
			{
				for(int i=0;i<5;i++)
				{
				s1[i]=rst.getString(i+1);
				}
				int c=Integer.parseInt(rst.getString(6));
				
				int s=Integer.parseInt(rst.getString(7));
				//s1[5]=getCity_name(c);
				//s1[6]=getState_name(s);
				s1[7]=rst.getString(8);
				
			}
		}catch(SQLException e)
		{
		e.printStackTrace();
		}
		v1.addElement(s1);
		db.close();
		return v1;
		
	}
	public String getuser_name(String user_email)
	{
		DConnection db=new DConnection();
		String name= null;
		try{
			ResultSet rst=db.executeSelect("select user_name from user where user_email='"+user_email.trim()+"'");
			rst.next();
			name=rst.getString(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return name;
		
	}
	public void changePassword(String pass,int user_id)
	{ 
	DConnection db=new DConnection();
	db.executeOther("update users set password='"+pass+"' where user_id="+user_id);
	db.close();
	}
	public String getpassword(String user_email)
	{
		DConnection db=new DConnection();
		String password= null;
		try{
			ResultSet rst=db.executeSelect("select password from user where user_email='"+user_email.trim()+"'");
			rst.next();
			password=rst.getString(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return password;
		
	}
	public String getcontact(String user_email)
	{
		DConnection db=new DConnection();
		String contact= null;
		try{
			ResultSet rst=db.executeSelect("select user_contact from user where user_email='"+user_email.trim()+"'");
			rst.next();
			contact=rst.getString(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return contact;
		
	}
	
	public void updateViaMailId(String name,String pass,String Email_id)
	{
		DConnection db=new DConnection();
		db.executeOther("update users set name='"+name+"', password='"+pass+"' where mail_id= '"+Email_id+"' ");
		db.close();
	}
}
