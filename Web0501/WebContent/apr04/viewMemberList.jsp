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
<title>ȸ�����</title>
</head>
<body>
MEMBER_123 ���̺��� ����
<table width="100%" border="1">
	<tr>
		<td>NAME</td><td>ID</td><td>EMAIL</td>
	</tr>
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver"); //JDBC ����̹� �ε� ���ϸ��� ����̹��� 
		Connection conn = null; //dbms�� �����Ҵ� ���� ��ü]
		Statement stmt = null; //�������� �����ϴ� ��ü
		ResultSet rs = null; //db�ʿ��� ���������� ���� ���� �״�� ���ͼ� �����ϴ� ��ü
		
		try{
			String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
			String dbUser = "KH10";
			String dbPass = "oracle";
			
			String query = "select * from MEMBER_123 order by MEMBERID";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass); //����̹��� �����ϱ����� conn��ü ����
			stmt = conn.createStatement(); //conn��ü�� �̿��� stmt��ü�� ����
			rs = stmt.executeQuery(query); //stmt ��ü�� �̿��ؼ� rs��ü�� ����   
										   //executeQuery-->select ������ �����Ҷ� ���
										   //executeUpdate -->insert,update,delete ������ �����Ҷ� ���
			
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





