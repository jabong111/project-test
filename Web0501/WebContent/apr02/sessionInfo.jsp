<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page session="true" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date time = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>session information</title>
</head>
<body>
세션ID:<%=session.getId() %><br>
<%
	time.setTime(session.getCreationTime());
%>
세션생성시간: <%=formatter.format(time)%> <br>
<%
	time.setTime(session.getLastAccessedTime());
%>
최근접근시간:<%=formatter.format(time) %><br>



</body>
</html>