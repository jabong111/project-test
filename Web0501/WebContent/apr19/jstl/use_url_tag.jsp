<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:url var="searchUrl" value="http://search.daum.net/search">
	<c:param name="w" value="blog"></c:param>
	<c:param name="q" value="jisung"></c:param>
</c:url>

<ul>
	<li>${searchUrl }</li>
	<c:url value="/use_if_tag.jsp" var="asd"></c:url>
	<li>aa${asd }</li>
	<li><c:url value="./use_if_tag.jsp"></c:url></li>
</ul>

</body>
</html>