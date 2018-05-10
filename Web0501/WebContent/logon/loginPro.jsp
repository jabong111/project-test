<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:if test="${check==1 }">	<!-- 로그인되었으면 session영역에 memId라는 이름으로  아이디를 저장한다.  -->
	<c:set var="memId" value="${id }" scope="session"/>
	<meta http-equiv="Refresh" content="0;url=/Web0501/logon/main.do"/>	<!-- 저장하고 메인으로 보낸다. -->
</c:if>
<c:if test="${check==0 }">
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${check==-1 }">
	<script>
		alert("아이디가 맞지 않습니다.");
		history.go(-1);
	</script>
</c:if>

