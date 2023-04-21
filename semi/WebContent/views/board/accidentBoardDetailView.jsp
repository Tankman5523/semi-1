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
                                <br>
                                <span>제보자 | <%=b.getBoardWriter()%></span>
                                <span>지역 | <%=ac.getRegion()%></span>
                            </div>
                            <%if(loginUser!=null){ %>
	                            <%if(loginUser.getUserId().equals(b.getBoardWriter())||loginUser.getAdmin().equals("Y")) {%>
	                        
		                            <div id="updateBtnArea" style="text-align:right;">
		                            	<!-- 나중에 이미지로 바꿔서 onclick 이벤트 -->
		                            	<input type="button" value="게시글 수정" onclick="location.href='<%=contextPath%>/update.ac?bno='+<%=b.getBoardNo()%>">
		                            	<input type="button" value="게시글 삭제" onclick="location.href='<%=contextPath%>/delete.ac?bno='+<%=b.getBoardNo()%>">
		                            </div>
	                            <%} %>
                            <%} %>
                            <%if(loginUser.getLawyer().equals("Y")){ %>
                            	<div id="accidentReviewBtn">
                            		<form action="enroll.ar">
                            			<input type="hidden" name="bno" value="<%=b.getBoardNo()%>">
                            			<input type="hidden" name="accNo" value="<%=ac.getAccNo()%>">
                            			<input type="submit" value="해결완료하려면 리뷰를 작성하세요">
                            		</form>
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
                
                <div class="replyWriteArea">
                <%if(loginUser!=null){ %>
                    <table>
                        <tr>
                            <th>작성자</th>
                        </tr>
                        <tr>
                            <td><%=loginUser.getUserId()%></td>
                        </tr>
                    </table>
                    <textarea name="" id="" cols="70" rows="5" style="resize: none;" placeholder="댓글을 입력해주세요."></textarea>
                    <input type="submit" value="댓글작성">
                <%}else{ %>
                	<table>
                        <tr>
                            <th>작성자</th>
                        </tr>
                        <tr>
                            <td>-</td>
                        </tr>
                    </table>
                    <textarea name="" id="" cols="70" rows="5" style="resize: none;" placeholder="로그인한 유저만 이용 가능합니다." readonly></textarea>
                    <input type="submit" value="댓글작성" disabled>
                <%} %>    
                </div>
            </div>
            <div class="bodyRight">
                <div class="replyViewArea">
                    <%for(int i=0;i<rplist.size();i++){ %>
	                    <div>
	                        <table>
	                            <tr>
	                                <th><%=rplist.get(i).getRpWriter()%></th>
	                            </tr>
	                            <tr>
	                                <td><%=rplist.get(i).getContent() %></td>
	                            </tr>
	                        </table>
	                    </div>
                    <%} %>
                </div>
                <div class="recommendArea">광고맨</div>
            </div>
        </div>
       
    </div>
</body>
</html>