<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page errorPage="erroView.jsp" %>
<%@ page import="kh10.service.DeleteMessageService" %>
<%@ page import="kh10.service.InvalidMessagePasswordException" %>
<%
	int messageId = Integer.parseInt(request.getParameter("messageId"));
	String password = request.getParameter("password");
	boolean invalidPassword = false;
	try{
		DeleteMessageService deleteService = DeleteMessageService.getInstance();
		deleteService.deleteMessage(messageId, password);
	}catch(InvalidMessagePasswordException ex){
		invalidPassword = true;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>메시지 삭제</title>
</head>
<body>
<%if(!invalidPassword){ %>
메시지 삭제
<%}else{ %>
암호가 올바르지 않습니다.
<%} %>
<a href="list.jsp">[목록보기]</a>
</body>
</html>