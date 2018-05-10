<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
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
@font-face {font-family:����; src:url();}
body,td,a,div,p,pre,input,textarea {font-family:����;font-size:9pt;}
-->
</style>
</head>
<body bgcolor="${bodyback_c }">
<center><b>�۳��� ����</b>
<br>
<form>
<table width="500" border="1" cellpadding="0" cellspacing="0" align="center">
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c }">�۹�ȣ</td>
		<td align="center" width="125" align="center">${article.num }</td>
		<td align="center" width="125" bgcolor="${value_c }">��ȸ��</td>
		<td align="center" width="125" align="center">${article.readcount }</td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c }">�ۼ���</td>
		<td align="center" width="125" align="center">${article.writer }</td>
		<td align="center" width="125" bgcolor="${value_c }">�ۼ���</td>
		<td align="center" width="125" align="center">${article.reg_date }</td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c }">������</td>
		<td align="center" width="375" align="center" colspan="3">${article.subject }</td>
	</tr>
	<tr>
		<td align="center" width="125" bgcolor="${value_c }">�۳���</td>
		<td align="left" width="375" align="center" colspan="3"><pre>${article.content }</pre>></td>
	</tr>
	<tr height="30">
		<td colspan="4" bgcolor="${value_c }" align="right">
		<input type="button" value="�ۼ���" onclick="document.location.href='/Web0501/MVC/updateForm.do?num=${article.num}&pageNum=${pageNum }'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="�ۻ���" onclick="document.location.href='/Web0501/MVC/deleteForm.do?num=${article.num}&pageNum=${pageNum }'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="��۾���" onclick="document.location.href='/Web0501/MVC/writeForm.do?num=${article.num}&ref=${article.ref}&re_step=${article.re_step}&re_level=${article.re_level}'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="�۸��" onclick="document.location.href='/Web0501/MVC/list.do?pageNum=${pageNum }'">
		</td>
	</tr>
	</form>
	<form action="/Web0501/MVC/commentPro.do" method="post">	<!-- �ڸ�Ʈ ���η� ������ �����ͺ��̽��� �ְ� content.jsp���� ����¡�Ѵ�. -->
	<tr bgcolor="${value_c }" align="center">
		<td>�ڸ�Ʈ �ۼ�</td>
		<td colspan="2">
			<textarea rows="6" cols="40" name="commentt"></textarea>
			<input type="hidden" name="num" value="${article.num }">
			<input type="hidden" name="pageNum" value="${pageNum }">
			<input type="hidden" name="comment_num" value="${count+1 }"> <!-- count�� �ڸ�Ʈ ������ ���ؼ� �����ش�. -->
		</td>
		<td align="center">
			�ۼ���<br>
			<input type="text" name="commenter" size="10"><br>
			��й�ȣ<br>
			<input type="password" name="passwd" size="10"><p>
			<input type="submit" value="�ڸ�Ʈ�ޱ�">
		</td>
	</tr>
	</form>
</table>
<c:if test="${count> 0}">	<!-- �ڸ�Ʈ ������ ������ �ڸ�Ʈ�� �ܴ�. -->
	<p>
	<table width="500" border="0" cellpadding="0" cellspacing="0" bgcolor="${bodyback_c }" align="center">
		<tr>
			<td align="left">�ڸ�Ʈ��:${count }</td>
		</tr>
		<c:forEach var="comment" items="${commentList }">
			<tr>
				<td align="left" size="250" bgcolor="${value_c }">
					&nbsp;<b>${comment.commenter }&nbsp;��</b>(<fmt:formatDate value="${comment.reg_date }" pattern="yyyy-MM-dd hh:mm:ss"/>)
				</td>
				<td align="right" size="250" bgcolor="${value_c }">����IP:${comment.ip }
				&nbsp;<a href="/Web0501/MVC/delCommentForm.do?commentNum=${comment.comment_num }
				&num=${comment.content_num }&pageNum=${pageNum}" >[����]</a>&nbsp;
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


































