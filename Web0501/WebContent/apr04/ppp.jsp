<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<%
	String memberID = request.getParameter("memberid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>VIEW ONE MEMBER</title>
</head>
<body>
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try{
			String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
			String dbUser = "KH10";
			String dbPass = "oracle";
			String sql = "select * from member_123 where memberid='"+memberID+"'";
			
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				%>
				<table border="1">
					<tr>
						<td>ID</td>
						<td>NAME</td>
						<td>E-MAIL</td>
					</tr>
					
					<tr>
						<td><%=rs.getString("memberid") %></td>
						<td><%=rs.getString("name") %></td>
						<td><%=rs.getString("email") %></td>
					</tr>
				</table>
				<%
			}
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			if(conn != null) try{conn.close();} catch(SQLException ex){}
			if(rs != null) try{rs.close();} catch(SQLException ex){}
			if(stmt != null) try{stmt.close();} catch(SQLException ex){}
		}
	%>

</body>
</html>