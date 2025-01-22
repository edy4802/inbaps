package inbaps.cbap.batch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

class BatchDaemon{
	public static void main(String[] args){
		// 스레드 클래스를 인스턴스화하여 독립된 스레드를 생성
		BatchDaemonRun t1 = new BatchDaemonRun("CbapBatchDaemon");
		//BatchScheduler t2 = new BatchScheduler("두번째 스레드");
		// start() 메서드를 호출하면 스레드 객체의 run() 메서드가 돌면서 스레드가 실행
		t1.start();
		// t2.start();
	}
}

class BatchDaemonRun extends Thread {
    
	protected Log log = LogFactory.getLog(this.getClass());

    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    String SQL = "";
    
    Map<String, Object> mParam = null; 
    Map<String, Object> mSqlParam = null;
    
    BatchDaemonRun(String name){	// 생성자에 스레드 이름이 전달인자로 넘어 옴
    	super(name);	// 전달인자로 준 값이 스레드의 이름이 됨
    }
    
    // 스레드 객체가 수행해야 하는 작업을 run() 메서드를 오버라이딩하여 이 내부에 기술
    public void run(){
        try{
        	Class.forName("oracle.jdbc.driver.OracleDriver");
        	// ZTC수집DB
        	//conn = DriverManager.getConnection("jdbc:oracle:thin:@121.134.69.240:1521:xe", "inbaps", "inbaps");
        	// INIT수집DB
        	//conn = DriverManager.getConnection("jdbc:oracle:thin:@112.217.204.26:1521:orcl", "inbaps", "inbaps");
        	conn = DriverManager.getConnection("jdbc:oracle:thin:@112.217.204.26:1521:INITDB", "INBAPS", "inbaps");
        	
        	String prmId= "";
        	String prmKey= "";
        	String prmVal= "";
        	String prmFixYn= "";
        	String prmType= "";
        	String strToday = "";
        	
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

        	while(true){
        		try{
        			
        			mParam = new HashMap<String, Object>();
        			mSqlParam = new LinkedHashMap<String, Object>();
        			
        			Calendar c1 = Calendar.getInstance();
        	        strToday = sdf.format(c1.getTime());
        	        
        			
        			SQL = ""
        			+ "SELECT T1.EXE_NUM, T1.USR_ID, T1.BAT_ID, T1.CAL_PRGM, T1.CAL_FILE_PATH "
        			+ "     , T2.CAL_TYPE "
        			+ "  FROM CBAP$_EXE_BAT_JOB T1 "
        			+ "     , CBAP$_BAT_JOB T2 "
        			+ " WHERE T1.USR_ID    = 'USER01' "
        			+ "   AND T1.EXE_STATE = 'S00' "
        			+ "   AND T1.RSV_DT < SYSDATE "
        			+ "   AND T2.USR_ID   = T1.USR_ID"
        			+ "   AND T2.BAT_ID   = T1.BAT_ID ";
        			
        			pstmt = conn.prepareStatement(SQL);
        			rs = pstmt.executeQuery();
        			
        			if(rs.next()){
        				mParam.put("EXE_NUM", rs.getString("EXE_NUM"));
        				mParam.put("USR_ID", rs.getString("USR_ID"));
        				mParam.put("BAT_ID", rs.getString("BAT_ID"));
        				mParam.put("CAL_PRGM", rs.getString("CAL_PRGM"));
        				mParam.put("CAL_FILE_PATH", rs.getString("CAL_FILE_PATH"));
        				mParam.put("CAL_TYPE", rs.getString("CAL_TYPE"));
        				
        				// 아래 부분을 배치 파라미터에서 가져오자!!!!
	        			// ★★★★ 예약어 ★★★★ 
        				// $TODAY$ : 오늘일자
        				// $USRID$ : 사용자ID
        				
        	        	SQL = ""
		        			+ "SELECT T1.PRM_ID, T1.PRM_KEY, T1.PRM_VAL, T1.PRM_FIX_YN, T1.PRM_TYPE "
		        			+ "  FROM CBAP$_BAT_JOB_PRM T1 "
		        			+ " WHERE T1.USR_ID = ? "
		        			+ "   AND T1.BAT_ID = ? "
		        			+ "   AND T1.USE_YN = 'Y' "
		        			+ " ORDER BY T1.DISP_ORD ";
	        			
	        			pstmt2 = conn.prepareStatement(SQL);
	        			pstmt2.setString(1, rs.getString("USR_ID"));
	        			pstmt2.setString(2, rs.getString("BAT_ID"));
	        			rs2 = pstmt2.executeQuery();
	        			
	        			while (rs2.next()) {
	        				prmId= String.valueOf(rs2.getString("PRM_ID"));
	        				prmKey= String.valueOf(rs2.getString("PRM_KEY"));
	        	        	prmVal= String.valueOf(rs2.getString("PRM_VAL"));
	        	        	prmFixYn= String.valueOf(rs2.getString("PRM_FIX_YN"));
	        	        	prmType= String.valueOf(rs2.getString("PRM_TYPE"));
	        	        	
	        	        	if("N".equals(prmFixYn)){
	        	        		if("$USRID$".equals(prmVal)){
	        	        			mSqlParam.put(prmKey, rs.getString("USR_ID"));
	        	        		}
	        	        		else if("$TODAY$".equals(prmVal)){
	        	        			mSqlParam.put(prmKey, strToday);
	        	        		}else{
	        	        			mSqlParam.put(prmKey, prmVal);	
	        	        		}
	        	        	}else{
	        	        		mSqlParam.put(prmKey, prmVal);
	        	        	}
	        	        }        	        	
	        			rs2.close();
	        			pstmt2.close();
        	        	
    					// 자바배치프로그램 호출
    					BatchWorker wt = new BatchWorker("CbapBatchWorker_" + mParam.get("EXE_NUM"), conn, mParam, mSqlParam);
    					wt.start();
        			}
        			rs.close();
        			pstmt.close();
        		}catch(Exception e){
        			e.printStackTrace();
        		}finally{
        			if(pstmt != null)try{pstmt.close();} catch(Exception e){}
        			if(pstmt2 != null)try{pstmt2.close();} catch(Exception e){}
        			if(rs != null)try{rs.close();} catch(Exception e){}
        			if(rs2 != null)try{rs2.close();} catch(Exception e){}
        		}
        		
        		// 매 1분(60초)마다 배치예약여부 체크
        		sleep(60000);
        	}
        }catch(ThreadDeath ouch){
        	System.out.println("I (" + getName() + ") is being killed.");
        	throw(ouch);
        }catch(Exception e){
        	e.printStackTrace();
        }
    }     
    
}

