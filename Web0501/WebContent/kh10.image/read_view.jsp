<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kh10.image.Theme"%>
<%@ page import="kh10.image.ThemeManager"%>
<%@ page import="kh10.image.ThemeManagerException"%>
<%@ page import="kh10.image.CommentDBBean" %>
<%@ page import="kh10.image.CommentDataBean" %>
<%@ page import="java.util.List" %>
<!-- �ڸ�Ʈ�� ����Ʈ�� �̾ƿͼ� ����� �����ش�. -->

<%
	
	String themeId = request.getParameter("id");	//�� ���̵� ������ ����
	System.out.println("themeID: "+themeId);
	int contentId = Integer.parseInt(themeId);//�Խñ� ���̵�
	ThemeManager manager = ThemeManager.getInstance();
	Theme theme = manager.select(Integer.parseInt(themeId));	//���̵𰪿� �ش��ϴ� �� �ϳ��� �����´�.
	CommentDBBean cdb = CommentDBBean.getInstance();
	int count =  cdb.getCommentCount(contentId);	//�ش� ���� ���̵��� �����´�.
	List<CommentDataBean> commentList = cdb.getComments(contentId);	//�Խñ� �߰�������
	System.out.println("count: "+count);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>


<c:set var="theme" value="<%=theme%>" />
<c:if test="${empty theme }">
�������� �ʴ� �׸� �̹����Դϴ�
</c:if>
<c:if test="${! empty theme }">
	<table width="100%" border="1" cellpadding="1" cellspacing="0">
		<tr>
			<td>����</td>
			<td>${theme.title }</td>
		</tr>
		<tr>
			<td>�ۼ���</td>
			<td>${theme.name } <c:if test="${empty theme.email }">
					<a href="mailto:${theme.email }">[�̸���]</a>
				</c:if>
			</td>
		</tr>
		<c:if test="${! empty theme.image }">
			<tr>
				<td colspan="2" align="center">
				<a href="javascript:viewLarge('/Web0426/image/${theme.image }')">
				<img src="/Web0426/image/${theme.image }" onclick="doImgPop('/Web0426/image/${theme.image }')" width="150" border="0">
				<br>
				</a>
				</td>
			</tr>
		</c:if>

		<tr>
			<td>����</td>
			<td><pre>${theme.content }</pre></td>
		</tr>
		<tr>
			<td colspan="2">
			<a href="javascript:goReply()">[�亯]</a>
			<a href="javascript:goModify()">[����]</a>
			<a href="javascript:goDelete()">[����]</a> 
			<a href="javascript:goList()">[���]</a>
			</td>
		</tr>
		<form action="comment.jsp" method="post" name="comment" onsubmit="return writeSave()">		<!-- passwd,commentt,commenter,content_num,comment_num�� �ش� �ۿ��� ī��Ʈ�� ���� �����ص� �ۿ��� 1�� �ø���. -->
			<input type="hidden" name="content_num" value="<%=contentId%>">
			<input type="hidden" name="comment_num" value="<%=count+1%>"> <!-- �̸� comment.jsp �� ������ �ش� ���� �ִ� ��� ��۰����� �����ͼ� ��۰������� 1�� �÷� 1�����ش�. -->
			
			<tr>
				<td colspan="2">
					�ۼ���:<input type="text" name="commenter" size="5">
					��й�ȣ:<input type="password" name="passwd" size="5"><p>
				</td>	
			</tr>
			<tr>
				<td align="center">�ڸ�Ʈ �ۼ�</td>
				<td>
					<textarea cols="40" rows="6" name="commentt"></textarea>
					<input type="submit" value="�ڸ�Ʈ�ޱ�">
				</td>
			</tr>
			
		</form>
	</table>
</c:if>
<!-- ��۴ޱ� �����ֱ� -->
<%if(count>0){ %>
	<p>
	<table width="500" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td>�ڸ�Ʈ��:<%=count %></td>
		</tr>
		<%for(int i=0;i<count;i++){ %>
		<%CommentDataBean dbc = (CommentDataBean)commentList.get(i); %>
			<tr>
				<td align="left" size="250">
					<%=dbc.getCommenter() %>��</b>(<%=sdf.format(dbc.getReg_date()) %>)
				</td>
				<td align="right">����IP:<%=dbc.getIp() %>
			</tr>
			<tr>
				<td colspan="2" align="left"><%=dbc.getCommentt() %></td>
		<%} %>
		</tr>
	</table>
<%} %>


<script language="JavaScript">
	function goReply() {
		document.move.action = "writeForm.jsp";
		document.move.submit();
	}
	function goModify() {
		document.move.action = "updateForm.jsp";
		document.move.submit();
	}
	function goDelete() {
		document.move.action = "deleteForm.jsp";
		document.move.submit();
	}
	function goList() {
		document.move.action = "list.jsp";
		document.move.submit();
	}
	function doImgPop(img){ 
		 img1= new Image(); 
		 img1.src=(img); 
		 imgControll(img); 
		} 
		  
	function imgControll(img){ 
		 if((img1.width!=0)&&(img1.height!=0)){ 
		    viewImage(img); 
		  } 
		  else{ 
		     controller="imgControll('"+img+"')"; 
		     intervalID=setTimeout(controller,20); 
		  } 
		}
	function viewImage(img){ 
		 W=img1.width; 
		 H=img1.height; 
		 O="width="+W+",height="+H+",scrollbars=yes"; 
		 imgWin=window.open("","",O); 
		 imgWin.document.write("<html><head><title>:*:*:*: �̹����󼼺��� :*:*:*:*:*:*:</title></head>");
		 imgWin.document.write("<body topmargin=0 leftmargin=0>");
		 imgWin.document.write("<img src="+img+" onclick='self.close()' style='cursor:pointer;' title ='Ŭ���Ͻø� â�� �����ϴ�.'>");
		 imgWin.document.close();
	}
	function writeSave(){
		if(document.comment.commentt.value==""){
		  alert("����� �޾��ּ���");
		  document.comment.commentt.focus();
		  return false;
		}
	}
	function writeSave(){
		if(document.comment.commenter.value==""){
		  alert("�ۼ��ڸ� �Է��Ͻʽÿ�.");
		  document.comment.commenter.focus();
		  return false;
		}
	}
	function writeSave(){
		if(document.comment.passwd.value==""){
		  alert("��й�ȣ�� �Է��ϼ���");
		  document.comment.passwd.focus();
		  return false;
		}
	}
		
</script>
<form name="move" method="post">
	<input type="hidden" name="id" value="${theme.id }"> 
	<input type="hidden" name="parentId" value="${theme.id }">
	<inpit type="hidden" name="groupId" value="${theme.groupId }">
	<input type="hidden" name="page" value="${param.page }">
	<c:forEach var="searchCond" items="${paramValues.search_cond}">
		<c:if test="${searchCond == 'title' }">
			<input type="hidden" name="search_cond" value="title">
		</c:if>
		<c:if test="${searchCond == 'name' }">
			<input type="hidden" name="search_cond" value="name">
		</c:if>
	</c:forEach>
		 <c:if test="${! empty param.search_key }">
		<input type="hidden" name="search_key" value="${param.search_key }">
	</c:if>
</form>









