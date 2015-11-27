package com;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;


public class Run {
	
	public void Execute(){
		ArrayList<Integer> al = new ArrayList<Integer>();
			for(int i = 1;i<=360;i++){
				al.add(i);
			}
			System.out.println(al.size());
		ArrayList<Integer> s_al = new ArrayList<Integer>();
		Connection connection = Database.getConn();
		Statement stmt = Database.getStmt(connection);
		try {
			String sql = "select id_order from candi_info where area_name = 'œÂ—Ù'";
			ResultSet rs = Database.executeQuery(stmt, sql);
			
			
 			while(rs.next()){
				int s = rs.getInt(1);
				//System.out.println(s);
				s_al.add(s);
			}
 		
 			
 			
 			
 			for(int j = 0;j<s_al.size();j++ ){
 				al.remove(s_al.get(j));
 			}
 			
 			System.out.println(al.size());
 			
 			for(int e = 0;e<al.size();e++){
 				//System.out.println(al.get(e));
 			}
 			
 				Database.close(rs);
 	 			Database.close(stmt);
 	 			Database.close(connection);
 			
 			
 			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public static void main(String[] args) {
		Run run = new Run();
		run.Execute();
	}

}
