<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="${bodyback_c }">
<center><b>글목록(전체 글:${count })</b>
<table width="700">
	<tr>
		<td align="right" bgcolor="${value_c }">
		<a href="/Web0501/MVC/writeForm.do">글쓰기</a>	<!-- 이동 -->
		</td>
	</tr>
</table>

<c:if test="${count==0 }">
<table width="700" border="1" cellpadding="0" cellspacing="0">
	<tr> 
		<td align="center">
			게시판에 저장된 글이 없습니다.
		</td>
	</tr>
</table>
</c:if>

<c:if test="${count>0 }">	<!-- 게시글이 존재한다면 -->
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="${value_c }">
		<td align="center" width="50">번호</td>
		<td align="center" width="250">제 목</td>
		<td align="center" width="100">작성자</td>
		<td align="center" width="150">작성일</td>
		<td align="center" width="50">조회</td>
		<td align="center" width="100">IP</td>
	</tr>
	<c:forEach var="article" items="${articleList }">
		
		<tr height="30">
			<td align="center" width="50">
				<c:out value="${number }"/>
				<c:set var="number" value="${number-1 }" />	<!-- 번호를 1씩 줄인다. -->
			</td>
			<td width="250">
			<c:if test="${article.re_level>0 }">	<!-- 답글이면 -->
				<img src="images/level.gif" width="${5*article.re_level }" height="16">
					<img  src="images/re.gif">
			</c:if>
			<c:if test="${article.re_level==0 }">
				<img  src="images/level.gif" width="${5*article.re_level }" height="16">
			</c:if>
			<!-- 상세보기 content.do로 보낼때 게시글번호랑 페이지번호만 보낸다.-->
			<a href="/Web0501/MVC/content.do?num=${article.num }&pageNum=${currentPage}">${article.subject }</a>
			<c:if test="${article.readcount>=20 }">	<!-- 조회수20이상이면 hot표시 붙이기 -->
				<img src="images/hot.gif" border="0" height="16">
			</c:if>
			</td>
			<td align="center" width="100">
				<a href="mailto:${article.email }">${article.writer}</a><!-- 작성자한테 메일보내기 -->
			</td>
			<td align="center" width="150">${article.reg_date }</td>
			<td align="center" width="50">${article.readcount }</td>
			<td align="center" width="100">${article.ip }</td>
			</tr>
	</c:forEach>
</table>
</c:if>
	<!-- 페이징 -->
<c:if test="${count>0 }">
	<c:set var="pageCount" value="${count/pageSize+(count%pageSize==0?0:1) }"/>
	<c:set var="pageBlock" value="${10 }"/>
	<fmt:parseNumber var="result" value="${currentPage/10 }" integerOnly="true"/>
	<c:set var="startPage" value="${result*10+1 }"/>
	<c:set var="endPage" value="${startPage+pageBlock-1 }"/>
	<c:if test="${endPage>pageCount }">
		<c:set var="endPage" value="${pageCount }"/>
	</c:if>
	
	<c:if test="${startPage>10 }">
		<a href="/Web0501/MVC/list.do?pageNum=${startPage-10 }">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${startPage }" end="${endPage }">
		<a href="/Web0501/MVC/list.do?pageNum=${i }">[${i }]</a>
	</c:forEach>

	<c:if test="${endPage<pageCount}">
		<a href="/Web0501/MVC/list.do?pageNum=${startPage+10 }">[다음]</a>
	</c:if>
</c:if>
<form action="/Web0501/MVC/list.do" method="post">	
	<select name="searchn">
		<option value="0">작성자</option>
		<option value="1">제목</option>
		<option value="2">글내용</option>
	</select>
	<input type="text" name="search">
	<input type="submit" value="검색">
</form>
</center>

</body>
</html>


























