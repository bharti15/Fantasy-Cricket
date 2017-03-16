package ckt_selector;
import java.sql.*;
import java.util.*;

public class Batingpts {
	
	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from bating_pts");
			while(rst.next())
			{	String s[]=new String[9];
				for(int i=0;i<9;i++)
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
	
	/*public int addRecord(int id, String value)
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
	}*/
	public int updateRecord(double run1, double run6, double run4, double duck, double halfCentury, double century, double bt_sr100_149, double bt_sr150_199, double bt_sr200_)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update bating_pts set run1="+run1+", run6="+run6+", run4="+run4+", duck="+duck+", halfCentury="+halfCentury+", century="+century+", bt_sr100_149="+bt_sr100_149+", bt_sr150_199="+bt_sr150_199+", bt_sr200_="+bt_sr200_);
		db.close();
		return c;
	}
	
	/*public Vector<String []> showRecord(int id)
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
	}*/

	
}
