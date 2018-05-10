<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>업로드 정보</title>
</head>
<body>
<%
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if(isMultipart){
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		List<FileItem> items = upload.parseRequest(request);
		
		Iterator<FileItem> iter = items.iterator();
		while(iter.hasNext()){
			FileItem item = iter.next();
			if(item.isFormField()){
				String name = item.getFieldName();
				String value = item.getString("euc-kr");
				%>
				요청 파라미터:<%=name %>=<%=value %><br>
		<%}else{
			String name = item.getFieldName();
			String fileName = item.getName();
			String contentType = item.getContentType();
			boolean isInMemory = item.isInMemory();
			long sizeInBytes = item.getSize();
			%>
			파일:<%=name %>,<%=fileName%>, <%=sizeInBytes %>,<%=isInMemory?"메모리저장":"임시파일저장" %>
			<br>
			
			<%
			}
		}
	}else{
		
		%>
		multipart/form 요청이 아님
		<%
	}


%>

</body>
</html>