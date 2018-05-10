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
<c:catch var="ex">
name 파라미터의 값=<%=request.getParameter("name") %><br>
<%if(request.getParameter("name").equals("test")){ %>
	${param.name }은 test입니다.
<%} %>
</c:catch>
<p>
<c:if test="${ex != null }"> <!-- ex값은 예외가 발생하면 null이 아니게된다.  -->
예외가 발생하엿습니다<br>
</c:if>

</body>
</html>