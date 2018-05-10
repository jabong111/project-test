<%@page import="soldesk.logon.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.logon.LogonDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="member" class="soldesk.logon.LogonDataBean">
	<jsp:setProperty name="member" property="*"/>
</jsp:useBean>
<%
	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	LogonDBBean manager = LogonDBBean.getInstance();
	manager.insertMember(member);
	response.sendRedirect("loginForm.jsp");

%>
