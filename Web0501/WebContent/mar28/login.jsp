<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 실패</title>
</head>
<body>
<%
	//String id = request.getParameter("memberId");
	request.setAttribute("name", "jihoon");
	//if(id.equals("jabong111")){
	//	response.sendRedirect("./now.jsp");
	//}else{
	//	out.print("아이디가 없습니다.");
	//}
	String name = (String)request.getAttribute("name");
		%>
	1231231<%= name %>123123123

</body>
</html>
