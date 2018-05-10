<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ page import="java.sql.Timestamp" %>

<%request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="article" scope="page" class="soldesk.board.BoardDataBean">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	String pageNum = request.getParameter("pageNum");
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.updateArticle(article);
	if(check == 1){

%>
	<meta http-equiv="Refresh" content="5;url=list.jsp?pageNum=<%=pageNum %>">	<!--pageNum은 겟방식으로 보낸다.  -->
<%}else{ %>
	<script language="JavaScript">
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>