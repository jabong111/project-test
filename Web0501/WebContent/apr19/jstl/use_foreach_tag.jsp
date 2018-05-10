<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	HashMap<String, Object> mapData = new HashMap<String, Object>();
	mapData.put("name","Soldesk");
	mapData.put("today",new java.util.Date());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="intArray" value="<%=new int[] {1,2,3,4,5} %>"></c:set>
<c:set var="map" value="<%=mapData %>"></c:set>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>forEach</title>
</head>
<body>
<h4>1~100 sum</h4>
<c:set var="sum" value="0"></c:set> <!-- 변수이름:var 값:value -->
<c:forEach var="i" begin="1" end="100" step="2">
<c:set var="sum" value="${sum+i }"></c:set>
</c:forEach>
result:${sum }

<h4>구구단</h4>

<ul>
<c:forEach var="i" begin="1" end="9" step="1">
	<li>4*${i } = ${i*4 }
</c:forEach>
</ul>

<h4>int형 배열</h4>
<c:forEach var="i" items="${intArray}" begin="2" end="4" varStatus="status">
	${status.index }-${status.count }-[${i }]<br>
</c:forEach>

<h4>Map</h4>
<c:forEach var="i" items="${map }">
	${i.key } = ${i.value }<br>
</c:forEach>
</body>
</html>











