<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	*{
		box-sizing: border-box;
	}

	a:hover, a:focus {
	  outline: none;
	}
	
	#link-area{
		padding: 200px 0 200px 0;
		margin: auto;
		width: 100%;
		height: 100%;


	}
    #selectMenu a {
		color: rgba(255, 255, 255, 0.8);
		font-size: 17pt;
		font-weight: 400;
		padding: 15px 25px;
		position: relative;
		display: inline-block;
		text-decoration: none;
		text-transform: uppercase;
		border: 0 solid;
		box-shadow: inset 0 0 20px rgba(255, 255, 255, 0);
		outline: 1px solid;
		outline-color: rgba(255, 255, 255, 0.5);
		outline-offset: 0px;
		text-shadow: none;
		transition: all 1250ms cubic-bezier(0.19, 1, 0.22, 1);
	}
    
    #selectMenu{
    	margin-left: 280px;
    	text-align: center;
    	width: 100%;
    }
	
	
	#selectMenu a:hover {
		border: 1px solid;
		box-shadow: inset 0 0 20px rgba(255, 255, 255, 0.5), 0 0 20px rgba(255, 255, 255, 0.2);
		outline-color: rgba(255, 255, 255, 0);
		outline-offset: 15px;
		text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
	}
	
	#selectMenu>li{
		list-style-type: none;
		float: left;
        width: 20%;
        height: 100%;
        text-align: center;
        margin: auto;
	}
	
	h1{
        font-size: 30px;
        color: #fff;
        text-transform: uppercase;
        font-weight: 300;
        text-align: center;
        margin-bottom: 15px;
    }
    
    
</style>
</head>
<body>
	<%@ include file="manager_header.jsp" %>
	
	<div id="content">
		<h1 style="height: 10%">자유게시판 관리 목록</h1>
		
		<div id="link-area">
			<div id="list">
				<ul id="selectMenu">
					<li><a href="<%=contextPath%>/boardList.ma">자유게시글 관리</a></li>
					<li><a href="<%=contextPath%>/noticeList.ma">공지사항 관리</a></li>
					<li><a href="<%=contextPath%>/deleteWait.ma">삭제요청 관리</a></li>
				</ul>
			</div>
		</div>

	</div>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>