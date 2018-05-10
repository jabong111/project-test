<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kh10.image.Theme"%>
<%@ page import="kh10.image.ThemeManager"%>
<%@ page import="kh10.image.ThemeManagerException"%>
<%@ page import="kh10.image.CommentDBBean" %>
<%@ page import="kh10.image.CommentDataBean" %>
<%@ page import="java.util.List" %>
<!-- 코멘트의 리스트를 뽑아와서 댓글을 보여준다. -->

<%
	
	String themeId = request.getParameter("id");	//글 아이디를 가져올 변수
	System.out.println("themeID: "+themeId);
	int contentId = Integer.parseInt(themeId);//게시글 아이디
	ThemeManager manager = ThemeManager.getInstance();
	Theme theme = manager.select(Integer.parseInt(themeId));	//아이디값에 해당하는 글 하나를 가져온다.
	CommentDBBean cdb = CommentDBBean.getInstance();
	int count =  cdb.getCommentCount(contentId);	//해당 글의 아이디값을 가져온다.
	List<CommentDataBean> commentList = cdb.getComments(contentId);	//게시글 쭉가져오기
	System.out.println("count: "+count);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>


<c:set var="theme" value="<%=theme%>" />
<c:if test="${empty theme }">
존재하지 않는 테마 이미지입니다
</c:if>
<c:if test="${! empty theme }">
	<table width="100%" border="1" cellpadding="1" cellspacing="0">
		<tr>
			<td>제목</td>
			<td>${theme.title }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${theme.name } <c:if test="${empty theme.email }">
					<a href="mailto:${theme.email }">[이메일]</a>
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
			<td>내용</td>
			<td><pre>${theme.content }</pre></td>
		</tr>
		<tr>
			<td colspan="2">
			<a href="javascript:goReply()">[답변]</a>
			<a href="javascript:goModify()">[수정]</a>
			<a href="javascript:goDelete()">[삭제]</a> 
			<a href="javascript:goList()">[목록]</a>
			</td>
		</tr>
		<form action="comment.jsp" method="post" name="comment" onsubmit="return writeSave()">		<!-- passwd,commentt,commenter,content_num,comment_num은 해당 글에서 카운트를 새서 보내준뒤 글에서 1씩 올린다. -->
			<input type="hidden" name="content_num" value="<%=contentId%>">
			<input type="hidden" name="comment_num" value="<%=count+1%>"> <!-- 이를 comment.jsp 로 보내서 해당 글의 있는 모든 댓글개수를 가져와서 댓글개수에서 1을 올려 1더해준다. -->
			
			<tr>
				<td colspan="2">
					작성자:<input type="text" name="commenter" size="5">
					비밀번호:<input type="password" name="passwd" size="5"><p>
				</td>	
			</tr>
			<tr>
				<td align="center">코멘트 작성</td>
				<td>
					<textarea cols="40" rows="6" name="commentt"></textarea>
					<input type="submit" value="코멘트달기">
				</td>
			</tr>
			
		</form>
	</table>
</c:if>
<!-- 댓글달기 보여주기 -->
<%if(count>0){ %>
	<p>
	<table width="500" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td>코멘트수:<%=count %></td>
		</tr>
		<%for(int i=0;i<count;i++){ %>
		<%CommentDataBean dbc = (CommentDataBean)commentList.get(i); %>
			<tr>
				<td align="left" size="250">
					<%=dbc.getCommenter() %>님</b>(<%=sdf.format(dbc.getReg_date()) %>)
				</td>
				<td align="right">접속IP:<%=dbc.getIp() %>
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
		 imgWin.document.write("<html><head><title>:*:*:*: 이미지상세보기 :*:*:*:*:*:*:</title></head>");
		 imgWin.document.write("<body topmargin=0 leftmargin=0>");
		 imgWin.document.write("<img src="+img+" onclick='self.close()' style='cursor:pointer;' title ='클릭하시면 창이 닫힙니다.'>");
		 imgWin.document.close();
	}
	function writeSave(){
		if(document.comment.commentt.value==""){
		  alert("댓글을 달아주세요");
		  document.comment.commentt.focus();
		  return false;
		}
	}
	function writeSave(){
		if(document.comment.commenter.value==""){
		  alert("작성자를 입력하십시요.");
		  document.comment.commenter.focus();
		  return false;
		}
	}
	function writeSave(){
		if(document.comment.passwd.value==""){
		  alert("비밀번호를 입력하세요");
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









