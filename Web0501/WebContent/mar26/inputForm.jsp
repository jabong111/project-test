<%@ page language = "java" contentType="text/html; charset=EUC-KR"
	pageEncoding = "EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://
	www.o3.org/TR/html14/loose.dtd">
<html>
<head>
<meta http-equive = "Content-Type" content = "text.html; charset=EUC-KR">
<title>ȸ������</title>
<link href = "style.css" rel = "stylesheet " type="text/css"/>

<script type="text/javascript">
function checkIt(){		//�ڹٽ�ũ��Ʈ
	var userinput = eval("document.userinput");	//�Է��� �޴´�.
	if(!userinput.id.value){	//�Է¹��� �����Ͱ� ������ ����Ѵ�.
		alrt("ID�� �Է��ϼ���!");
		return false;
	}
	if(!userinput.passwd.value){
		alert("��й�ȣ�� �Է��ϼ���!");
		return false;
	}
	if(!userinput.name.value){
		alert("�̸��� �Է��ϼ���!");
		return false;
	}
	if(!userinput.jumin1.value || !userinput.jumin2.value){
		alert("�ֹι�ȣ�� �Է��ϼ���!");
		return false;
	}
}
</script>
</head>
<body>
<div id = "wrap">
	<form action="./inputPro.jsp" name = "userinput" onsubmit="return checkIt()" method="post">
		<h1>�ڡ�ȸ�����ԡڡ�</h1>
		<div id ="body">	
			<table width="500px;">
				<colgroup>
					<col width="20%"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<th colspan="2" class="subTitle">���̵� �Է�</th>
				</tr>
				<tr>
					<th>����� ID</th>
					<td>
						<input type = "text" name="id" maxlenth="12"/>
						<input type="button" name="confirm_if" value="ID �ߺ�Ȯ��" class="inputBtn" onclick="javascript:openConfirmid(this.form);"/></td>
				</tr>
				<tr>
					<th>��й�ȣ</th>
					<td><input type="password" name = "passwd" maxlength="12"/></td>
				</tr>
				<tr>
					<th>��й�ȣ Ȯ��</th>
					<td><input type="password" name="passwd2" maxlength="12"/></td>
				</tr>
					<th colspan="2" class="subTitle">�������� �Է�</th>
				</tr>
				<tr>
					<th>����� �̸�</th>
					<td><input type="text" name ="name" maxlength="10"/></td>
				</tr>
				<tr>
					<th>�ֹε�� ��ȣ</th>
					<td>
						<input type = "text" name = "jumin1" maxlenth="6"/> - 
						<input type ="password" name = "jumin2"	maxlength="7"/>
					</td>
				</tr>
				<tr>
					<th>E-MAIL</th>
					<td><input type ="text" name="email" class="w300" maxlength="30"/></td>
				</tr>
				<tr>
					<th>Blog</th>
					<td><input type="text" name="blog" class="w300" maxlength="50"/></td>
				</tr>
				<tr>
					<th>�����ȣ</th>
					<td>
						<input type="text" name="zipcode" /><input type="button" 
							value="�����ȣ �˻�" class="inputBtn" onclick="javascript:zipcheck();"/>
							<span>�����ȣ�� �Է��ϼ���</span>
					</td>
				</tr>
				<tr>
					<th>�ּ�</th>
					<td>
						<input type="text" name="address" class="w380"/>
						<span class=descB>�ּҸ� �Է��ϼ���.</span>
					</td>
				</tr>
			</table>
		</div>
		<div id="footer">
			<input type="submit" name="confirm" class="inputBtn" value="�� ��"/>
			<input type="reset" name="reset" class="inputBtn" value="�ٽ��Է�"/>
			<input type="button" value="�� ��" class="inputBtn" onclick="javascript:window.location='main.jsp'"/>
		</div>
	</form>
</div>
</body>
</html>































