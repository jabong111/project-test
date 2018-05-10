<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>폼</title>
</head>
<body>
<form action="fileupload.jsp" method="post" enctype="multipart/form-data">
	tex11:<input type="text" name="text1"/><br>
	file1:<input type="file" name="file1"/><br>
	file2:<input type="file" name="file2"/><br>
	<input type="submit" value="전송">
</form>
</body>
</html>