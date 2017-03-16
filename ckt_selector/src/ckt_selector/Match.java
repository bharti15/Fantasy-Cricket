package ckt_selector;
import java.sql.*;
import java.util.*;

public class Match {
	
	public int addRecord(int m_id, String m_name, String m_date, String m_time, String m_where, int at_id1, int at_id2, int l_id)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into matches values("+m_id+",'"+m_name+"','"+m_date+"','"+m_time+"','"+m_where+"',"+at_id1+", "+at_id2+", "+l_id+")");
		db.close();
		return c;
	}
	public int deleteRecord(int m_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from matches where m_id="+m_id);
		db.close();
		return c;
	}
	public int updateRecord(int m_id, String m_name, String m_date, String m_time, String m_where, int at_id1, int at_id2, int l_id)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update matches set m_name='"+m_name+"',m_date='"+m_date+"', m_time='"+m_time+"', m_where='"+m_where+"', at_id1="+at_id1+", at_id2="+at_id2+", l_id="+l_id+" where m_id="+m_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from matches");
			while(rst.next())
			{	String s[]=new String[8];
				for(int i=0;i<8;i++)
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
	
	public int[] matchTeams(int m_id){
		int teamids[]=new int[2];
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select at_id1, at_id2 from matches where m_id="+m_id);
			if(rst.next()){
				teamids[0]=rst.getInt(1);
				teamids[1]=rst.getInt(2);
			}
		}
		catch(SQLException e)
		{	e.printStackTrace();
		}
		db.close();
		return teamids;
	}
	
	public Vector<String []> showleagueMatch(int l_id)
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from matches where l_id="+l_id);
			while(rst.next())
			{	String s[]=new String[8];
				for(int i=0;i<8;i++)
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
	public Vector<String []> showRecord(int m_id)
	{
		Vector<String[]> v1=new Vector<>();
		String s[]=new String[8];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from matches where m_id="+m_id);
			if(rst.next())
			{
				for(int i=0;i<8;i++)
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
			rst=db.executeSelect("select max(m_id) from matches");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	
	public String getLeague(int l_id)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		String r=null;
		try
		{
			rst=db.executeSelect("select l_name from league where l_id="+l_id);
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

	public int getLeagueid(String l_name)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		int r=0;
		try
		{
			rst=db.executeSelect("select l_id from league where l_name='"+l_name+"'");
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
