package ckt_selector;
import java.sql.*;
import java.util.*;

public class Bwscorecard {
	
	public int addRecord(int p_id, int runs_given,int wickets, double bowlingSR, int at_id, int m_id, int l_id)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into at_bwscorecard values("+p_id+","+runs_given+","+wickets+", "+bowlingSR+", "+at_id+", "+m_id+", "+l_id+")");
		db.close();
		return c;
	}
	public int deleteRecord(int p_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from at_bwscorecard where p_id="+p_id);
		db.close();
		return c;
	}
	public int updateRecord(int p_id, int runs_given, int wickets, double bowlingSR, int at_id, int m_id, int l_id)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update at_bwscorecard set runs_given="+runs_given+", wickets="+wickets+", bowlingSR="+bowlingSR+", at_id="+at_id+", m_id="+m_id+", l_id="+l_id+"  where p_id="+p_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from at_bwscorecard");
			while(rst.next())
			{	String s[]=new String[7];
				for(int i=0;i<7;i++)
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
	public Vector<String []> showRecord(int p_id)
	{
		Vector<String[]> v1=new Vector<>();
		String s[]=new String[7];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from at_bwscorecard where p_id="+p_id);
			if(rst.next())
			{
				for(int i=0;i<7;i++)
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
			rst=db.executeSelect("select max(p_id) from at_bwscorecard");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}

	public String getplayername(int p_id)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		String r=null;
		try
		{
			rst=db.executeSelect("select p_name from players where p_id="+p_id);
			rst.next();
			r=rst.getString(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	
	public String getTeam(int at_id)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		String r=null;
		try
		{
			rst=db.executeSelect("select at_name from ac_team where at_id="+at_id);
			rst.next();
			r=rst.getString(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	
	public int getTeamid(String at_name)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		int r=0;
		try
		{
			rst=db.executeSelect("select at_id from ac_team where at_name='"+at_name+"'");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
}
