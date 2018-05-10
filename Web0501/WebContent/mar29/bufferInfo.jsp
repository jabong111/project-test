<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page buffer="8kb" autoFlush="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>buffer Information</title>
</head>
<body>
	버퍼크기:<%=out.getBufferSize() %><br>
	남은크기:<%=out.getRemaining() %><br>
	auto flush:<%= out.isAutoFlush() %><br>

</body>
</html>