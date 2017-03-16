package ckt_selector;
import java.sql.*;
import java.util.*;

public class Bowlingpts {

	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from bowling_pts");
			while(rst.next())
			{	String s[]=new String[10];
				for(int i=0;i<10;i++)
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
	
	public int updateRecord(double bowled, double wickets, double LBW, double dotBall, double maidenOver, double hattrik, double bowl_sr30_39, double bowl_sr40_49, double bowl_sr50_, double hitWicket)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update bowling_pts set bowled="+bowled+", wickets="+wickets+", LBW="+LBW+", dotBall="+dotBall+", maidenOver="+maidenOver+", hattrik="+hattrik+", bowl_sr30_39="+bowl_sr30_39+", bowl_sr40_49="+bowl_sr40_49+", bowl_sr50_="+bowl_sr50_+", hitWicket="+hitWicket);
		db.close();
		return c;
	}
	
}
