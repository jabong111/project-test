<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "soldesk.board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<jsp:useBean id="article" scope="page" class="soldesk.board.BoardDataBean">	<!-- writeForm.jsp �κ��� �޾ƿ� �����͸� �ڹٺ� �ִ´�. -->
   <jsp:setProperty name="article" property="*"/>	<!-- ��簪�� ���� �ִ´� ������ �ð��� �������ּҴ� �ڹٺ����� �־����� �ʱ� ������ ���� �־��ش�. -->
</jsp:useBean>

<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );	//�ۼ��� �ð� �����͸� �����Ѵ�.
	article.setIp(request.getRemoteAddr());	//�����Ǹ� �����Ѵ�.

    BoardDBBean dbPro = BoardDBBean.getInstance();	//BoardDBBean ��ü�� �̱����������� �����
    dbPro.insertArticle(article);	//�ڹٺ� �� �����͸� ��� ���� �ִ´�.

    response.sendRedirect("list.jsp");	//����Ʈ�� ������.
%>