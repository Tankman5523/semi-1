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
        width: 1200px;
        height: 450px;
        margin: auto;
    }
    
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

	<%@include file="../common/mainMenu.jsp" %>
	
	<div class="outer">
		<h2 align="center" style="height:10%">글작성</h2>
		
		<form action="insert.bo" method="post" id="insertForm-area" enctype="multipart/form-data">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
			
			<%if(loginUser != null && loginUser.getAdmin().equals("Y")){ %>
			<input type="checkbox" name="notice" id="notice" value="1"><label for="notice">공지사항 등록</label>
            <%}else{ %>
            <input type="hidden" name="notice" value="0">
            <%} %>
            
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
						<input type="file" name="upFile">
					</td>
				</tr>
			</table>
			
			<div id="submit-area" style="border:none; padding:10px; hieght:10%;">
				<button type="submit">작성하기</button>
			</div>
		</form>
	
	</div>
</body>
</html>