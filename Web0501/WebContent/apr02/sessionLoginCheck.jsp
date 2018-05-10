<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String memberId = (String)session.getAttribute("MEMBERID");
	boolean login = memberId == null ? false:true;
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 여부 검사</title>
</head>
<body>
<%
	if(login){
%>
	<%=memberId %>로 로그인중
	<%
	}else{
	%>
	로그인 안되어잇브이
	<%
	}
	%>

</body>
</html>