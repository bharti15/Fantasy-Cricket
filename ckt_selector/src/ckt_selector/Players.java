package ckt_selector;
import java.sql.*;
import java.util.*;

public class Players {
	
	public int addRecord(int p_id, String p_name,int tot_runs, double max_sr, double curr_sr, int tot_wk, int tot_catchout, int halfCentury, int century, double max_runrate, int noOf6, int noOf4, double max_bowlsr, int stumpsTaken, int bowled, int tot_catchesTaken, int tot_runouts, int directHits, int LBW, int dotBall, int maidenOver, int hattrik, int duck, int speci, double tot_pts, double bet_pt)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into players values("+p_id+",'"+p_name+"',"+tot_runs+","+max_sr+", "+curr_sr+", "+tot_wk+", "+tot_catchout+", "+halfCentury+", "+century+", "+max_runrate+", "+noOf6+", "+noOf4+", "+max_bowlsr+", "+stumpsTaken+", "+bowled+", "+tot_catchesTaken+", "+tot_runouts+", "+directHits+", "+LBW+", "+dotBall+", "+maidenOver+", "+hattrik+", "+duck+", "+speci+", "+tot_pts+", "+bet_pt+")");
		db.close();
		return c;
	}
	public int deleteRecord(int p_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from players where p_id="+p_id);
		db.close();
		return c;
	}
	public int updateRecord(int p_id, String p_name,int tot_runs, double max_sr, double curr_sr, int tot_wk, int tot_catchout, int halfCentury, int century, double max_runrate, int noOf6, int noOf4, double max_bowlsr, int stumpsTaken, int bowled, int tot_catchesTaken, int tot_runouts, int directHits, int LBW, int dotBall, int maidenOver, int hattrik, int duck, int speci, double tot_pts, double bet_pt)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update players set p_name='"+p_name+"', tot_runs="+tot_runs+", max_sr="+max_sr+", curr_sr="+curr_sr+", tot_wk="+tot_wk+", tot_catchout="+tot_catchout+", halfCentury="+halfCentury+", century="+century+", max_runrate="+max_runrate+", noOf6="+noOf6+", noOf4="+noOf4+", max_bowlsr="+max_bowlsr+", stumpsTaken="+stumpsTaken+", bowled="+bowled+", tot_catchesTaken="+tot_catchesTaken+", tot_runouts="+tot_runouts+", directHits="+directHits+", LBW="+LBW+", dotBall="+dotBall+", maidenOver="+maidenOver+", hattrik="+hattrik+", duck="+duck+", specification="+speci+", tot_pts="+tot_pts+", bet_pt="+bet_pt+"  where p_id="+p_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from players");
			while(rst.next())
			{	String s[]=new String[26];
				for(int i=0;i<26;i++)
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
		String s[]=new String[26];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from players where p_id="+p_id);
			if(rst.next())
			{
				for(int i=0;i<26;i++)
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
			rst=db.executeSelect("select max(p_id) from players");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	
	public int speciId(int p_id)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		int r=0;
		try
		{
			rst=db.executeSelect("select specification from players where p_id="+p_id);
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	
	public String playerName(int p_id)
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
	
	public double betingPoint(int p_id)
	{
		DConnection db=new DConnection();
		ResultSet rst;
		double r=0;
		try
		{
			rst=db.executeSelect("select bet_pt from players where p_id="+p_id);
			rst.next();
			r=rst.getDouble(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	
	public ArrayList<Integer> getplayers(int at_id1, int at_id2){
		ArrayList<Integer> a=new ArrayList<Integer>();
		
		DConnection db=new DConnection();
		ResultSet rst;
		try{
			rst=db.executeSelect("select * from at_players where at_id="+at_id1);
			if(rst.next())
			{
				for(int i=0;i<13;i++)
					{a.add(rst.getInt(i+2));}
			}
			rst=db.executeSelect("select * from at_players where at_id="+at_id2);
			if(rst.next())
			{
				for(int i=0;i<13;i++)
					{a.add(rst.getInt(i+2));}
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return a;
	}
	public ArrayList<String []> matchplayers(ArrayList<Integer> a)
	{
		ArrayList<String[]> v1=new ArrayList<String[]>();
		
		DConnection db=new DConnection();
		try
		{
			for(int j=0;j<a.size();j++){
				String s[]=new String[4];
				ResultSet rst=db.executeSelect("select p_id,p_name,specification,bet_pt from players where p_id="+a.get(j));
				if(rst.next()){
					for(int i=0;i<4;i++){
						s[i]=rst.getString(i+1);
					}
					v1.add(j, s);
				}
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		db.close();
		return v1;
	}
}
