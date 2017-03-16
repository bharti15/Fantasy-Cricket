package ckt_selector;
import java.sql.*;
import java.util.*;

public class Atplayers {
	
	public int addRecord(int at_id, int at_p1, int at_p2, int at_p3, int at_p4, int at_p5, int at_p6, int at_p7, int at_p8, int at_p9, int at_p10, int at_p11, int at_p12, int at_p13)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into at_players values("+at_id+","+at_p1+","+at_p2+","+at_p3+","+at_p4+","+at_p5+","+at_p6+","+at_p7+","+at_p8+","+at_p9+","+at_p10+","+at_p11+","+at_p12+","+at_p13+")");
		db.close();
		return c;
	}
	public int deleteRecord(int at_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from at_players where at_id="+at_id);
		db.close();
		return c;
	}
	public int updateRecord(int at_id, int at_p1, int at_p2, int at_p3, int at_p4, int at_p5, int at_p6, int at_p7, int at_p8, int at_p9, int at_p10, int at_p11, int at_p12, int at_p13)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update at_players set at_p1="+at_p1+", at_p2="+at_p2+", at_p3="+at_p3+", at_p4="+at_p4+", at_p5="+at_p5+", at_p6="+at_p6+", at_p7="+at_p7+", at_p8="+at_p8+", at_p9="+at_p9+", at_p10="+at_p10+", at_p11="+at_p11+", at_p12="+at_p12+", at_p13="+at_p13+"  where at_id="+at_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from at_players");
			while(rst.next())
			{	String s[]=new String[14];
				for(int i=0;i<14;i++)
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
	public Vector<String []> showRecord(int at_id)
	{
		Vector<String[]> v1=new Vector<>();
		String s[]=new String[14];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from at_players where at_id="+at_id);
			if(rst.next())
			{
				for(int i=0;i<14;i++)
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
			rst=db.executeSelect("select max(at_id) from at_players");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}

	public int[] getteamPlayers(int at_id){
		int n[]=new int[13];
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select * from at_players where at_id="+at_id);
			if(rst.next()){
				for(int i=0;i<13;i++){
					n[i]=rst.getInt(i+2);
				}
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		db.close();
		return n;
	}
	
	public String[] getplayerName(int n[]){
		String s[]=new String[13];
		DConnection db=new DConnection();
		try{
			for(int j=0;j<13;j++){
				ResultSet rst=db.executeSelect("select p_name from players where p_id="+n[j]);
				if(rst.next()){
					s[j]=rst.getString(1);
				}
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		db.close();
		return s;
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
}
