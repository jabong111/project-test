<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="javax.servlet.ServletException" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� �߻�</title>
</head>
<body>

������ �߻��Ͽ����ϴ�!<br><br>
���� �޽���:<%=exception.getMessage() %>
<% exception.printStackTrace(); %>
<p>
<%
	Throwable rootCause = null;
	if(exception instanceof ServletException){
		rootCause = ((ServletException)exception).getRootCause();
	}else{
		rootCause = exception.getCause();
	}
	if(rootCause != null){
		rootCause.printStackTrace();
		do{
			%>
			���� ����:<%=rootCause.getMessage() %><br>
			<%
				rootCause.getMessage();
		}while(rootCause != null);
	}
%>
</body>
</html>