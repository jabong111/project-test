/**
 * 
 */

function checkIt(){
	var userinput = eval("document.userinput");
	if(!userinput.id.value){
		alert("ID를 입력하세요");
		return false;
	}
	if(!userinput.passwd.value){
		alert("비밀번호를 입력하세요");
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
		alert("주민번호를 입력하세요");
		return false;
	}
}

function openConfirmid(userinput){
	if(userinput.id.value == ""){
		alert("아이디를 입력하세요");
		return;
	}
	url = "/Web0501/logon/confirmId.do?id="+userinput.id.value;
	open(url,"confirm","toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=550, height=200");
}