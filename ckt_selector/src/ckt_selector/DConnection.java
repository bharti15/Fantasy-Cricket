package ckt_selector;
import java.sql.*;
import java.util.ArrayList;
//import java.util.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public class DConnection {
	
	Connection conn;
	Statement stmt;
	ResultSet rst;
	
	
	public DConnection()
	{
		executeOther("create table if not exists admin_login(admin_id int primary key  auto_increment, admin_name  varchar(25)  unique  not null, password varchar(25)  unique  not null)");
		close();
		int cnt=0;
		try
		{
			rst=executeSelect("select count(*) from admin_login");
			rst.next();
			cnt=rst.getInt(1);
			close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}	
		if(cnt==0)
		{
			executeOther("insert into admin_login(admin_name,password) values('admin','admin')");
			close();
		}
		
	}

		
		public int executeOther(String qry)//insert,delete,update
		{
			int cnt=0;
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				conn=DriverManager.getConnection
				("jdbc:mysql://localhost:3306/ckt_slctor","root","");
				stmt=conn.createStatement();
				cnt=stmt.executeUpdate(qry);
			}
			catch(ClassNotFoundException e)
			{
				e.printStackTrace();	
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			return cnt;
		}
		public ResultSet executeSelect(String qry)//select
		{
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ckt_slctor","root","");
				stmt=conn.createStatement();
				rst=stmt.executeQuery(qry);
			}
			catch(ClassNotFoundException e)
			{
				e.printStackTrace();	
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}		
			return rst;
		}
		public void close()
		{
			try
			{
				stmt.close();
				conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();			
			}
		}
		
		public ArrayList<String[]> getUpDate(){
			ArrayList<String[]> s=new ArrayList<String[]>();
		
			try{
				ResultSet rst=executeSelect("select ut_id,updatedDate from ut_players");
				while(rst.next()){
						String s1[]=new String[2];
						s1[0]=rst.getString(1);
						//System.out.print("ut_id="+s1[0]);//------------->check1
						s1[1]=rst.getString(2);
						//System.out.println(" :  updated date="+s1[1]);//------------->check2
						s.add(s1);	
				}
			}
			catch(SQLException e){
				e.printStackTrace();
			}
			return s;
		}
		
		public int updateTransfer(int ut_id){
			int n=0;
			//System.out.println("1. ut_id="+ut_id);//------------->check3
			try{
				n=executeOther("update ut_trasfer_details set tans_left=20 where ut_id="+ut_id);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			return n;
		}
	
		public int UpdateUserTransfer(){
			// to update transfers of all users
			ArrayList<String[]> ud=getUpDate();
			//System.out.println("checking getUpdate fn by its size: "+ud.size());//------------------->check6
			java.util.Date date = new Date();
			//System.out.println("check7: date="+date);//----------------->check7;
			int c=0;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String curdate = formatter.format(date);
			//System.out.println("check9: currdate="+curdate);//----------------->check9;
			Date d1 = null;
			ArrayList<Date> d2=new ArrayList<Date>();
			try {
				
				long diffDays[]=new long[ud.size()];
				d1 = formatter.parse(curdate);
			//	System.out.println("check10: d1 date entered="+d1);//------------->check10
				for(int i=0;i<ud.size();i++){
					String s[]=ud.get(i);
				//	System.out.println("check8: date from table="+s[1]+" size="+s.length);//----------------->check8;
				//	System.out.println("check4: d2 date entered="+formatter.parse(s[1]));//------------->check4
					d2.add(formatter.parse(s[1]));
					
				}

				//in milliseconds
				int diff[]=new int[d2.size()];
				for(int j=0;j<d2.size();j++){
					//System.out.println("check13: d1 date="+d1);//------------->check13
					//System.out.println("check2: d2.get(j)="+d2.get(j));//------------>check12
					diff[j] =  (int)(((d2.get(j)).getTime()-d1.getTime())/(24 * 60 * 60 * 1000));
				//	System.out.println("check11: difference bw days1="+diff[j]);//-------------------------->check11
				}
				
				for(int l=0;l<d2.size();l++){
					if(diff[l]>20){
						String s2[]=ud.get(l);
						c=updateTransfer(Integer.parseInt(s2[0]));
						
					}
				}
				//int c1=executeOther("update ut_players set updatedDate="+curdate+" where ut_id");

				//System.out.print(diffDays + " days, ");
				//System.out.print(diffHours + " hours, ");
				//System.out.print(diffMinutes + " minutes, ");
				//System.out.print(diffSeconds + " seconds.");

			} catch (Exception e) {
				e.printStackTrace();
			}
			return c;
		}
	
}
