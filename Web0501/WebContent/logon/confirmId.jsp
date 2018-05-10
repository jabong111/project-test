<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ID 중복확인</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="${bodyback_c }">

<c:if test="${check==1 }">
<table width="270" border="0" cellpadding="5" cellspacing="0">
	<tr bgcolor="${title_c }">
		<td height="39">${id }는 이미 사용중인 아이디입니다.</td>
	</tr>
</table>
<form name="checkForm" method="post" action="/Web0501/logon/confirmId.do">
	<table width="270" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td bgcolor="${value_c }" align="center">
			 	다른 아이디를 선택하세요.<p>
			 	<input type="text" size="10" maxlength="12" name="id">
			 	<input type="submit" value="ID중복확인">
			</td>
		</tr>
	</table>
</form>
</c:if>
<c:if test="${check==-1 }">
<table width="270" border="0" cellspacing="0" cellpadding="5">
	<tr bgcolor="${title_c }">
		<td align="center">
		<p>입력하신${id}는 사용하실 수 있는 ID입니다.</p>
		<input type="button" value="닫기" onclick="setid()">
		</td>
	</tr>
</table>
</c:if>
</body>
</html>
<script language="javascript">
	function setid(){
		opener.document.userinput.id.value="${id}";
		self.close();
	}
</script>













