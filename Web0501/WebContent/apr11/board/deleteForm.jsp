<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ include file="color.jsp" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="style.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
	function deleteSave(){
		if(document.delForm.passwd.value ==''){
			alert("비밀번호를 입력하세요/");
			document.delForm.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body bgcolor="<%=bodyback_c%>">
	<center><b>글삭제</b>
	<br>
	
	<!-- a href="delCommentForm.jsp?ctn=( dbc.getContent_num())%>& cmn= (dbc.getComment_num()) %>&p_num= ( pageNum) ">[삭제]</a>&nbsp; -->
	
	<form action="deletePro.jsp?pageNum=<%=pageNum %>" name="delForm" method="post" onsubmit="return deleteSave()">
		<table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
			<tr height="30">
				<td align="center" bgcolor="<%=value_c%>">
				<b>비밀번호를 입력해 주세요.</b></td>
			</tr>
			<tr height="30">
				<td align="center">비밀번호:
				<input type="password" name="passwd" size="8" maxlength="12">
				<input type="hidden" name="num" value="<%=num%>"></td>
			</tr>
			<tr height="30">
				<td align="center" bgcolor="<%=value_c%>">
					<input type="submit" value="글삭제">
					<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>
	</form>
	</center>
</body>
</html>












