<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%
	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("memberid");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>INSERT TABLE</title>
</head>
<body>
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
			String dbUser = "KH10";
			String dbPass = "oracle";
			String sql = "insert into member_123 values(?,?,?,?)";
			
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			pstmt.executeUpdate(); //insert db
			
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			if(conn != null) try{conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException ex) {}
		}
	%>
	member_123 테이블에 데이터를 삽입했습니다.
</body>
</html>