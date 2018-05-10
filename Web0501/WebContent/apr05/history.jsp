<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%@ page import="java.io.Reader" %>
<%@ page import="java.io.IOException" %>

<%
	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("memberid");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>VIEW HISTORY</title>
</head>
<body>
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
			String dbUser = "KH10";
			String dbPass = "oracle";
			String sql = "select * from kk4163 where memberid=(?)";
			
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				%>
				<table border="1">
					<tr>
						<td>ID</td>
						<td><%=id %></td>
					</tr>
					<tr>
						<td>HISTORY</td>
						<td>
						<%
							String history = null;
							Reader reader = null;
							try{
								reader = rs.getCharacterStream("history");
								if(reader != null){
									StringBuffer buff = new StringBuffer();
									char[] ch = new char[512];
									int len = -1;
									while((len = reader.read(ch)) != -1){
										buff.append(ch,0,len);
										buff.append("\n");
									}
									history = buff.toString();
								}
							}catch(IOException ioe){
								ioe.printStackTrace();
							}finally{
								if(reader != null) try{reader.close();} catch(IOException ioe){}
							}
						%>
						<%=history %>
						</td>
					</tr>
				</table>
			<%}else{%>
				<%=id %>에 해당하는 HISTORY가 없습니다.
			<%}
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			if(conn != null) try{conn.close();} catch(SQLException ex){}
			if(pstmt != null) try{pstmt.close();} catch(SQLException ex){}
			if(rs != null) try{rs.close();} catch(SQLException ex){}
		}
	
	%>

</body>
</html>












