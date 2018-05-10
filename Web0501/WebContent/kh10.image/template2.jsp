<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page errorPage="error_view.jsp"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
<title><tiles:getAsString name="title"/></title>
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
			<td><tiles:insertAttribute name="top"/></td>
		</tr>
		<tr>
			<td>
				<!--  내용부분 시작 -->
				<tiles:insertAttribute name="middle"/>
			</td>
		</tr>
		<tr>
			<td><tiles:insertAttribute name="bottom"/></td>
		</tr>

	</table>

</body>

</html>
