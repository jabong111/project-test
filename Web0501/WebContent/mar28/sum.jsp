<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="euc-kr" %>
<html>
	<head>
		<title>�� ���ϱ�</title>
	</head>
	<body>
		<%
			int sum=0;
			for(int i=1;i<=100;i++){
				sum += i;
			}
			
		%>
		1~100���� ���� <%=sum %> �Դϴ�.</br>
		<%
			int sum2=0;
			for(int i=100;i<=200;i++){
				sum2 += i;
			}
			
		%>
		100~200���� ���� <%=sum2 %>�Դϴ�.
		
		
	
	</body>


</html>
