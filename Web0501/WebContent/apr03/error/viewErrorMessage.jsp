<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� �߻�</title>
<script>
	function showDetail(){
		d = document.getElementById('detail');
		d.style.display = 'block';
	}
</script>

</head>
<body>	
	<h3 id="header"><%=exception.getClass().getName() %></h3>
	<div id="main">
		<%= exception.getMessage() %>
		<input type="button" onClick="showDetail()" value="�󼼺���">
		<div id="detail" style="display:none">
			<% exception.printStackTrace(new PrintWriter(out)); %>	
		</div>
	</div>
</body>
</html>

<!--
���� ���� �������� ���̰� 513 ����Ʈ���� �۴ٸ�,
���ͳ� �ͽ��÷η��� �� �������� ����ϴ� ���� �������� ������� �ʰ�
��ü������ �����ϴ� 'HTTP ���� �޽���' ȭ���� ����� ���̴�.
���� ���� �������� ���̰� 513 ����Ʈ���� ������
���� �������� ������ ���ͳ� �ͽ��÷η������� �ùٸ��� ��µǱ� ���Ѵٸ�,
���� ����� �� �ּ��� ���� ������ ���Խ��Ѽ�
���� �������� ���̰� 513 ����Ʈ �̻��� �ǵ��� �� �־�� �Ѵ�.
����� �� �ּ��� 456����Ʈ�̴�.
-->