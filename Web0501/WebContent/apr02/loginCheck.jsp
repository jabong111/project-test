<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="util.CookieBox" %>
<%
	CookieBox cookiebox = new CookieBox(request);
	boolean login = cookiebox.exists("LOGIN") && cookiebox.getValue("LOGIN").equals("SUCCESS");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login check</title>
</head>
<body>
<%
	if(login){
%>
	<%=cookiebox.getValue("ID") %>로 로그인 한 상태
<%
	}else{
%>
	로그인하지 않은 상태
<%
	}
%>
</body>
</html>