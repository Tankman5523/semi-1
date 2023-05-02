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
<title>일반게시글</title>
<style>
	
	#content{
       	border: 1px solid white;
      	overflow: auto;
      	margin: auto;
		border: 1px solid white;
		color : white;
    }
    
    .comment{
    	border: 1px solid white;
    	width: 1200px;
    	margin: auto;
    }
    
    
    #reply-area tfoot>tr{
    	height: 40px;
    }
    
  	#liked-area>i:hover{
    	cursor: pointer;
    	color: gray;
    }
    
    #reply-area{
    	border: none;
    	overflow: auto;
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
			<h1>자유 일반게시글</h1>
		</div>
	
		<table align="center" border="1" id="detail-area" style="height:40%; width:100%">
			<tr style="text-align: center;">
				<th height="50" width="100">글번호</th>
				<td width="50"><%=b.getBoardNo()%></td>
				<th>제목</th>
				<td width="250" colspan="5" style="text-align: left;"><%=b.getTitle()%></td>
				<th width="100">작성자</th>
				<td width="100"><%=b.getBoardWriter()%></td>
				<th width="100">작성일</th>
				<td width="130"><%=b.getCreateDate()%></td>
				<th width="100">추천수</th>
				<td width="50" id="liked_count"><%=b.getLiked()%></td>
				<th width="100">조회수</th>
				<td width="50"><%=b.getCount()%></td>
			</tr>
			
			<tr>
				<th style="text-align: center;">내용</th>
				<td colspan="7">
					<%if(at != null){ %>
						<img src="<%=contextPath+at.getFilePath()+at.getChangeName()%>">
					<%} %>
					<span>
					<%=b.getContent()%>
					</span>
				</td>
			</tr>

		</table>
		
		
		<div id="liked-area" align="center" style="height: 10%; padding-top: 20px">
			<i id="good" class="fa-regular fa-thumbs-up fa-2x" style="margin-right: 70px"></i>
			<i id="bad" class="fa-regular fa-thumbs-down fa-2x"></i>
		</div>
		
		
		<%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter()) || loginUser.getAdmin().equals("Y")){%>
		<div id="update-area" align="center" style="border:none; padding:10px; hieght:5%;">
			<button class="btn btn-warning" onclick="location.href='<%=contextPath%>/update.bo?bno=<%=b.getBoardNo()%>'" style="margin:5px;">수정하기</button>
			<button class="btn btn-danger" onclick="location.href='<%=contextPath%>/delete.bo?bno=<%=b.getBoardNo()%>'" style="margin:5px;">삭제하기</button>
		</div>
		<%}%>

		<div class="comment" style="height: 30%;">
			<div id="reply-area" align="center" style="height: 100%;">
				<table border="0" style="width:70%; height:100%; text-align:center;">
					<thead>
						<tr>
							<th colspan="4" style="font-size: 20px; border:none;">댓글</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="border:none;"></td>
							<td><textarea id="reply_input" rows="5" cols="60" style="resize: none; padding: 0px;" placeholder="댓글을 입력하세요."></textarea></td>
							<td style="border:none;"><button id="reply_btn" >댓글 등록</button></td>
						</tr>
					</tbody>
					<tfoot>
					
					</tfoot>
					
				</table>
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
							 	str+= "<td width='50px'><button id='delRp'>삭제</button></td></tr>";
							}else{
								str+= "<td width='50px'></td></tr>";
							}
						<%}else{%>
							str+= "<td width='50px'></td></tr>";		
						<%}%>
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