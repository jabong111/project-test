<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:if test="${check==1 }">
<!-- ���������� ����Ʈ�� ������ -->
<meta http-equiv="Refresh" content="0;url=/Web0501/MVC/list.do?pageNum=${pageNum}">
</c:if>

<c:if test="${check==0 }">
��й�ȣ�� �ٸ��ϴ�.
<br>
<a href="javascript:history.go(-1)">[�ۻ��� ������ ���ư���]</a>
</c:if>