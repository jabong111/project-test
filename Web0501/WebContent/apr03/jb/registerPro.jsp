<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="color.jsp" %>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="regBean" class="ssol.member.RegisterBean"></jsp:useBean>
<jsp:setProperty property="*" name="regBean"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>REGISTER INFORMATION</title>
<link href="sytyle.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="<%=back_c%>">
<table border="1" cellpadding="5" cellspacing="0" width="800">
	<colgroup>
		<col width="20%">
		<col width="*">
	</colgroup>
	<tr>
		<th colspan="2" align="center"><strong>REGISTER INFO</strong></th>
	</tr>
	<tr>
		<th bgcolor="<%=title_c%>">ID</th>
		<td bgcolor="<%=value_c%>"><%=regBean.getId()%></td>
	</tr>
	
	<tr>
		<th bgcolor="<%=title_c%>">PASSWORD</th>
		<td bgcolor="<%=value_c%>"><%=regBean.getPasswd()%></td>
	</tr>
	
	<tr>
		<th bgcolor="<%=title_c%>">REPASSWORD</th>
		<td bgcolor="<%=value_c%>"><%=regBean.getRepasswd()%></td>
	</tr>
	
	<tr>
		<th bgcolor="<%=title_c%>">NAME</th>
		<td bgcolor="<%=value_c%>"><%=regBean.getName()%></td>
	</tr>
	
	<tr>
		<th bgcolor="<%=title_c%>">E-MAIL</th>
		<td bgcolor="<%=value_c%>"><%=regBean.getEmail()%></td>
	</tr>
	
	<tr>
		<th bgcolor="<%=title_c%>">TELEPHONE</th>
		<td bgcolor="<%=value_c%>"><%=regBean.getTel()%></td>
	</tr>
</table>
</body>
</html>







