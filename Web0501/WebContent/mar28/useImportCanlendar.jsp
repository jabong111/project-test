<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.Calendar" %>
<%
	Calendar cal = Calendar.getInstance();
%>
<html>
<head>
	<title>Ŭ���� ���</title>
</head>
<body>
	<%= cal.get(Calendar.YEAR) %>��
	<%= cal.get(Calendar.MONTH) %>��
	<%= cal.get(Calendar.DATE) %>��
</body>

</html>


