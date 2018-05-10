<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp"%>
<%@ page import="util.CookieBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MAIN</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function focusIt(){
		document.inform.id.focus();
	}
	
	function checkIt(){
		inputForm = eval("document.inform");
		if(!inputForm.id.value){
			alert("아이디를 입력하세요")
			inputForm.id.focus();
			return false;
		}
		if(!inputForm.passwd.value){
			alert("비밀번호를 입력하세요")
			inputForm.passwd.focus();
			return false;
		}
	}
<%CookieBox cookieBox = new CookieBox(request);%>
</script>
</head>
<%
	try{
		if(session.getAttribute("memId")==null){%>

	
<body onload="focusIt();" bgcolor="<%=bodyback_c%>">
	<table width="500"  cellpadding="0" cellspacing="0" align="center" border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">
				&nbsp; 
			</td>
			<form name="inform" method="post" action="./loginPro.jsp" onsubmit="return checkIt();">
			<td bgcolor="<%=title_c%>" width="100" align="right">ID</td>
			<td width="100" bgcolor="<%=value_c %>" >
			<%if(cookieBox.exists("ID")){ %>
				<input type="text" name="id" size="15" maxlength="10" value="<%=cookieBox.getValue("ID")%>"></td>
				<td><input type="checkbox" name="save" value="true" checked="checked"></td>
				<%}else{ %>
				<input type="text" name="id" size="15" maxlength="10"></td>
				<td><input type="checkbox" name="save" value="true"></td>
				<%} %>
		</tr>
		
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">MAIN</td>
			<td bgcolor="<%=title_c%>" width="100" align="right">PASSWORD</td>
			<td width="100" bgcolor="<%=value_c%>" colspan="2"><input type="password" name="passwd" size="15" maxlength="10"></td>
		</tr>
		
		<tr>
			<td colspan="3" bgcolor="<%=title_c%>" align="center">
				<input type="submit" name="Submit" value="login">
				<input type="button" value="register" onclick="javascript:window.location='inputForm.jsp'" >
				<input type="button" value="find_id" onclick="javascript:window.location='findidForm.jsp'">
				<input type="button" value="find_passwd" onclick="javascript:window.location='findpassForm.jsp'">
		</td></form></tr>
		
	</table>
	<%}else{ %>
		<table width="500" cellpadding="0" cellspacing="0" align="center" border="1">
			<tr>
				<td width="300" bgcolor="<%=bodyback_c%>" height="20">ggg</td>
				<td rowspan="3" bgcolor="<%=value_c%>" align="center">
					<%=session.getAttribute("memId") %> is coming<br>
					<form action="./logout.jsp" method="post">
					<input type="submit" value="logout">
					<input type="button" value="list" onclick="javascript:window.location='../list_search.jsp'">
					<input type="button" value="update" onclick="javascript:window.location='modify.jsp'">
					</form>
				</td>
			</tr>
			<tr>
				<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">MAIN</td>
			</tr>
		</table>
		<br>
<%} 
}catch(NullPointerException e){}%>
</body> 
</html>

































