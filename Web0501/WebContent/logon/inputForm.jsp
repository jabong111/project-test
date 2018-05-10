<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
    
    function checkIt() {
        var userinput = eval("document.userinput");
        if(!userinput.id.value) {
            alert("ID를 입력하세요");
            return false;
        }
        
        if(!userinput.passwd.value ) {
            alert("비밀번호를 입력하세요");
            return false;
        }
        if(userinput.passwd.value != userinput.passwd2.value)
        {
            alert("비밀번호를 동일하게 입력하세요");
            return false;
        }
       
        if(!userinput.username.value) {
            alert("사용자 이름을 입력하세요");
            return false;
        }
        if(!userinput.jumin1.value  || !userinput.jumin2.value )
        {
            alert("주민등록번호를 입력하세요");
            return false;
        }
    }

    // 아이디 중복 여부를 판단
    function openConfirmid(userinput) {
        // 아이디를 입력했는지 검사
        if (userinput.id.value == "") {
            alert("아이디를 입력하세요");
            return;
        }
        // url과 사용자 입력 id를 조합합니다.
        url = "/Web0501/logon/confirmId.do?id=" + userinput.id.value ;
        
        // 새로운 윈도우를 엽니다.
        open(url, "confirm", 
        "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=550, height=200");
    }
</script>
<%@ include file="daumApi.jsp" %>
</head>
<body bgcolor="${bodyback_c }">
<form action="/Web0501/logon/inputPro.do" name="userinput" onsubmit="return checkIt()" method="post">
	<table width="600" border="1" cellpadding="0" cellspacing="3" align="center">
		<tr>
			<td colspan="2" headers="39" align="center" bgcolor="${value_c }">
				<font size="+1"><b>회원가입</b></font>
			</td>
		</tr>
		<tr>
			<td width="200" bgcolor="${value_c }"><b>아이디 입력</b></td>
			<td width="400" bgcolor="${value_c }">&nbsp;</td>
		</tr>
		<tr>
			<td width="200">사용자 ID</td>
			<td width="400">
				<input type="text" name="id" size="10" maxlength="12">
				<input type="button" name="confirm_id" value="ID중복확인" onclick="openConfirmid(this.form)">
			</td>
		</tr>
		<tr>
			<td width="200">비밀번호</td>
			<td width="400">
				<input type="password" name="passwd" size="15" maxlength="12">
			</td>
		</tr>
		<tr>
			<td width="200">비밀번호 확인</td>
			<td width="400">
				<input type="password" name="passwd2" size="15" maxlength="12">
			</td>
		</tr>
		<tr>
		 <td width="200">사용자 이름</td>
		 <td width="400">
		 	<input type="text" name="name" size="15" maxlength="10">
		 </td>
		</tr>
		<tr>
		 <td width="200">주민등록번호</td>
		 <td width="400">
		 	<input type="text" name="jumin1" size="7" maxlength="6">-
		 	<input type="text" name="jumin2" size="7" maxlength="7">
		 </td>
		</tr>
		<tr>
			<td width="200">우편번호</td>
			<td>
				<input type="text" name="zipcode" size="7" id="sample6_postcode">
				<input type="button" value="우편찾기" onclick="DaumPostcode()">
				우편번호를 검색하세요.
			</td>
		<tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="address" size="70" id="sample6_address"></td>
		</tr>
		
		<tr>
			<td width="200">E-mail</td>
			<td width="400">
				<input type="text" name="email" size="40" maxlength="30">
			</td>
		</tr>
		<tr>
			<td width="200">Blog</td>
			<td width="400">
				<input type="text" name="blog" size="60" maxlength="50">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="${value_c }">
				<input type="submit" name="confirm" value="등록">
				<input type="reset" name="reset" value="다시입력">
				<input type="button"  value="등록" onclick="document.location.href='/Web0501/logon/main.do'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>





























