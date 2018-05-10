<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%request.setCharacterEncoding("euc-kr"); %>
<%@ page import="kh10.board.service.DeleteArticleService" %>
<jsp:useBean id="deleteRequest" class="kh10.board.model.DeleteRequest"/>
<jsp:setProperty property="*" name="deleteRequest"/>
<%
	String viewPage = null;
	try{
		DeleteArticleService.getInstance().deleteArticle(deleteRequest);
		viewPage="delete_success.jsp";
	}catch(Exception e){
		request.setAttribute("deleteException", e);
		viewPage = "delete_error.jsp";
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