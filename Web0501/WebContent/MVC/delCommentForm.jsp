<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script language="javascript">
	function deleteSave(){
		if(document.delform.passwd.value == ''){
			alert("비밀번호를 입력하세요");
			document.delform.passwd.focus();
			return false;
		}
	}

</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body bgcolor="${bodyback_c }">
	<form action="/Web0501/MVC/delCommentPro.do" method="post" onsubmit="return deleteSave()" name="delform">
		<table border="1" align="center" cellpadding="0" cellspacing="0" width="360">
			<tr height="30">
				<td align="center" bgcolor="${value_c }">
					<b>비밀번호를 입력해 주세요</b>
				</td>
			</tr>
			<tr height="30">
				<td align="center">
				비밀번호:<input type="password" name="passwd" size="8" maxlength="12">
				<input type="hidden" name="num" value="${num }"><!-- 게시글번호 -->
				<input type="hidden" name="pageNum" value="${pageNum }"><!-- 페이지번호 -->
				<input type="hidden" name="commentNum" value="${commentNum}"><!-- 코멘트번호 -->
				</td>
			</tr>
			<tr height="30">
				<td align="center" bgcolor="${value_c }">
					<input type="submit" value="삭제">
					<input type="button" value="취소" onclick="document.location.href='/Web0501/MVC/content.do?num=${num}&pageNum=${pageNum} }'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
<!-- 
지울대는 커멘트넘,컨텐트넘,패스워드가 있어야되고 
페이지로 돌아가게 하기위해서는 컨텐트넘,페이지넘을 프로로 보내줘야된다.
삭제할대는 페이지넘,게시글번호 두개는 conten.jsp로 돌아가서 보여주기위해서 넘겨주는 값이고
패스워드와 코멘트넘도 보내주어야한다.
 -->