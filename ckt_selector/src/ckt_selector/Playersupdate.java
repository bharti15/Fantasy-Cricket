package ckt_selector;
import java.sql.*;
import java.util.*;

public class Playersupdate {
	
	public int addRecord(int p_id, int specification, double m_batingsr, int m_wicketTaken, int m_catchout, int halfCentury, int century, double m_runRate, int noOf6, int noOf4, double m_bowlsr, int stumpsTaken, int bowled, int runout, int directHit, int LBW, int dotBall, int maidenOver, int hattrik, int duck, double m_pts, int tot_runs)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into player_update values("+p_id+","+specification+","+m_batingsr+","+m_wicketTaken+", "+m_catchout+", "+halfCentury+", "+century+", "+m_runRate+", "+noOf6+", "+noOf4+", "+m_bowlsr+", "+stumpsTaken+", "+bowled+", "+runout+", "+directHit+", "+LBW+", "+dotBall+", "+maidenOver+", "+hattrik+", "+duck+", "+m_pts+", "+tot_runs+")");
		db.close();
		return c;
	}
	public int deleteRecord(int p_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from player_update where p_id="+p_id);
		db.close();
		return c;
	}
	public int updateRecord(int p_id, int specification, double m_batingsr, int m_wicketTaken, int m_catchout, int halfCentury, int century, double m_runRate, int noOf6, int noOf4, double m_bowlsr, int stumpsTaken, int bowled, int runout, int directHit, int LBW, int dotBall, int maidenOver, int hattrik, int duck, double m_pts, int tot_runs)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update player_update set specification="+specification+", m_batingsr="+m_batingsr+", m_wicketTaken="+m_wicketTaken+", m_catchout="+m_catchout+", halfCentury="+halfCentury+", century="+century+", m_runRate="+m_runRate+", noOf6="+noOf6+", noOf4="+noOf4+", m_bowlsr="+m_bowlsr+", stumpsTaken="+stumpsTaken+", bowled="+bowled+", runout="+runout+", directHit="+directHit+", LBW="+LBW+", dotBall="+dotBall+", maidenOver="+maidenOver+", hattrik="+hattrik+", duck="+duck+", m_pts="+m_pts+", tot_runs="+tot_runs+"  where p_id="+p_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from player_update");
			while(rst.next())
			{	String s[]=new String[22];
				for(int i=0;i<22;i++)
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
		String s[]=new String[22];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from player_update where p_id="+p_id);
			if(rst.next())
			{
				for(int i=0;i<22;i++)
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
			rst=db.executeSelect("select max(p_id) from player_update");
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
