<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="javax.servlet.ServletRequest" %>
<%request.setAttribute("name", "jihoon"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Test</title>
</head>
<body>
URI: ${pageContext.request.requestURI }<br>
aaaa: <%=request.getRequestURI() %><br>
NAME: ${requestScope.name}<br>
code PARAMETER: ${param.code }<br>


</body>
</html>