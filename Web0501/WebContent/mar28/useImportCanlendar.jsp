<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.Calendar" %>
<%
	Calendar cal = Calendar.getInstance();
%>
<html>
<head>
	<title>클래스 사용</title>
</head>
<body>
	<%= cal.get(Calendar.YEAR) %>년
	<%= cal.get(Calendar.MONTH) %>월
	<%= cal.get(Calendar.DATE) %>일
</body>

</html>


