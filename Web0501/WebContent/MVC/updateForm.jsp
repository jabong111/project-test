<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
<body bgcolor="${bodyback_c}">
<center><b>�ۼ���</b>
<br>
<!-- ���η� ������ ��񿡼� ���� -->
<form method="post" name="writeform" action="/Web0501/MVC/updatePro.do?pageNum=${pageNum }" onsubmit="return writeSave()">
<table width="400" border="1" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">�̸�</td>
		<td align="left" width="330">
			<input type="text" size="10" maxlength="10" name="writer" value="${article.writer }">	
			<input type="hidden" name="num" value="${article.num }" >	<!-- �������� �Խñ۹�ȣ ������ -->
		</td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">����</td>
		<td align="left"  width="330">
			<input type="text" size="40" maxlength="50" name="subject" value="${article.subject }">
		</td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">E-mail</td>
		<td align="left" width="330"><input type="text" size="40" maxlength="30" name="email" value="${article.email }"></td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">����</td>
		<td align="left" width="330">
			<textarea rows="13" cols="40" name="content">${article.content }</textarea>
		</td>
	</tr>	
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">��й�ȣ</td>
		<td align="left" width="330">
			<input type="password" size="8" maxlength="12" name="passwd">
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="${value_c }" align="center">
			<input type="submit" value="�ۼ���">
			<input type="reset" value="�ٽ��ۼ�">
			<input type="button" value="��Ϻ���" onclick="document.location.href='/Web0501/MVC/list.do?pageNum=${pageNum}'">
		</td>
	</tr>
</table>
</form>
</body>
</html>









