<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.image.CommentDataBean" %>
<%@ page import="kh10.image.CommentDBBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Timestamp" %>

<jsp:useBean id="cmt" class="kh10.image.CommentDataBean">
	<jsp:setProperty  name="cmt" property="*"/>	
</jsp:useBean>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	//<!-- �ڸ�Ʈ���� �ڹٺ� �����͸� �ְ�  ����Ʈ�� ������ -->

	
	CommentDBBean cdb = CommentDBBean.getInstance();
	cmt.setReg_date(new Timestamp(System.currentTimeMillis())); //�ð� ���� 
	cmt.setIp(request.getRemoteAddr());//������ ����
	cdb.insertComment(cmt);
	
	String contentId = request.getParameter("content_num");
	String url = "read.jsp?id="+contentId+"";	//�Խñ� ���̵�� �������� ������.
	response.sendRedirect(url);
	
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
