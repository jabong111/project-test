<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� ��θ� ����Ϸ� �ڿ� �б�</title>
</head>
<body>
	<%
		FileReader fr = null;
		char[] buff = new char[512];
		int len = -1;
		try{
			fr = new FileReader("C:\\Java\\App\\Web\\WebContent\\mar29\\message\\notice\\notice.txt");
			while((len = fr.read(buff)) != -1){ //�ƹ����� ������ len�� -1�̰� ���� ������ -1�� �ƴϴ�.		
				String str = new String(buff,0,len);
				out.print(str);
			}
		}catch(IOException ioe){
			ioe.printStackTrace();
		}finally{
			try{
				if(fr != null)	fr.close();
			}catch(IOException ioe){
				ioe.printStackTrace();
			}
		}
	
	%>

</body>
</html>