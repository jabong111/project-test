<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="euc-kr" %>
<html>
	<head>
		<title>합 구하기</title>
	</head>
	<body>
		<%
			int sum=0;
			for(int i=1;i<=100;i++){
				sum += i;
			}
			
		%>
		1~100까지 합은 <%=sum %> 입니다.</br>
		<%
			int sum2=0;
			for(int i=100;i<=200;i++){
				sum2 += i;
			}
			
		%>
		100~200까지 합은 <%=sum2 %>입니다.
		
		
	
	</body>


</html>
