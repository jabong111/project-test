<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.board.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jsp" %>

<%!
	int pageSize=10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>
<%
	String pageNum = request.getParameter("pageNum");
	
	int searchn = 0; //ã���� Ű����
	String search = request.getParameter("search"); //ã�� �ܾ�
	System.out.println("search: "+search);
	if(pageNum == null){
		pageNum = "1";
	}
	
	if(search != null){	//�˻��� �ܾ ������
		searchn = Integer.parseInt(request.getParameter("searchn"));
	}
	System.out.println("searchn: "+searchn);
	
	int currentPage = Integer.parseInt(pageNum);
	//System.out.println(currentPage);
	int startRow = (currentPage*10)-9;	//1*10 - 9 = 1  2*10 - 9 = 11
	int endRow = currentPage*pageSize;	//1*10 = 10 2*10 = 20
	int count=0;
	int number=0;
	//list.jsp �� �������� �ٸ��ֱ����� jsp
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	CommentDBBean dbc = CommentDBBean.getInstance();
	
	if(search != null){	//ã�°� ������
		count = dbPro.getArticleCount(searchn, search);	//�ѱ��Ǽ�
	}else{ 
		count = dbPro.getArticleCount();
	}
	
	System.out.println("count: "+count);
	if(count>0){	//���� �ִٸ�
		if(search != null){
			articleList = dbPro.getArticles(startRow, endRow, searchn, search);
		}else{ //
			articleList = dbPro.getArticles(startRow, endRow);	//1~10 11~20 10���� �����ͺ��̽����� ��̸���Ʈ�� �޾ƿ´�.
		}
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
		<%if(session.getAttribute("memId")!=null){ %>
			<td align="left" bgcolor="<%=value_c%>">
				<%=session.getValue("memId") %> ��
				<a href="./login/logout.jsp">�α׾ƿ�</a>
			</td>
			<td align="right" bgcolor="<%=value_c%>">
			<a href="writeForm.jsp">�۾���</a>
			</td>
		<%}else{ %>
			<td align="right" bgcolor="<%=value_c%>">
			<a href="./login/loginForm.jsp">�α���</a>
			</td>
		<%} %>
	</tr>
</table>	
<%
	if(count == 0){	//���� ���ٸ�
%>
	<table width="700" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
			�Խ��ǿ� ����� ���� �����ϴ�.
			</td>
		</tr>
	</table>

<%}else{ //���� �ִٸ� %>
	<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
		<tr height="30" bgcolor="<%=value_c%>">
			<td align="center" width="50">�� ȣ</td>
			<td align="center" width="250">��   ��</td>
			<td align="center" width="100">�ۼ���</td>
			<td align="center" width="150">�ۼ���</td>
			<td align="center" width="50">�� ȸ</td>
			<td align="center" width="100">IP</td>
		</tr>
	<%
		for(int i=0;i<articleList.size();i++){			//���� �°� �����͸� �޾ƿͼ� 
			BoardDataBean article = (BoardDataBean)articleList.get(i);
			int comment_count = dbc.getCommentCount(article.getNum());
	%>
		<tr height="30">
		<td align="center" width="50"> <%=number-- %></td>
		<td width="250">
	<%
		int wid=0;
		if(article.getRe_level()>0){	//0���� ũ�� ����̸�
			wid=5*(article.getRe_level());		//�鿩���Ⱚ
	%>
		<img width="<%=wid %>" height="16" src="./images/level.gif">
		<img  src="./images/re.gif">
	<%}else{ //�����̸� %>	
		<img  src="./images/level.gif" width="<%=wid%>" height="16">
	<%} %>
	
		<% if(comment_count > 0){ %>	<!-- ����� ������ ��۰����� ȭ�鿡 �������ϰ�  -->
			<a href="content1.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
				<%=article.getSubject() %> [<%=comment_count %>]</a>
		<%}else{%>	<!-- ����� ������ 0�� �ߴ°� �ƴ϶� �ȶ߰� �Ѵ�.  -->
			<a href="content1.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
				<%=article.getSubject() %></a>		
		<%} %>					
		<%if(article.getReadcount() >= 20){ %>	<!-- hot������ �����ְ��ϱ����� -->
			<img  src="./images/hot.gif" border="0" height="16"><%} %></td>
			<td align="center" width="100">
			<a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>		<!-- mailto�� Ŭ�������� �ٷ� ������ �����ֱ����� -->
			<td align="center" width="150"><%=sdf.format(article.getReg_date()) %></td>
			<td align="center" width="50"><%=article.getReadcount() %></td>
			<td align="center" width="100"><%=article.getIp() %></td>
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
			<%if(search != null){ %>
				<a href="list_search.jsp?pageNum=<%=startPage - 5%>&searchn=<%=searchn%>&search=<%=search%>">[����]</a>
			<%}else{ %>
				<a href="list_search.jsp?pageNum=<%=startPage - 5%>">[����]</a>
			<%} %>
<%		} 
		
		for(int i=startPage; i<=endPage;i++){ %>
			<%if(search != null){%>			
				<a href="list_search.jsp?pageNum=<%=i%>&searchn=<%=searchn%>&search=<%=search%>">[<%=i %>]</a>
			<%}else{ %>
				<a href="list_search.jsp?pageNum=<%=i%>">[<%=i %>]</a>
			<%} %>
		<%}
		
		if(endPage < pageCouunt){	%>
			<%if(search != null){ %>
				<a href="list_search.jsp?pageNum=<%=startPage+5%>&searchn=<%=searchn%>&search=<%=search%>">[����]</a>
			<%}else{ %>
				<a href="list_search.jsp?pageNum=<%=startPage+5%>">[����]</a>
			<%} %>
	<%} %>	
<%}%>
<%if(session.getAttribute("memId") != null){ %>
	<form>
		<select name="searchn">
			<option value="0">�ۼ���</option>
			<option value="1">����</option>
			<option value="2">�۳���</option>
		</select>
		<input type="text" name="search">
		<input type="submit" value="�˻�">
	</form>
<%} %>

</center>
</body>
</html>

































