<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
a:link { color:black; text-decoration:none; }
a:visited {  }
a:active { text-decoration:underline; }
a:hover { text-decoration:underline; background-image:url('text_dottdeline.gif'); background-repeat:repeat-x; background-position:50% 100%; }
-->
</style>
<style type="text/css">
<!--
@font-face {font-family:굴림; src:url();}
body,td,a,div,p,pre,input,textarea {font-family:굴림;font-size:9pt;}
-->
</style>
</head>
<body bgcolor="${bodyback_c }">
<center><b>글내용 보기</b>
<br>
<form>
<table width="500" border="1" cellpadding="0" cellspacing="0" align="center">
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c }">글번호</td>
		<td align="center" width="125" align="center">${article.num }</td>
		<td align="center" width="125" bgcolor="${value_c }">조회수</td>
		<td align="center" width="125" align="center">${article.readcount }</td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c }">작성자</td>
		<td align="center" width="125" align="center">${article.writer }</td>
		<td align="center" width="125" bgcolor="${value_c }">작성일</td>
		<td align="center" width="125" align="center">${article.reg_date }</td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c }">글제목</td>
		<td align="center" width="375" align="center" colspan="3">${article.subject }</td>
	</tr>
	<tr>
		<td align="center" width="125" bgcolor="${value_c }">글내용</td>
		<td align="left" width="375" align="center" colspan="3"><pre>${article.content }</pre>></td>
	</tr>
	<tr height="30">
		<td colspan="4" bgcolor="${value_c }" align="right">
		<input type="button" value="글수정" onclick="document.location.href='/Web0501/MVC/updateForm.do?num=${article.num}&pageNum=${pageNum }'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글삭제" onclick="document.location.href='/Web0501/MVC/deleteForm.do?num=${article.num}&pageNum=${pageNum }'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="답글쓰기" onclick="document.location.href='/Web0501/MVC/writeForm.do?num=${article.num}&ref=${article.ref}&re_step=${article.re_step}&re_level=${article.re_level}'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글목록" onclick="document.location.href='/Web0501/MVC/list.do?pageNum=${pageNum }'">
		</td>
	</tr>
	</form>
	<form action="/Web0501/MVC/commentPro.do" method="post">	<!-- 코멘트 프로로 보내서 데이터베이스에 넣고 content.jsp에서 페이징한다. -->
	<tr bgcolor="${value_c }" align="center">
		<td>코멘트 작성</td>
		<td colspan="2">
			<textarea rows="6" cols="40" name="commentt"></textarea>
			<input type="hidden" name="num" value="${article.num }">
			<input type="hidden" name="pageNum" value="${pageNum }">
			<input type="hidden" name="comment_num" value="${count+1 }"> <!-- count는 코멘트 개수를 정해서 보내준다. -->
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
<c:if test="${count> 0}">	<!-- 코멘트 갯수가 있으면 코멘트를 단다. -->
	<p>
	<table width="500" border="0" cellpadding="0" cellspacing="0" bgcolor="${bodyback_c }" align="center">
		<tr>
			<td align="left">코멘트수:${count }</td>
		</tr>
		<c:forEach var="comment" items="${commentList }">
			<tr>
				<td align="left" size="250" bgcolor="${value_c }">
					&nbsp;<b>${comment.commenter }&nbsp;님</b>(<fmt:formatDate value="${comment.reg_date }" pattern="yyyy-MM-dd hh:mm:ss"/>)
				</td>
				<td align="right" size="250" bgcolor="${value_c }">접속IP:${comment.ip }
				&nbsp;<a href="/Web0501/MVC/delCommentForm.do?commentNum=${comment.comment_num }
				&num=${comment.content_num }&pageNum=${pageNum}" >[삭제]</a>&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">${comment.commentt }</td>
			</tr>
		</c:forEach>
	</table>
</c:if>


</body>
</html>


































