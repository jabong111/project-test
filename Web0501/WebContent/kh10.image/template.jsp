<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page errorPage="error_view.jsp"%>
<html>
<head>
<title>�׸� ������</title>
<style>
A {
	color: blue;
	font-weight: bold;
	text-decoration: none
}

A:hover {
	color: blue;
	font-weight: bold;
	text-decoration: underling
}
</style>
</head>
<body>
	<table width="100%" border="1" cellpadding="2" cellspacing="0">
		<tr>
			<td><jsp:include page="top.jsp" flush="flase" /></td>
		</tr>
		<tr>
			<td>
				<!--  ����κ� ���� --> <jsp:include page="${param.CONTENTPAGE }"
					flush="false"></jsp:include> <!-- ����κ� �� -->
			</td>
		</tr>
		<tr>
			<td><jsp:include page="bottom.jsp" flush="false" /></td>
		</tr>

	</table>

</body>

</html>