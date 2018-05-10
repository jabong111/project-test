<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="memberInfo" class="member.MemberInfo" scope="request"></jsp:useBean>
<jsp:setProperty property="*" name="memberInfo"/>
<jsp:setProperty property="password" name="memberInfo" value="<%=memberInfo.getId()%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>REGISTER</title>
</head>
<body>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td>ID</td>
			<td><%=memberInfo.getId() %></td>
			<td>PASSWORD</td>
			<td><%=memberInfo.getPassword() %></td>
		</tr>
		<tr>
			<td>NAME</td>
			<td><%=memberInfo.getName() %></td>
			<td>EMAIL</td>
			<td><%=memberInfo.getEmail() %></td>
		</tr>
		<tr>
			<td>ADDRESS</td>
			<td colspan="3"><%=memberInfo.getAddress() %></td>
		</tr>
	</table>
</body>
</html>