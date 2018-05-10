<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="util.CookieBox" %>
<%
	String id = (String)request.getParameter("id");
	String password = (String)request.getParameter("password");
	String saveid = (String)request.getParameter("saveid");
	
	if(id.equals(password)){
		if(saveid.equals("save")){	//체크박스가체크되있으면 쿠키를 생성한다.
			response.addCookie(CookieBox.createCookie("id", id,"/",-1));
			response.addCookie(CookieBox.createCookie("password", password,"/",-1));
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 성공</title>
</head>
<body>
	<%=id %>로 로그인 했습니다.
</body>
</html>
<%
	}else{
%>
<script>
	alert("로그인 실패");
	history.go(-1);
</script>
<%
	}
%>