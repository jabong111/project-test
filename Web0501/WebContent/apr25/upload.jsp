<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.pds.service.AddPdsItemService" %>
<%@ page import="kh10.pds.file.FileSaveHelper" %>
<%@ page import="kh10.pds.model.AddRequest" %>
<%@ page import="kh10.pds.model.PdsItem" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<%
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if(!isMultipart){	//멀티파트폼이 아니면
		response.setStatus(HttpServletResponse.SC_BAD_REQUEST);//400ERROR
		return;
	}
	DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	List<FileItem> items = upload.parseRequest(request);
	
	AddRequest addRequest = new AddRequest();
	
	Iterator<FileItem> iter = items.iterator();
	while(iter.hasNext()){
		FileItem item = iter.next();
		if(item.isFormField()){
			String name = item.getFieldName();
			if(name.equals("description")){
				String value = item.getString("euc-kr");
				addRequest.setDescription(value);
			}
		}else{
			String name = item.getFieldName();
			if(name.equals("file")){
				String realPath = FileSaveHelper.save("C:\\Java\\pds", item.getInputStream());
				addRequest.setFileName(item.getName());
				addRequest.setFileSize(item.getSize());
				addRequest.setRealPath(realPath);
			}
		}
	}
	PdsItem pdsItem = AddPdsItemService.getInstance().add(addRequest);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>업로드 성공</title>
</head>
<body>
<%=pdsItem.getFileName() %>파일을 업로드 했습니다.
<br>
<a href="list.jsp">목록보기</a>
</body>
</html>