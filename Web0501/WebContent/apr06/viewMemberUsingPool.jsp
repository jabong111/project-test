<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>VIEW MEMBER USING POOL</title>
</head>
<body>
	<table border="1">
		<tr>
			<td>NAME</td><td>ID</td><td>E-MAIL</td>
		</tr>
			<%
				//Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try{
					//String jdbcDriver="jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
					//String dbUser="KH10";
					//String dbPass="oracle";
					String jdbcDriver="jdbc:apache:commons:dbcp:/pool";
					String sql = "select * from member_123 order by memberid";
					conn = DriverManager.getConnection(jdbcDriver);
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while(rs.next()){%>
						<tr> 
							<td><%=rs.getString("name") %></td>
							<td><%=rs.getString("memberid") %></td>
							<td><%=rs.getString("email") %></td>
						</tr>
					<%
					}
				}catch(SQLException ex){
					ex.printStackTrace();
				}finally{
					if(conn != null) try{conn.close();} catch(SQLException ex){}
					if(pstmt != null) try{pstmt.close();} catch(SQLException ex){}
					if(rs != null) try{rs.close();} catch(SQLException ex){}
				}
			
			%>
	</table>

</body>
</html>



















