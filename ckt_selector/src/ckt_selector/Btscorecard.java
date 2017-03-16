package ckt_selector;
import java.sql.*;
import java.util.*;

public class Btscorecard {
	
	public int addRecord(int p_id, int runs,int noOfBallsPlayed, int noOf4, int noOf6, int halfCentury, int century, double battingSR, int at_id, int m_id, int l_id)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into at_btscorecard values("+p_id+","+runs+","+noOfBallsPlayed+","+noOf4+","+noOf6+", "+halfCentury+", "+century+", "+battingSR+", "+at_id+", "+m_id+", "+l_id+")");
		db.close();
		return c;
	}
	public int deleteRecord(int p_id, int m_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from at_btscorecard where p_id="+p_id+" and m_id="+m_id);
		db.close();
		return c;
	}
	public int updateRecord(int p_id, int runs,int noOfBallsPlayed, int noOf4, int noOf6, int halfCentury, int century, double battingSR, int at_id, int m_id, int l_id)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update at_btscorecard set runs="+runs+", noOfBallsPlayed="+noOfBallsPlayed+", noOf4="+noOf4+", noOf6="+noOf6+", halfCentury="+halfCentury+", century="+century+", battingSR="+battingSR+", at_id="+at_id+", m_id="+m_id+", l_id="+l_id+"  where p_id="+p_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll(int m_id)
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from at_btscorecard where m_id="+m_id);
			while(rst.next())
			{	String s[]=new String[11];
				for(int i=0;i<11;i++)
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
		String s[]=new String[11];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from at_btscorecard where p_id="+p_id);
			if(rst.next())
			{
				for(int i=0;i<11;i++)
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
			rst=db.executeSelect("select max(p_id) from at_btscorecard");
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
