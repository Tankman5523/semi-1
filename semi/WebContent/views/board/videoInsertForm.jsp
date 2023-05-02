<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반영상 게시판 글 작성</title>
<style>
	
    
    #insertForm-area>#submit-area{
    	text-align: center;
    	margin: 15px; 
    }
    
    #insertForm-area>table *{
    	margin: 10px;
    }
    
    #insertForm-area>table
    
    
</style>
</head>
<body>


	<%@include file="../common/header.jsp" %>

	
	<div id="content">
		<h2 align="center" style="height:10%">일반영상 게시판 글작성</h2>
		
		<form action="insert.vi" method="post" id="insertForm-area" enctype="multipart/form-data">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
			
			<table align="center" border="1" style="width:80%; height:70%;">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style="width: 80%;" required placeholder="제목을 입력해주세요.">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="30" name="content" style="resize:none; width:80%; height:100%;" required placeholder="내용을 입력하세요."></textarea>
					</td>
				</tr>
				
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="upFile" required>
					</td>
				</tr>
			</table>
			
			<div id="submit-area" style="border:none; padding:10px; hieght:10%;">
				<button type="submit" class="btn btn-primary">작성하기</button>
			</div>
		</form>
	
	</div>
	
	<%@include file="../common/footer.jsp" %>
</body>
</html>