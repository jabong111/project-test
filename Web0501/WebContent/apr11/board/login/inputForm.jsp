<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>REGISTER</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function checkIt() {
		var userinput = eval("document.userinput");
		if(!userinput.id.value){
			alert("ID를 입력하세요");
			return false;
		}
		if(!userinput.passwd.value){
			alert("PASSWORD를 입력하세요");
			return false;
		}
		if(userinput.passwd.value != userinput.passwd2.value){
			alert("비밀번호를 동일하게 입력하세요");
			return false;
		}
		if(!userinput.username.value){
			alert("이름을 입력하세요");
			return false;
		}
		if(!userinput.jumin1.value || !userinput.jumin2.value){
			alert("주민등록번호를 입력하세요");
			return false;
		}
			
	}
		function openConfirmid(userinput){
			if(userinput.id.value == ""){
				alert("아이디를 입력하세요");
				return;
			}
			url = "confirmId.jsp?id="+userinput.id.value;
			open(url, "confirm","toolbar=no,  location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
		}
		
	function zipCheck(){
		url = "ZipCheck.jsp?check=y";
		window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
	}
	
</script>

</head>
<body bgcolor="<%=bodyback_c%>">
	<form action="./inputPro.jsp" method="post" name="userinput"
		onsubmit="return checkIt()">
		<table width="600" border="1" cellpadding="3" cellspacing="0"
			align="center">
			<tr>
				<td colspan="2" headers="39" align="center" bgcolor="<%=value_c%>">
					<font size="+1"><b>REGISTER</b></font>
				</td>
			</tr>
			<tr>
				<td width="200" bgcolor="<%=value_c%>"><b>ID</b></td>
				<td width="400" bgcolor="<%=value_c%>"></td>
			</tr>

			<tr>
				<td width="200">USER ID</td>
				<td width="400"><input type="text" name="id" size="10"
					maxlength="12"> <input type="button" name="confirm_id"
					value="ID중복확인" onclick="openConfirmid(this.form)"></td>
			</tr>
			<tr>
				<td width="200">PASSWORD</td>
				<td width="400"><input type="password" name="passwd" size="15"
					maxlength="12"></td>
			</tr>
			<tr>
				<td width="200">PASSWORD CONFIRM</td>
				<td width="400"><input type="password" name="passwd2" size="15"
					maxlength="12"></td>
			</tr>

			<tr>
				<td width="200" bgcolor="<%=value_c%>"><b>개인정보 입력</b></td>
				<td width="400" bgcolor="<%=value_c%>"></td>
			</tr>
			<tr>
				<td width="200">USER NAME</td>
				<td width="400"><input type="text" name="name" size="15"
					maxlength="10"></td>
			</tr>
			<tr>
				<td width="200">JUMIN</td>
				<td width="400"><input type="text" name="jumin1" size="7"
					maxlength="6"> -<input type="text" name="jumin2" size="7"
					maxlength="7"></td>
			</tr>
			<tr>
				<td width="200">E-MAIL</td>
				<td width="400"><input type="text" name="email" size="40"
					maxlength="30"></td>
			</tr>
			<tr>
				<td width="200">BLOG</td>
				<td width="400"><input type="text" name="blog" size="60"
					maxlength="50"></td>
			</tr>
			
			<tr>
				<td width="200">우편번호</td>
				<td>
					<input type="text" name="zipcode" size="7">
					<input type="button" value="우편찾기" onclick="zipCheck()"><!-- 버튼누르면 새로운창이 떠야된다. 주소를 검색하는 새로운창 zipCheck 자바스크립트 함수를 실행하고 자바스크립트 함수는 ZipCheck.jsp파일을 열게하는 함수이다.-->
					우편번호를 검색하세요					
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address" size="70"></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" bgcolor="<%=value_c%>"><input
					type="submit" name="confirm" value="apply"> <input
					type="reset" name="reset" value="reset"> <input
					type="button" value="가입안함"
					onclick="javascript:window.location='main.jsp'"></td>
			</tr>
		</table>
	</form>
</body>
</html>
































