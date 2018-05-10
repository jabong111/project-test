<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.net.URLEncoder" %>
<%
	Cookie cookie = new Cookie("name",URLEncoder.encode("김지훈","euc-kr"));
	response.addCookie(cookie);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>make cookie</title>
</head>
<body>
쿠키생성<br>
<%=cookie.getName() %> 쿠키의 값 = [<%= cookie.getValue() %>]

</body>
</html>