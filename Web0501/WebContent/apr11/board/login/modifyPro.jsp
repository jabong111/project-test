<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.logon.*" %>
<%@ include file="color.jsp" %>
<%request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="member" class="soldesk.logon.LogonDataBean">
	<jsp:setProperty property="*" name="member"/>
</jsp:useBean>

<%
	String id = request.getParameter("id");
	System.out.println("id: "+id);
	member.setId(id);
	LogonDBBean manager = LogonDBBean.getInstance();
	manager.updateMember(member);
%>
<link href="style.css" rel="stylesheet" type="text/css">
<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
	<tr bgcolor="<%=title_c%>">
		<td height="39" align="center">
		<font size="+1"><b>ȸ�������� �����Ǿ����ϴ�.</b></font></td>
	</tr>
	<tr>
		<td bgcolor="<%=value_c%>" align="center">
			<p>�Է��Ͻ� ������ ������ �Ϸ�Ǿ����ϴ�.</p>
		</td>
	</tr>
	<tr>
		<td bgcolor="<%=value_c%>" align="center">
		<form action="">
			<input type="button" value="��������" onclick="window.location='../list_member.jsp'">
		</form>
		5���Ŀ� �������� �̵��մϴ�.<meta http-equiv="Refresh" content="5;url=../list_member.jsp"> 
		</td>
	</tr>
</table>
