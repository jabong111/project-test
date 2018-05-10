<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="util.CookieBox" %>
<%
	response.addCookie(CookieBox.createCookie("name", "최범균"));
	response.addCookie(CookieBox.createCookie("id", "madvirus","/Web/apr02/",-1));

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>make cookie using cookieBox</title>
</head>
<body>
쿠키박스를 이용하여 쿠키를 만들었습니다.
</body>
</html>