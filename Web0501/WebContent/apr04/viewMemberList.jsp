<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원목록</title>
</head>
<body>
MEMBER_123 테이블의 내용
<table width="100%" border="1">
	<tr>
		<td>NAME</td><td>ID</td><td>EMAIL</td>
	</tr>
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver"); //JDBC 드라이버 로딩 제일먼저 드라이버를 
		Connection conn = null; //dbms와 연결할대 쓰는 객체]
		Statement stmt = null; //쿼리문을 실행하는 객체
		ResultSet rs = null; //db쪽에서 쿼리문으로 나온 형태 그대로 나와서 저장하는 객체
		
		try{
			String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
			String dbUser = "KH10";
			String dbPass = "oracle";
			
			String query = "select * from MEMBER_123 order by MEMBERID";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass); //드라이버를 연결하기위한 conn객체 생성
			stmt = conn.createStatement(); //conn객체를 이용해 stmt객체를 생성
			rs = stmt.executeQuery(query); //stmt 객체를 이용해서 rs객체를 생성   
										   //executeQuery-->select 쿼리를 실행할때 사용
										   //executeUpdate -->insert,update,delete 쿼리를 실행할때 사용
			
			while(rs.next()){
				%>
				<tr>
					<td><%=rs.getString("NAME") %></td>
					<td><%=rs.getString("MEMBERID") %></td>
					<td><%=rs.getString("EMAIL") %></td>
				</tr>
				<%
			}
		}catch(SQLException ex){
			out.print(ex.getMessage());
			ex.printStackTrace();
		}finally{
			if(rs != null) try{rs.close();} catch(SQLException ex){}
			if(stmt != null) try{stmt.close();} catch(SQLException ex){}
			if(conn!=null) try{conn.close();} catch(SQLException ex){}
		}
	%>


</table>

</body>
</html>




<%
	if(rs != null){
		try{
			rs.close();
		}catch(SQLException sql){
			
		}
	}

%>





