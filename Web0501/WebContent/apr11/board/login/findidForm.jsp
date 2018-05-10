<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="color.jsp" %>
<%@ page import="soldesk.logon.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>FIND ID</title>
</head>
<body bgcolor="<%=bodyback_c%>">
<center>
	<form action="./findidPro.jsp" method="post">
		<table border="1" cellpadding="3" cellspacing="0">
			<tr>
				<td>NAME</td>
				<td><input type="text" name="name" size="10"></td>
			</tr> 
			
			<tr>
				<td>주민번호</td>
				<td>
					<input type="text" name="jumin1" size="10"> - <input type="text" name="jumin2" size="10">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="find" >
					<input type="reset" value="reset" >
					<input type="button" value="main" onclick="javascript:window.location='main.jsp'" >
				</td>
			</tr>
		</table>	
	</form>
</center>
</body>
</html>