<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="color.jsp" %>
<%@ page import="soldesk.logon.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String jumin1 = request.getParameter("jumin1");
	String jumin2 = request.getParameter("jumin2");
	String findpasswd = "";
	
	LogonDBBean manager = LogonDBBean.getInstance();
	findpasswd = manager.findPass(id, name, jumin1, jumin2);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ã�Ҵ� ��й�ȣ!!</title>
</head>
<body bgcolor="<%=bodyback_c%>">
	<%if(findpasswd.equals("�ش� ������ ��й�ȣ�� �����ϴ�.")){ %>
		<p align="center">�ش� ������ ��й�ȣ�� �����ϴ�.</p>
	<%}else{ %>
		<p align="center">ã���ô� ��й�ȣ�� <%=findpasswd %> �Դϴ�.</p>
	<%} %>

</body>
</html>