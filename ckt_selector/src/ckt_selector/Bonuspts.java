package ckt_selector;
import java.sql.*;
import java.util.*;

public class Bonuspts {
	
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from bonus_pts");
			while(rst.next())
			{	String s[]=new String[3];
				for(int i=0;i<3;i++)
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
	
	public int updateRecord(double man_player, double man_team, double victory_player)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update bonus_pts set man_player="+man_player+", man_team="+man_team+", victory_player="+victory_player);
		db.close();
		return c;
	}

}
