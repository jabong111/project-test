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
	//���� �ۼ���
	int num=0,ref=1,re_step=0,re_level=0;	//����� �ƴϰ� �����̸� num���� 0���� DBbean�� �������� �ǰ�  insertArticle�޼��忡�� �ֽűۺ���+1�� num���� �ο��޴´�.
	// ref= ���α۰� �亯���� �����ش�.��
	// re_step=ȭ����¼���
	// re_level=���α�����, �亯�������� �������ش�.  0,1
	String id = (String)session.getValue("memId");
	LogonDBBean m = LogonDBBean.getInstance();
	LogonDataBean c = m.getMember(id);
	try{
			//��� �ۼ���	..... content.jsp �������� �´�.
		if(request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num")); //4
			ref = Integer.parseInt(request.getParameter("ref")); //0
			re_step = Integer.parseInt(request.getParameter("re_step")); //0
			re_level = Integer.parseInt(request.getParameter("re_level")); //0
		}
			
%>
<body bgcolor="<%=bodyback_c%>">
<center><b>�۾���</b>
	<br>
	<form action="writePro.jsp" name="writeform" method="post" onsubmit="return writeSave()" >
		<input type="hidden" name="num" value="<%=num%>">				<!-- hidden����  writePro.jsp�� ������. -->
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
		
		<table width="400" border="1" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
			<tr>
				<td align="right" colspan="2" bgcolor="<%=value_c%>">
					<a href="list_search.jsp">�۸��</a>
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">�̸�</td>
				<td width="330" align="left">
					<%if(session.getAttribute("memId") != null){ %>
						<input type="text" size="10" maxlength="10" name="writer" value="<%=c.getId()%>"></td>
					<%}else{ %>
						<input type="text" size="10" maxlength="10" name="writer"></td>
					<%} %>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">����</td>
				<td width="330" align="left">
				<%if(request.getParameter("num")==null){ %>	<!-- ����� �ƴϸ� -->
					<input type="text" size="40" maxlength="50" name="subject"></td>
				<%}else{ %>	<!-- ����̸� -->
					<input type="text" size="40" maxlength="50" name="subject" value="[�亯]"></td>
				<%} %>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">EMAIL</td>
				<%if(session.getAttribute("memId") != null){ %>
					<td width="330" align="left"><input type="text" size="40" maxlength="30" name="email" value="<%=c.getEmail()%>"></td>
				<%}else{ %>
					<td width="330" align="left"><input type="text" size="40" maxlength="30" name="email"></td>
				<%} %>
			</tr>
			<tr>
    			<td  width="70"  bgcolor="<%=value_c%>" align="center" >�� ��</td>
    			<td  width="330" align="left">
    			 <textarea name="content" rows="13" cols="40"></textarea> </td>		
  			</tr>
			
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">��й�ȣ</td>
				<td width="330" align="left"><input type="password" size="8" maxlength="12" name="passwd"></td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=value_c%>" align="center">
					<input type="submit" value="�۾���">	<!-- writePro.jsp�� �������� -->
					<input type="reset" value="�ٽ��ۼ�">
					<input type="button" value="��Ϻ���" onclick="window.location='list_search.jsp'">	<!-- list.jsp�� �����ش�. -->
				</td>
			</tr>
		</table>
		<%
	}catch(Exception e){}
%>
	</form>

</body>
</html>