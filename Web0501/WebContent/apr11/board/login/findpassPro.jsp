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
<title>찾았다 비밀번호!!</title>
</head>
<body bgcolor="<%=bodyback_c%>">
	<%if(findpasswd.equals("해당 정보의 비밀번호가 없습니다.")){ %>
		<p align="center">해당 정보의 비밀번호가 없습니다.</p>
	<%}else{ %>
		<p align="center">찾으시는 비밀번호는 <%=findpasswd %> 입니다.</p>
	<%} %>

</body>
</html>