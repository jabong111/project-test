<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.IOException, java.io.FileReader"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ҽ� ����</title>
</head>
<body>
<%
	FileReader reader = null;
	try{
		String path = request.getParameter("path");
		reader = new FileReader(getServletContext().getRealPath(path));
%>
<pre>
�ҽ��ڵ�=<%=path%>
<c:set value="<%=reader %>" escapeXml="true"></c:set>
</pre>
<%}catch(IOException ex){ %>
����:<%=ex.getMessage() %>
<%
	}finally{
		if(reader != null){
			try{
				reader.close();
			}catch(IOException ex){}
		}
	}
%>
</body>
</html>