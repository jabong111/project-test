<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�� �б�</title>
</head>
<body>
<table border="1">
<tr>
	<td>����</td>
	<td>${article.title }</td>
</tr>
<tr>
	<td>�ۼ���</td>
	<td>${article.writerName }</td>
</tr>
<tr>
	<td>�ۼ���</td>
	<td><fmt:formatDate value="${article.postingDate }" pattern="yyyy-MM-dd"/></td>
</tr>
<tr>
	<td>����</td>
	<td><pre><c:out value="${article.content }"/></pre></td>
</tr>
<tr>
	<td colspan="2">
	<a href="list.jsp?p=${param.p }">��Ϻ���</a>
	<a href="reply_form.jsp?parentId=${article.id }&p=${param.p}">�亯����</a>
	<a href="update_form.jsp?articleId=${article.id}&p=${param.p}">�����ϱ�</a>
	<a href="delete_form.jsp?articleId=${article.id }">�����ϱ�</a>
	</td>
</tr>
</table>
<table border="1" cellpadding="0" cellspacing="0">
<form action="comment.jsp" method="post">
	<input type="hidden" value="${article.id }">
	<tr>
		<td colspan="1" align="left">�̸�:<input type="text" name="name"></td>
		<td colspan="1" align="left">��й�ȣ<input type="password" name="password"></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="2">
		<textarea cols="40" rows="" name="content"></textarea>
		</td>
		<td rowspan="2"><input type="submit" value="�亯"></td>
	</tr>
		
	
</form>
</table>
</body>
</html>





























