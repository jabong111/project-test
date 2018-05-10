<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>timezone</title>
</head>
<body>
<c:set var="now" value="<%=new java.util.Date() %>"/>
<fmt:formatDate value="${now }" type="both" dateStyle="full" timeStyle="full"/>

<br>
<fmt:timeZone value="America/Argentina/Buenos_Aires">
	<fmt:formatDate value="${now }" type="both" dateStyle="full" timeStyle="full"/>
</fmt:timeZone>
</body>
</html>