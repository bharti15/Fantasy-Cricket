package ckt_selector;
import java.sql.*;
import java.util.*;

public class League {

	public int addRecord(int l_id, String l_name,String when, int noOfMatches)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into league(l_id, l_name,l_when,noOfMatches) values("+l_id+",'"+l_name+"','"+when+"',"+noOfMatches+")");
		db.close();
		return c;
	}
	public int deleteRecord(int l_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from league where l_id="+l_id);
		db.close();
		return c;
	}
	public int updateRecord(int oldid, String newl_name, String newwhen, int newnoOfMatches)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update league set l_name='"+newl_name+"', l_when='"+newwhen+"', noOfMatches="+newnoOfMatches+"  where l_id="+oldid);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from league");
			while(rst.next())
			{	String s[]=new String[4];
				for(int i=0;i<4;i++)
				{
					s[i]=rst.getString(i+1);
				}
				v1.addElement(s);
			}
		}
		catch(SQLException e)
		{	e.printStackTrace();
		}
		db.close();
		return v1;
	}
	public Vector<String []> showcurLeague(String date)
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from league where l_when>='"+date+"'");
			while(rst.next())
			{	String s[]=new String[4];
				for(int i=0;i<4;i++)
				{
					s[i]=rst.getString(i+1);
				}
				v1.addElement(s);
			}
		}
		catch(SQLException e)
		{	e.printStackTrace();
		}
		db.close();
		return v1;
	}
	public Vector<String []> showRecord(int l_id)
	{
		Vector<String[]> v1=new Vector<>();
		String s[]=new String[4];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from league where l_id="+l_id);
			if(rst.next())
			{
				for(int i=0;i<4;i++)
					s[i]=rst.getString(i+1);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		v1.addElement(s);
		db.close();
		return v1;
	}
	public int maxId()
	{
		DConnection db=new DConnection();
		ResultSet rst;
		int r=0;
		try
		{
			rst=db.executeSelect("select max(l_id) from league");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	public String getname(int l_id){
		DConnection db=new DConnection();
		ResultSet rst;
		String name=null;
		try{
			rst=db.executeSelect("select l_name from league where l_id="+l_id);
			rst.next();
			name=rst.getString(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return name;
	}
}
