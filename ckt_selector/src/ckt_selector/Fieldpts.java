package ckt_selector;
import java.sql.*;
import java.util.*;

public class Fieldpts {

	public Vector<String []> showRecordAll()
	{
		Vector<String[]> v1=new Vector<String[]>();
		DConnection db=new DConnection();
		try
		{	ResultSet rst=db.executeSelect("select * from field_pts");
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
	
	public int updateRecord(double catch_out, double f_stumps, double run_out, double directHit)
	{
		DConnection db=new DConnection();
		int c=db.executeOther("update field_pts set catch_out="+catch_out+", f_stumps="+f_stumps+", run_out="+run_out+", directHit="+directHit);
		db.close();
		return c;
	}
	
}
