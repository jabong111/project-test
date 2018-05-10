<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="soldesk.logon.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	String check = request.getParameter("check");
	String area3 = request.getParameter("area3");
	LogonDBBean manager = LogonDBBean.getInstance();
	Vector zipcodeList = manager.zipcodeRead(area3);
	int totalList = zipcodeList.size();
%>
<!-- �� �������� inputForm.jsp ���� ����˻���ư�� Ŭ���ҽ� �˾�â���� �ߴ��������̰�
	 �˻� �� �ּҸ� Ŭ���ϸ� â�� �ݤ��Ӱ� �ڵ������� �ּҰ� ������ �ȴ�.
	 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� ��ȣ �˻�</title>
<link href="./style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function dongCheck() {
		if(document.zipForm.area3.value==""){	//���̸��� ���� �ʾҴٸ� ��� ���д�.
			alert("���̸��� �Է��ϼ���");
			document.zipForm.area3.focus();
			return;
		}
		document.zipForm.submit();
	}
	
	function sendAddress(zipcode, area1, area2, area3, area4){
		 var address = area1+" "+area2+" "+area3+" "+area4;
		 opener.document.userinput.zipcode.value = zipcode; //�ּҸ� Ŭ���ҽ� �ڵ����� inputForm.jsp���Ͽ� �����ȣ�� �ּҸ� �����ִ� �ڹٽ�ũ��Ʈ �ڵ�
		 opener.document.userinput.address.value = address;
		 self.close();
	 }
</script>
</head>
<body bgcolor="#FFFFCC">
<center>	
	<b>�����ȣ ã��</b>
	<table>
		<form action="ZipCheck.jsp" name="zipForm" method="post">
			<tr>
				<td><br>
				���̸� �Է�:<input type="text" name="area3">
				<input type="button" value="�˻�" onclick="dongCheck();">
			</tr>
			<input type="hidden" name="check" value="n">
		</form>
		<%
			if(check.equals("n")){
		%>
		<%
				if(zipcodeList.isEmpty()){%>
					<tr><td align="center"><br>�˻��� ����� �����ϴ�.</td></tr>
				
				
				<%}else{ %>
				<tr><td align="center"><br>�ذ˻� ��, �Ʒ� �����ȣ�� Ŭ���ϸ� �ڵ����� �Էµ˴ϴ�.</td></tr>
				<%
					for(int i=0;i<totalList;i++){
						ZipcodeBean zipBean = (ZipcodeBean)zipcodeList.elementAt(i);	//���;ȿ� �ִ� �ּ� �����͸� �ϳ��ϳ� �ҷ��� �ڹٺ� �ִ´�.
						String tempZipcode = zipBean.getZipcode();
						String tempArea1 = zipBean.getArea1();
						String tempArea2 = zipBean.getArea2();
						String tempArea3 = zipBean.getArea3();
						String tempArea4 = zipBean.getArea4();
				%>
				<tr><td>
				<a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempArea1%>','<%=tempArea2%>','<%=tempArea3%>','<%=tempArea4%>')">
					<%=tempZipcode%> &nbsp <%=tempArea1%> &nbsp <%=tempArea2%> &nbsp <%=tempArea3%> &nbsp;
				</a><br>
				<%} %>
			<%} %>
		<%} %>
	</td></tr>
	<tr><td align="center"><br><a href="javascript:this.close();">�ݱ�</a></td></tr>
	</table>
</center>

</body>
</html>


























































