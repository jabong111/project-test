<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>UPDATE FORM</title>
</head>
<body>
<form action="./update.jsp" method="post">
	<table border="1">
		<tr>
			<td>ID</td>
			<td><input type="text" name="id" size="10"></td>
			<td>NAME</td>
			<td><input type="text" name="name" size="10"></td>
		</tr>
		<tr>
			<td colspan="4" align="center"><input type="submit" value="modify"></td>
		</tr>
	</table>
</form>

</body>
</html>