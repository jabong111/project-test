<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "soldesk.board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<jsp:useBean id="article" scope="page" class="soldesk.board.BoardDataBean">	<!-- writeForm.jsp 로부터 받아온 데이터를 자바빈에 넣는다. -->
   <jsp:setProperty name="article" property="*"/>	<!-- 모든값을 집어 넣는다 하지만 시간과 아이피주소는 자바빈으로 넣어지지 않기 때문에 따로 넣어준다. -->
</jsp:useBean>

<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );	//작성된 시간 데이터를 저장한다.
	article.setIp(request.getRemoteAddr());	//아이피를 저장한다.

    BoardDBBean dbPro = BoardDBBean.getInstance();	//BoardDBBean 객체를 싱글톤형식으로 만들고
    dbPro.insertArticle(article);	//자바빈에 들어간 데이터를 디비에 집어 넣는다.

    response.sendRedirect("list.jsp");	//리스트로 보낸다.
%>