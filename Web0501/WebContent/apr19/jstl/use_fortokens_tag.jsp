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
콤마와 점을 구분자로 사용:<br>
<c:forTokens items="빨강색,주황색.노란색.초록색,파랑색,남색.보라색" delims=",." var="token">
	${token }<br>
</c:forTokens>

</body>
</html>