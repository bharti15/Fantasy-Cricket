package ckt_selector;
import java.sql.*;
import java.util.*;

public class SpecificationId {

	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from specificationid");
			while(rst.next())
			{	String s[]=new String[2];
				for(int i=0;i<2;i++)
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
	
	public int addRecord(int id, String value)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("insert into specificationid values("+id+",'"+value+"')");
		db.close();
		return c;
	}
	public int deleteRecord(int id)
	{
        DConnection db=new DConnection();
		int c=db.executeOther("delete from specificationid where id="+id);
		db.close();
		return c;
	}
	public int updateRecord(int id, String value)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update specificationid set value='"+value+"' where id="+id);
		db.close();
		return c;
	}
	
	public Vector<String []> showRecord(int id)
	{
		Vector<String[]> v1=new Vector<>();
		String s[]=new String[2];
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select * from specificationid where id="+id);
			if(rst.next())
			{
				for(int i=0;i<2;i++)
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
			rst=db.executeSelect("select max(id) from specificationid");
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
