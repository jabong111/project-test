<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>INFO</title>
</head>
<body>

body_sub에서 name 파라미터 값: <%=request.getParameter("name") %>
<br/>
name 파라미터 값 목록:
<ul>
<% String[] params = request.getParameterValues("name");
	for(String a:params){
%>	
	<li>
	<%= a%>
	</li>
<%
	}
%>

</ul>

</body>
</html>