<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String errorMsg = (String)request.getAttribute("errorMsg");
	String alertMsg = (String)request.getAttribute("alertMsg");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>errorPage</title>
</head>
<body>
	<br>
	<h2 align ="center"> <a href="<%=request.getContextPath()%>">메인으로 돌아가기</a></h2>
	
<script>
		var msg = "<%=alertMsg%>";
		var errmsg ="<%=errorMsg%>";
		
		if(msg != "null"){
			alert(msg);	
			<% session.removeAttribute("alertMsg"); %>
		}
		if(errmsg != "null"){
			alert(errmsg);
			<% session.removeAttribute("errorMsg"); %>
		}
</script>

</body>
</html>