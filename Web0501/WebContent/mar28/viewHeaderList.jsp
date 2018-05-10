<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.Enumeration" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		Enumeration headerEnum = request.getHeaderNames();
		while(headerEnum.hasMoreElements()){
			String headerName = (String)headerEnum.nextElement();
			String headerValue = request.getHeader(headerName);
	%>
			<%=headerName %> = <%= headerValue %><br>
	<%
		}
	%>
	
</body>
</html>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="euc-kr"%>