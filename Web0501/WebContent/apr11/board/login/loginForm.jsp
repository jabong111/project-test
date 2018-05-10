<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp" %>
<%@ page import="util.CookieBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>LOGIN</title>
<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function begin(){
			document.myform.id.focus();
		}
		function checkIt(){
			if(!document.myform.id.value){
				alert("이름을 입력하지 않으셨습니다.");
				document.myform.id.focus();
				return false;
			}
			if(!document.myform.passwd.value){
				alert("비밀번호를 입력하지 않르셨습니다.");
				document.myform.passwd.focus();
				return false;
			}
		}
	</script>
</head>
<%
	CookieBox cookiebox = new CookieBox(request);
%>
<body onload="begin()" bgcolor="<%=bodyback_c%>">
	<form action="loginPro.jsp" name="myform" method="post" onsubmit="return checkIt()">
		<table cellspacing="1" cellpadding="1" width="260" border="1" align="center">
			<tr height="30">
				<td colspan="3" align="middle" bgcolor="<%=title_c%>"><strong>회원로그인</strong></td>
			</tr>
			<tr height="30">
				<td width="110" bgcolor="<%=title_c%>" align="center">ID</td>
				<td width="150" bgcolor="<%=value_c%>" align="center">
				<%if(cookiebox.exists("ID")){ %>
					<input type="text" name="id" size="15" maxlength="12" value="<%=cookiebox.getValue("ID") %>" align="left" >
					<td><input type="checkbox" name="save" value="true" checked="checked"></td>
					<%}else{ %>
					<input type="text" name="id" size="15" maxlength="12" align="left">
					<td><input type="checkbox" name="save" value="true" ></td>
					<%} %>
				</td>
			</tr>
			
			<tr height="30">
				<td width="110" bgcolor="<%=title_c%>" align="center">PASSWORD</td>
				<td width="150" bgcolor="<%=value_c%>" align="center" colspan="2">
				<input type="password" name="passwd" size="15" maxlength="12" align="left"></td>
			</tr>
			
			<tr height="30">
				<td colspan="3" align="middle" bgcolor="<%=title_c%>">
				<input type="submit" value="login">
				<input type="reset" value="reset">
				<input type="button" value="find_id" onclick="javascript:window.location='findidForm.jsp'">
				<input type="button" value="find_passwd" onclick="javascript:window.location='findpassForm.jsp'">
				<input type="button" value="register" onclick="javascript:window.location='inputForm.jsp'">
				
				</td>
			</tr>
		</table>
	</form>
</body>
</html>






























