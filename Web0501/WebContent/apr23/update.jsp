<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.board.service.UpdateArticleService" %>
<%@ page import="kh10.board.model.Article" %>
<%request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="updateRequest" class="kh10.board.model.UpdateRequest"/>
<jsp:setProperty property="*" name="updateRequest"/>
<%
	String viewPage = null;
	try{
		Article article = UpdateArticleService.getInstance().update(updateRequest);
		request.setAttribute("updatedArticle", article);
		viewPage="update_success.jsp";
	}catch(Exception e){
		request.setAttribute("updateException", e);
		viewPage="update_error.jsp";
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