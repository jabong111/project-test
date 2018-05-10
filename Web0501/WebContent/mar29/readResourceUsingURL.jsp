<%@page import="java.nio.Buffer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>어플리케이션 객체를 이용하여 URL로 자원 읽기</title>
</head>
<body>
	<%
		String resourcePath = "\\mar29\\message\\notice\\notice.txt";
		 BufferedReader br = null;
		 char[] buff = new char[512];
		 int len=-1;
		 
		 try{
			 URL url = application.getResource(resourcePath); //URL을 받아온다.
			 br = new BufferedReader(new InputStreamReader(url.openStream()));
			 while((len = br.read(buff)) != -1){
				 String str = new String(buff,0,len);
				 out.print(str);
			 }
		 }catch(IOException ioe){
			 
		 }finally{
			 try{
				 if(br != null)	br.close();
			 }catch(IOException ioe){
				 ioe.printStackTrace();
			 }
		 }
	
	%>

</body>
</html>