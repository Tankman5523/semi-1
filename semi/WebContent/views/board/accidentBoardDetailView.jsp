<%@page import="com.bbbox.board.model.vo.Reply"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bbbox.board.model.vo.Accident"%>
<%@page import="com.bbbox.board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Board b = (Board)request.getAttribute("board");
	Accident ac = (Accident)request.getAttribute("accident");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- font-awesome Copy Link Tag (아이콘 CDN) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>제보영상 게시글</title>
<style>
        div{
            box-sizing: border-box;
        }
        #content{
            width: 1300px;
            height: 1200px;
            margin: auto;
            color:white;
        }

        /*헤더파트*/
        .accidentBoardDetailHeader{
            height: 10%;
            color: rgb(255, 236, 173);
        }
		.accidentBoardDetailHeader>h1{
			display:inline-block;
			margin:0;
			margin-left:30px;
			padding-top:20px;
		}
        /*바디파트*/
        .accidentBoardDetailBody{
            height: 90%;
            overflow-y: scroll; 
        }
        .accidentBoardDetailBody>div{
            float: left;
            height: 100%;
        }
        .bodyLeft{
            width: 70%;
        }
        .bodyLeft>div{
        }

        /*비디오영역*/
        .videoArea{
            height: 50%;
        }
        #video{
            width: 90%;
            height: 90%;
            border: 1px solid brown;
            margin: 30px
        }

        /*게시글 영역*/
        .contentArea{
            height: 40%;
        }
        .contentArea>div{
            width: 90%;
            margin-left:30px;
            margin-right:30px;
            background-color: rgba(50, 50, 50, 0.7);
        }
        .infoArea{
            height: 40%;
        }
        .infoArea>div{
            float: left;
            height: 100%;
        }
        .infoArea>div>*{
            margin-left:20px;
        }
        .detail{
            width: 75%;
        }
        .rate{
            width: 25%;
            
        }
        .rate table{
            margin: auto;
            text-align: center;
            border: 1px solid gray;
            height: 100%;
            width: 100%;
            font-size:20px;
        }
        .rate>table>*{
            border: 1px solid gray;
        }
        .title{
            height: 40%;
        }

        .content{
            height: 60%;
        }
        .content>*{
        	margin-left:20px;
        	margin-right:20px;
        }


        .replyWriteArea{
            height: 10%;
            width: 90%;
            margin-left:30px;
            margin-right:30px;
            background-color: rgba(50, 50, 50, 0.6);
        }
        .replyWriteArea>*{
            float: left;
            margin-top: 15px;
            margin-left: 10px;
        }
        .replyWriteArea>table{
            border: 1px solid black;
            text-align:center;
        }

        /*댓글영역*/
        .bodyRight{
            width: 30%;
            background-color: rgba(50, 50, 50, 0.6);
        }
        .bodyRight>div{
            width: 100%;
        }
        .replyViewArea{
            height: 60%;
        }
        .recommendArea{
            height: 40%;
        }
        .yellowBtn{
        	background-color: white;
        	border-radius: 0;
		    border-top-left-radius: 0px;
		    border-bottom-left-radius: 0px;
		    padding: 2px 10px;
		    border: 1px solid red;
		    font-weight:1000;
        }
        .rpDelBtn{
        	background-color:red;
        	color:white;
        	font-size:10px;
        	width:30px;
        }
        i:hover{
        	cursor:pointer;
        	color:gray;
        }
        
        
    </style>
</head>
<body>
<%@include file="../common/header.jsp" %>
	<%	
	//로그인 안됬으면 홈으로 보내기
	if(loginUser==null){
		session.setAttribute("alertMsg", "로그인한 유저만 이용할 수 있습니다.");
		response.sendRedirect(contextPath);
	}
	%>	
    <div id="content">
        <div class="accidentBoardDetailHeader">
            <h1>사건제보영상</h1>
        </div>
        <div class="accidentBoardDetailBody">
            <div class="bodyLeft">
                <div class="videoArea">
                    <video src="<%=contextPath%><%=b.getFilePath()%>" controls id="video"></video>
                </div>
                <div class="contentArea">
                    <div class="infoArea">
                        <div class="detail">
                            <div class="title">
                                <span style="font-size:20px;font-weight:1000;"><%=b.getTitle()%></span>
                                <%if(ac.getSolve().equals("N")) {%>
                                	<span>#미해결</span>
                                <%}else{ %>
                                	<span>#해결</span>
                                <%} %>
                                <span>#<%=ac.getInsuranceType()%></span>
                            </div>
                            <div class="info">
                                <span>제보일 | <%=b.getCreateDate()%></span>
                                <span>조회수 | <%=b.getCount() %></span>
                                <span>추천수 | </span><span id="liked_count"><%=b.getLiked()%></span>
                                <span>비추천 | <%=b.getReportCount()%> </span>
                                <%if(b.getReportCount()>10){ %>
                                	<span><i class="fa-solid fa-diamond-exclamation" style="color: #e6d519;"></i></span>
                                <%}else if(b.getReportCount()>20){ %>
                                	<i class="fa-solid fa-diamond-exclamation" style="color: #f80d0d;"></i>
                                <%} %>
                                <br>
                                <span>제보자 | <%=b.getBoardWriter()%></span>
                                <span>지역 | <%=ac.getRegion()%></span>
                            </div>
                            <%if(loginUser!=null){ %>
	                            <div id="updateBtnArea" style="text-align:right; margin-right:5px;">
	                            <%if(loginUser.getLawyer().equals("Y")){ %>
	                            		<form action="enroll.ar" style="display:inline;">
	                            			<input type="hidden" name="oldFileChangeName" value="<%=b.getChangeName()%>">
	                            			<input type="hidden" name="bno" value="<%=b.getBoardNo()%>">
	                            			<input type="hidden" name="accNo" value="<%=ac.getAccNo()%>">
	                            			<input class="yellowBtn" type="submit" value="사건리뷰작성">
	                            		</form>
	                        	<%} %>
	                            		<i id="good" class="fa-regular fa-thumbs-up fa-2x"></i>
	                            		<!-- <i class="fa-solid fa-thumbs-up"></i> -->
	                            		<i id="bad" class="fa-regular fa-thumbs-down fa-2x"></i>
	                            		<!-- <i class="fa-solid fa-thumbs-down"></i> -->
		                            <%if((loginUser.getUserId().equals(b.getBoardWriter())||loginUser.getAdmin().equals("Y"))) {%>
		                            	<!-- 나중에 이미지로 바꿔서 onclick 이벤트 -->
		                            	<i onclick="location.href='<%=contextPath%>/update.ac?bno='+<%=b.getBoardNo()%>" class="fa-sharp fa-solid fa-gear fa-2x"></i>
	                            		<i onclick="location.href='<%=contextPath%>/delete.ac?bno='+<%=b.getBoardNo()%>" class="fa-sharp fa-solid fa-trash fa-2x"></i>
	                            <%} %>
	                            </div>
                            <%} %>
                            
                        </div>
                        <!-- 과실비율 -->
                        <div class="rate">
                            <table>
                                <tr>
                                    <th>제보자</th>
                                    <th>상대방</th>
                                </tr>
                                <tr>
                                    <td><%=ac.getAccRateMe() %></td>
                                    <td><%=ac.getAccRateYou() %></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- 글내용 -->
                    <div class="content">
                        <span><%=b.getContent()%></span>
                    </div>
                </div>
                <!-- 댓글작성 영역 -->
                
                <div class="replyWriteArea" >
                <%if(loginUser!=null){ %>
                    <table>
                        <tr>
                            <th>작성자</th>
                        </tr>
                        <tr>
                            <td><%=loginUser.getUserId()%></td>
                        </tr>
                    </table>
                    <textarea name="" id="reply_input" cols="60" rows="3" style="resize: none;" placeholder="댓글을 입력해주세요." required></textarea>
                    <input type="button" id="reply_btn" value="댓글등록">
                    
                <%}else{ %>
                	<table>
                        <tr>
                            <th>작성자</th>
                        </tr>
                        <tr>
                            <td>비회원</td>
                        </tr>
                    </table>
                    <textarea name="" id="reply_input" cols="60" rows="3" style="resize: none;" placeholder="로그인한 유저만 이용 가능합니다." disabled></textarea>
                    <input type="button" id="reply_btn" value="댓글등록" disabled>
                <%} %> 
                <br>   
                </div>
            </div>
            <div class="bodyRight">
                <div id="replyViewArea">
                    <table style="width:400px;">
                    	<thead>
	                    	<tr>
	                    		<th style="width:50px">작성자</th>
	                    		<th style="width:260px;word-break: break-all">내용</th>
	                    		<th style="width:50px">작성일</th>
	                    		<th style="width:40px">삭제</th>
	                    	</tr>
                    	</thead>
                    	<tbody>
                    		
                    	</tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
	        <script>
	        	//좋아요 기능
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
									alert("좋아요 취소");
									
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
	        	
	        	//싫어요
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
	        
	        
	        	//디테일 넘어왔을때 댓글 최신화
		        $(document).ready(function(){
		        	viewRpList();
		        });
	        	//댓글 입력
	        	$(function(){
	        		$("#reply_input").on("keydown",function(e){
	        			//엔터키를 눌렀을때
	        			if(e.keyCode ==13){
	        				e.preventDefault(); //줄바꿈기능을 제거하고 
	        				$("#reply_btn").click(); //버튼의 submit과 동일한기능 추가
	        			}
	        		});
	        		
	        		$("#reply_btn").on("click",function(){
	        			<%if(loginUser !=null){%>
	        				$.ajax({
	        					url:"insertRp",
	        					data:{
	        						bno:<%=b.getBoardNo()%>,
	        						content:$("#reply_input").val()
	        					},
	        					success:function(result){
	        						if(result>0){
	        							alert("댓글 등록 성공");
	        							//완료되면 댓글창 비워주기
	        							$("#reply_input").val("");
	        							
	        							//댓글 리스트 최신화
	        							viewRpList();
	        						}else{
	        							alert("댓글을 입력해주세요.");
	        						}
	        					},
	        					error:function(){
	        						alert("댓글 등록 통신 실패");
	        					}
	        				});
	        			<%}%>
	        		});
	        	});
	        	
	        	//댓글 삭제기능
	    		$(function(){
	    			$("#replyViewArea").on("click", ".rpDelBtn", function(){
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
	        	
	        	function viewRpList(){
	        		$.ajax({
	        			url:"listRp",
	        			data:{
    						bno:<%=b.getBoardNo()%>
    					},
	        			success:function(list){
	        				var str = "";
	           				if(list.length!=0){
	    	       				for(var i in list){
	    	       					str += "<tr style='padding-top:15px;padding-bottom:15px;'><input type='hidden' id='rpNo' name='rpNo' value="+list[i].rpNo+">"
	    	       					  +"<td>"+list[i].rpWriter+"</td>"
	    							  +"<td style='word-break: break-all'>"+list[i].content+"</td>"
	    							  +"<td style='font-size:8px;'>"+list[i].createDate+"</td>";
	    							  
	    							  <%if(loginUser!=null){%>
		    							  var rpWriter = list[i].rpWriter;
		    							  var loginUserId="<%=loginUser.getUserId()%>";
		    	       					  if(rpWriter==loginUserId||<%=loginUser.getAdmin().equals("Y")%>){
		    							  	str+= "<td><button class='rpDelBtn'><i class='fa-sharp fa-solid fa-trash'></i></button></td></tr>";
		    							  }else{
		    								str+= "<td></td></tr>";  
		    							  }
	    							  <%}%>
	    	       				}
	           				}else{
	           					str +="<tr><td colspan='3'>댓글이 없습니다.</td></tr>"
	           				}
	           				$("#replyViewArea>table>tbody").html(str);
	        			},
	        			error:function(){
	    					alert("댓글리스트 조회 통신 실패");
	    				}
	        		});
	        	}
	        </script>
<%@include file="../common/footer.jsp" %>
</body>
</html>