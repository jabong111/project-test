<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script language="javascript">
	function deleteSave(){
		if(document.delform.passwd.value == ''){
			alert("��й�ȣ�� �Է��ϼ���");
			document.delform.passwd.focus();
			return false;
		}
	}

</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body bgcolor="${bodyback_c }">
	<form action="/Web0501/MVC/delCommentPro.do" method="post" onsubmit="return deleteSave()" name="delform">
		<table border="1" align="center" cellpadding="0" cellspacing="0" width="360">
			<tr height="30">
				<td align="center" bgcolor="${value_c }">
					<b>��й�ȣ�� �Է��� �ּ���</b>
				</td>
			</tr>
			<tr height="30">
				<td align="center">
				��й�ȣ:<input type="password" name="passwd" size="8" maxlength="12">
				<input type="hidden" name="num" value="${num }"><!-- �Խñ۹�ȣ -->
				<input type="hidden" name="pageNum" value="${pageNum }"><!-- ��������ȣ -->
				<input type="hidden" name="commentNum" value="${commentNum}"><!-- �ڸ�Ʈ��ȣ -->
				</td>
			</tr>
			<tr height="30">
				<td align="center" bgcolor="${value_c }">
					<input type="submit" value="����">
					<input type="button" value="���" onclick="document.location.href='/Web0501/MVC/content.do?num=${num}&pageNum=${pageNum} }'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
<!-- 
������ Ŀ��Ʈ��,����Ʈ��,�н����尡 �־�ߵǰ� 
�������� ���ư��� �ϱ����ؼ��� ����Ʈ��,���������� ���η� ������ߵȴ�.
�����Ҵ�� ��������,�Խñ۹�ȣ �ΰ��� conten.jsp�� ���ư��� �����ֱ����ؼ� �Ѱ��ִ� ���̰�
�н������ �ڸ�Ʈ�ѵ� �����־���Ѵ�.
 -->