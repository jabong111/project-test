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
<c:if test="${param.dest == '1' }">
	<c:redirect url="/use_c_set.jsp"></c:redirect>
</c:if>
<c:if test="${param.dest == '2' }">
	<c:redirect url="use_c_set.jsp"></c:redirect>
</c:if>
<c:if test="${param.dest == '3' }">
	<c:redirect url="/apr19/viewToday.jsp"></c:redirect>
</c:if>
<c:if test="${param.dest == '4' }">
	<c:redirect url="http://www.youtube.com/results">
		<c:param name="a" value="ryu"></c:param>
	</c:redirect>
</c:if>

</body>
</html>