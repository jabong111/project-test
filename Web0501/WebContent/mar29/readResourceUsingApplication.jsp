<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>어플리케이션 기본 객체를 이용하여 자원 읽기</title>
</head>
<body>
	<%
		String resourcePath = "\\mar29\\message\\notice\\notice.txt";
	%>
	자원의 실제 경로:<br> <!-- 어플리게이션 객체를 이용하여 상대경로를 받아들여 절대경로를 얻는다. -->
	<%=application.getRealPath(resourcePath) %>
	<br>
	----------<br>
	<%=resourcePath %>의 내용<br> <!-- message디렉토리가 같은 경로안에 있으므로 여기서부터 적어주는것이 상대경로가 된다. -->
	----------<br>
	
	<%
		BufferedReader br = null;
		char[] buff = new char[512];
		int len = -1;
		
		try{
			br = new BufferedReader(new InputStreamReader(application.getResourceAsStream(resourcePath)));
			while((len = br.read(buff)) != -1){
				out.print(new String(buff,0,len));
			}
		}catch(IOException ioe){
			ioe.printStackTrace();
		}finally{
			
		}
	%>
	
	
	
</body>
</html>