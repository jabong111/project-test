<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%
	String idValue = request.getParameter("id");
	
	Connection conn = null;
	PreparedStatement pstmtItem = null;
	PreparedStatement pstmtDetail = null;
	
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser = "KH10";
	String dbPass = "oracle";
	
	Exception occuredExeception = null;
	try{
		int id = Integer.parseInt(idValue);
		
		conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
		conn.setAutoCommit(false); //트랜잭션 시작
		
		pstmtItem = conn.prepareStatement("insert into jabong111_item values (?,?)");
		pstmtItem.setInt(1, id);
		pstmtItem.setString(2, "상품 이름"+id);
		pstmtItem.executeUpdate();
		
		if(request.getParameter("error") != null){
			throw new Exception("의도적 예외 발생");	//예외가 발생하면 트랜잭션에 의해 롤백되고 
		}
		
		pstmtDetail = conn.prepareStatement("insert into jabong111_detail_item values(?,?)");
		pstmtDetail.setInt(1, id);
		pstmtDetail.setString(2, "상세 설명"+id);
		pstmtDetail.executeUpdate();
		
		conn.commit();	//모든 데이터가 예외없이 들어갔다면 커밋으로 데이터를 삽입하는것을 완료한다.
		
	}catch(Throwable e){
		if(conn != null){
			try{
				conn.rollback();
			}catch(SQLException ex){
				
			}
		}
		occuredExeception = (Exception)e;
	}finally{
		if(pstmtItem != null) try{pstmtItem.close();} catch(SQLException ex){}
		if(pstmtDetail != null) try{pstmtDetail.close();} catch(SQLException ex){}
		if(conn != null) try{conn.close();} catch(SQLException ex){}
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>INSERT ITEM VALUE</title>
</head>
<body>
<% if(occuredExeception != null){ %>
	에러가 발생했습니다:<%=occuredExeception.getMessage() %>
<%}else{ %>
	데이터가 성공적으로 들어갔습니다.
<%} %>
 
</body>
</html>

























