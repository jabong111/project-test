<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.logon.*" %>
<%@ include file="color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ����������</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function checkIt(){											
		var userinput = eval("document.userinput");
		if(!userinput.passwd.value){
			alert("��й�ȣ�� �Է��ϼ���");
			return false;
		}
		if(userinput.passwd.value != userinput.passwd2.value){
			alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
			return false;
		}
		if(!userinput.username.value){
			alert("����� �̸��� �Է��ϼ���");
			return false;
		}
		if(!userinput.jumin1.value || !userinput.jumin2.value){
			alert("�ֹι�ȣ�� �Է��ϼ���");
			return false;
		}
	}
	function zipCheck(){		//�ּҸ� üũ���ִ� �ڹٽ�ũ��Ʈ �ڵ�
		url = "ZipCheck.jsp?check=y";	//ZipCheck.jsp�� ������ �̵��ؼ� check���� y�� ������.
		window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");	//��â�� ����.
	}

</script>
<%@ include file="daumApi.jsp" %>
<%
	String id=request.getParameter("id");		//���ǰ��� �޾ƿ´�. 
	System.out.println("id: "+id);
	LogonDBBean manager = LogonDBBean.getInstance();	//LogonDBBean ��ü�� �����ؼ� ��� ������ �޾ƿ´��� LogonDataBean ���ο� ��ü�� �����ؼ� �ڹٺ� �ִ´�.
	LogonDataBean c = manager.getMember(id);	//�������ִ� Ŭ���̾�Ʈ���� ���̵��� �޾ƿͼ� LogonDataBean���κ��� ��� �ִ� ���� �޾ƿ´�.
try{
%>

</head>
<!-- ��ĥ�� �ִºκ��� inputâ�� �ְ� ����ġ�� �κ��� ���� �����ع�����. -->
<body bgcolor="<%=bodyback_c%>">
<form action="modifyPro.jsp" method="post" name="userinput" onsubmit="return checkIt()">
	<table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
		<tr>
			<td colspan="2" headers="39" bgcolor="<%=title_c%>" align="center">
			<font size="+1"><b>ȸ�� ��������</b></font></td>
		</tr>
		<tr>
			<td colspan="2" class="normal" align="center">ȸ���� ������ �����մϴ�.</td>
		</tr>
		<tr>
			<td width="200" bgcolor="<%=value_c%>"><b>���̵� �Է�</b></td>
			<td width="400" bgcolor="<%=value_c%>"></td>
		</tr>
		
		<tr>
			<td width="200">����� ID</td>
			<input type="hidden" name="id" value="<%=c.getId() %>" >
			<td width="400"><%=c.getId() %></td>
		</tr>
		
		<tr>
			<td width="200">��й�ȣ</td>
			<td width="400">
				<input type="password" name="passwd" size="10" maxlength="10" value="<%=c.getPasswd()%>">
			</td>
		</tr>
		<tr>
			<td width="200" bgcolor="<%=value_c%>"><b>�������� �Է�</b></td>
			<td width="400" bgcolor="<%=value_c%>"></td>
		</tr>
		<tr>
			<td width="200">����� �̸�</td>
			<td width="400"><input type="text" name="name" size="15" maxlength="20" value="<%=c.getName()%>"></td>
		</tr>
		<tr>
			<td width="200">�ֹε�Ϲ�ȣ</td>
			<td width="400">
				<%=c.getJumin1() %>-<%=c.getJumin2() %>
			</td>
		</tr>
		
		<tr>
			<td width="200">E-MAIL</td>
			<td width="400">
			<%if(c.getEmail()==null){ %>	<!--LogonDataBean c��ü�� ���ϰ��� �ִ��� ������ Ȯ���� ������ ���� ���س���   -->
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
			<td width="200">�����ȣ</td>
			<td width="400">
				<% if(c.getZipcode()==null){ %>
				<input type="text" id="sample6_postcode"  name="zipcode" size="7">
				<input type="button" value="����ã��" onclick="zipCheck()"><!-- ��ư������ ���ο�â�� ���ߵȴ�. �ּҸ� �˻��ϴ� ���ο�â zipCheck �ڹٽ�ũ��Ʈ �Լ��� �����ϰ� �ڹٽ�ũ��Ʈ �Լ��� ZipCheck.jsp������ �����ϴ� �Լ��̴�.-->
				<%}else{ %>
				<input type="text" id="sample6_postcode" name="zipcode" size="7" value="<%=c.getZipcode()%>">
				<input type="button" value="����ã��" onclick="DaumPostcode()">
				<%} %>
				�����ȣ�� �˻��ϼ���					
			</td>
		</tr>
			
		<tr>
			<td width="200">�ּ�</td>
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
				<input type="submit" name="modify" value="����">
				<input type="button" value="���" onclick="javascript:window.location='../list_member.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
<%}catch(Exception e){} %>
</html>






























