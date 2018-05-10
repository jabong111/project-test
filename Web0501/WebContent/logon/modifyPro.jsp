<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원정보수정</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="${bodyback_c }">
<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
	<tr bgcolor="${title_c }">
		<td height="39" align="center">
		<font size="+1"><b>회원정보가 수정되었습니다.</b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="${value_c }" align="center">
			<p>입력하신 내용대로 수정이 완료되었습니다.</p>
		</td>
	</tr>
	<tr>
		<td bgcolor="${value_c } " align="center">
			<form >
				<input type="button " value="메인" onclick="document.location.href='/Web0501/logon/main.do'">
			</form>
			5초후에 메인으로 이동합니다.<meta http-equiv="Refresh" content="5;url=/Web0501/logon/main.do">
		</td>
	</tr>l
</table>
</body>
</html>