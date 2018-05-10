<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="kh10.board.service.ReadArticleService" %>
<%@page import="kh10.board.service.ArticleNotFoundException" %>
<%@page import="kh10.board.model.Article" %>
<%
	int articleId = Integer.parseInt(request.getParameter("articleId"));
	String viewPage = null;
	try{
		Article article = ReadArticleService.getInstance().readArticle(articleId);
		request.setAttribute("article", article);
		viewPage = "read_view.jsp";
		
	}catch(ArticleNotFoundException ex){
		viewPage = "article_not_found.jsp";
	}
%>
<jsp:forward page="<%=viewPage %>"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>