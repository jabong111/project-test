<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.board.service.ReplyArticleService" %>
<%@ page import="kh10.board.model.Article" %>
<%request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="replyingRequest" class="kh10.board.model.ReplyingRequest"/>
<jsp:setProperty property="*" name="replyingRequest"/>
<%
	String viewPage = null;
	try{
		Article postedArticle = ReplyArticleService.getInstance().reply(replyingRequest);
		request.setAttribute("postedArticle", postedArticle);
		viewPage = "reply_success.jsp";
		
	}catch(Exception e){
		viewPage = "reply_error.jsp";
		request.setAttribute("replyException", e);
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