package ckt_selector;
import java.sql.*;
import java.util.*;

public class Acteam {
	
	public int addRecord(int at_id, String at_name,String belongsTo, int curRank)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into ac_team values("+at_id+",'"+at_name+"','"+belongsTo+"',"+curRank+")");
		db.close();
		return c;
	}
	public int deleteRecord(int at_id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from ac_team where at_id="+at_id);
		db.close();
		return c;
	}
	public int updateRecord(int at_id, String at_name, String belongsTo, int curRank)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update ac_team set at_name='"+at_name+"', belongsTo='"+belongsTo+"', curRank="+curRank+"  where at_id="+at_id);
		db.close();
		return c;
	}
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from ac_team");
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
	public Vector<String []> showRecord(int at_id)
	{
		Vector<String[]> v1=new Vector<>();
		String s[]=new String[4];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from ac_team where at_id="+at_id);
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
			rst=db.executeSelect("select max(at_id) from ac_team");
			rst.next();
			r=rst.getInt(1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return r;
	}
	public String getname(int at_id){
		DConnection db=new DConnection();
		ResultSet rst;
		String name=null;
		try{
			rst=db.executeSelect("select at_name from ac_team where at_id="+at_id);
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
