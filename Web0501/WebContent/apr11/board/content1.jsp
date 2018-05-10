<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ page import="soldesk.board.CommentDataBean" %>
<%@ page import="soldesk.board.CommentDBBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="./color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function writeSave(){
	if(document.comment.commentt.value==""){
		alert("댓글내용을 입력하세요.");
		document.comment.commentt.focus();
		return false;
	}
	
	if(document.comment.commenter.value==""){
		alert("댓글내용을 입력하세요.");
		document.comment.commenter.focus();
		return false;
	}
	
	if(document.comment.passwd.value==""){
		alert("댓글내용을 입력하세요.");
		document.comment.passwd.focus();
		return false;
	}
}
function zipCheck(){
	url = "ZipCheck.jsp?check=y";
	window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
}
function commentOfcomment(){
	url = "commentForm.jsp";
	window.open(url,"commnet","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
}
	

</script>
</head>	<!-- 글 하나를 디비에서 가져와서 자세히 보여준다. -->
<%
	int num = Integer.parseInt(request.getParameter("num"));	//list.jsp 로부터 값을 받아온다.
	String pageNum = request.getParameter("pageNum");	//글이 저장되어있는 페이지 넘버
	int pageSize = 10;
	String cPageNum = request.getParameter("cPageNum");	//코멘트가 저장되어있는 페이지 넘어
	if(cPageNum == null){		//코멘트페이지가 없으면 1페이지로 저장한다.
		cPageNum = "1";
	}
	int cCurrentPage  = Integer.parseInt(cPageNum);	//코멘트현재페이지	페이징을 위한 현재 코멘트페이지
	int startRow = (cCurrentPage * 10) - 9;	
	int endRow = cCurrentPage * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();	//BoardDBBean객체를 생성하고	
		BoardDataBean article = dbPro.getArticle(num);	//글 하나를 받아온다.
				
		CommentDBBean cdb = CommentDBBean.getInstance();	//CommentDBBean 객체를 생성하고
		
		ArrayList comments = cdb.getComments(article.getNum(), startRow, endRow);	//코멘트들을 가져온다. 게시글의 넘버와  가져올개수
		int count = cdb.getCommentCount(article.getNum());	//코멘트가 총 몇개있는지 가져온다.
		
		int ref = article.getRef();				
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
%>
<body bgcolor="<%=bodyback_c%>">
<center><b>글내용 보기</b>
<br>
<form>
	<table width="500" border="1" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
		<tr height="30">
				<td align="center" width="125" bgcolor="<%=value_c%>">글번호</td>
				<td align="center" width="125" align="center">
					<%=article.getNum() %></td>
				<td align="center" width="125" bgcolor="<%=value_c%>">조회수</td>
				<td align="center" width="125" align="center">
					<%=article.getReadcount()%></td>
		</tr>
		
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c%>">작성자</td>
			<td align="left" width="125" align="center">
				<%=article.getWriter() %></td>
			<td align="center" width="125" bgcolor="<%=value_c%>">작성일 </td>
			<td align="center" width="125" align="center">
				<%=sdf.format(article.getReg_date()) %></td>
		</tr>
		
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c%>">글제목</td>
			<td align="center" width="375" align="center" colspan="3">
				<%=article.getSubject()%></td>
		</tr>
		
		<tr>
			<td align="center" width="125" bgcolor="<%=value_c%>">글내용</td>
			<td align="left" width="375" colspan="3"><pre><%=article.getContent() %></pre></td>
		</tr>
		
		<tr height="30">
			<td colspan="4" bgcolor="<%=value_c%>" align="right">
			<input type="button" value="글수정"
			 onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글삭제"
			 onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="답글쓰기" 
			 onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref %>&re_step=<%=re_step %>&re_level=<%=re_level %>'"	>
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글목록" 
			 onclick="document.location.href='list_search.jsp?pageNum=<%=pageNum %>'"	>
			 </td>
		</tr>
		</form>
		<%
			int com_num=0,com_ref=1,com_step=0,com_level=0; 
		%>
		
		<form method="post" action="contentPro.jsp" name="comment" onsubmit="return writeSave()">	<!-- contentPro.jsp로 넘어가는 파라미터(commentt,content_num,p_num,comment_num,commenter,passwd) -->
			<tr bgcolor="<%=value_c%>" align="center">
				<td>코멘트 작성</td>
				<td colspan="2">
				 	<textarea rows="6" cols="40" name="commentt"></textarea>
				 	<input type="hidden" name="content_num" value="<%=article.getNum()%>">	<!-- 게시글 번호 -->
				 	<input type="hidden" name="p_num" value="<%=pageNum%>">	<!-- 페이지넘버 보내기 코멘트 달고나서 현재페이지를 저장하기위해  -->
				 	<input type="hidden" name="comment_num" value="<%=com_num%>">	<!-- count+1; 현재 코멘트번호에 1을더해 보내면 새로운 코멘트의 번호가 1올라간다. -->
				 	<input type="hidden" name="ref" value="<%=com_ref%>">
				 	<input type="hidden" name="re_step" value="<%=com_step%>">
				 	<input type="hidden" name="re_level" value="<%=com_level%>">
				 	<input type="hidden" name="count" value="<%=count%>">
				</td>
				<td align="center">
					작성자<br>
					<input type="text" name="commenter" size="10"><br>
					비밀번호<br>
					<input type="password" name="passwd" size="10"><p>
					<input type="submit" value="코멘트달기">
				</td>
			</tr>
		</form>
	</table>
	<%if(count>0){ %>	<!-- 코멘트 달려있으면 -->
		<p>
		<table width="500" border="0" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
			<tr>
				<td>코멘트 수:<%=comments.size() %></td>
			</tr>
			<%for(int i=0;i<comments.size();i++){
				CommentDataBean dbc = (CommentDataBean)comments.get(i);
				int wid = 0;%>
				<tr>
				<%if(dbc.getRe_step() >0){
					wid=5*(dbc.getRe_step());%>	<!-- 댓글의 댓글이 달렸으면  -->
					<td>
					<img width="<%=wid %>" height="16" src="./images/level.gif">
					<img  src="./images/re.gif">
					</td>
				<%}else{ %>
				
				<%} %>
					<td align="left" size="250" bgcolor="<%=value_c%>">
					&nbsp;<b><%=dbc.getCommenter() %>&nbsp;님</b>(<%=sdf.format(dbc.getReg_date()) %>)
					</td>
					<td align="right" size="250" bgcolor="<%=value_c%>">접속 IP:<%=dbc.getIp() %>
					<a href="delCommentForm.jsp?ctn=<%=dbc.getContent_num()%>&cmn=<%=dbc.getComment_num() %>&p_num=<%=pageNum %>">[삭제]</a>&nbsp;
					<form action="commentForm.jsp" method="post">
						<input type="hidden" name="re_step" value="<%=dbc.getRe_step()%>">
						<input type="hidden" name="ref" value="<%=dbc.getRef()%>">
						<input type="hidden" name="re_level" value="<%=dbc.getRe_level()%>">
						<input type="hidden" name="num" value="<%=dbc.getComment_num()%>">
						<input type="hidden" name="count" value="<%=count%>">
						<input type="hidden" name="content_num" value="<%=dbc.getContent_num()%>">
						<input type="hidden" name="p_num" value="<%=pageNum%>">
						<input type="submit" value="[답글]">
					</form>
					
					<!-- <a href="commentForm.jsp?ctn=<%=dbc.getContent_num()%>&num=<%=dbc.getComment_num() %>&ref=<%=dbc.getRef() %>
					&re_level=<%=dbc.getRe_level()%>&re_step=<%=dbc.getRe_step()%>&count=<%=count%>">[답글]</a>&nbsp;-->
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left"><%=dbc.getCommentt() %></td>
			<% }%>
				</tr>
		</table>
		<table width="500" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c%>" align="center">
		<tr>
		<center>
		<%
			if(count >0){
				int pageCount = count/pageSize+(count%pageSize==0?0:1);
				int startPage=(int)(cCurrentPage/5)*5+1;
				int pageBlock=5;
				int endPage = startPage+pageBlock-1;
				if(endPage>pageCount)	endPage=pageCount;
				if(startPage>5){%>
				<a href="content1.jsp?num=<%=num%>&pageNum=<%=pageNum%>&cPageNum=<%=startPage-5%>">[이전]</a>
				
		<%	}
			for(int i=startPage;i<=endPage;i++){%>
				<a href="content1.jsp?num=<%=num%>&pageNum=<%=pageNum%>&cPageNum=<%=i%>">[<%=i %>]</a>
<%
			}
			if(endPage<pageCount){%>
			<a href="content1.jsp?num=<%=num%>&pageNum=<%=pageNum%>&cPageNum=<%=startPage+5%>">[다음]</a>
<%
			}
		}
%>		
		
		</center>
		</tr>
		</table>
	<%} %>
<%
	}catch(Exception e) {}
%>
</body>
</html>




















