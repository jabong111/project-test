<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page errorPage="errorView.jsp" %>
<%@ page import="kh10.model.Message" %>
<%@ page import="kh10.service.WriteMessageService" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="message" class="kh10.model.Message">
	<jsp:setProperty name="message" property="*"/>
</jsp:useBean>
<%
	WriteMessageService writeService = WriteMessageService.getInstance();
	writeService.write(message);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>방명록 메시지 남김</title>
</head>
<body>
방명록에 메시지를 남겼습니다.
<br/>
<a href="list.jsp">[목록보기]</a>
</body>
</html>