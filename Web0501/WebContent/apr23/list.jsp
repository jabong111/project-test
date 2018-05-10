<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.board.model.ArticleListModel" %>
<%@ page import="kh10.board.service.ListArticleService" %>

<%
	String pageNumberString = request.getParameter("p");	//request�������� p�� �޴´�.
	int pageNumber = 1;
	if(pageNumberString != null && pageNumberString.length() >0){
		pageNumber = Integer.parseInt(pageNumberString);
	}
	ListArticleService listService = ListArticleService.getInstance();	//���� ��ü�� �����
	ArticleListModel articleListModel = listService.getArticleList(pageNumber);
	request.setAttribute("listModel", articleListModel); //ArticleListModel ��ü�� listModel�̸����� ������ �����Ѵ�.
	
	if(articleListModel.getTotalPageCount()>0){		//�������� 0���� ũ��
		int beginPageNumber = (articleListModel.getRequestPage()-1)/10*10+1;
		int endPageNumber = beginPageNumber+9;
		if(endPageNumber > articleListModel.getTotalPageCount()){
			endPageNumber = articleListModel.getTotalPageCount();
		}
		request.setAttribute("beginPage", beginPageNumber);
		request.setAttribute("endPage",endPageNumber );
		
	}

%>
<jsp:forward page="list_view.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>