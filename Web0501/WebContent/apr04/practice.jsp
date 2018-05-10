<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table border="1" width="800">
	<tr>
		<td>NAME</td>
		<td>ID</td>
		<td>E-MAIL</td>
	</tr>
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
			String dbUser = "KH10";
			String dbpass = "oracle";
			String sql = "select * from member_123 order by memberid";
			
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbpass);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				%>
				
				<tr>
					<td><%=rs.getString("memberid") %></td>
					<td><%=rs.getString("name") %></td>
					<td><%=rs.getString("email") %></td>
				</tr>
				<%
			}
		}catch(SQLException ex){
			out.println(ex.getMessage());
			ex.printStackTrace();
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException ex){
					
				}
			}
			if(conn != null){
				try{
					conn.close();
				}catch(SQLException ex){
					
				}
			}
			if(stmt != null){
				try{
					stmt.close();
				}catch(SQLException ex){
					
				}
			}
			
		}
		
	
	%>

	

</table>

</body>
</html>