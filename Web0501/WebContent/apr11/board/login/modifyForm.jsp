<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.logon.*" %>
<%@ include file="color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원정보수정</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function checkIt(){											
		var userinput = eval("document.userinput");
		if(!userinput.passwd.value){
			alert("비밀번호를 입력하세요");
			return false;
		}
		if(userinput.passwd.value != userinput.passwd2.value){
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}
		if(!userinput.username.value){
			alert("사용자 이름을 입력하세요");
			return false;
		}
		if(!userinput.jumin1.value || !userinput.jumin2.value){
			alert("주민번호를 입렵하세요");
			return false;
		}
	}
	function zipCheck(){		//주소를 체크해주는 자바스크립트 코드
		url = "ZipCheck.jsp?check=y";	//ZipCheck.jsp로 페이지 이동해서 check값을 y로 보낸다.
		window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");	//새창을 연다.
	}

</script>
<%@ include file="daumApi.jsp" %>
<%
	String id=request.getParameter("id");		//세션값을 받아온다. 
	System.out.println("id: "+id);
	LogonDBBean manager = LogonDBBean.getInstance();	//LogonDBBean 객체를 생성해서 디비에 정보를 받아온다음 LogonDataBean 새로운 객체를 생성해서 자바빈에 넣는다.
	LogonDataBean c = manager.getMember(id);	//접속해있는 클라이언트에서 아이디값을 받아와서 LogonDataBean으로부터 디비에 있는 값을 받아온다.
try{
%>

</head>
<!-- 고칠수 있는부분은 input창을 넣고 못고치는 부분은 값을 고정해버린다. -->
<body bgcolor="<%=bodyback_c%>">
<form action="modifyPro.jsp" method="post" name="userinput" onsubmit="return checkIt()">
	<table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
		<tr>
			<td colspan="2" headers="39" bgcolor="<%=title_c%>" align="center">
			<font size="+1"><b>회원 정보수정</b></font></td>
		</tr>
		<tr>
			<td colspan="2" class="normal" align="center">회원의 정보를 수정합니다.</td>
		</tr>
		<tr>
			<td width="200" bgcolor="<%=value_c%>"><b>아이디 입력</b></td>
			<td width="400" bgcolor="<%=value_c%>"></td>
		</tr>
		
		<tr>
			<td width="200">사용자 ID</td>
			<input type="hidden" name="id" value="<%=c.getId() %>" >
			<td width="400"><%=c.getId() %></td>
		</tr>
		
		<tr>
			<td width="200">비밀번호</td>
			<td width="400">
				<input type="password" name="passwd" size="10" maxlength="10" value="<%=c.getPasswd()%>">
			</td>
		</tr>
		<tr>
			<td width="200" bgcolor="<%=value_c%>"><b>재인정보 입력</b></td>
			<td width="400" bgcolor="<%=value_c%>"></td>
		</tr>
		<tr>
			<td width="200">사용자 이름</td>
			<td width="400"><input type="text" name="name" size="15" maxlength="20" value="<%=c.getName()%>"></td>
		</tr>
		<tr>
			<td width="200">주민등록번호</td>
			<td width="400">
				<%=c.getJumin1() %>-<%=c.getJumin2() %>
			</td>
		</tr>
		
		<tr>
			<td width="200">E-MAIL</td>
			<td width="400">
			<%if(c.getEmail()==null){ %>	<!--LogonDataBean c객체의 메일값이 있는지 없는지 확인후 있으면 값을 정해놓고   -->
			<input type="text" name="email" size="40" maxlength="30">
			<%}else{ %>
				<input type="text" name="email" size="40" maxlength="30" value="<%=c.getEmail()%>">
			<%} %>
			</td>
		</tr>
		
		<tr>
			<td width="200">Blog</td>
			<td width="400">
			<%if(c.getBlog()==null){ %>
			<input type="text" name="blog" size="60" maxlength="50">
			<%}else{ %>
				<input type="text" name="blog" size="60" maxlength="50" value="<%=c.getBlog()%>">
			<%} %>
			</td>
		</tr>
		
		<tr>
			<td width="200">우편번호</td>
			<td width="400">
				<% if(c.getZipcode()==null){ %>
				<input type="text" id="sample6_postcode"  name="zipcode" size="7">
				<input type="button" value="우편찾기" onclick="zipCheck()"><!-- 버튼누르면 새로운창이 떠야된다. 주소를 검색하는 새로운창 zipCheck 자바스크립트 함수를 실행하고 자바스크립트 함수는 ZipCheck.jsp파일을 열게하는 함수이다.-->
				<%}else{ %>
				<input type="text" id="sample6_postcode" name="zipcode" size="7" value="<%=c.getZipcode()%>">
				<input type="button" value="우편찾기" onclick="DaumPostcode()">
				<%} %>
				우편번호를 검색하세요					
			</td>
		</tr>
			
		<tr>
			<td width="200">주소</td>
			<td	width="400">
			<%if(c.getAddress()==null){ %>
				<input type="text" id="sample6_address"  name="address" size="70">
			<%}else{ %>
				<input type="text" id="sample6_address" name="address" size="70" value="<%=c.getAddress()%>">
			<%} %>
			</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center" bgcolor="<%=value_c%>">
				<input type="submit" name="modify" value="수정">
				<input type="button" value="취소" onclick="javascript:window.location='../list_member.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
<%}catch(Exception e){} %>
</html>






























