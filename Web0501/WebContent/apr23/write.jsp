<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.board.service.WriteArticleService" %>
<%@ page import="kh10.board.model.Article" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="writingRequest" class="kh10.board.model.WritingRequest"/>
	<jsp:setProperty name="writingRequest" property="*"/>
<%
	Article postedArticle = WriteArticleService.getInstance().Write(writingRequest);
	request.setAttribute("postedArticle", postedArticle);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խñ� �ۼ�</title>
</head>
<body>
�Խñ��� ����߽��ϴ�.<br>
<a href="<c:url value='list.jsp'/>">��Ϻ���</a>
<a href="<c:url value='read.jsp?articleId=${postedArticle.id }'/>">�Խñ� �б�</a>

</body>
</html>