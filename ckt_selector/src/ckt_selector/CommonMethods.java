package ckt_selector;
import java.sql.*;
import ckt_selector.DConnection;
public class CommonMethods 
{

	ResultSet rst;
	public String getUserName(int user_id)
	{
		String userName="";
		try
		{
			DConnection db=new DConnection();
			ResultSet rst=db.executeSelect("select name from users where user_id="+user_id);
			rst.next();
			userName=rst.getString(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return userName;
	}
	public String getAdminName(String user_id)
	{
		String userName="";
		try
		{
			DConnection db=new DConnection();
			ResultSet rst=db.executeSelect("select admin_name from admin where admin_id='"+user_id+"'");
			rst.next();
			userName=rst.getString(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return userName;
	}
	
	
	public static String getCategoryName(int id)
	{
		DConnection db=new DConnection();
		String name="";
		try{
			ResultSet rst=db.executeSelect("select cat_name from category where cat_id="+id);
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
	public static String getSubCategoryName(int id)
	{
		DConnection db=new DConnection();
		String name="";
		try{
			ResultSet rst=db.executeSelect("select subcat_name from subcategory where subcat_id="+id);
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
	public int count(String mail)
	{
		int cnt=0;
		try
		{
			DConnection db=new DConnection();
			ResultSet rst=db.executeSelect("select count(*) from user where user_email='"+mail+"'");
			rst.next();
			cnt=rst.getInt(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return cnt;
	}
	public int count1(String contact)
	{
		int cnt1=0;
		try
		{
			DConnection db=new DConnection();
			
			ResultSet rst=db.executeSelect("select count(*) from user where user_contact='"+contact+"'");
			rst.next();
			
			cnt1=rst.getInt(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return cnt1;
	}
	public static int adminCount(String mail)
	{
		int cnt=0;
		try
		{
			DConnection db=new DConnection();
			ResultSet rst=db.executeSelect("select count(*) from admin where admin_id='"+mail+"'");
			rst.next();
			cnt=rst.getInt(1);
			db.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return cnt;
	}


}