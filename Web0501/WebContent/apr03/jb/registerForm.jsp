<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>REGISTER</title>
<link href="./style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./script.js""></script>
</head>
<body bgcolor="<%=bodyback_c%>">
<form action="./registerPro.jsp" method="post" name="regForm" onsubmit="return inputCheck()">
	<table border="1" cellpadding="5" cellspacing="0" width="800">
		<colgroup>
			<col width="20%">
			<col width="*">
			<col width="30%">
		</colgroup>
		<tr>
			<td colspan="3" align="center"><strong>REGISTER</strong></td>
		</tr>
		<tr>
			<th bgcolor="<%=title_c%>">ID</th>
			<td bgcolor="<%=value_c%>"><input type="text" name="id" size="20">></td>
			<td bgcolor="<%=value_c%>">insert id.</td>
		</tr>
		<tr>
			<th bgcolor="<%=title_c%>">PASSWORD</th>
			<td bgcolor="<%=value_c%>"><input type="password" name="passwd" size="20"></td>
			<td bgcolor="<%=value_c%>">isert password</td>
		</tr>
		<tr>
			<th bgcolor="<%=title_c%>">REPASSWORD</th>
			<td bgcolor="<%=value_c%>"><input type="password" name="repasswd" size="20"></td>
			<td bgcolor="<%=value_c%>">isert repassword</td>
		</tr>
		<tr>
			<th bgcolor="<%=title_c%>">NAME</th>
			<td bgcolor="<%=value_c%>"><input type="text" name="name" size="20"></td>
			<td bgcolor="<%=value_c%>">insert name</td>
		</tr>
		<tr>
			<th bgcolor="<%=title_c%>">E-MAIL</th>
			<td bgcolor="<%=value_c%>"><input type="text" name="email" size="20"></td>
			<td bgcolor="<%=value_c%>">insert email</td>
		</tr>
		<tr>
			<th bgcolor="<%=title_c%>">TELEPHONE</th>
			<td bgcolor="<%=value_c%>"><input type="text" name="tel" size="20"></td>
			<td bgcolor="<%=value_c%>">insert telephone</td>
		</tr>
		<tr>
			<td colspan="3" height="50" align="center"><input type="submit" value="register"/><input type="reset" value="again"></td>
		</tr>
	</table>
</form>
</body>
</html>















