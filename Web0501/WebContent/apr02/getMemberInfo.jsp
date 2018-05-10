<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String memberId = (String)session.getAttribute("MEMBERID");
	String name = (String)session.getAttribute("NAME");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>세션에서 정보 가져오기</title>
</head>
<body>
세션에서 가져온 정보<br>
memberId: <%=memberId %><br>
name: <%=name %>

</body>
</html>