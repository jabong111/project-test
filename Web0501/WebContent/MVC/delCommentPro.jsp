<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:if test="${check== 1}">
	<meta http-equiv="Refresh" content="0;url=/Web0501/MVC/content.do?num=${num }&pageNum=${pageNum}">
</c:if>
<c:if test="${check==0 }">
	<script>
		alert("비밀번호가 틀렸습니다.");
		history.go(-1);
	</script>
</c:if>