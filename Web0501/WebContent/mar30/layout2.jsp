<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>layout2</title>
</head>
<body>
	<table width="400" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan="2">
				<jsp:include page="./module/top.jsp"></jsp:include>
			</td>
		</tr>
		<tr>
			<td>
				<jsp:include page="./module/left.jsp"></jsp:include>
			</td>
			<td width="300" valign="top">
				내용시작<br>
				layout2<br>
				내용끝<br>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<jsp:include page="./module/bottom.jsp"></jsp:include>
			</td>
		</tr>
	</table>

</body>
</html>