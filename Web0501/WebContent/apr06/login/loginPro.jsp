<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="soldesk.logon.LogonDBBean" %>
<%@ page import="util.CookieBox" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	LogonDBBean manager = LogonDBBean.getInstance();
	CookieBox cookie = new CookieBox(request);
	int check = manager.userCheck(id, passwd);
	if(check == 1){
		session.setAttribute("memId", id);	//�������� �����ǹǷ� �������������� �����ϸ� ������ ������ �ִ�.
		if(request.getParameter("save") == null){	
			response.addCookie(CookieBox.createCookie("ID", "","/",-1));	
		}else{
			response.addCookie(CookieBox.createCookie("ID", id,"/",-1));
		}
		response.sendRedirect("main.jsp");	//�α����� �Ϸ�Ǹ� main.jsp�� ����. (else�κ�)
	}else if(check==0){%>
		<script>
			alert("��й�ȣ�� ���� �ʽ��ϴ�.")
			history.go(-1);
		</script>
	
	<%}else{%>
	<script>
			alert("���̵� ���� �ʽ��ϴ�.")
			history.go(-1);
		</script>
	<%} %>
		
