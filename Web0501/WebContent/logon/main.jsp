<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�����Դϴ�..</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="${bodyback_c }">

<c:if test="${empty sessionScope.memId }">	<!-- �α��� �ȵȰ�� -->
	<table width="500" cellpadding="0" cellspacing="0" align="center" border="1">
			<tr>
			<td width="300" bgcolor="${bodyback_c }" headers="20">&nbsp;</td>
			<form name="inform" method="post" action="/Web0501/logon/loginPro.do">
				<td bgcolor="${title_c }" width="100" align="right">���̵�</td>
				<td width="100" bgcolor="${value_c }"><input type="text" name="id" size="15" maxlength="10"></td>
			</tr>
			<tr>
				<td rowspan="2" bgcolor="${bodyback_c }" width="300">�����Դϴ�.</td>
				<td bgcolor="${title_c }" width="100" align="right">�н�����</td>
				<td width="100" bgcolor="${value_c }"><input type="password" name="passwd" size="15" maxlength="10"></td>
			</tr>
			<tr>
				<td colspan="3" bgcolor="${title_c }" align="center">
				<input type="submit" name="Submit" value="�α���">
				<input type="button" value="ȸ������" onclick="document.location.href='/Web0501/logon/inputForm.do'">
				</td>
				</form>
			</tr>
	</table>
</c:if>
<c:if test="${!empty sessionScope.memId }">	<!-- �α��εȰ�� ������ �������� ��������Ƿ� �����̸����� ������ ��������� ���������ϴ�. -->
	<table width="500" cellpadding="0" cellspacing="0" align="center" border="1">
		<tr>
			<td width="300" bgcolor="${bodyback_c }" headers="20">������</td>
			<td rowspan="3" bgcolor="${value_c }" align="center">
				${sessionScope.memId }����<br>
				�湮�ϼ̽��ϴ�.
				<form action="/Web0501/logon/logout.do">
				<input type="submit" value="�α׾ƿ�">
				<input type="button" value="ȸ����������" onclick="document.location.href='/Web0501/logon/modify.jsp'">
				</form>
			</td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="${bodyback_c }" width="300">�����Դϴ�.</td>
		</tr>
	</table>
	<br>
</c:if>
</body>
</html>
































