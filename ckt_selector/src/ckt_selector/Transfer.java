package ckt_selector;
import java.sql.*;
import java.util.*;

public class Transfer {
	
	public void replace(int removeId, int addId, int ut_id){
		DConnection db=new DConnection();
		Players p=new Players();
		int r_speciId=p.speciId(removeId);
		int a_speciId=p.speciId(addId);
		double r_betingPt=p.betingPoint(removeId);
		double a_betingPt=p.betingPoint(addId);
		try{
			ResultSet rst=db.executeSelect("select * from ut_players where ut_id="+ut_id);
			if(rst.next()){
				for(int i=2;i<=12;i++){
					if(rst.getInt(i)==removeId){
						int c=db.executeOther("update ut_players set ut_p"+(i-1)+"="+addId+" where ut_id="+ut_id);
					}
				}
			}
			int c1=db.executeOther("update ut_trasfer_details set tans_left=tans_left-1 where ut_id="+ut_id);
			int c2=db.executeOther("update ut_details set ut_leftpts=ut_leftpts+"+(r_betingPt-a_betingPt));
			if(r_speciId==1){
				int c3=db.executeOther("update ut_playerspeci set noOfBT=noOfBT-1 where ut_id="+ut_id);
			}
			if(r_speciId==2){
				int c4=db.executeOther("update ut_playerspeci set noOfBT=noOfBT-1 where ut_id="+ut_id);
			}
			if(r_speciId==3){
				int c5=db.executeOther("update ut_playerspeci set noOfBT=noOfBT-1 where ut_id="+ut_id);
			}
			if(r_speciId==4){
				int c6=db.executeOther("update ut_playerspeci set noOfBT=noOfBT-1 where ut_id="+ut_id);
			}
			if(a_speciId==1){
				int c7=db.executeOther("update ut_playerspeci set noOfBT=noOfBT+1 where ut_id="+ut_id);
			}
			if(a_speciId==2){
				int c8=db.executeOther("update ut_playerspeci set noOfBT=noOfBT+1 where ut_id="+ut_id);
			}
			if(a_speciId==3){
				int c9=db.executeOther("update ut_playerspeci set noOfBT=noOfBT+1 where ut_id="+ut_id);
			}
			if(a_speciId==4){
				int c10=db.executeOther("update ut_playerspeci set noOfBT=noOfBT+1 where ut_id="+ut_id);
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}

}
