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
	//<!-- 코멘트관련 자바빈에 데이터를 넣고  리스트로 포워드 -->

	
	CommentDBBean cdb = CommentDBBean.getInstance();
	cmt.setReg_date(new Timestamp(System.currentTimeMillis())); //시간 저장 
	cmt.setIp(request.getRemoteAddr());//아이피 저장
	cdb.insertComment(cmt);
	
	String contentId = request.getParameter("content_num");
	String url = "read.jsp?id="+contentId+"";	//게시글 아이디와 페이지를 보낸다.
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
