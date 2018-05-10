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
	//새글 작성시
	int num=0,ref=1,re_step=0,re_level=0;	//답글이 아니고 새글이면 num값은 0으로 DBbean에 보내지게 되고  insertArticle메서드에서 최신글보다+1된 num값을 부여받는다.
	// ref= 메인글과 답변글을 묶어준다.ㅌ
	// re_step=화면출력순서
	// re_level=메인글인지, 답변글인지를 구분해준다.  0,1
	String id = (String)session.getValue("memId");
	LogonDBBean m = LogonDBBean.getInstance();
	LogonDataBean c = m.getMember(id);
	try{
			//답글 작성시	..... content.jsp 에서부터 온다.
		if(request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num")); //4
			ref = Integer.parseInt(request.getParameter("ref")); //0
			re_step = Integer.parseInt(request.getParameter("re_step")); //0
			re_level = Integer.parseInt(request.getParameter("re_level")); //0
		}
			
%>
<body bgcolor="<%=bodyback_c%>">
<center><b>글쓰기</b>
	<br>
	<form action="writePro.jsp" name="writeform" method="post" onsubmit="return writeSave()" >
		<input type="hidden" name="num" value="<%=num%>">				<!-- hidden으로  writePro.jsp로 보낸다. -->
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
		
		<table width="400" border="1" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
			<tr>
				<td align="right" colspan="2" bgcolor="<%=value_c%>">
					<a href="list_search.jsp">글목록</a>
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
				<td width="330" align="left">
					<%if(session.getAttribute("memId") != null){ %>
						<input type="text" size="10" maxlength="10" name="writer" value="<%=c.getId()%>"></td>
					<%}else{ %>
						<input type="text" size="10" maxlength="10" name="writer"></td>
					<%} %>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
				<td width="330" align="left">
				<%if(request.getParameter("num")==null){ %>	<!-- 답글이 아니면 -->
					<input type="text" size="40" maxlength="50" name="subject"></td>
				<%}else{ %>	<!-- 답글이면 -->
					<input type="text" size="40" maxlength="50" name="subject" value="[답변]"></td>
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
    			<td  width="70"  bgcolor="<%=value_c%>" align="center" >내 용</td>
    			<td  width="330" align="left">
    			 <textarea name="content" rows="13" cols="40"></textarea> </td>		
  			</tr>
			
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330" align="left"><input type="password" size="8" maxlength="12" name="passwd"></td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=value_c%>" align="center">
					<input type="submit" value="글쓰기">	<!-- writePro.jsp로 보내진다 -->
					<input type="reset" value="다시작성">
					<input type="button" value="목록보기" onclick="window.location='list_search.jsp'">	<!-- list.jsp를 보여준다. -->
				</td>
			</tr>
		</table>
		<%
	}catch(Exception e){}
%>
	</form>

</body>
</html>