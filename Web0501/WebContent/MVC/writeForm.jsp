<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="${bodyback_c }">
<center><b>�۾���</b>
<br>
<form action="/Web0501/MVC/writePro.do" onsubmit="return writeSave()" method="post">
<input type="hidden" name="num" value="${num }">		<!-- writePro.do�� ��� ����������.   -->
<input type="hidden" name="ref" value="${ref }">		<!-- writePro.jsp�� �����°� �ƴ� actionŬ������ ������. -->
<input type="hidden" name="re_step" value="${re_step }"><!-- actionŬ������ ������ �ڹٺ� �����ϰ� writePro.jsp�� �����Ѵ�.  -->
<input type="hidden" name="re_level" value="${re_level }">

<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td align="right" colspan="2" bgcolor="${value_c }">
			<a href="/Web0501/MVC/list.do">�۸��</a>
		</td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">�� ��</td>
		<td width="330"><input type="text" size="10" maxlength="10" name="writer"></td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">����</td>
		<td width="330">
		<c:if test="${num==0 }">	<!--  -->
			<input type="text" size="40" maxlength="50" name="subject" ></td>
		</c:if>
		<c:if test="${num != 0 }">
			<input type="text" size="40" maxlength="50" name="subject" value="[�亯]"></td>
		</c:if>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">�� ��</td>
		<td width="330"><textarea rows="13" cols="40" name="content"></textarea></td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">��й�ȣ</td>
		<td width="330">
			<input type="password" name="passwd" size="8" maxlength="12">
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="${value_c }" align="center">
			<input type="submit" value="�۾���">
			<input type="reset" value="�ٽþ���">
			<input type="button" value="��Ϻ���" onclick="window.location='/Web0501/MVC/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>


























