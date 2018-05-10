<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp" %>
<%@ page import="soldesk.logon.LogonDBBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ID 중복확인</title>
<link href="style.css" rel="stylesheet" type="text/css">
	<%request.setCharacterEncoding("euc-kr"); %>
	<%
		String id = request.getParameter("id");
		LogonDBBean manager = LogonDBBean.getInstance();
		int check = manager.confirmId(id);
	%>
</head>

<body bgcolor="<%= bodyback_c%>">
<%
	if(check ==1){
%>
	<table width="270" border="0" cellpadding="0" cellspacing="5" align="center">
		<tr bgcolor="<%=title_c%>">
			<td headers="39"><%=id %>이미 사용중인 아이디입니다.</td>
		</tr>
	</table>
	<form action="confirmId.jsp" name="checkForm" method="post">
		<table width="270" border="0" cellpadding="5" cellspacing="0" align="center">
			<tr>
				<td bgcolor="<%=value_c%>" align="center">
				다른 아이디를 선탯하세요.<p>
				<input type="text" size="10" maxlength="12" name="id">
				<input type="submit" value="ID중복확인">
				</td>
			</tr>
		</table>
	</form>

<%}else{ %>
	<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
		<tr bgcolor="<%=title_c%>">
			<td align="center">
				<p>입력하신<%=id %>는 사용하실 수 있는 ID입니다.</p>
				<input type="button" value="close" onclick="setid()">
			</td>
		</tr>
	</table>
<%} %>

</body>
</html>

<script language="javascript">
	function setid(){
		opener.document.userinput.id.value="<%=id%>";
		self.close();
	}
</script>































