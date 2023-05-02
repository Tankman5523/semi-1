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
<!--awesome 아이콘 cdn-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>자유 영상게시글</title>
<style>
	*{
		box-sizing: border-box;
	}
	#content{
		
		height: 1300px;
	}
	
    
    .comment{
    	border: 1px solid black;
    	width: 1300px;
    	margin: auto;
    }
    
    #reply-area tfoot>tr{
    	height: 40px;
    }
    #reply-area{
    	overflow: auto;
    }
    
    #detail-2{
    	overflow: auto;
    }
    
    #detail-area span{
    	padding: 10px;
    }
    
    #detail-1,#detail-2{
    	border: 1px solid white;
    }
    
    #liked-area>i:hover{
    	cursor: pointer;
    	color: gray;
    }
    
    ::-webkit-scrollbar {
        width: 6px;
    } 
    ::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(255, 255, 255, 0.8); 
    } 
    ::-webkit-scrollbar-thumb {
        -webkit-box-shadow: inset 0 0 6px rgba(255, 255, 255, 0.8); 
    }
    
</style>
</head>
<body>

<%@include file="../common/header.jsp" %>
	
	<div id="content">
		
		<div align="center" style="height:10%; width:100%;">
			<h1>자유 영상게시글</h1>
		</div>
		
		<div id="body_area" style="float:left; height:90%; width:100%;">
			<div border="1" id="detail-area" style="height:100%; width:60%; display:inline-block;">	
				<div class=video-area>
					<video style="height:300px; padding: 0px;" src="<%=contextPath+at.getFilePath()+at.getChangeName()%>" controls width="500px" height="500px"></video>
				</div>
				
				<table border="1" style="width: 100%;" id="detail-1">
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
					
				<div id="detail-2" style="padding: 20px; height: 200px">
					<span style="font-size: 20px">
						-내용-
					</span>
					<br><br>
					<span>
						<%=b.getContent()%>
					</span>
				</div>
				
				
				<div id="liked-area" align="center" style="height: 10%; padding-top: 20px">
					<i id="good" class="fa-regular fa-thumbs-up fa-2x" style="margin-right: 70px"></i>
					
					<i id="bad" class="fa-regular fa-thumbs-down fa-2x"></i>
				</div>
				
				
				<%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())){%>
				<div id="update-area" align="center" style="border:none; padding:10px; hieght:5%;">
					<button class="btn btn-warning" onclick="location.href='<%=contextPath%>/update.vi?bno=<%=b.getBoardNo()%>'" style="margin:5px;">수정하기</button>
					<button class="btn btn-danger" onclick="location.href='<%=contextPath%>/delete.vi?bno=<%=b.getBoardNo()%>'" style="margin:5px;">삭제하기</button>
				</div>
				<%}%>
			</div>
		
		
		
	
			<div class="comment" style="height:100%; width: 39%; display:inline-block;">
				<div id="reply-area" align="center" style="height: 100%;">
					<table>
						<thead>
							<tr>
								<th colspan="4" style="font-size: 20px; border:none;">댓글</th>
							</tr>
							<tr>
								<td colspan="2"><textarea id="reply_input" rows="3" cols="35" style="resize: none; padding: 0px;" placeholder="댓글을 입력하세요."></textarea></td>
								<td colspan="2" style="border:none;"><button id="reply_btn" >댓글 등록</button></td>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
						<tfoot>
						
						</tfoot>
						
					</table>
				</div>
			</div>
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

		//비추천 버튼
		$(function(){
			$("#bad").on("click", function(){
				<%if(loginUser == null){%>
					alert("로그인 후 이용해 주세요.");
				<%}else{%>
					var control = confirm("싫어요는 취소할 수 없습니다. 계속 진행하시겠습니까?");
					if(control){
						$.ajax({
							url:"dislike.bo",
							data:{
								bno:<%=b.getBoardNo()%>,
								uno:<%=loginUser.getUserNo()%>
							},
							success:function(result2){
								if(result2>0){
									alert("이 게시글을 싫어합니다.");
									$("#bad").attr("class","fa-solid fa-thumbs-down");
								}else{
									alert("이미 싫어요한 게시글입니다.");
								}
							},
							error:function(){
								alert("통신 에러");
							}
						});
					}
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
						var rpWriter = list[i].rpWriter;
						
						str += "<tr><input type='hidden' id='rpNo' name='rpNo' value="+list[i].rpNo+">"
								  +"<td>"+list[i].rpWriter+"</td>"
								  +"<td style='text-align:left; padding-left: 5px;'>"+list[i].content+"</td>"
								  +"<td>"+list[i].createDate+"</td>";
								  
						<%if(loginUser != null){%>
							if(rpWriter=="<%=loginUser.getUserId()%>"||<%=loginUser.getAdmin().equals("Y")%>){
							 	str+= "<td width='40px'><button id='delRp'>삭제</button></td></tr>";
							}else{
								str+= "<td width='40px'></td></tr>";
							}
						<%}else{%>
							str+= "<td width='40px'></td></tr>";		
						<%}%>
					}
					
					$("#reply-area>table>tbody").html(str);
					
				},
				error:function(){
					console.log("댓글리스트 조회 통신 실패");
				}
			});
		}
		
		//댓글 삭제기능
		$(function(){
			$("#reply-area").on("click", "#delRp", function(){
				
				<%if(loginUser != null){%>
				$.ajax({
					url:"delRp",
					data:{
						rpNo:$(this).parent().siblings("input[type=hidden]").val(),
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