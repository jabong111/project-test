<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kh10.model.Message" %>
<%@ page import="kh10.model.MessageListView" %>
<%@ page import="kh10.service.GetMessageListService" %>
<%
	String pageNumberStr = request.getParameter("page");
	int pageNumber = 1;
	if(pageNumberStr != null){
		pageNumber = Integer.parseInt(pageNumberStr);
	}
	
	GetMessageListService messageListServive = GetMessageListService.getInstance();
	MessageListView viewData = messageListServive.getMessageList(pageNumber);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� �޽��� ���</title>
</head>
<body>
	<form action="writeMessage.jsp" method="post">
		�̸�:<input type="text" name="guestName" /><br/>
		��ȣ:<input type="password" name="password" /><br/>
		�޽���:<textarea name="message" cols="30" row="3"></textarea><br />
		<input type="submit" value="�޽��� �����"/>
	</form>
	<hr>
	<%if(viewData.isEmpty()){ %>
	��ϵ� �޽����� �����ϴ�.
	<%}else{ %>
		<table border="1">
		<%
			for(Message message:viewData.getMessageList()){
		%>
			<tr>
				<td>
					�޽��� ��ȣ:<%=message.getId() %><br/>
					�մ� �̸�:<%=message.getGuestName() %><br/>
					�޽���:<%=message.getMessage() %><br/>
					<a href="confirmDeletion.jsp?messageId=<%=message.getId()%>">
					[�����ϱ�]</a>
				</td>
			</tr>
		<%} %>
		</table>
	<%for(int i=1;i<=viewData.getPageTotalCount();i++){ %>
	<a href="list.jsp?page=<%=i%>">[<%=i %>]</a>
		<%} %>
	<%} %>
</body>
</html>