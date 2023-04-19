<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.board.model.vo.Board, com.bbbox.board.model.vo.Attachment"%>
<%
	Board b = (Board)request.getAttribute("board");
	Attachment at = (Attachment)request.getAttribute("at");
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
        height: 600px;
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

	<%@include file="../common/mainMenu.jsp" %>
	
	<div class="outer">
		
		<div align="center" style="height:10%; width:100%;">
			<p>일반게시판</p>
		</div>
	
		<table align="center" border="1" id="detail-area" style="height:70%; width:100%">
			<tr>
				<th>글번호</th>
				<td width="100"><%=b.getBoardNo()%></td>
				<th>제목</th>
				<td width="400" colspan="5"><%=b.getTitle()%></td>
			</tr>
			<tr style="text-align: right" id="list-value">
				<th>작성자</th>
				<td><%=b.getBoardWriter()%></td>
				<th>작성일</th>
				<td><%=b.getCreateDate()%></td>
				<th>좋아요 받은 수</th>
				<td><%=b.getLiked()%></td>
				<th>조회수</th>
				<td><%=b.getCount()%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="7">
					<%if(at != null){ %>
						<img src="<%=contextPath+at.getFilePath()+at.getChangeName()%>">
					<%} %>
					<p style="height:200px">
					<%=b.getContent()%>
					</p>
				</td>
			</tr>
			
			
			
		</table>
		
		
		<div id="liked-area" align="center" style="height: 10%;">
			<button style="margin: 5px;" id="good">글 내용이 좋아요</button>
		</div>
		
		
		<%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())){%>
		<div id="update-area" align="center" style="border:none; padding:10px; hieght:10%;">
			<button onclick="location.href='<%=contextPath%>/update.bo?bno=<%=b.getBoardNo()%>'" style="margin:5px;">수정하기</button>
			<button onclick="location.href='<%=contextPath%>/delete.bo?bno=<%=b.getBoardNo()%>'" style="margin:5px;">삭제하기</button>
		</div>
		<%}%>
	
	
	</div>
	
	<script>
		$(function(){
			$("#good").on("click", function(){
				<%if(loginUser == null){%>
					alert("로그인 후 이용해 주세요.");
				<%}else{%>
					$.ajax({
						url:"liked.bo",
						data:{
							bno:<%=b.getBoardNo()%>,
							uno:<%=loginUser.getUserNo()%>
						},
						success:function(result2){
							if(result2>0){
								alert("이 게시글을 좋아합니다.");
							}else{
								alert("이미 추천한 게시글입니다.");
							}
						},
						error:function(){
							alert("통신 에러");
						}
					});
				<%}%>
			})
		});
	</script>
</body>
</html>