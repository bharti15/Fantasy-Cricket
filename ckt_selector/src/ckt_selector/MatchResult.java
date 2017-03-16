package ckt_selector;
import java.sql.*;
import java.util.*;

public class MatchResult {
	
	public int addRecord(int m_id, String status, int l_id, int won, int lost)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into match_result values("+m_id+",'"+status+"',"+l_id+","+won+","+lost+")");
		db.close();
		return c;
	}
	public int deleteRecord(int m_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from match_result where m_id="+m_id);
		db.close();
		return c;
	}
	public int updateRecord(int m_id, String status, int won, int lost, int l_id)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update matches set status='"+status+"', won="+won+", lost="+lost+", l_id="+l_id+" where m_id="+m_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from match_result");
			while(rst.next())
			{	String s[]=new String[5];
				for(int i=0;i<5;i++)
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
		String s[]=new String[4];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from match_result where m_id="+m_id);
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
			rst=db.executeSelect("select max(m_id) from match_result");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	
	public String getMatch(int m_id)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		String r=null;
		try
		{
			rst=db.executeSelect("select m_name from matches where m_id="+m_id);
			rst.next();
			r=rst.getString(1);
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

	public int getMatchid(String m_name)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		int r=0;
		try
		{
			rst=db.executeSelect("select m_id from matches where m_name='"+m_name+"'");
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
