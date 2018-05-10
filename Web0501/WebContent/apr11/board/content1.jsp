<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ page import="soldesk.board.CommentDataBean" %>
<%@ page import="soldesk.board.CommentDBBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="./color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function writeSave(){
	if(document.comment.commentt.value==""){
		alert("��۳����� �Է��ϼ���.");
		document.comment.commentt.focus();
		return false;
	}
	
	if(document.comment.commenter.value==""){
		alert("��۳����� �Է��ϼ���.");
		document.comment.commenter.focus();
		return false;
	}
	
	if(document.comment.passwd.value==""){
		alert("��۳����� �Է��ϼ���.");
		document.comment.passwd.focus();
		return false;
	}
}
function zipCheck(){
	url = "ZipCheck.jsp?check=y";
	window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
}
function commentOfcomment(){
	url = "commentForm.jsp";
	window.open(url,"commnet","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
}
	

</script>
</head>	<!-- �� �ϳ��� ��񿡼� �����ͼ� �ڼ��� �����ش�. -->
<%
	int num = Integer.parseInt(request.getParameter("num"));	//list.jsp �κ��� ���� �޾ƿ´�.
	String pageNum = request.getParameter("pageNum");	//���� ����Ǿ��ִ� ������ �ѹ�
	int pageSize = 10;
	String cPageNum = request.getParameter("cPageNum");	//�ڸ�Ʈ�� ����Ǿ��ִ� ������ �Ѿ�
	if(cPageNum == null){		//�ڸ�Ʈ�������� ������ 1�������� �����Ѵ�.
		cPageNum = "1";
	}
	int cCurrentPage  = Integer.parseInt(cPageNum);	//�ڸ�Ʈ����������	����¡�� ���� ���� �ڸ�Ʈ������
	int startRow = (cCurrentPage * 10) - 9;	
	int endRow = cCurrentPage * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();	//BoardDBBean��ü�� �����ϰ�	
		BoardDataBean article = dbPro.getArticle(num);	//�� �ϳ��� �޾ƿ´�.
				
		CommentDBBean cdb = CommentDBBean.getInstance();	//CommentDBBean ��ü�� �����ϰ�
		
		ArrayList comments = cdb.getComments(article.getNum(), startRow, endRow);	//�ڸ�Ʈ���� �����´�. �Խñ��� �ѹ���  �����ð���
		int count = cdb.getCommentCount(article.getNum());	//�ڸ�Ʈ�� �� ��ִ��� �����´�.
		
		int ref = article.getRef();				
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
%>
<body bgcolor="<%=bodyback_c%>">
<center><b>�۳��� ����</b>
<br>
<form>
	<table width="500" border="1" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
		<tr height="30">
				<td align="center" width="125" bgcolor="<%=value_c%>">�۹�ȣ</td>
				<td align="center" width="125" align="center">
					<%=article.getNum() %></td>
				<td align="center" width="125" bgcolor="<%=value_c%>">��ȸ��</td>
				<td align="center" width="125" align="center">
					<%=article.getReadcount()%></td>
		</tr>
		
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c%>">�ۼ���</td>
			<td align="left" width="125" align="center">
				<%=article.getWriter() %></td>
			<td align="center" width="125" bgcolor="<%=value_c%>">�ۼ��� </td>
			<td align="center" width="125" align="center">
				<%=sdf.format(article.getReg_date()) %></td>
		</tr>
		
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c%>">������</td>
			<td align="center" width="375" align="center" colspan="3">
				<%=article.getSubject()%></td>
		</tr>
		
		<tr>
			<td align="center" width="125" bgcolor="<%=value_c%>">�۳���</td>
			<td align="left" width="375" colspan="3"><pre><%=article.getContent() %></pre></td>
		</tr>
		
		<tr height="30">
			<td colspan="4" bgcolor="<%=value_c%>" align="right">
			<input type="button" value="�ۼ���"
			 onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="�ۻ���"
			 onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="��۾���" 
			 onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref %>&re_step=<%=re_step %>&re_level=<%=re_level %>'"	>
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="�۸��" 
			 onclick="document.location.href='list_search.jsp?pageNum=<%=pageNum %>'"	>
			 </td>
		</tr>
		</form>
		<%
			int com_num=0,com_ref=1,com_step=0,com_level=0; 
		%>
		
		<form method="post" action="contentPro.jsp" name="comment" onsubmit="return writeSave()">	<!-- contentPro.jsp�� �Ѿ�� �Ķ����(commentt,content_num,p_num,comment_num,commenter,passwd) -->
			<tr bgcolor="<%=value_c%>" align="center">
				<td>�ڸ�Ʈ �ۼ�</td>
				<td colspan="2">
				 	<textarea rows="6" cols="40" name="commentt"></textarea>
				 	<input type="hidden" name="content_num" value="<%=article.getNum()%>">	<!-- �Խñ� ��ȣ -->
				 	<input type="hidden" name="p_num" value="<%=pageNum%>">	<!-- �������ѹ� ������ �ڸ�Ʈ �ް��� ������������ �����ϱ�����  -->
				 	<input type="hidden" name="comment_num" value="<%=com_num%>">	<!-- count+1; ���� �ڸ�Ʈ��ȣ�� 1������ ������ ���ο� �ڸ�Ʈ�� ��ȣ�� 1�ö󰣴�. -->
				 	<input type="hidden" name="ref" value="<%=com_ref%>">
				 	<input type="hidden" name="re_step" value="<%=com_step%>">
				 	<input type="hidden" name="re_level" value="<%=com_level%>">
				 	<input type="hidden" name="count" value="<%=count%>">
				</td>
				<td align="center">
					�ۼ���<br>
					<input type="text" name="commenter" size="10"><br>
					��й�ȣ<br>
					<input type="password" name="passwd" size="10"><p>
					<input type="submit" value="�ڸ�Ʈ�ޱ�">
				</td>
			</tr>
		</form>
	</table>
	<%if(count>0){ %>	<!-- �ڸ�Ʈ �޷������� -->
		<p>
		<table width="500" border="0" cellpadding="0" cellspacing="0" bgcolor="<%=bodyback_c%>" align="center">
			<tr>
				<td>�ڸ�Ʈ ��:<%=comments.size() %></td>
			</tr>
			<%for(int i=0;i<comments.size();i++){
				CommentDataBean dbc = (CommentDataBean)comments.get(i);
				int wid = 0;%>
				<tr>
				<%if(dbc.getRe_step() >0){
					wid=5*(dbc.getRe_step());%>	<!-- ����� ����� �޷�����  -->
					<td>
					<img width="<%=wid %>" height="16" src="./images/level.gif">
					<img  src="./images/re.gif">
					</td>
				<%}else{ %>
				
				<%} %>
					<td align="left" size="250" bgcolor="<%=value_c%>">
					&nbsp;<b><%=dbc.getCommenter() %>&nbsp;��</b>(<%=sdf.format(dbc.getReg_date()) %>)
					</td>
					<td align="right" size="250" bgcolor="<%=value_c%>">���� IP:<%=dbc.getIp() %>
					<a href="delCommentForm.jsp?ctn=<%=dbc.getContent_num()%>&cmn=<%=dbc.getComment_num() %>&p_num=<%=pageNum %>">[����]</a>&nbsp;
					<form action="commentForm.jsp" method="post">
						<input type="hidden" name="re_step" value="<%=dbc.getRe_step()%>">
						<input type="hidden" name="ref" value="<%=dbc.getRef()%>">
						<input type="hidden" name="re_level" value="<%=dbc.getRe_level()%>">
						<input type="hidden" name="num" value="<%=dbc.getComment_num()%>">
						<input type="hidden" name="count" value="<%=count%>">
						<input type="hidden" name="content_num" value="<%=dbc.getContent_num()%>">
						<input type="hidden" name="p_num" value="<%=pageNum%>">
						<input type="submit" value="[���]">
					</form>
					
					<!-- <a href="commentForm.jsp?ctn=<%=dbc.getContent_num()%>&num=<%=dbc.getComment_num() %>&ref=<%=dbc.getRef() %>
					&re_level=<%=dbc.getRe_level()%>&re_step=<%=dbc.getRe_step()%>&count=<%=count%>">[���]</a>&nbsp;-->
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left"><%=dbc.getCommentt() %></td>
			<% }%>
				</tr>
		</table>
		<table width="500" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c%>" align="center">
		<tr>
		<center>
		<%
			if(count >0){
				int pageCount = count/pageSize+(count%pageSize==0?0:1);
				int startPage=(int)(cCurrentPage/5)*5+1;
				int pageBlock=5;
				int endPage = startPage+pageBlock-1;
				if(endPage>pageCount)	endPage=pageCount;
				if(startPage>5){%>
				<a href="content1.jsp?num=<%=num%>&pageNum=<%=pageNum%>&cPageNum=<%=startPage-5%>">[����]</a>
				
		<%	}
			for(int i=startPage;i<=endPage;i++){%>
				<a href="content1.jsp?num=<%=num%>&pageNum=<%=pageNum%>&cPageNum=<%=i%>">[<%=i %>]</a>
<%
			}
			if(endPage<pageCount){%>
			<a href="content1.jsp?num=<%=num%>&pageNum=<%=pageNum%>&cPageNum=<%=startPage+5%>">[����]</a>
<%
			}
		}
%>		
		
		</center>
		</tr>
		</table>
	<%} %>
<%
	}catch(Exception e) {}
%>
</body>
</html>




















