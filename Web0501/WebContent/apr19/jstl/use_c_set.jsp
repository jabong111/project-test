<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="member.*" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Member member = new Member();
	HashMap<String, String> pref = new HashMap<String, String>();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:set var="member" value="<%=member %>" scope="page"></c:set>
<c:set target="${member }" property="name" value="������"></c:set>	<!-- setName -->

<c:set var="pref" value="<%=pref %>"></c:set>
<c:set var="favoriteColor" value="#{pref.color}"></c:set>

ȸ���̸�:${member.name },	<!-- getName -->
�����ϴ� ��:${favoriteColor }

<br>
<c:set target="${pref }" property="color" value="red"></c:set>

���� ���� �����ϴ� ��:${favoriteColor }
</body>
</html>