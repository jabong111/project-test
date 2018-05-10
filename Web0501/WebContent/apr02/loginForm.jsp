<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="util.CookieBox" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	CookieBox cookiebox = new CookieBox(request);
	if(cookiebox.exists("id")){
		%>
		<form action="./login.jsp" method="post">
		아이디<input type="text" value="<%cookiebox.getValue("id"); %>" ="id" size="10">
		암호<input type="password" name="password" size="10">
		아이디저장<input type="checkbox" name="saveid" value="save">
		<input type="submit" value="login">	
		</form>
	<%} else { %>
		<form action="./login.jsp" method="post">
			아이디<input type="text" name="id" size="10">
			암호<input type="password" name="password" size="10">
			아이디저장<input type="checkbox" name="saveid" value="save">
			<input type="submit" value="login">
		</form>
<%} %>

</body>
</html>