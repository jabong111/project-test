<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ������</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
    
    function checkIt() {
        var userinput = eval("document.userinput");
        if(!userinput.id.value) {
            alert("ID�� �Է��ϼ���");
            return false;
        }
        
        if(!userinput.passwd.value ) {
            alert("��й�ȣ�� �Է��ϼ���");
            return false;
        }
        if(userinput.passwd.value != userinput.passwd2.value)
        {
            alert("��й�ȣ�� �����ϰ� �Է��ϼ���");
            return false;
        }
       
        if(!userinput.username.value) {
            alert("����� �̸��� �Է��ϼ���");
            return false;
        }
        if(!userinput.jumin1.value  || !userinput.jumin2.value )
        {
            alert("�ֹε�Ϲ�ȣ�� �Է��ϼ���");
            return false;
        }
    }

    // ���̵� �ߺ� ���θ� �Ǵ�
    function openConfirmid(userinput) {
        // ���̵� �Է��ߴ��� �˻�
        if (userinput.id.value == "") {
            alert("���̵� �Է��ϼ���");
            return;
        }
        // url�� ����� �Է� id�� �����մϴ�.
        url = "/Web0501/logon/confirmId.do?id=" + userinput.id.value ;
        
        // ���ο� �����츦 ���ϴ�.
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
				<font size="+1"><b>ȸ������</b></font>
			</td>
		</tr>
		<tr>
			<td width="200" bgcolor="${value_c }"><b>���̵� �Է�</b></td>
			<td width="400" bgcolor="${value_c }">&nbsp;</td>
		</tr>
		<tr>
			<td width="200">����� ID</td>
			<td width="400">
				<input type="text" name="id" size="10" maxlength="12">
				<input type="button" name="confirm_id" value="ID�ߺ�Ȯ��" onclick="openConfirmid(this.form)">
			</td>
		</tr>
		<tr>
			<td width="200">��й�ȣ</td>
			<td width="400">
				<input type="password" name="passwd" size="15" maxlength="12">
			</td>
		</tr>
		<tr>
			<td width="200">��й�ȣ Ȯ��</td>
			<td width="400">
				<input type="password" name="passwd2" size="15" maxlength="12">
			</td>
		</tr>
		<tr>
		 <td width="200">����� �̸�</td>
		 <td width="400">
		 	<input type="text" name="name" size="15" maxlength="10">
		 </td>
		</tr>
		<tr>
		 <td width="200">�ֹε�Ϲ�ȣ</td>
		 <td width="400">
		 	<input type="text" name="jumin1" size="7" maxlength="6">-
		 	<input type="text" name="jumin2" size="7" maxlength="7">
		 </td>
		</tr>
		<tr>
			<td width="200">�����ȣ</td>
			<td>
				<input type="text" name="zipcode" size="7" id="sample6_postcode">
				<input type="button" value="����ã��" onclick="DaumPostcode()">
				�����ȣ�� �˻��ϼ���.
			</td>
		<tr>
		<tr>
			<td>�ּ�</td>
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
				<input type="submit" name="confirm" value="���">
				<input type="reset" name="reset" value="�ٽ��Է�">
				<input type="button"  value="���" onclick="document.location.href='/Web0501/logon/main.do'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>





























