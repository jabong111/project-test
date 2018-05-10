<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:forward page="template.jsp">
	<jsp:param value="list_view.jsp" name="CONTENTPAGE"/>
</jsp:forward>


