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
		session.setAttribute("memId", id);	//서버에서 생성되므로 여러브라우저에서 접근하면 여러개 받을수 있다.
		if(request.getParameter("save") == null){	
			response.addCookie(CookieBox.createCookie("ID", "","/",-1));	
		}else{
			response.addCookie(CookieBox.createCookie("ID", id,"/",-1));
		}
		response.sendRedirect("main.jsp");	//로그인이 완료되면 main.jsp로 간다. (else부분)
	}else if(check==0){%>
		<script>
			alert("비밀번호가 맞지 않습니다.")
			history.go(-1);
		</script>
	
	<%}else{%>
	<script>
			alert("아이디가 맞지 않습니다.")
			history.go(-1);
		</script>
	<%} %>
		
