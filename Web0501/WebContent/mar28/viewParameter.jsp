<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Map" %>
<%
	request.setCharacterEncoding("euc-kr"); //Ŭ���̾�Ʈ���� �޾ƿ� �����͸� ���ڵ��Ѵ�.
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��û �Ķ����</title>
</head>
<body>
	<b>request.getParamether() �޼ҵ� ���</b><br>
	name �Ķ����: <%=request.getParameter("name") %><br>	<!-- ���Ӱ��� �ٷ� �޾ƿ´� -->
	address �Ķ����: <%=request.getParameter("address") %> <!-- �ּҰ��� �ٷ� �޾ƿ´�. -->
	<p>
	<b>request.getParameter() �޼ҵ� ���</b><br>		
	<%	
		String[] values = request.getParameterValues("pet");//�꿡 �ش��ϴ� value�� �迭�� �ִ´�.
		if(values != null){
			for(int i=0;i<values.length;i++){
				%>
				<%= values[i]%>
	<%
			}
		}
	%>
	<p>
	<b>request.getParameterNames() �޼��� ���</b><br>
	<%
		Enumeration paramEnum = request.getParameterNames();	//�̴��ӷ��̼ǰ�ü�� name ������ �� �ִ´�.
		while(paramEnum.hasMoreElements()){
			String name = (String)paramEnum.nextElement();
			%>
			<%=name %>
	<%
		}
	
	%>
	<p>
	<b>request.getParameterMap() �޼��� ���</b><br>
	<%
		Map parameterMap = request.getParameterMap();				//�ʰ�ü�� �����·� ������ Ŭ���̾�Ʈ�� ������ �޾Ƽ� �����Ѵ�.
		String[] nameParam = (String[])parameterMap.get("name");	//name���� �ش��ϴ� ����� �޾ƿ´�.
		if(nameParam != null){
	%>
			name = <%=nameParam[0] %>
	<%
		}
	%>
</body>
</html>













