<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="${bodyback_c }">
<center><b>글쓰기</b>
<br>
<form action="/Web0501/MVC/writePro.do" onsubmit="return writeSave()" method="post">
<input type="hidden" name="num" value="${num }">		<!-- writePro.do로 모두 보내버린다.   -->
<input type="hidden" name="ref" value="${ref }">		<!-- writePro.jsp로 보내는게 아닌 action클래스로 보낸다. -->
<input type="hidden" name="re_step" value="${re_step }"><!-- action클래스로 보내서 자바빈에 저장하고 writePro.jsp를 리턴한다.  -->
<input type="hidden" name="re_level" value="${re_level }">

<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td align="right" colspan="2" bgcolor="${value_c }">
			<a href="/Web0501/MVC/list.do">글목록</a>
		</td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">이 름</td>
		<td width="330"><input type="text" size="10" maxlength="10" name="writer"></td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">제목</td>
		<td width="330">
		<c:if test="${num==0 }">	<!--  -->
			<input type="text" size="40" maxlength="50" name="subject" ></td>
		</c:if>
		<c:if test="${num != 0 }">
			<input type="text" size="40" maxlength="50" name="subject" value="[답변]"></td>
		</c:if>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">내 용</td>
		<td width="330"><textarea rows="13" cols="40" name="content"></textarea></td>
	</tr>
	<tr>
		<td width="70" bgcolor="${value_c }" align="center">비밀번호</td>
		<td width="330">
			<input type="password" name="passwd" size="8" maxlength="12">
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="${value_c }" align="center">
			<input type="submit" value="글쓰기">
			<input type="reset" value="다시쓰기">
			<input type="button" value="목록보기" onclick="window.location='/Web0501/MVC/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>


























