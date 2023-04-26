<%@page import="com.bbbox.board.model.vo.Reply"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bbbox.board.model.vo.Accident"%>
<%@page import="com.bbbox.board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Board b = (Board)request.getAttribute("board");
	Accident ac = (Accident)request.getAttribute("accident");
	ArrayList<Reply> rplist = (ArrayList<Reply>)request.getAttribute("rplist");
	
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
            border: 1px solid black;
            box-sizing: border-box;
        }
        .outer{
            width: 1200px;
            height: 1200px;
            margin: auto;
        }

        /*헤더파트*/
        .accidentBoardDetailHeader{
            height: 10%;
        }

        /*바디파트*/
        .accidentBoardDetailBody{
            height: 90%;
        }
        .accidentBoardDetailBody>div{
            float: left;
            height: 100%;
        }
        .bodyLeft{
            width: 70%;
        }
        .bodyLeft>div{
            width: 100%;
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
            width: 100%;
        }
        .infoArea{
            height: 40%;
        }
        .infoArea>div{
            float: left;
            height: 100%;
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


        .replyWriteArea{
            height: 10%;
        }
        .replyWriteArea>*{
            float: left;
            margin-top: 15px;
            margin-left: 10px;
        }
        .replyWriteArea>table{
            border: 1px solid black;
        }

        /*댓글영역*/
        .bodyRight{
            width: 30%;
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
        
    </style>
</head>
<body>
<%@include file="../common/mainMenu.jsp" %>

    <div class="outer">
        <div class="accidentBoardDetailHeader">
            <h1>사건제보영상</h1>
        </div>
        <div class="accidentBoardDetailBody">
            <div class="bodyLeft">
                <div class="videoArea">
                    <video src="<%=contextPath%>/resources/accident_board_file/video1.mp4" controls poster="" id="video"></video>
                </div>
                <div class="contentArea">
                    <div class="infoArea">
                        <div class="detail">
                            <div class="title">
                                <span><%=b.getTitle()%></span>
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
                                <span>추천수 | <%=b.getLiked()%> </span>
                                <span>신고수 | <%=b.getReportCount()%> </span>
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
	                            <div id="updateBtnArea" style="text-align:right;">
	                            		<input type="button" value="좋아요" id="good">
	                            		<input type="button" value="싫어요" id="bad">
		                            <%if(loginUser.getUserId().equals(b.getBoardWriter())||loginUser.getAdmin().equals("Y")) {%>
		                            	<!-- 나중에 이미지로 바꿔서 onclick 이벤트 -->
		                            	<input type="button" value="게시글 수정" onclick="location.href='<%=contextPath%>/update.ac?bno='+<%=b.getBoardNo()%>">
		                            	<input type="button" value="게시글 삭제" onclick="location.href='<%=contextPath%>/delete.ac?bno='+<%=b.getBoardNo()%>">
	                            <%} %>
	                            </div>
                            <%} %>
                            <%if(loginUser!=null){ %>
	                            <%if(loginUser.getLawyer().equals("Y")){ %>
	                            	<div id="accidentReviewBtn">
	                            		<form action="enroll.ar">
	                            			<input type="hidden" name="oldFileChangeName" value="<%=b.getChangeName()%>">
	                            			<input type="hidden" name="bno" value="<%=b.getBoardNo()%>">
	                            			<input type="hidden" name="accNo" value="<%=ac.getAccNo()%>">
	                            			<input type="submit" value="해결완료하려면 리뷰를 작성하세요">
	                            		</form>
	                            	</div>
	                            <%} %>
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
                    <textarea name="" id="reply_input" cols="70" rows="5" style="resize: none;" placeholder="댓글을 입력해주세요."></textarea>
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
                    <textarea name="" id="" cols="70" rows="5" style="resize: none;" placeholder="로그인한 유저만 이용 가능합니다." disabled></textarea>
                    <input type="button" value="댓글작성" disabled>
                <%} %>    
                </div>
            </div>
            <div class="bodyRight">
                <div id="replyViewArea">
                    <table>
                    	
                    </table>
	                
                </div>
                <div class="recommendArea">광고맨</div>
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
	        	
	        	//싫어요
	        	$(function(){
					$("#bad").on("click", function(){
						<%if(loginUser == null){%>
							alert("로그인 후 이용해 주세요.");
						<%}else{%>
							$.ajax({
								url:"dislike.bo",
								data:{
									bno:<%=b.getBoardNo()%>,
									uno:<%=loginUser.getUserNo()%>
								},
								success:function(result2){
									if(result2>0){
										alert("이 게시글을 싫어합니다.");
									}else{
										alert("이미 싫어요한 게시글입니다.");
									}
								},
								error:function(){
									alert("통신 에러");
								}
							});
						<%}%>
					});
				});
	        
	        
	        	//디테일 넘어왔을때 댓글 최신화
		        $(document).ready(function(){
		        	viewRpList();
		        });
	        
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
	        							alert("댓글 등록 실패");
	        						}
	        					},
	        					error:function(){
	        						alert("댓글 등록 통신 실패");
	        					}
	        				});
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
	        				
	        				for(var i in list){
	        					str += "<tr><td>"+list[i].rpWriter+"</td>"
								  +"<td style='text-align:left; padding-left: 5px;'>"+list[i].content+"</td>"
								  +"<td>"+list[i].createDate+"</td></tr>";
	        	        		
	        				}
	        				$("#replyViewArea>table").html(str);
	        			},
	        			error:function(){
	    					alert("댓글리스트 조회 통신 실패");
	    				}
	        		});
	        	}
	        </script>
</body>
</html>