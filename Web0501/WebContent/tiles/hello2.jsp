<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
	request.setAttribute("greeting", "ȯ���մϴ�.");
%>
<tiles:insertDefinition name="hello2" />