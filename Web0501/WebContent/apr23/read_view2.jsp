<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 읽기</title>
</head>
<body>
<table border="1">
<tr>
	<td>제목</td>
	<td>${article.title }</td>
</tr>
<tr>
	<td>작성자</td>
	<td>${article.writerName }</td>
</tr>
<tr>
	<td>작성일</td>
	<td><fmt:formatDate value="${article.postingDate }" pattern="yyyy-MM-dd"/></td>
</tr>
<tr>
	<td>내용</td>
	<td><pre><c:out value="${article.content }"/></pre></td>
</tr>
<tr>
	<td colspan="2">
	<a href="list.jsp?p=${param.p }">목록보기</a>
	<a href="reply_form.jsp?parentId=${article.id }&p=${param.p}">답변쓰기</a>
	<a href="update_form.jsp?articleId=${article.id}&p=${param.p}">수정하기</a>
	<a href="delete_form.jsp?articleId=${article.id }">삭제하기</a>
	</td>
</tr>
</table>
<table border="1" cellpadding="0" cellspacing="0">
<form action="comment.jsp" method="post">
	<input type="hidden" value="${article.id }">
	<tr>
		<td colspan="1" align="left">이름:<input type="text" name="name"></td>
		<td colspan="1" align="left">비밀번호<input type="password" name="password"></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="2">
		<textarea cols="40" rows="" name="content"></textarea>
		</td>
		<td rowspan="2"><input type="submit" value="답변"></td>
	</tr>
		
	
</form>
</table>
</body>
</html>





























