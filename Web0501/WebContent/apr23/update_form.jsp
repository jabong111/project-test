<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.board.service.ReadArticleService" %>
<%@ page import="kh10.board.model.Article" %>
<%@ page import="kh10.board.service.ArticleNotFoundException" %>
<%
	String viewPage = null;
	try{
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		Article article = ReadArticleService.getInstance().getArticle(articleId);
		viewPage = "update_form_view.jsp";
		request.setAttribute("article", article);
	}catch(ArticleNotFoundException e){
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