<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>INFO</title>
</head>
<body>
include 전 name 파라미터 값:<%=request.getParameter("name") %>
<hr>
	<jsp:include page="./value/body_sub.jsp">
		<jsp:param value="최범균" name="name"/>
	</jsp:include>
</hr>
include 후 name 파라미터 값:<%=request.getParameter("name") %>

</body>
</html>