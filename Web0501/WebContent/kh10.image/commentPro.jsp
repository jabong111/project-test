<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="kh10.image.CommentDataBean" %>
<%@ page import="kh10.image.CommentDBBean" %>
<%
	request.setCharacterEncoding("euc-kr");
 %>
 <%
 	int con_num = Integer.parseInt(request.getParameter("id"));//�Խñ� ���̵�
 	CommentDBBean cdb = CommentDBBean.getInstance();
 	List<CommentDataBean> commentList = cdb.getComments(con_num);	//�ش� �Խñۿ� �ִ� ��� �ڸ�Ʈ�� �� �����´�.
 	request.setAttribute("commentList", commentList);	//request������ �����ϰ� read_view.jsp�� ���̵𰪰� �����̷�Ʈ �Ѵ�.
 	
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