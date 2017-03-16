package ckt_selector;
import java.sql.*;
import java.util.*;

public class Performance {
	
	public ArrayList<String[]> matchdetails(int user_id, int l_id)
	{	DConnection db=new DConnection();
		ArrayList<String[]> s1=new ArrayList<String[]>();
		
		try
		{	
			ResultSet rst=db.executeSelect("select * from ut_performance where user_id="+user_id+" and l_id="+l_id );
			while(rst.next())
			{
				String s[]=new String[6];
				for(int i=0;i<6;i++){
					s[i]=rst.getString(i+1);
				}
				s1.add(s);
			}
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		db.close();
		return s1;
		
	}
	
	public String getmatchname(int m_id)
	{
		
		String s=null;
		DConnection db=new DConnection();
		try
		{
			ResultSet rst=db.executeSelect("select m_name from matches where m_id="+m_id);
			if(rst.next())
			{
					s=rst.getString(1);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		db.close();
		return s;
	}
	
	public int leftTransfers(int ut_id){
		int n=0;
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select tans_left from ut_trasfer_details where ut_id="+ut_id);
			if(rst.next())
			{
					n=rst.getInt(1);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		db.close();
		return n;
	}

	public int getcapId(int ut_id){
		int n=0;
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select ut_p1 from ut_players where ut_id="+ut_id);
			if(rst.next())
			{
					n=rst.getInt(1);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		db.close();
		return n;
	}
	
	public String[] capInfo(int cap_id){
		String s[]=new String [3];
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select p_name,tot_pts from players where p_id="+cap_id);
			if(rst.next()){
				for(int i=0;i<2;i++){
					s[i]=rst.getString(i+1);
				}
			}
			ResultSet rst2=db.executeSelect("select m_pts from player_update where p_id="+cap_id);
			if(rst2.next()){
				s[2]=rst2.getString(1);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		db.close();
		return s;
		
	}
	
	public ArrayList<Integer> getteamPlayers(int ut_id){
		ArrayList<Integer> n=new ArrayList<Integer>();
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select * from ut_players where ut_id="+ut_id);
			if(rst.next()){
				for(int i=0;i<11;i++){
					n.add(rst.getInt(i+2));
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
	
	public String[] getplayerName(ArrayList<Integer> n){
		String s[]=new String[11];
		DConnection db=new DConnection();
		try{
			for(int j=0;j<11;j++){
				ResultSet rst=db.executeSelect("select p_name from players where p_id="+n.get(j));
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
	
	public String[] getplayerName1(ArrayList<Integer> n){
		String s[]=new String[15];
		DConnection db=new DConnection();
		try{
			for(int j=0;j<15;j++){
				ResultSet rst=db.executeSelect("select p_name from players where p_id="+n.get(j));
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
	
	public void changecaptian(int p_id, int ut_id){
		//boolean t=false;
		int temp,c=0,c1=0;
		DConnection db=new DConnection();
		DConnection db1=new DConnection();
		try{
			/*ResultSet rst=db.executeSelect("select ut_p1 from ut_players where ut_id="+ut_id);
			if(rst.next()){
				capid=rst.getInt(1);
			}
			capid=rst.getInt(1);*/
			ResultSet rst2=db.executeSelect("select * from ut_players where ut_id="+ut_id);
			if(rst2.next()){
				for(int i=2;i<12;i++){
					if(p_id==rst2.getInt(i)){
						temp=rst2.getInt(i);
						c=db.executeOther("update ut_players set ut_p"+(i-1)+"="+rst2.getInt(1));
						c1=db1.executeOther("update ut_players set ut_p1="+temp);
					}
				}
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		db.close();
		db1.close();
		//return t;
	}
}
