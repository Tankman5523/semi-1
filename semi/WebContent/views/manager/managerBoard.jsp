<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div{
	    border: 1px solid black;
	    box-sizing: border-box;
	}
	.outer{
        border: 1px solid black;
        width: 1200px;
        height: 600px;
        margin: auto;
        text-align: center;
    }
</style>
</head>
<body>
	<%@ include file="manager_menu.jsp" %>
	
	<div class="outer">
	
	
	<a href="<%=contextPath%>/boardList.ma">자유게시글 관리</a>
	<a href="<%=contextPath%>/noticeList.ma">공지사항 관리</a>
	<a href="<%=contextPath%>/deleteWait.ma">삭제요청 관리</a>
	
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>