package ckt_selector;
import java.sql.*;
import java.util.*;
import ckt_selector.DConnection;

public class Calculation {

					//-------------------USER CALCULATION-------------------------
	//Update in ut_performance, ut_details after a match
	public void ut_update(int ut_id, double m_pts){
		DConnection db=new DConnection();
		double tot=0;
		double high=0;
		try{
			//ut_performance
			ResultSet rst=db.executeSelect("select tot_pts from ut_performance where ut_id="+ut_id);
			if(rst.next()){
				tot=rst.getDouble(1);
			}
			tot=tot+m_pts;
			int c=db.executeOther("update ut_performance set m_pts="+m_pts+", tot_pts="+tot+" where ut_id");
			//ut_details
			ResultSet rst1=db.executeSelect("select ut_highScore from ut_details where ut_id="+ut_id);
			if(rst.next()){
				high=rst.getDouble(1);
			}
			if(tot>high){
				high=tot;
			}
			int c1=db.executeOther("update ut_details set ut_curScore="+m_pts+", ut_totScore="+tot+", ut_highScore="+high+" where ut_id="+ut_id);
		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	public ArrayList<Integer> utIds(){
		ArrayList<Integer> ids=new ArrayList<Integer>();
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select ut_id from ut_details");
			while(rst.next()){
				ids.add(rst.getInt(1));
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return ids;
	}
	
	public void getUserPoints(ArrayList<Integer> ids){
		
		double userpt=0;
		ArrayList<Integer> pids=new ArrayList<Integer>();
		ArrayList<Double> playerPoints=new ArrayList<Double>();
		DConnection db=new DConnection();
		try{
			for(int i=0;i<ids.size();i++){
				ResultSet rst1=db.executeSelect("select * from ut_players where ut_id="+ids.get(i));
				rst1.next();
				for(int j=2;j<=12;j++){
					pids.add(rst1.getInt(j));
				}
				for(int k=0;k<pids.size();k++){
					playerPoints.add(getPlayerPoint(pids.get(k)));
				}
				for(int l=0;l<playerPoints.size();l++){
					userpt=userpt+playerPoints.get(l);
				}
				ut_update(ids.get(i), userpt);
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return;
	}
	
	public double getPlayerPoint(int pid){
		double pt=0;
		DConnection db=new DConnection();
		try{
			ResultSet rst=db.executeSelect("select tot_pts from players where p_id="+pid);
			if(rst.next()){
				pt=rst.getDouble(1);
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return pt;
	}
	
	//-------------------------------------------------------------------------------------------------------------------------------------------------------//
	
	
		//-------------------PLAYER CALCULATION-------------------------
	//Update in ut_performance, ut_details after a match
	public void playerUpdate(int p_id, double m_batingsr, int m_wicketTaken, int m_catchout, int halfCentury, int century, double m_runRate, int noOf6, int noOf4, double m_bowlsr, int stumpsTaken, int bowled, int runout, int directHit, int LBW, int dotBall, int maidenOver, int hattrik, int duck, int tot_runs){
		DConnection db=new DConnection();
		double m_pts=0;
		//Bating points
		double run1=0, run6=0, run4=0, dck=0, hCentury=0, cent=0, bt_sr100_149=0, bt_sr150_199=0, bt_sr200_=0;
		//Bowling points
		double bwled=0, wickets=0, lbw=0, dotball=0, maidenover=0, hattrk=0, bowl_sr30_39=0, bowl_sr40_49=0, bowl_sr50_=0;
		//Bonus points
		double man_player=0, man_team=0, victory_player=0;
		//Field points
		double catch_out=0, f_stumps=0, run_out=0, directhit=0;
		try{
			// Taking bating points values
			ResultSet rst=db.executeSelect("select * from bating_pts");
			if(rst.next()){
				run1=rst.getDouble(1);
				run6=rst.getDouble(2);
				run4=rst.getDouble(3);
				dck=rst.getDouble(4);
				hCentury=rst.getDouble(5);
				cent=rst.getDouble(6);
				bt_sr100_149=rst.getDouble(7);
				bt_sr150_199=rst.getDouble(8);
				bt_sr200_=rst.getDouble(9);
			}
			// Taking bowling points values
			ResultSet rst1=db.executeSelect("select * from bowling_pts");
			if(rst.next()){
				bwled=rst1.getDouble(1);
				wickets=rst1.getDouble(2);
				lbw=rst1.getDouble(3);
				dotball=rst1.getDouble(4);
				maidenover=rst1.getDouble(5);
				hattrk=rst1.getDouble(6);
				bowl_sr30_39=rst1.getDouble(7);
				bowl_sr40_49=rst1.getDouble(8);
				bowl_sr50_=rst1.getDouble(9);
			}
			// Taking Fielding points values
			ResultSet rst2=db.executeSelect("select * from field_pts");
			if(rst2.next()){
				catch_out=rst2.getDouble(1);
				f_stumps=rst2.getDouble(2);
				run_out=rst2.getDouble(3);
				directhit=rst2.getDouble(4);
			}
			// Taking Bonus points values
			ResultSet rst3=db.executeSelect("select * from field_pts");
			if(rst3.next()){
				man_player=rst3.getDouble(1);
				man_team=rst3.getDouble(2);
				victory_player=rst3.getDouble(3);
			}
			int run_1=tot_runs-noOf6-noOf4;  // no of 1 run he has taken
			m_pts=(m_wicketTaken*wickets)+(m_catchout*catch_out)+(halfCentury*hCentury)+(century*cent)+(run_1*run1)+(noOf6*run6)+(noOf4*run4)+(stumpsTaken*f_stumps)+(bowled+bwled)+(runout*run_out)+(directHit*directhit)+(LBW*lbw)+(dotBall*dotball)+(maidenOver*maidenover)+(hattrik*hattrk)+(duck*dck);
			if(100<=m_batingsr && m_batingsr<=149){
				m_pts=m_pts+(bt_sr100_149);
			}
			else if(150<=m_batingsr && m_batingsr<=199){
				m_pts=m_pts+(bt_sr150_199);
			}
			else if(200<=m_batingsr){
				m_pts=m_pts+(bt_sr200_);
			}
			if(30<=m_bowlsr && m_bowlsr<=39){
				m_pts=m_pts+(bowl_sr30_39);
			}
			else if(40<=m_bowlsr && m_batingsr<=49){
				m_pts=m_pts+(bowl_sr40_49);
			}
			else if(50<=m_bowlsr){
				m_pts=m_pts+(bowl_sr50_);
			}
			//System.out.println("match point="+m_pts);//------------>chech1
			//to update player_update
			int c=db.executeOther("update player_update set m_pts="+m_pts+" where p_id="+p_id);
			//System.out.println("update player_update="+c);//------------>chech2
			
			//taking values from players to update it
			double max_sr=0, curr_s=0, max_bowlsr=0, tot_pt=0;
			int tot_wk=0, halfcentury=0, Century=0, no6=0, no4=0, stumpstaken=0, bwld=0, catches=0, tot_runouts=0, directhits=0, Lbw=0, dtball=0, maidover=0, hatt=0, dk=0, tot_run=0;
			ResultSet rst4=db.executeSelect("select max_sr, tot_wk, halfCentury, century, noOf6, noOf4, max_bowlsr, stumpsTaken, bowled, tot_catchesTaken, tot_runouts, directHits, LBW, dotBall, maidenOver, hattrik, duck, tot_pts, tot_runs from players where _id="+p_id);
			if(rst4.next()){
				max_sr=rst4.getDouble(1);
				tot_wk=rst4.getInt(2);
				halfcentury=rst4.getInt(3);
				Century=rst4.getInt(4);
				no6=rst4.getInt(5);
				no4=rst4.getInt(6);
				max_bowlsr=rst4.getDouble(7);
				stumpstaken=rst4.getInt(8);
				bwld=rst4.getInt(9);
				catches=rst4.getInt(10);
				tot_runouts=rst4.getInt(11);
				directhits=rst4.getInt(12);
				Lbw=rst4.getInt(13);
				dtball=rst4.getInt(14);  
				maidover=rst4.getInt(15);
				hatt=rst4.getInt(16);
				dk=rst4.getInt(17);
				tot_pt=rst4.getDouble(18);
				tot_run=rst4.getInt(19);
			}
			if(max_sr<m_batingsr){
				max_sr=m_batingsr;
			}
			if(max_bowlsr<m_bowlsr){
				max_bowlsr=m_bowlsr;
			}
			tot_wk=tot_wk+m_wicketTaken;
			halfcentury=halfcentury+halfCentury;
			Century=Century+century;
			no6=no6+noOf6;
			no4=no4+noOf4;
			stumpstaken=stumpstaken+stumpsTaken;
			bwld=bwld+bowled;
			catches=catches+m_catchout;
			tot_runouts=tot_runouts+runout;
			directhits=directhits+directHit;
			Lbw=Lbw+LBW;
			dtball=dtball+dotBall;
			maidover=maidover+maidenOver;
			hatt=hatt+hattrik;
			dk=dk+duck;
			tot_pt=tot_pt+m_pts;
			tot_run=tot_run+tot_runs;
			
			//to update players
			int c1=db.executeOther("update players set tot_runs="+tot_run+", max_sr="+max_sr+", curr_sr="+m_batingsr+", tot_wk="+tot_wk+", halfCentury="+halfcentury+", century="+Century+", noOf6="+no6+", noOf4="+no4+", max_bowlsr="+max_bowlsr+", stumpsTaken="+stumpstaken+", bowled="+bwld+", tot_catchesTaken="+catches+", tot_runsouts="+tot_runouts+", directHits="+directhit+", LBW="+Lbw+", dotBall="+dtball+", maidenOver="+maidover+", hattrik="+hatt+", duck="+dk+", tot_pts="+tot_pt+" where p_id="+p_id);
			System.out.println("update players="+c1);//------------>chech3
		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}
}
