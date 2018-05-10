<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%
	request.setCharacterEncoding("euc-kr");

	String memberId = request.getParameter("id");
	String name = request.getParameter("name");
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	int updateCount = 0;
	Connection conn = null;
	Statement stmt = null;
	try{
		String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
		String dbUser = "KH10";
		String dbPass = "oracle";
		String sql = "update member_123 set name='"+name+"' where memberid='"+memberId+"' ";
				//update member_123 set name='jihoon' where memberid='abcs';
		
		conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
		stmt = conn.createStatement();
		updateCount = stmt.executeUpdate(sql);
	}finally{
		if(conn != null) conn.close();
		if(stmt != null) stmt.close();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>UPDATE INFO</title>
</head>
<body>
<%if(updateCount > 0){
	%>
	<%=memberId %>가 <%=name %>으로 변경되었습니다.
<%}else{%>
	<%=memberId %>가 존재하지 않습니다.
<%} %>

	

</body>
</html>