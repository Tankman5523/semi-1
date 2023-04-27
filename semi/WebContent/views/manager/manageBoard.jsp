<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="manager_menu.jsp" %>
	
	<a href="<%=contextPath%>/boardList.ma?currentPage=1">게시판 관리</a>
	<a href="<%=contextPath%>/noticeList.ma?currentPage=1">공지사항 관리</a>
	<a href="<%=contextPath%>/deleteList.ma?currentPage=1">삭제요청 관리</a>
</body>
</html>