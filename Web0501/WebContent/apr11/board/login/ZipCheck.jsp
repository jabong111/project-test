<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="soldesk.logon.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	String check = request.getParameter("check");
	String area3 = request.getParameter("area3");
	LogonDBBean manager = LogonDBBean.getInstance();
	Vector zipcodeList = manager.zipcodeRead(area3);
	int totalList = zipcodeList.size();
%>
<!-- 이 페이지는 inputForm.jsp 에서 우편검색버튼을 클릭할시 팝업창으로 뜨는페이지이고
	 검색 후 주소를 클릭하면 창이 닫ㅎㅣ고 자동적으로 주소가 적히게 된다.
	 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>우편 번호 검색</title>
<link href="./style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function dongCheck() {
		if(document.zipForm.area3.value==""){	//동이름을 적지 않았다면 경고를 띄어둔다.
			alert("동이름을 입력하세요");
			document.zipForm.area3.focus();
			return;
		}
		document.zipForm.submit();
	}
	
	function sendAddress(zipcode, area1, area2, area3, area4){
		 var address = area1+" "+area2+" "+area3+" "+area4;
		 opener.document.userinput.zipcode.value = zipcode; //주소를 클릭할시 자동으로 inputForm.jsp파일에 우편번호와 주소를 적어주는 자바스크립트 코드
		 opener.document.userinput.address.value = address;
		 self.close();
	 }
</script>
</head>
<body bgcolor="#FFFFCC">
<center>	
	<b>우편번호 찾기</b>
	<table>
		<form action="ZipCheck.jsp" name="zipForm" method="post">
			<tr>
				<td><br>
				동이름 입력:<input type="text" name="area3">
				<input type="button" value="검색" onclick="dongCheck();">
			</tr>
			<input type="hidden" name="check" value="n">
		</form>
		<%
			if(check.equals("n")){
		%>
		<%
				if(zipcodeList.isEmpty()){%>
					<tr><td align="center"><br>검색된 결과가 없습니다.</td></tr>
				
				
				<%}else{ %>
				<tr><td align="center"><br>※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td></tr>
				<%
					for(int i=0;i<totalList;i++){
						ZipcodeBean zipBean = (ZipcodeBean)zipcodeList.elementAt(i);	//벡터안에 있던 주소 데이터를 하나하나 불러와 자바빈에 넣는다.
						String tempZipcode = zipBean.getZipcode();
						String tempArea1 = zipBean.getArea1();
						String tempArea2 = zipBean.getArea2();
						String tempArea3 = zipBean.getArea3();
						String tempArea4 = zipBean.getArea4();
				%>
				<tr><td>
				<a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempArea1%>','<%=tempArea2%>','<%=tempArea3%>','<%=tempArea4%>')">
					<%=tempZipcode%> &nbsp <%=tempArea1%> &nbsp <%=tempArea2%> &nbsp <%=tempArea3%> &nbsp;
				</a><br>
				<%} %>
			<%} %>
		<%} %>
	</td></tr>
	<tr><td align="center"><br><a href="javascript:this.close();">닫기</a></td></tr>
	</table>
</center>

</body>
</html>


























































