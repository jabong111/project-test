<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.logon.*" %>
<%@ include file="./color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="./style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<%	
	try{
			//��� �ۼ���	..... content.jsp �������� �´�.
		int num = Integer.parseInt(request.getParameter("num")); //�Խñ� �ѹ�
		int ref = Integer.parseInt(request.getParameter("ref")); //0
		int re_step = Integer.parseInt(request.getParameter("re_step")); //0
		int re_level = Integer.parseInt(request.getParameter("re_level")); //0
		int count = Integer.parseInt(request.getParameter("count"));
%>
<body bgcolor="<%=bodyback_c%>">
<center><b>��۾���</b>
	<br>
	<form action="contentPro.jsp" name="writeform" method="post" onsubmit="return writeSave()" >
		<input type="hidden" name="content_num" value="<%=num%>"> <!-- �۹�ȣ -->
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
		<input type="hidden" name="count" value="<%=count%>">
		
		<table width="400" border="1" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">�̸�</td>
				<td width="330" align="left">
				<input type="text" size="10" maxlength="10" name="commenter"></td>
			</tr>
			<tr>
    			<td  width="70"  bgcolor="<%=value_c%>" align="center" >�� ��</td>
    			<td  width="330" align="left">
    			 <textarea name="commentt" rows="13" cols="40"></textarea> </td>		
  			</tr>
			
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">��й�ȣ</td>
				<td width="330" align="left"><input type="password" size="8" maxlength="12" name="passwd"></td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=value_c%>" align="center">
					<input type="submit" value="�۾���">	<!-- writePro.jsp�� �������� -->
					<input type="reset" value="�ٽ��ۼ�">
				</td>
			</tr>
		</table>
		<%
	}catch(Exception e){}
%>
	</form>

</body>
</html>