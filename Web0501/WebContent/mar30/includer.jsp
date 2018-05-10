<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>디렉티브</title>
</head>
<body>
	<%
		int number = 10;
	%>
	<%@ include file="./value/includee.jspf" %>
	공통변수 DATAFOLDER = "<%=dataFolder %>"

</body>
</html>