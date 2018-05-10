/**
 * 
 */

function inputCheck(){
	var userinput = eval("document.regForm");
	if(userinput.id.value == ""){
		alert("you must input ID");
		userinput.id.focus();
		return false;
	}
	
	if(userinput.passwd.value==""){
		alert("you must input password");
		userinput.passwd.focus();
		return false;
	}
	if(userinput.repasswd.value==""){
		alert("you must insert repassword");
		userinput.repasswd.focus();
		return false;
	}
	
	if(userinput.name.value==""){
		alert("you must insert name");
		userinput.name.focus();
		return false;
	}
	
	if(userinput.email.value==""){
		alert("you must insert email");
		userinput.email.focus();
		return false;
	}
	if(userinput.tel.value==""){
		alert("you must insert telephone");
		userinput.tel.focus();
		return false;
	}
	
	if(userinput.passwd.value != userinput.repasswd.value){
		alert("password is not match!!");
		userinput.repasswd.focus();
		return false;
	}
	
	
	
	
	
}