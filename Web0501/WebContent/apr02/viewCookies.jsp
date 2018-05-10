<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>view cookies</title>
</head>
<body>
쿠키 목록<br>
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null && cookies.length>0){
		for(int i=0;i<cookies.length;i++){
	%>
		<%=cookies[i].getName() %> = 
		<%=URLDecoder.decode(cookies[i].getValue()) %><br>
	<%	
		}
	}else{
		%>
		쿠키가 존재하지 않습니다.		
		<%
	}
%>

</body>
</html>