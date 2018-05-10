<%@page import="com.sun.org.apache.bcel.internal.classfile.Field"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page errorPage="error_view.jsp" %>

<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>

<%@ page import="kh10.image.ImageUtil" %>
<%@ page import="kh10.image.FileUploadRequestWrapper" %>

<%@ page import="kh10.image.Theme" %>
<%@ page import="kh10.image.ThemeManager" %>
<%@ page import="kh10.image.ThemeManagerException" %>

<%
	FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(request,-1,-1,
			"C:\\Java\\App\\Web0426\\WebContent\\temp");
	HttpServletRequest tempRequest = request;
	request = requestWrap;
%>
<jsp:useBean id="theme" class="kh10.image.Theme">
	<jsp:setProperty name="theme" property="*"/>
</jsp:useBean>
<%
	FileItem imageFileItem = requestWrap.getFileItem("imageFile");
	String image = "";
	if(imageFileItem.getSize()>0){
		image = Long.toString(System.currentTimeMillis());
		
		File imageFile = new File("C:\\Java\\App\\Web0426\\WebContent\\image");
		if(imageFile.exists()){
			for(int i=0;true;i++){
				imageFile = new File("C:\\Java\\App\\Web0426\\WebContent\\image",image+"_"+i);
				if(!imageFile.exists()){
					image = image+"_"+i;
					break;
				}
			}
		}
		imageFileItem.write(imageFile);
		
		File destFile = new File("C:\\Java\\App\\Web0426\\WebContent\\image",image+".small.jpg");
		ImageUtil.resize(imageFile, destFile, 50, ImageUtil.RATIO);
	}
	
	theme.setRegister(new Timestamp(System.currentTimeMillis()));
	theme.setImage(image);

	ThemeManager manager = ThemeManager.getInstance();
	manager.insert(theme);
%>

<script>
	alert("새로운 이미지를 등록했습니다.");
	location.href = "list.jsp";
</script>

























































<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>