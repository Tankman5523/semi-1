<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.board.model.vo.Board"%>
<%
	Board b = (Board)request.getAttribute("board");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.outer{
        border: 1px solid black;
        width: 1200px;
        height: 450px;
        margin: auto;
    }
    
    #updateForm-area>#submit-area{
    	text-align: center;
    	margin: 15px; 
    }
    
    #updateForm-area>table *{
    	margin: 10px;
    }
    
    #updateForm-area>table
    
    
</style>
</head>
<body>

	<%@include file="../common/mainMenu.jsp" %>
	
	<div class="outer">
		<h2 align="center" style="height:10%">글작성</h2>
		
		<form action="insert.bo" method="post" id="updateForm-area" enctype="multipart/form-data">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
			<table align="center" border="1" style="width:80%; height:70%;">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style="width: 80%;" required value="<%=b.getTitle()%>">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="30" name="content" style="resize:none; width:80%; height:100%;" required value="<%=b.getContent()%>"></textarea>
					</td>
				</tr>
				
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="upFile" value="<%=%>">
					</td>
				</tr>
			</table>
			
			<div id="submit-area" style="border:none; padding:10px; hieght:10%;">
				<button type="submit">수정완료</button>
			</div>
		</form>
	
	</div>
</body>
</html>