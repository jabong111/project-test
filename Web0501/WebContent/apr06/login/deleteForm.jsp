<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function begin(){
			document.myform.passwd.focus();
		}
		
		function checkIt(){
			if(!document.myform.passwd.value){
				alert("비밀번호를 입력하지 않으셨습니다.");
				document.myform.passwd.focus();
				return false;
			}
		}
	</script>
</head>
<body onload="begin()" bgcolor="<%=bodyback_c%>">
<form action="deletePro.jsp" method="post" name="myform" onsubmit="return checkIt()">
	<table>
		<tr height="30">
			<td colspan="2" align="middle" bgcolor="<%=title_c%>">
				<font size="+1"><b>회원 탈퇴</b></font>
			</td> 
		</tr>
		<tr height="30">
			<td width="110" bgcolor="<%=value_c%>" align="center">비밀번호</td>
			<td width="150" align="center">
				<input type="password" name="passwd" size="15" maxlength="12">
			</td>
		</tr>	
		<tr height="30">
			<td colspan="2" align="middle" bgcolor="<%=value_c%>">
				<input type="submit" value="회원탈퇴">
				<input type="button" value="최 소" onclick="javascript:window.location='main.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>
















