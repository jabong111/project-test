<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="kh10.image.CommentDataBean" %>
<%@ page import="kh10.image.CommentDBBean" %>
<%
	request.setCharacterEncoding("euc-kr");
 %>
 <%
 	int con_num = Integer.parseInt(request.getParameter("id"));//게시글 아이디
 	CommentDBBean cdb = CommentDBBean.getInstance();
 	List<CommentDataBean> commentList = cdb.getComments(con_num);	//해당 게시글에 있는 모든 코멘트를 다 가져온다.
 	request.setAttribute("commentList", commentList);	//request영역에 저장하고 read_view.jsp로 아이디값과 리다이렉트 한다.
 	
 	String url = "read_view.jsp?id="+request.getParameter("id")+"";
 	response.sendRedirect(url);
 
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>