<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
	<title>클래스 사용</title>
	
</head>
<body>
	<%	java.util.Calendar cal = java.util.Calendar.getInstance();  %>
	<%= cal.get(java.util.Calendar.YEAR) %>년
	<%= cal.get(java.util.Calendar.MONTH)+1 %>월
	<%= cal.get(java.util.Calendar.DATE) %>일
	
	
</body>

</html>