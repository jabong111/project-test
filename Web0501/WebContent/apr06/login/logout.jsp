<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	session.invalidate();	//세션의 연결을 끝낸다.
	response.sendRedirect("main.jsp");	//메인으로 돌려보낸다.
%>