<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="color.jsp" %>
<%@ page import="soldesk.logon.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name");
	String jumin1 = request.getParameter("jumin1");
	String jumin2 = request.getParameter("jumin2");
	
	LogonDBBean manager = LogonDBBean.getInstance();
	String findid = manager.findId(name, jumin1, jumin2);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ã�Ҵ� ���̵�!</title>
</head>
<body bgcolor="<%=bodyback_c%>">
	<%if(findid.equals("�ش� ������ ���̵� �����ϴ�.")){ %>
		�ش� ������ ���̵� �����ϴ�.
	<%}else{ %>
		ã���ô� ���̵�� <%=findid%>�Դϴ�.
	<%} %>
 
</body>
</html>