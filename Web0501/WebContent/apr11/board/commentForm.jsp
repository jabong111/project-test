<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.logon.*" %>
<%@ include file="./color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="./style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<%	
	try{
			//답글 작성시	..... content.jsp 에서부터 온다.
		int num = Integer.parseInt(request.getParameter("num")); //게시글 넘버
		int ref = Integer.parseInt(request.getParameter("ref")); //0
		int re_step = Integer.parseInt(request.getParameter("re_step")); //0
		int re_level = Integer.parseInt(request.getParameter("re_level")); //0
		int count = Integer.parseInt(request.getParameter("count"));
%>
<body bgcolor="<%=bodyback_c%>">
<center><b>답글쓰기</b>
	<br>
	<form action="contentPro.jsp" name="writeform" method="post" onsubmit="return writeSave()" >
		<input type="hidden" name="content_num" value="<%=num%>"> <!-- 글번호 -->
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
		<input type="hidden" name="count" value="<%=count%>">
		
		<table width="400" border="1" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
				<td width="330" align="left">
				<input type="text" size="10" maxlength="10" name="commenter"></td>
			</tr>
			<tr>
    			<td  width="70"  bgcolor="<%=value_c%>" align="center" >내 용</td>
    			<td  width="330" align="left">
    			 <textarea name="commentt" rows="13" cols="40"></textarea> </td>		
  			</tr>
			
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330" align="left"><input type="password" size="8" maxlength="12" name="passwd"></td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=value_c%>" align="center">
					<input type="submit" value="글쓰기">	<!-- writePro.jsp로 보내진다 -->
					<input type="reset" value="다시작성">
				</td>
			</tr>
		</table>
		<%
	}catch(Exception e){}
%>
	</form>

</body>
</html>