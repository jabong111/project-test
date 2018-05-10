<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="./Web/mar28/viewParameter.jsp" method="get">
		이름:<input type="text" name="name" size="10"><br>
		주소:<input type="text" name="address" size="30"><br>
		종아하는 동물:
			<input type="checkbox" name="pet" value="dog"> 강아지 	
			<input type="checkbox" name="pet" value="cat"> 고양이 	
			<input type="checkbox" name="pet" value="pig"> 돼지
			<br> 	
			<input type="submit" value="전송">
	</form>

</body>
</html>