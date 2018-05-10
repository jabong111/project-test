<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jsp" %>

<%!
	int pageSize=10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>

<%
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	System.out.println(currentPage);
	int startRow = (currentPage*10)-9;	//1*10 - 9 = 1  2*10 - 9 = 11
	int endRow = currentPage*pageSize;	//1*10 = 10 2*10 = 20
	int count=0;
	int number=0;
	//list.jsp 는 페이지를 꾸며주기위한 jsp
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	CommentDBBean cdb = CommentDBBean.getInstance();
	count = dbPro.getArticleCount();	//총글의수
	if(count>0){	//글이 있다면
		articleList = dbPro.getArticles(startRow, endRow);	//1~10 11~20 10개씩 데이터베이스에서 어레이리스트를 받아온다.
	}
	number=count-(currentPage-1)*pageSize;	//14 - (1-1)*10  14-(2-1)*10 = 4 다음페이지에 보여줄 숫자
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 </title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<center><b>글목록(전체 글:<%=count %>)</b>
<table width="700">
	<tr>
		<td align="right" bgcolor="<%=value_c%>">
		<a href="writeForm.jsp">글쓰기</a>
		</td>
</table>	
<%
	if(count == 0){	//글이 없다면
%>
	<table width="700" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
			게시판에 저장된 글이 없습니다.
			</td>
		</tr>
	</table>

<%}else{ //글이 있다면 %>
	<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
		<tr height="30" bgcolor="<%=value_c%>">
			<td align="center" width="50">번 호</td>
			<td align="center" width="250">제   목</td>
			<td align="center" width="100">작성자</td>
			<td align="center" width="150">작성일</td>
			<td align="center" width="50">조 회</td>
			<td align="center" width="100">IP</td>
		</tr>
	<%
		for(int i=0;i<articleList.size();i++){			//폼에 맞게 데이터를 받아와서 
			BoardDataBean article = (BoardDataBean)articleList.get(i);
			int com_count = cdb.getCommentCount(article.getNum());
	%>
		<tr height="30">
		<td align="center" width="50"> <%=number-- %></td>
		<td width="250">
	<%
		int wid=0;
		if(article.getRe_level()>0){	//0보다 크면 답글 답글이면
			wid=5*(article.getRe_level());		//들여쓰기값
	%>
		<img width="<%=wid %>" height="16" src="./images/level.gif">
		<img  src="./images/re.gif">
	<%}else{ //새글이면 %>	
		<img  src="./images/level.gif" width="<%=wid%>" height="16">
	<%} %>
		<% if(com_count > 0){ %>	<!-- 댓글이 있으면 댓글개수를 화면에 나오게하고  -->

			<a href="content1.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
				<%=article.getSubject() %> [<%=com_count %>]</a>
<%}else{%>	<!-- 댓글이 없으면 0이 뜨는게 아니라 안뜨게 한다.  -->
			<a href="content1.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
				<%=article.getSubject() %></a>		
<%} %>	
		<%if(article.getReadcount() >= 20){ %>	<!-- hot사인을 보여주게하기위한 -->
			<img  src="./images/hot.gif" border="0" height="16"><%} %></td>
			<td align="center" width="100">
			<a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>		<!-- mailto는 클릭했을때 바로 메일을 보여주기위한 -->
			<td align="center" width="150"><%=sdf.format(article.getReg_date()) %></td>
			<td align="center" width="50"><%=article.getReadcount() %></td>
			<td align="center" width="100"><%=article.getIp() %></td>
			</tr>
	<%} %>
	</table>
<%} %>

<%
	if(count>0){	//글이 있으면
		int pageCouunt = count/pageSize+(count%pageSize==0?0:1);	// 14/10+(14%10==0?) 1+0 = 1 	
		
		int startPage = (int)(currentPage/5)*5+1;	//(1/5)*5+1	시작페이지=1  (2/5)*5+1 
		int pageBlock=5;
		int endPage = startPage + pageBlock-1;
		if(endPage>pageCouunt)	endPage = pageCouunt;
		
		if(startPage>5){%>
		<a href="list.jsp?pageNum=<%=startPage - 5%>">[이전]</a>
<%		} 
		for(int i=startPage; i<=endPage;i++){ %>			
		<a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>

		<%}
		if(endPage < pageCouunt){	%>
		<a href="list.jsp?pageNum=<%=startPage+5%>">[다음]</a>
	<%} %>	
<%}%>


</center>
</body>
</html>

































