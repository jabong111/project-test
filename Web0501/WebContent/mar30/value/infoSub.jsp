<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String type = request.getParameter("type");
	if(type != null){
%>
<br>
<table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <th>type</th>
    <th><b><%=type %></b></th>
  </tr>
  <tr>
    <td>특징</td>
    <td>
    <%if(type.equals("A")){ %>
    	강한내구성.
    <% }else if(type.equals("B")) {%>
    	뛰어난 대처 능력
    <%} %>
    </td>
  </tr>
</table>
<%} %>
<%

%>

