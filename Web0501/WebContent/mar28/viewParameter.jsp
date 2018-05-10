<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Map" %>
<%
	request.setCharacterEncoding("euc-kr"); //클라이언트에서 받아온 데이터를 인코딩한다.
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>요청 파라미터</title>
</head>
<body>
	<b>request.getParamether() 메소드 사용</b><br>
	name 파라미터: <%=request.getParameter("name") %><br>	<!-- 네임값을 바로 받아온다 -->
	address 파라미터: <%=request.getParameter("address") %> <!-- 주소값을 바로 받아온다. -->
	<p>
	<b>request.getParameter() 메소드 사용</b><br>		
	<%	
		String[] values = request.getParameterValues("pet");//펫에 해당하는 value를 배열에 넣는다.
		if(values != null){
			for(int i=0;i<values.length;i++){
				%>
				<%= values[i]%>
	<%
			}
		}
	%>
	<p>
	<b>request.getParameterNames() 메서드 사용</b><br>
	<%
		Enumeration paramEnum = request.getParameterNames();	//이뉴머레이션객체에 name 값들을 다 넣는다.
		while(paramEnum.hasMoreElements()){
			String name = (String)paramEnum.nextElement();
			%>
			<%=name %>
	<%
		}
	
	%>
	<p>
	<b>request.getParameterMap() 메서드 사용</b><br>
	<%
		Map parameterMap = request.getParameterMap();				//맵객체에 맵형태로 정보를 클라이언트의 정보를 받아서 저장한다.
		String[] nameParam = (String[])parameterMap.get("name");	//name값에 해당하는 밸류를 받아온다.
		if(nameParam != null){
	%>
			name = <%=nameParam[0] %>
	<%
		}
	%>
</body>
</html>













