<%@page import="com.bbbox.board.model.vo.AccidentReview"%>
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
	AccidentReview ar = (AccidentReview)request.getAttribute("review");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
            height: 30%;
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
            width: 80%;
        }
        .rate{
            width: 20%;
        }
        .rate table{
            margin: auto;
            text-align: center;
            border: 1px solid gray;
            height: 100%;
            width: 100%;
            font-size: 20px;
        }
        .rate>table>*{
            border: 1px solid gray;
        }
        .title{
            height: 40%;
        }
        .info{
            height: 60%;
        }

        .content{
            height: 60%;
        }

        /*리뷰 영역*/
        .reviewArea{
            height: 10%;
        }
        .reviewArea>div{
            float: left;
            height: 100%;
        }
        .reviewContent{
            width: 80%;
        }
        .correctRate{
            width: 20%;
        }
        .correctRate table{
            margin: auto;
            text-align: center;
            border: 1px solid gray;
            height: 100%;
            width: 100%;
            font-size: 20px;
        }


        /*댓글작성영역*/
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
            <h1>해결된 영상</h1>
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
                                <span>조회수 | <%=b.getCount()%></span>
                                <span>신고수 | <%=b.getReportCount()%> </span>
                                
                                <br>
                                <span>제보자 | <%=b.getBoardWriter()%></span>
                                <span>지역 | <%=ac.getRegion()%></span>
                            </div>
                        </div>
                        <div class="rate">
                            <table>
                                <tr>
                                    <th>제보자</th>
                                    <th>상대방</th>
                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>5</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="content">
                        <span><%=b.getContent()%></span>
                    </div>
                </div>
                <div class="reviewArea">
                    <div class="reviewContent">
                        <span><%=ar.getLawName() %> 변호사</span><br>
                        <span><%=ar.getContent() %> </span>
                    </div>
                    <div class="correctRate">
                        <table>
                            <tr>
                                <th>제보자</th>
                                <th>상대방</th>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="replyWriteArea">
                    <table>
                        <tr>
                            <th>작성자</th>
                        </tr>
                        <tr>
                            <td>아이디</td>
                        </tr>
                    </table>
                    <textarea name="" id="" cols="70" rows="5" style="resize: none;" placeholder="댓글을 입력해주세요."></textarea>
                    <input type="submit" value="댓글작성">
                </div>
            </div>
            <div class="bodyRight">
                <div class="replyViewArea">
                    <div>
                        <table>
                            <tr>
                                <th>아이디</th>
                            </tr>
                            <tr>
                                <td>댓글내용</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="recommendArea">광고나해라</div>
            </div>
        </div>
       
    </div>
</body>
</html>