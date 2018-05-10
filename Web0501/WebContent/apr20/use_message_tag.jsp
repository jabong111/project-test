<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- <fmt:setLocale value="en"/> --%>
<fmt:bundle basename="resource.message"/>
<fmt:message key="TITLE" var="title"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>${title }</title>
</head>
<body>
<fmt:message key="GREETING"/>
<br>
<c:if test="${! empty param.id }">
	<fmt:message key="VISITOR">
		<fmt:param value="${param.id}"/>
	</fmt:message>
</c:if>

</body>
</html>