<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>자료실 목록</title>
</head>
<body>
<table border="1">
	<c:if test="${listModel.totalPageCount > 0 }">
		<tr>
			<td colspan="5">
			${listModel.startRow }-${listModel.endRow }
			[${listModel.requestPage }/${listModel.totalPageCount }]
			</td>
		</tr>
	</c:if>
	
	<tr>
		<td>번호</td>
		<td>파일명</td>
		<td>파일크기</td>
		<td>다운로드횟수</td>
		<td>다운로드</td>
	</tr>
	
<c:choose>
	<c:when test="${listModel.hasPdsItem == false }">
	<tr>
		<td colspan="5">
			게시글이 없습니다.
		</td>
	</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${listModel.pdsItemList }">
			<tr>
				<td>${item.id }</td>
				<td>${item.fileName }</td>
				<td>${item.fileSize }</td>
				<td>${item.downloadCount }</td>
				<td><a href="download.jsp?id=${item.id }">다운받기</a></td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5">
			<c:if test="${beginPage>10 }">
				<a href="<c:url value="list.jsp?p=${beginPage-1 }"/>">이전</a>
			</c:if>
			<c:forEach var="pno" begin="${beginPage }" end="${endPage }">
				<a href="<c:url value="list.jsp?p=${pno }"/>">[${ pno}]</a>
			</c:forEach>
			<c:if test="${endPage<listModel.totalPageCount }">
				<a href="<c:url value="list.jsp?p=${endPage+1 }"/>">다음</a>
			</c:if>
			</td>
		</tr>
	</c:otherwise>
</c:choose>
	<tr>
		<td colspan="5">
			<a href="uploadForm.jsp">파일 첨부</a>
		</td>
	</tr>

</table>

<form action="list.jsp" method="get">
			<select name="searchn">
				<option value="0">작성자</option>
				<option value="1">제목</option>
				<option value="2">내용</option>
			</select>
			<input type="text" name="search" value="${search}" />
			<input type="submit" value="검색" class="btn" />
	</form>


</body>
</html>







































