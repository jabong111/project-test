<%@page import="soldesk.logon.LogonDataBean"%>
<%@page import="soldesk.logon.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jsp" %>

<%!
	int pageSize=3;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>
<%
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	System.out.println(currentPage);
	int startRow = (currentPage*3)-2;	//1*10 - 9 = 1  2*10 - 9 = 11
	int endRow = currentPage*pageSize;	//1*10 = 10 2*10 = 20
	int count=0;
	int number=0;
	//list.jsp �� �������� �ٸ��ֱ����� jsp
	List memberList = null;
	LogonDBBean dbPro = LogonDBBean.getInstance();
	count = dbPro.getMemberCount();	//���ο���
	if(count>0){	//���� �ִٸ�
		memberList = dbPro.getMembers(startRow, endRow);	//1~10 11~20 10���� �����ͺ��̽����� ��̸���Ʈ�� �޾ƿ´�.
	}
	number=count-(currentPage-1)*pageSize;	//14 - (1-1)*10  14-(2-1)*10 = 4 ������������ ������ ����
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ��� </title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<center><b>�۸��(��ü ��:<%=count %>)</b>
<table width="700">
	<tr>
		<td align="right" bgcolor="<%=value_c%>">
		<a href="writeForm.jsp">�۾���</a>
		</td>
</table>	
<%
	if(count == 0){	//���� ���ٸ�
%>
	<table width="700" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
			ȸ���� �����ϴ�.
			</td>
		</tr>
	</table>

<%}else{ //���� �ִٸ� %>
	<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
		<tr height="30" bgcolor="<%=value_c%>">
			<td align="center" width="50">ID</td>
			<td align="center" width="250">PASSWORD</td>
			<td align="center" width="100">NAME</td>
			<td align="center" width="150">JUMIN</td>
			<td align="center" width="50">EMAIL</td>
			<td align="center" width="50">BLOG</td>
			<td align="center" width="50">REG_DATE</td>
			<td align="center" width="50">ZIPCODE</td>
			<td align="center" width="300">ADDRESS</td>
			<td align="center" width="100">����/����</td>
		</tr>
	<%
		for(int i=0;i<memberList.size();i++){			//���� �°� �����͸� �޾ƿͼ� 
			LogonDataBean member= (LogonDataBean)memberList.get(i);
	%>
		<tr height="30">
			<td align="center" width="50"><%=member.getId() %></td>
			<td align="center" width="250"><%=member.getPasswd() %></td>
			<td align="center" width="100"><%=member.getName() %></td>
			<td align="center" width="150"><%=member.getJumin1() %>-<%=member.getJumin2() %></td>
			<td align="center" width="50"><%=member.getEmail() %></td>
			<td align="center" width="50"><%=member.getBlog() %></td>
			<td align="center" width="50"><%=member.getReg_date() %></td>
			<td align="center" width="50"><%=member.getZipcode() %></td>
			<td align="center" width="300"><%=member.getAddress() %></td>
			<td align="center" width="100"><a href="./login/modifyForm.jsp?id=<%=member.getId() %>">����/</a><a href="./login/deleteForm.jsp?id=<%=member.getId()%>">����</a></td>
		</tr>
	<%} %>
	</table>
<%} %>

<%
	if(count>0){	//���� ������
		int pageCouunt = count/pageSize+(count%pageSize==0?0:1);	// 14/10+(14%10==0?) 1+0 = 1 	
		
		int startPage = (int)(currentPage/5)*5+1;	//(1/5)*5+1	����������=1  (2/5)*5+1 
		int pageBlock=5;
		int endPage = startPage + pageBlock-1;
		if(endPage>pageCouunt)	endPage = pageCouunt;
		
		if(startPage>5){%>
		<a href="list_member.jsp?pageNum=<%=startPage - 5%>">[����]</a>
<%		} 
		for(int i=startPage; i<=endPage;i++){ %>			
		<a href="list_member.jsp?pageNum=<%=i%>">[<%=i %>]</a>

		<%}
		if(endPage < pageCouunt){	%>
		<a href="list_member.jsp?pageNum=<%=startPage+5%>">[����]</a>
	<%} %>	
<%}%>


</center>
</body>
</html>

































