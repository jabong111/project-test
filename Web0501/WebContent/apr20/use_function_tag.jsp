<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>function</title>
</head>
<body>

<c:set var="str1" value="Functions <�±�>�� ����մϴ�. "/>
<c:set var="str2" value="���"/>
<c:set var="token" value="1,2,3,4,5,6,7,8,9,10 "/>

length(str1) = ${fn:length(str1)} <br>
toUpperCase(str1) = "${fn:toUpperCase(str1)}" <br>
toLowerCase(str1) = "${fn:toLowerCase(str1)}" <br>
substring(str1, 3, 6) = "${fn:substring(str1, 3, 6)}" <br>
substringAfter(str1, str2) = "${fn:substringAfter(str1, str2)}" <br>
substringBefore(str1, str2) = "${fn:substringBefore(str1, str2)}" <br>
trim(str1) = "${fn:trim(str1)}" <br>
replace(str1, src, dest) = "${fn:replace(str1, " ", "-")}" <br>
indexOf(str1, str2) = "${fn:indexOf(str1, str2)}" <br>
startsWith(str1, str2) = "${fn:startsWith(str1, 'Fun')}" <br>
endsWith(str1, str2) = "${fn:endsWith(str1, "�մϴ�.")}" <br>
contains(str1, str2) = "${fn:contains(str1, str2)}" <br>
containsIgnoreCase(str1, str2) = "${fn:containsIgnoreCase(str1, str2)}" <br>

<c:set var="array" value="${fn:split(tokens, ',')}" />

join(array, "-") = "${fn:join(array, "-")}" <br>
escapeXml(str1) = "${fn:escapeXml(str1)}" <br>


</body>
</html>