<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.outer{
        border: 1px solid black;
        width: 900px;
        height: 450px;
        margin: auto;
    }
    
    #insertForm-area>#submit-area{
    	text-align: right;
    	margin-right: 80px; 
    }
    
    #insertForm-area>table *{
    	margin: 10px;
    }
    
    #insertForm-area>table
    
    
</style>
</head>
<body>
	<div class="outer">
		<h2>글작성</h2>
		
		<form action="insert.bo" method="post" id="insertForm-area" enctype="multipart/form-data">
			<input type="hidden" name="userId" value="">
			<table align="center" border="1">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style="width: 500px;" required placeholder="제목을 입력해주세요.">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="30" name="content" style="resize:none; width:500px;" required placeholder="내용을 입력하세요."></textarea>
					</td>
				</tr>
				
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="upFile">
					</td>
				</tr>
			</table>
			
			<br><br>
			<div id="submit-area">
				<button type="submit">작성하기</button>
			</div>
		</form>
	
	</div>
</body>
</html>