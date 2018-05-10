<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>초기화 파라미터 읽어오기</title>
</head>
<body>
	초기화 파라미터 목록:
	<ul>
		<%
			Enumeration enumName = application.getInitParameterNames();
			while(enumName.hasMoreElements()){
				String name = (String)enumName.nextElement();
				
				%>
				<li><%= name %>
				<%= application.getInitParameter(name)%>
				<%
				
			}				
		%>
		
	
	
	</ul>

</body>
</html>