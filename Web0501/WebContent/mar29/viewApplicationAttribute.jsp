<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�⺻ ��ü �Ӽ� ����</title>
</head>
<body>
	<%
		Enumeration attrEnum = application.getAttributeNames();
		while(attrEnum.hasMoreElements()){
			String name = (String)attrEnum.nextElement();
			Object value = application.getAttribute(name);
		%>
			application �Ӽ�: <b><%=name %></b> = <%=value %> <br>
		<%	
		}
	%>

</body>
</html>