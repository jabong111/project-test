<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr"); %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String passwd  = request.getParameter("passwd");
	
	CommentDBBean cdbp = CommentDBBean.getInstance();
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.deleteArticle(num, passwd);
	if(check == 1){
%>
	<!-- 코멘트삭제부분 -->
	<%cdbp.deleteComment(num); %>	<!-- 게시글에 달려있는 댓글 모두 삭제 -->
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<%}else{ %>
	<script language="JavaScript">     
       <!--     
         alert("비밀번호가 맞지 않습니다");
         history.go(-1);
       -->
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