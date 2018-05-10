<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	Calendar cal = (Calendar)request.getAttribute("time");
%>
	<%=cal.get(Calendar.HOUR) %>시
	<%=cal.get(Calendar.MINUTE) %>분
	<%=cal.get(Calendar.SECOND) %>초
</body>
</html>