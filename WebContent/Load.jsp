<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.*"%>

<%@ page language="java" contentType="text/html; charset=gb18030"
	pageEncoding="gb18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=gb18030">

<title>��ǩ���</title>
</head>
<body>
<%	request.setCharacterEncoding("gb18030"); 
	String user_name = request.getParameter("user_name");
	String id_number = request.getParameter("id_number");
	String area_name = request.getParameter("area_name");
	
	int id_order = 0;
	int i = 0;
	int user_id_order = 0; //�����������
	
	Connection conn = Database.getConn();
	Statement stmt = Database.getStmt(conn);
	String queryString = "select id_order from candi_info where id_number = '" + id_number +"' and area_name = '" + area_name + "'";
		
	ResultSet rs = Database.executeQuery(stmt, queryString);
	
	
	try{
		while(rs.next()){
			id_order = rs.getInt(1);
			i++;
		}
	
	}catch (Exception e){
			e.printStackTrace();
	}

	if(i > 0){
		%>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <div align="center">
	 <h1>������<%=user_name  %></h1>
	 <h1>���֤�ţ�<%=id_number  %></h1>
	 <h1>���У�<%=area_name  %></h1>
	 <h1><font color="red">����׼��֤��Ϊ��<%=id_order  %></font></h1>
	 </div>
<%	}else {
		String area_number_c = "select order_number from area_number where area_name = '" + area_name + "'"; //��ѯ�����ܿ�����
		String user_area_number_c = "select id_order from candi_info where area_name = '" + area_name + "'"; //��ѯ�ѷ��俼��
		
		ResultSet rs_area_number = Database.executeQuery(stmt, area_number_c);
		
		
		ArrayList<Integer> al = new ArrayList<Integer>();
		
		int area_number = 0; //��ʼ����������
		int user_area_number = 0; //��ʼ���ѷ��俼��
		
		while(rs_area_number.next()){
			area_number = rs_area_number.getInt(1);
		}
		
		ResultSet rs_user_area_number = Database.executeQuery(stmt, user_area_number_c);
		
		while(rs_user_area_number.next()){
			user_area_number = rs_user_area_number.getInt(1);
			al.add(user_area_number);
		}
	 	
		user_id_order = new Candidate().randomID(area_number, al); //����������
		
		Database.close(rs);
		Database.close(stmt);
		Database.close(conn);
		Database.close(rs_user_area_number);
		Database.close(rs_area_number);
		
		new Info_Save().save(user_name, id_number, area_name, user_id_order); //��¼�������
		
		if(user_id_order > 0){
		%>
		<br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <div align="center">
	 <h1>������<%=user_name  %></h1>
	 <h1>���֤�ţ�<%=id_number  %></h1>
	 <h1>���У�<%=area_name  %></h1>
	 <h1><font color="red">����׼��֤��Ϊ��<%=user_id_order  %></font></h1>
	 </div>
	<%}else{
		%>
		<br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <br/>
	 <div align="center">
	 <h1><font color="red">׼��֤���ѷ�����ϣ����빤����Ա��ϵ��лл��</font></h1>
	 </div>
			
	<%}
		
}
		
%>


</body>
</html>