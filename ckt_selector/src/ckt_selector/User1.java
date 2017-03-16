package ckt_selector;

import java.sql.*;
import java.util.*;

public class User1 {

	public int userNoOfTeam(int userid){
		DConnection db=new DConnection();
		int c=db.executeOther("update user set user_noOfTeam=user_noOfTeam+1  where user_id="+userid);
		db.close();
		return c;
	}
	
	// use this method when admin enters new match score... to update user details
	public int updateUserDetails(int ut_id, double score){
		DConnection db=new DConnection();
		DConnection db1=new DConnection();
		Double s[]=new Double[2];
		int c=0;
		try{
			ResultSet rs=db.executeSelect("select ut_totScore, ut_highScore from ut_details where ut_id="+ut_id);
			while(rs.next()){
				s[0]=rs.getDouble(1);
				s[1]=rs.getDouble(2);
			}
			double tot=s[0]+score;
			double high=s[1];
			if(high<score){
				high=score;
			}
			c=db1.executeOther("update ut_details set ut_curScore="+score+", ut_totScore="+tot+", ut_highScore="+high+"  where ut_id="+ut_id);
			db.close();
		}		
		catch(SQLException e){
			e.printStackTrace();
		}
		return c;
	}
	
	public int userDetails(double leftpts, int m_id, int l_id, int user_id){
		DConnection db=new DConnection();
		int ut_id=maxId();
		ut_id++;
		int c=db.executeOther("insert into ut_details values("+ut_id+",0.0,0.0,0.0, "+leftpts+", "+m_id+", "+user_id+", "+l_id+")");
		db.close();
		return ut_id;
	}
	
	public int userPerformance(int ut_id, int user_id, int m_id, int l_id){
		DConnection db=new DConnection();
		int c=db.executeOther("insert into ut_performance values("+ut_id+", "+user_id+", "+m_id+", "+l_id+", 0.0, 0.0)");
		db.close();
		return c;
	}
	
	public int updateUserPerformance(int ut_id, double m_pts){
		DConnection db=new DConnection();
		DConnection db1=new DConnection();
		double tot=0;
		int c=0;
		try{
			ResultSet rs=db.executeSelect("select tot_pts from ut_performance where ut_id="+ut_id);
			if(rs.next()){
				tot=rs.getDouble(1);
			}
			tot=tot+m_pts;
			c=db1.executeOther("update ut_performance set m_pts="+m_pts+" , tot_pts="+tot+" where ut_id="+ut_id);
			db.close();
			db1.close();
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return c;
	}
	
	public int userPlayers(int ut_id, String p1, String p2, String p3, String p4, String p5, String p6, String p7, String p8, String p9, String p10, String p11, String sdate, String update){
		DConnection db=new DConnection();
		int c=db.executeOther("insert into ut_players values("+ut_id+", "+p1+", "+p2+", "+p3+", "+p4+", "+p5+", "+p6+", "+p7+", "+p8+", "+p9+", "+p10+", "+p11+", '"+sdate+"', '"+update+"')");
		db.close();
		return c;
	}
	
	public int userPlayerSpecification(int ut_id, int bt, int bw, int wk, int all){
		DConnection db=new DConnection();
		int c=db.executeOther("insert into ut_playerspeci values("+ut_id+", "+bt+", "+bw+", "+wk+", "+all+")");
		db.close();
		return c;
	}
	
	public int userTransferDetails(int ut_id){
		DConnection db=new DConnection();
		int c=db.executeOther("insert into ut_trasfer_details values("+ut_id+", 20)");
		db.close();
		return c;
	}
	
	public int updateTransferDetails(int ut_id){
		DConnection db=new DConnection();
		int c=db.executeOther("update ut_trasfer_details set tans_left=tans_left-1 where ut_id="+ut_id);
		db.close();
		return c;
	}
	
	public int updateUserNoOfTeam(int user_id){
		DConnection db=new DConnection();
		int c=db.executeOther("update user set user_noOfTeam=user_noOfTeam+1 where user_id="+user_id);
		db.close();
		return c;
	}
	
	public int maxId()
	{
		DConnection db=new DConnection();
		ResultSet rst;
		int r=0;
		try
		{
			rst=db.executeSelect("select max(ut_id) from ut_details");
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
