<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.CommentDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="cmt" scope="page" class="soldesk.board.CommentDataBean">	<!-- 자바빈에 넘어온 데이터를 저장 -->
	<jsp:setProperty name="cmt" property="*"/>
</jsp:useBean>
<%
	CommentDBBean comt = CommentDBBean.getInstance();
	int count = Integer.parseInt(request.getParameter("count"));
	cmt.setReg_date(new Timestamp(System.currentTimeMillis()));
	cmt.setIp(request.getRemoteAddr());
	comt.insertComment(cmt,count);	//ip,reg_date 를 만들어주고 CommentDBBean객체에 넣어준다.
	
	String content_num = request.getParameter("num");
	String p_num =request.getParameter("p_num");
	String url="content1.jsp?num="+content_num+"&pageNum="+p_num;
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