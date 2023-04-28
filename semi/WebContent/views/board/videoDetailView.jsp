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
<title>일반 영상게시글</title>
<style>
	.outer{
        border: 1px solid black;
        width: 1200px;
        height: 1000px;
        margin: auto;
    }
    
    .comment{
    	border: 1px solid black;
    	width: 1200px;
    	margin: auto;
    }
    
    #reply-area tfoot>tr{
    	height: 40px;
    }
    
    #detail-area span{
    	padding: 10px;
    }
    
</style>
</head>
<body>

	<%@include file="../common/mainMenu.jsp" %>
	
	<div class="outer">
		
		<div align="center" style="height:10%; width:100%;">
			<p>일반 영상게시글</p>
		</div>
		
	
		<div border="1" id="detail-area" style="height:70%; width:100%">	
			<div class=video-area align="center">
				<video style="margin: auto; height:100%; padding: 0px;" src="<%=contextPath+at.getFilePath()+at.getChangeName()%>" controls width="500px" height="500px"></video>
			</div>
			
			<table border="1">
				<tr>
					<th>
						제목
					</th>
					<td width="400">
						<span id="video_title" style="font-size: 30px" colspan="3">
							<%=b.getTitle()%>
						</span>
					</td>
					
					<th>
						조회수
					</th>
					<td>
						<span id="video_count">
							<%=b.getCount()%>
						</span>
					</td>
					
					<th>
						댓글
					</th>
					<td>
						<%=b.getRpCount()%>
					</td>
				</tr>
				<tr>
					<th>
						작성자
					</th>
					<td>
						<%=b.getBoardWriter()%>
					</td>
					
					<th>
						작성일
					</th>
					<td>
						<span id="video_createDate">
							<%=b.getCreateDate()%>
						</span>
					</td>
					
					<th>
						추천수
					</th>
					<td id="liked_count">
						<%=b.getLiked()%>
					</td>
				</tr>
			</table>
				
			<div id="video_content" style="padding: 20px; height:20%;">
				<span style="font-size: 20px">
					-내용-
				</span>
				<br><br>
				<%=b.getContent()%>
			</div>
		</div>
		
		
		<div id="liked-area" align="center" style="height: 10%;">
			<button style="margin: 5px;" id="good">추천</button>
		</div>
		
		
		<%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())){%>
		<div id="update-area" align="center" style="border:none; padding:10px; hieght:10%;">
			<button onclick="location.href='<%=contextPath%>/update.vi?bno=<%=b.getBoardNo()%>'" style="margin:5px;">수정하기</button>
			<button onclick="location.href='<%=contextPath%>/delete.vi?bno=<%=b.getBoardNo()%>'" style="margin:5px;">삭제하기</button>
		</div>
		<%}%>
	
	
	</div>
	
	<div class="comment">
		<div id="reply-area" align="center">
			<table border="1" style="width:70%; text-align:center;">
				<thead>
					<tr>
						<th colspan="4" style="font-size: 20px; border:none;">댓글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="border:none;"></td>
						<td><textarea id="reply_input" rows="5" cols="60" style="resize: none; padding: 0px; height:100%; width:100%" placeholder="댓글을 입력하세요."></textarea></td>
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
						success:function(jobj){
							if(jobj.result==1){
								alert("이 게시글을 좋아합니다.");
								
								$("#liked_count").text(jobj.cnt);
							}else if(jobj.result==2){
								alert("좋아요 취소! 흥");
								
								$("#liked_count").text(jobj.cnt);
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
						
						str += "<tr><input type='hidden' id='rpNo' name='rpNo' value="+list[i].rpNo+">"
								  +"<td>"+list[i].rpWriter+"</td>"
								  +"<td style='text-align:left; padding-left: 5px;'>"+list[i].content+"</td>"
								  +"<td>"+list[i].createDate+"</td>"
								  +"<td><button id='delRp'>삭제</button></td></tr>";
					}
					
					$("#reply-area>table>tfoot").html(str);
					
				},
				error:function(){
					console.log("댓글리스트 조회 통신 실패");
				}
			});
		}
		
		//댓글 삭제기능
		$(function(){
			$("#reply-area").on("click", "#delRp", function(){
				
				<%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())){%>
				$.ajax({
					url:"delRp",
					data:{
						rpNo:$("#reply-area tfoot *").siblings("input[type=hidden]").val(),
						bno:<%=b.getBoardNo()%>
					},
					success:function(result){
						if(result>0){
							alert("댓글삭제가 완료되었습니다.");
							
							viewRpList();
						}else{
							alert("댓글삭제 실패!");
						}
					},
					error:function(){
						alert("댓글 삭제 통신실패!")
					}
				});
				<%}else{%>
				alert("댓글 삭제 권한이 없습니다.");
				<%}%>
				
			});
		});
		
	</script>
	
	<%@include file="../common/footer.jsp" %>
</body>
</html>