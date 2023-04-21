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
    
    .comment{
    	border: 1px solid black;
    	width: 1200px;
    	margin: auto;
    }
    #insertForm-area>#submit-area{
    	text-align: right;
    	margin-right: 80px; 
    }
    
    #insertForm-area>table *{
    	margin: 10px;
    }
    
    #reply-area tfoot>tr{
    	height: 40px;
    }
    
    
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
					<p>
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
	
	<div class="comment">
		<div id="reply-area" align="center">
			<table border="1" style="width:70%; text-align:center;">
				<thead>
					<tr>
						<th colspan="3" style="font-size: 20px; border:none;">댓글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="border:none;"></td>
						<td><textarea id="reply_input" rows="4" cols="60" style="resize: none; padding: 0px; height:100%; width:100%" placeholder="댓글을 입력하세요."></textarea></td>
						<td style="border:none;"><button id="reply_btn" >댓글 등록</button></td>
					</tr>
				</tbody>
				<tfoot>
				
				</tfoot>
			</table>
		</div>
	</div>
	
	
	<script>
		
		$(function(){
			viewRpList();
		});
		//좋아요버튼 눌렀을대 발생
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
			});
		});
		
		$(function(){
			//댓글입력영역에서 엔터눌렀을때 이벤트
			$("#reply_input").on("keydown", function(e){
				if(e.keyCode == 13){
					e.preventDefault(); //엔터키의 기본동작을 취소하는 조치
					$("#reply_btn").click();
				}
			});
			
			$("#reply_btn").on("click", function(){
				
			<%if(loginUser != null){%>
				console.log($("#reply_input").val());
				
				$.ajax({
					url:"insertRp",
					data:{
						bno:<%=b.getBoardNo()%>,
						content:$("#reply_input").val(),
					},
					success:function(result){
						if(result>0){
							alert("댓글 등록 성공");
							$("#reply_input").val("");
							
							viewRpList();
						}else{
							alert("댓글 등록 실패");
						}
					},
					error:function(){
						console.log("댓글 등록 통신 실패");
					}
				});
			<%}else{%>
				alert("로그인 후 이용해주세요.");
				$("#reply_input").val("");
			<%}%>
			});			
		});
		
		//댓글 리스트
		function viewRpList(){
			$.ajax({
				url:"listRp",
				data:{
					bno:<%=b.getBoardNo()%>
				},
				success:function(list){
					var str = "";
					
					for(var i in list){
						
						str += "<tr><td>"+list[i].rpWriter+"</td>"
								  +"<td style='text-align:left; padding-left: 5px;'>"+list[i].content+"</td>"
								  +"<td>"+list[i].createDate+"</td></tr>";
					}
					
					$("#reply-area>table>tfoot").html(str);
					
				},
				error:function(){
					console.log("댓글리스트 조회 통신 실패");
				}
			});
		}
	</script>
	
	<%@include file="../common/footer.jsp" %>
</body>
</html>