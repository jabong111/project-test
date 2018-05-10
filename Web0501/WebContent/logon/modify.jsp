<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>정보수정</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="${bodyback_c }">
	<table width="500" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td>
				<form action="/Web0501/logon/modifyForm.do" name="myform" method="post">
					<input type="hidden" name="id" value="${sessionScope.memId }">
					<input type="submit" value="회원정보 수정">
				</form>
			</td>
			<td>
				<form action="/Web0501/logon/deleteForm.do" name="myform" method="post">
					<input type="hidden" name="id" value="${sessionScope.memId }">
					<input type="submit" value="회원 탈퇴">
				</form>
			</td>
			<td>
				<form action="/Web0501/logon/main.do" name="myform" method="post">
					<input type="submit" value="메인으로">
				</form>
			</td>
		</tr>
	</table>
</body>
</html>