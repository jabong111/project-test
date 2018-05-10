<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="euc-kr" %>
<%!
	public int mul(int a, int b){
	return a*b;
}

%>

<html>
	<head>
		<title>메소드 이용</title>
	</head>
	<body>
		<%= mul(12, 23) %>
	</body>


</html>