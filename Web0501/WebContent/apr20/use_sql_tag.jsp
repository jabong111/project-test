<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>sql</title>
</head>
<body>
<sql:query var="rs" dataSource="jdbc:apache:commons:dbcp:/pool">
	select * from member_jabong111
</sql:query>

<table border="1">
	<tr>	
		<c:forEach var="columnName" items="${rs.columnNames }">
			<th><c:out value="${columnName}"/></th>
		</c:forEach>
	</tr>
	<c:forEach var="row" items="${rs.rowsByIndex }">
	<tr>
		<c:forEach var="column" items="${row }" varStatus="i">
		<td>
			<c:if test="${column != null }">
				<c:out value="${column }"/>
			</c:if>
			<c:if test="${column == null }">
				&nbsp;
			</c:if>
		</td>
		</c:forEach>
	</tr>
	</c:forEach>
</table>

</body>
</html>