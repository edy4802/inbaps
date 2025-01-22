package inbaps.cbap.batch;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

class BatchScheduler{
	public static void main(String[] args){
		
		// args 파라미터 정의
		// args[0] = Y OR N (즉시예약여부)
		// args[1] = 20170101200000 (args[0]=N, 즉, 특정예약일경우 예약일시(년월일시분초))
		String autoRsvYn = "Y";
		String strRsvDt = "";
		if(args != null && args.length > 0){
			autoRsvYn = args[0];
		}
		if(args != null && args.length > 1 && autoRsvYn == "N"){
			strRsvDt = args[1];
		}
		
		// 스레드 클래스를 인스턴스화하여 독립된 스레드를 생성
		BatchSchedulerRun t1 = new BatchSchedulerRun();
		t1.run(autoRsvYn, strRsvDt);
	}
	
}

class BatchSchedulerRun{
    
	protected Log log = LogFactory.getLog(this.getClass());

    Connection conn = null;
    CallableStatement cstmt = null;
    String SQL = "";
    
    public void run(String autoRsvYn, String strRsvDt){
        try{
        	
        	Class.forName("oracle.jdbc.driver.OracleDriver");
        	// ZTC수집DB
        	//conn = DriverManager.getConnection("jdbc:oracle:thin:@121.134.69.240:1521:xe", "inbaps", "inbaps");
        	// INIT수집DB
        	//conn = DriverManager.getConnection("jdbc:oracle:thin:@112.217.204.26:1521:orcl", "inbaps", "inbaps");
        	conn = DriverManager.getConnection("jdbc:oracle:thin:@112.217.204.26:1521:INITDB", "INBAPS", "inbaps");
        	log.info("=========== cbap.batch.BatchScheduler start... ===========");
    		try{
    			if(strRsvDt != ""){
    				SQL = "{CALL SP_BTCH_RSV_LOAD(?,?)}";
    				cstmt = conn.prepareCall(SQL);
    				cstmt.setString(1, autoRsvYn);
    				cstmt.setString(2, strRsvDt);
    			}else{
    				SQL = "{CALL SP_BTCH_RSV_LOAD(?)}";
    				cstmt = conn.prepareCall(SQL);
    				cstmt.setString(1, autoRsvYn);
    			}
    			cstmt.executeQuery();
    			cstmt.close();
    		}catch(Exception e){
    			e.printStackTrace();
    			log.info("[ERROR]" + e.getMessage());
    		}finally{
    			if(cstmt != null)try{cstmt.close();} catch(Exception e){}
    			if(conn != null)try{conn.close();} catch(Exception e){}
    			log.info("=========== cbap.batch.BatchScheduler finished. ===========");
    		}
        }catch(Exception e){
        	e.printStackTrace();
        	log.info("[ERROR]" + e.getMessage());
        }
    }     
        
}
