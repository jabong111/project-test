<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
<title>쇼핑몰</title>
<script>
function check(){
	var id=joinform.MEMBER_ID.value;
	var password1=joinform.MEMBER_PW.value;
	var password2=joinform.MEMBER_PW2.value;	
	var email1=joinform.MEMBER_EMAIL1.value;
	var email2=joinform.MEMBER_EMAIL2.value;
	var phone=joinform.MEMBER_PHONE.value;
	var addr1=joinform.MEMBER_ADDR1.value;
	var addr2=joinform.MEMBER_ADDR2.value;
	var mobile=joinform.MEMBER_MOBILE.value;
	
	var forms = document.getElementById("joinform");

	if ((forms.MEMBER_NAME.value=="")||(forms.MEMBER_NAME.value.length<=1)){
		alert("이름을 제대로 입력해 주세요.");
		forms.MEMBER_NAME.focus();
         		return false;
	}
	if(id.length == 0){
		alert("아이디를 입력하세요.");
		joinform.MEMBER_ID.focus();
		return false;
	}
	if(password1.length == 0){
		alert("비밀번호를 입력하세요.");
		joinform.MEMBER_PW.focus();
		return false;
	} 
	if(password1 != password2){
		alert("비밀번호가 일치하지 않습니다.");
		joinform.MEMBER_PW.value="";
		joinform.MEMBER_PW2.value="";
		joinform.MEMBER_PW.focus();
		return false;
	}
	if((forms.MEMBER_JUMIN1.value=="")||(forms.MEMBER_JUMIN1.value.length<6)){
		alert("주민등록번호 앞의 6자리를 입력해 주세요.");
      	forms.MEMBER_JUMIN1.focus();
        return false;
 	}
 	if((forms.MEMBER_JUMIN2.value=="")||(forms.MEMBER_JUMIN2.value.length<7)){
		alert("주민등록번호 뒤의 7자리를 입력해 주세요.");
      	forms.MEMBER_JUMIN2.focus();
        return false;
	} 
	if(email1.length == 0 || email2.length ==0){
		alert("이메일을 제대로 입력하세요.");
		joinform.MEMBER_EMAIL1.focus();
		return false;
	}
	if(phone.length == 0){
		alert("집 전화를 입력하세요.");
		joinform.MEMBER_PHONE.focus();
		return false;
	} 
	if((forms.MEMBER_ZIPCODE1.value=="")||(forms.MEMBER_ZIPCODE1.value.length<3)){
		alert("우편번호 앞의 3자리를 입력해 주세요.");
      	forms.MEMBER_ZIPCODE1.focus();
        return false;
 	}
 	if((forms.MEMBER_ZIPCODE2.value=="")||(forms.MEMBER_ZIPCODE2.value.length<3)){
		alert("우편번호 뒤의 3자리 입력해 주세요.");
      	forms.MEMBER_ZIPCODE2.focus();
        return false;
	}  
	if(addr1.length == 0){
		alert("집 주소를 입력하세요.");
		joinform.MEMBER_ADDR1.focus();
		return false;
	} 
	if(addr2.length == 0){
		alert("상세 주소를 입력하세요.");
		joinform.MEMBER_ADDR2.focus();
		return false;
	} 
	if(mobile.length == 0){
		alert("휴대폰 번호를 입력하세요.");
		joinform.MEMBER_MOBILE.focus();
		return false;
	}
	
	return true;
}

function openConfirmId(joinform){			
	var id=joinform.MEMBER_ID.value;
	var url="./MemberIDCheckAction.me?MEMBER_ID="+joinform.MEMBER_ID.value;
	
	if(id.length == 0){
		alert("아이디를 입력하세요.");
		joinform.MEMBER_ID.focus();
		return false;
	}
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=400,height=200");
}

function openZipcode(joinform){			
	var url="./Zipcode.me"
	open(url, "confirm", "toolbar=no,location=no,"
						+"status=no,menubar=no,"
						+"scrollbars=yes,resizable=no,"
						+"width=410,height=400");
}	

function gNumCheck(){
	if(event.keyCode >=48 && event.keyCode <=57) {
		return true;
	}else{
		event.returnValue=false;	
	}
}		
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
	function DaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }
                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample_address2').focus();
            }
        }).open();
    }
</script> 

</head>
<body>
<table width="960" cellspacing="0" cellpadding="0" border="0" align="center">
	<tr>
	<td colspan=2>
	<!-- 회원가입 -->
	<form name="joinform" action="./MemberJoinAction.me" method="post" 
		onsubmit="return check()">		
	<p align="center">	
	<table border="1" width="80%" height="80%">
	<tr>
		<td width="17%" bgcolor="#f5f5f5">
			<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;이름</font>
		</td>
		<td>
			&nbsp;&nbsp;&nbsp;
			<input type="text" name="MEMBER_NAME" size="20"/>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5">
			<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;아이디</font>
		</td>
		<td>
			&nbsp;&nbsp;&nbsp;
			<input type="text" name="MEMBER_ID" size="10" maxlength=15/>
			<input type="button" name="confirm_id" value="중복확인" 
				onclick="openConfirmId(this.form)" />
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5">
			<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;비밀번호</font>
		</td>
		<td>
			&nbsp;&nbsp;&nbsp;
			<input type="password" name="MEMBER_PW" size="15"/>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5">
			<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 확인</font>
		</td>
		<td>
			&nbsp;&nbsp;&nbsp;
			<input type="password" name="MEMBER_PW2" size="15" />
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5">&nbsp;</td>
		<td>
		<font size="2">&nbsp;&nbsp;&nbsp;
		(아이디와 비밀번호는 문자와 숫자를 조합하여 2~12자리로 만들어 주세요)</font>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5">
			<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;주민등록번호</font>
		</td>
		<td>
			&nbsp;&nbsp;&nbsp;
			<input type="text" name="MEMBER_JUMIN1" size="12" 
				onkeypress="gNumCheck()" maxlength="6"/>-	
			<input type="text" name="MEMBER_JUMIN2" size="12" 
				onkeypress="gNumCheck()" maxlength="7"/>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5">
			<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;이메일 주소</font>
		</td>
		<td>
			&nbsp;&nbsp;&nbsp;
			<input type="text" name="MEMBER_EMAIL1" size="13"/>@
			<input type="text" name="MEMBER_EMAIL2" size="15"/> 
		</td>
		</tr>
		<tr>
		<td bgcolor="#f5f5f5">
		<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;메일 수신 여부</font>
		</td>
		<td>
		&nbsp;&nbsp;&nbsp;
		<input type="radio" name="MEMBER_EMAIL_GET" value="YES" checked/>
		<font size="2">수신</font>
		&nbsp;&nbsp;<input type="radio" name="MEMBER_EMAIL_GET" value="NO"/>
		<font size="2">수신 안함</font>
		</td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5">
				<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;집전화</font>
			</td>
			<td>
				&nbsp;&nbsp;&nbsp;
				<input type="text" name="MEMBER_PHONE" size="24"/>
			</td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5">
				<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;우편번호</font>
			</td>
			<td>
			&nbsp;&nbsp;&nbsp;
			<input type="text" id="sample6_postcode" name="MEMBER_ZIPCODE" size="7">
			<input type="button" value="우편번호 검색" onclick="DaumPostcode()">
			</td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5">
				<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;집주소</font>
			</td>
			<td>
				&nbsp;&nbsp;&nbsp;
				<input type="text" name="MEMBER_ADDR1" id="sample6_address" size="50" />
			</td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5">
				<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;상세주소</font>
			</td>
			<td>
				&nbsp;&nbsp;&nbsp;
				<input type="text" name="MEMBER_ADDR2" id="sample_address2" size="50" />
			</td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5">
				<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;휴대폰</font>
			</td>
			<td>
				&nbsp;&nbsp;&nbsp;
				<input type="text" name="MEMBER_MOBILE" size="24" />
				</td>
			</tr>
		</table>
		<table width="80%">
			<tr>
				<td align="center">
					<br/><input type="submit" value="확 인" />
				</td>
			</tr>
		</table>
		</form>
		<!-- 회원가입 -->	
		</td>
	</tr>
</table>
</body>
</html>