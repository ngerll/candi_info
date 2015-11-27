package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;



public class Info_Save {
	public void save(String user_name,String id_number,String area_name,int id_order) {
		Connection conn = Database.getConn();
		Statement stmt = Database.getStmt(conn);
		
		String sql_id = "select * from candi_info where id_number = '" + id_number + "'";
		String save = "insert into candi_info values (?,?,?,?)";
		PreparedStatement pstmt = null;
		
		try {
			conn.setAutoCommit(false);
			pstmt =  Database.prepareStmt(conn, save);
			ResultSet rs = Database.executeQuery(stmt, sql_id);
			int i = 0;
			while(rs.next()){
				String id_number_c = rs.getNString(2);
				if(id_number_c.equalsIgnoreCase(id_number) ){
					i++;
				}			
			}
			if(i > 0){
				return;
			}else {
				//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				pstmt.setString(1, user_name);
				pstmt.setString(2, id_number);
				pstmt.setString(3, area_name);
				pstmt.setInt(4, id_order);
				//pstmt.setString(5, df.format(new Date()));
				pstmt.addBatch();
				pstmt.executeBatch();
				conn.commit();				
				//System.out.println("信息存入数据库");
			}
			Database.close(pstmt);
			Database.close(rs);
			Database.close(stmt);
			Database.close(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
