<%@ page contentType="text/html; charset=uft-8" %>
<%@ page pageEncoding="euc-kr" %>
<%!
	public int add(int a, int b){
	return a+b;
}
	public int sub(int a, int b){
		return a-b;
	}

%>

<html>
	<head>
		<title>메서드 이용</title>
	</head>
	<body>
		<%
			int addResult = add(10,20);
			int subResult = sub(20,10);
		%>
		add:<%=addResult %></br>
		sub:<%=subResult %>
	
	</body>
</html>