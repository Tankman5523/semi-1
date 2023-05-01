<%@page import="com.bbbox.board.model.vo.Accident"%>
<%@page import="com.bbbox.board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Board b = (Board)request.getAttribute("board");
	Accident ac = (Accident)request.getAttribute("accident");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
    <title>해결 게시글 수정</title>
    <style>
        input{
            box-sizing: border-box;
        }
        #content{
            width: 1300px;
            height: 1000px;
            margin: auto;
            color:white;
            text-align:center;
        }
        
        #content div{
       		border:none;
       	}
        
        #content>form{
            height: 100%;
            width: 100%;
        }
        #content>form *{
            text-align: center;
        }
        #content>form>div{
            width: 100%;
        }
        #content>form>div>table{
            margin: 20px;
            color:black;
        }
        #content>form>div>table *{
            background-color: white;
            border:0;
        }
        #content>form>div>table input{
            width: 100%;
            height: 100%;
        }
        #content>form>div>table select{
            width: 100%;
            height: 100%;
        }
        .title{
            height: 7%;
        }
        .inputTitle{
            font-size: 20px;
            font-weight: bold;
        }
        .privateInfo{
            height: 23%;
        }
        .privateInfo>table{
            display: inline-table;
            
            width: 600px;
            height: 50%;
            
            margin: 50px;
            margin-top: 10px;
        }

        .accidentInfo{
            height: 55%;
        }
        .accidentInfo>table{
            display: inline-table;
            width: 600px;
            height: 300px;
        }
        .submitArea{
            height: 15%;
            text-align: center;
        }
        .submitArea>*{
            margin-top: 20px;
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
        .grayBtn{
        	background-color: gray;
        	border-radius: 0;
		    border-top-left-radius: 0px;
		    border-bottom-left-radius: 0px;
		    padding: 8px 12px;
		    border: 0;
        }
    </style>
   
</head>
<body>
<%@ include file="../common/header.jsp"%>
	<%	
	//로그인 안됬으면 홈으로 보내기
	if(loginUser==null){
		session.setAttribute("alertMsg", "로그인한 유저만 이용할 수 있습니다.");
		response.sendRedirect(contextPath);
	}
	%>	
    <div id="content">
        <div class="title" style="text-align: center;">
            <div style="padding-top:10px">
        		<h2 style="margin:0;">해결 영상 게시글 수정</h2>
        	</div>
        </div>
        <form action="<%=contextPath%>/update.ac?" method="post" enctype="multipart/form-data">
            <!-- 작성자 아이디 숨겨서 가져가주세요 -->
            <input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
            <input type="hidden" name="bno" value="<%=b.getBoardNo()%>">
            <input type="hidden" name="cno" value="4">
            <div class="accidentInfo">
                <br>
                <span class="inputTitle">사건 정보 수정</span>
                <br>
                <table>
                    <tr>
                        <th><span style="color: red;">*</span> 제목</th>
                        <td>
                            <input type="text" name="title" value="<%=b.getTitle()%>" required>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 사건유형</th>
                        <td>
                            <select name="partCategory" id="partCategory">
                            	<option value="<%=ac.getRefPno()%>">변경없음</option>
                                <option value="1">대인</option>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                                <option value="2">대물</option>
                                <option value="3">음주운전</option>
                                <option value="4">뺑소니</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 과실처리</th>
                        <td>
                            <select name="insuranceType" id="insuranceType">
                            	<option value="<%=ac.getInsuranceType()%>"><%=ac.getInsuranceType()%></option>
                                <option value="보험">보험</option>
                                <option value="비보험">합의</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 사고지역</th>
                        <td>
                            <select name="region" id="region" >
                            	<option value="<%=ac.getRegion()%>"><%=ac.getRegion()%></option>
                                <option value="서울">서울</option>
                                <option value="경기">경기</option>
                                <option value="인천">인천</option>
                                <option value="충청">충청</option>
                                <option value="전라">전라</option>
                                <option value="경상">경상</option>
                                <option value="강원">강원</option>
                                <option value="제주">제주</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 과실비율</th>
                        <td>
                            <input type="number" name="accidentRateMe" class="rate" style="float:left;width: 50%;" placeholder="제보자 과실비율" value=<%=ac.getAccRateMe()%> required>
                            <input type="number" name="accidentRateYou" class="rate" style="float:left;width: 50%;" placeholder="상대방 과실비율" value=<%=ac.getAccRateYou()%> required>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 상세내용</th>
                        <td>
                            <textarea name="content" id="" cols="30" rows="10" style="resize: none;width: 95%;height: 95%;" placeholder="사고상황에 대하여 입력해주세요" required><%=b.getContent()%></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 첨부영상 <br> (50MB 이내) </th>
                        <td>
                        	<a href="<%=contextPath + b.getFilePath()%>">동영상_<%=b.getChangeName()%></a>
                    		
                        </td>
                    </tr>
                </table>
                
            </div>
            <div class="privateInfo">
                <br>
                <br>
                <span>
                    - 해결된영상 게시판에 올라온 영상은 변경할 수 없습니다.<br><br>
                    - 영상과 무관하게 내용을 변경할 경우 게시글이 삭제될 수 있습니다. <br><br>
                </span>   
                    
            </div>
            
            <div class="submitArea">
                <input type="checkbox" name="accept" id="accept"><label for="accept"> <span style="color:red">*</span> 개인정보 수집 및 이용에 동의합니다.</label>
                <br>
                <!--동의해야만 활성화 되도록 조건처리-->
                <button type="submit" id="submitBtn" class="grayBtn" disabled>제보하기</button>
            </div>
        </form>
    </div>
    
    <script>
    $(function(){     
        $("#accept").click(function(){
            if($("#accept").is(":checked")==true){
                $("#submitBtn").attr("disabled",false);
                $("#submitBtn").attr("class","yellowBtn");

            }else{
                $("#submitBtn").attr("disabled",true);
                $("#submitBtn").attr("class","grayBtn");
            }
        });
    });
    
    </script>
<%@include file="../common/footer.jsp" %>
</body>
</html>