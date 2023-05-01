<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int bno = (int)request.getAttribute("bno");
	int accNo= (int)request.getAttribute("accNo");
	String oldFileChangeName = (String)request.getAttribute("oldFileChangeName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사건 리뷰 작성</title>
    <style>
        div{
            box-sizing: border-box;
        }
        #content{
            width: 1300px;
            height: 800px;
            margin: auto;
            color:white;
            text-align:center;
        }
        #content div{
            text-align: center;
        }
        #content>div{
            width: 100%;
            
        }
        .titleArea{
            height: 10%;
        }
        .titleArea>h1{
        	margin:0;
        	padding-top:20px;
        	color: rgb(255, 236, 173);
        }
        .reviewEnrollForm{
            height: 70%;
        }
        #content>form{
            height: 80%;
            width: 100%;
        }
        #contentArea{
            margin-top: 20px;
            height: 70%;
        }
        #contentArea>div{
            float: left;
            height: 100%;
            width: 100%;
        }
        #InfoArea{
        	height:30%
        }
        
        .submitArea{
            height: 20%;
        }
		
		 /*버튼 커스텀*/
        .yellowBtn{
        	background-color: #f9d700;
        	border-radius: 0;
		    border-top-left-radius: 0px;
		    border-bottom-left-radius: 0px;
		    padding: 8px 12px;
		    border: 0;
        }
        .yellowBtn:hover{
        	cursor: pointer;
        }
		
		
    </style>
</head>
<body>
<%@include file="../common/header.jsp" %>
    <!--디자인 나중에 합시당-->
    <div id="content">
        <div class="titleArea">
            <h1>사건리뷰 작성</h1>
        </div>
        <form action="enroll.ar" method="post" enctype="multipart/form-data">
        <div class="reviewEnrollForm">
            <div id="contentArea" >
                <table style="display: inline-table;">
                   <tr>
                    <th>내용</th>
                    <td><textarea name="content" id="reviewContent" cols="60" rows="15" placeholder="리뷰 내용을 작성해주세요." style="resize: none;"></textarea></td>
                   </tr> 
                </table>
            </div>
            <div  id="InfoArea" style="width: 100%;">
                <table style="display: inline-table;">
                    <tr>
                        <th rowspan="2">수정 과실비율</th>
                        <th>제보자</th>
                        <th>상대방</th>
                    </tr>
                    <tr>
                        <td><input type="number" name="correctRateMe"></td>
                        <td><input type="number" name="correctRateYou"></td>
                    </tr>
                    <tr>
                        <th>리뷰영상</th>
                        <td colspan="2"><input type="file" name="reviewVideo" id="reviewVideo"></td>
                    </tr>
                </table>
            </div>    
        </div>
        <div class="submitArea">
        	<!-- 리뷰 작성되면 solve값 y로 변경 -->
        	
            <button class="yellowBtn" type="submit">리뷰 작성</button>
        </div>
        <!--회원번호 , 글번호, 사건번호-->
        <input type="hidden" name="uno" value="<%=loginUser.getUserNo()%>">
        <input type="hidden" name="bno" value="<%=bno%>">
        <!-- 사고리뷰는 참조값이 accidentNo에 걸려있음 -->
        <input type="hidden" name="accNo" value="<%=accNo%>">
        <!-- 기존 영상 파일명 -->
        <input type="hidden" name="oldFileChangeName" value="<%=oldFileChangeName%>">
        </form>
    </div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>