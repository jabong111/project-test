<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:if test="${check==1 }">	<!-- �α��εǾ����� session������ memId��� �̸�����  ���̵� �����Ѵ�.  -->
	<c:set var="memId" value="${id }" scope="session"/>
	<meta http-equiv="Refresh" content="0;url=/Web0501/logon/main.do"/>	<!-- �����ϰ� �������� ������. -->
</c:if>
<c:if test="${check==0 }">
	<script>
		alert("��й�ȣ�� ���� �ʽ��ϴ�.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${check==-1 }">
	<script>
		alert("���̵� ���� �ʽ��ϴ�.");
		history.go(-1);
	</script>
</c:if>

