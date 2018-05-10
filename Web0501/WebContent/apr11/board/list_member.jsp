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
	//list.jsp 는 페이지를 꾸며주기위한 jsp
	List memberList = null;
	LogonDBBean dbPro = LogonDBBean.getInstance();
	count = dbPro.getMemberCount();	//총인원수
	if(count>0){	//글이 있다면
		memberList = dbPro.getMembers(startRow, endRow);	//1~10 11~20 10개씩 데이터베이스에서 어레이리스트를 받아온다.
	}
	number=count-(currentPage-1)*pageSize;	//14 - (1-1)*10  14-(2-1)*10 = 4 다음페이지에 보여줄 숫자
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 </title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<center><b>글목록(전체 글:<%=count %>)</b>
<table width="700">
	<tr>
		<td align="right" bgcolor="<%=value_c%>">
		<a href="writeForm.jsp">글쓰기</a>
		</td>
</table>	
<%
	if(count == 0){	//글이 없다면
%>
	<table width="700" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
			회원이 없습니다.
			</td>
		</tr>
	</table>

<%}else{ //글이 있다면 %>
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
			<td align="center" width="100">수정/삭제</td>
		</tr>
	<%
		for(int i=0;i<memberList.size();i++){			//폼에 맞게 데이터를 받아와서 
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
			<td align="center" width="100"><a href="./login/modifyForm.jsp?id=<%=member.getId() %>">수정/</a><a href="./login/deleteForm.jsp?id=<%=member.getId()%>">삭제</a></td>
		</tr>
	<%} %>
	</table>
<%} %>

<%
	if(count>0){	//글이 있으면
		int pageCouunt = count/pageSize+(count%pageSize==0?0:1);	// 14/10+(14%10==0?) 1+0 = 1 	
		
		int startPage = (int)(currentPage/5)*5+1;	//(1/5)*5+1	시작페이지=1  (2/5)*5+1 
		int pageBlock=5;
		int endPage = startPage + pageBlock-1;
		if(endPage>pageCouunt)	endPage = pageCouunt;
		
		if(startPage>5){%>
		<a href="list_member.jsp?pageNum=<%=startPage - 5%>">[이전]</a>
<%		} 
		for(int i=startPage; i<=endPage;i++){ %>			
		<a href="list_member.jsp?pageNum=<%=i%>">[<%=i %>]</a>

		<%}
		if(endPage < pageCouunt){	%>
		<a href="list_member.jsp?pageNum=<%=startPage+5%>">[다음]</a>
	<%} %>	
<%}%>


</center>
</body>
</html>

































