<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.util.Date" %>
<%
	Date now = new Date();
%>
<html>
	<head>
		<title>현재시간</title>
	</head>
	<body>
		현재시간: <%= now %>
	</body>
</html>