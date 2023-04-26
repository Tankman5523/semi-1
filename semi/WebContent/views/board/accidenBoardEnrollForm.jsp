<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
    <title>영상 제보하기</title>
    <style>
        input{
            box-sizing: border-box;
        }
        div{
            border: 1px solid black;
            box-sizing: border-box;
        }
        
        .outer{
            width: 1200px;
            height: 1000px;
            margin: auto;
        }
        .outer>form{
            height: 100%;
            width: 100%;
        }
        .outer>form *{
            text-align: center;
        }
        .outer>form>div{
            width: 100%;
        }
        .outer>form>div>table{
            margin: 20px;
        }
        .outer>form>div>table *{
            background-color: white;
        }
        .outer>form>div>table input{
            width: 100%;
            height: 100%;
        }
        .outer>form>div>table select{
            width: 100%;
            height: 100%;
        }
        .title{
            height: 15%;
        }
        .inputTitle{
            font-size: 20px;
            font-weight: bold;
        }
        .privateInfo{
            height: 25%;
        }
        .privateInfo>table{
            display: inline-table;
            
            width: 600px;
            height: 50%;
            
            margin: 50px;
            margin-top: 10px;
        }

        .accidentInfo{
            height: 50%;
        }
        .accidentInfo>table{
            display: inline-table;
            width: 600px;
            height: 300px;
            
        }
        .submitArea{
            height: 10%;
            text-align: center;
        }
        .submitArea>*{
            margin-top: 20px;
        }
        
    </style>
   
</head>
<body>
<%@ include file="../common/mainMenu.jsp"%>

	<%	
	//로그인 안됬으면 홈으로 보내기
	if(loginUser==null){
		session.setAttribute("alertMsg", "로그인한 유저만 이용할 수 있습니다.");
		response.sendRedirect(contextPath);
	}
	%>	
	<!-- 비로그인시 오류방지 -->
	<%if(loginUser!=null){ %>
    <div class="outer">
        <div class="title" style="text-align: center;">
            <h1>영상 제보하기</h1>
        </div>
        <form action="<%=contextPath%>/enroll.ac" method="post" enctype="multipart/form-data">
            <!-- 작성자 아이디 숨겨서 가져가주세요 -->
            <input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
            <div class="privateInfo">
                <br>
                <span class="inputTitle">개인 정보 입력</span>
                <!-- 
                    로그인정보에 다 있는데 굳이 다시 물어봐야하는건지..?
                    가져와도 담을 DB가 없음, 굳이 테이블을 만들 이유가 없는데?
                -->
                
                <br>
                <table>
                    <tr>
                        <th>이름</th>
                        <td><input type="text" name="userName" id="" placeholder="로그인된 정보 자동입력" value="<%=loginUser.getUserName()%>"></td>
                    </tr>
                    <tr>
                        <th>휴대폰 번호</th>
                        <td><input type="text" name="phone" id="" placeholder="- 포함입력" value="<%=loginUser.getPhone()%>"></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td><input type="email" name="email" id="" placeholder="로그인된 정보 자동입력" value="<%=loginUser.getEmail()%>"></td>
                    </tr>
                </table>
                <br>
                <span>회원정보에 입력하지 않으신 사항에 대해서는 반드시 입력바랍니다.</span>
            </div>
            <div class="accidentInfo">
                <br>
                <span class="inputTitle">사건 정보 입력</span>
                <br>
                <table>
                    <tr>
                        <th><span style="color: red;">*</span> 제목</th>
                        <td>
                            <input type="text" name="title" required>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 사건유형</th>
                        <td>
                            <select name="partCategory" id="partCategory">
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
                                <option value="보험">보험</option>
                                <option value="비보험">합의</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 사고지역</th>
                        <td>
                            <select name="region" id="region">
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
                            <input type="number" name="accidentRateMe" class="rate" style="float:left;width: 50%;" placeholder="제보자 과실비율" required><input type="number" name="accidentRateYou" class="rate" style="float:left;width: 50%;" placeholder="상대방 과실비율" required>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 상세내용</th>
                        <td>
                            <textarea name="content" id="" cols="30" rows="10" style="resize: none;width: 100%;height: 100%;" placeholder="사고상황에 대하여 입력해주세요" required></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span> 첨부영상 <br> (50MB 이내) </th>
                        <td>
                            <input type="file" name="video" required>
                        </td>
                    </tr>
                </table>
                <br>
                <span>
                    - 정확하고 자세한 내용을 입력하여 변호사의 신속한 컨텍에 도움이 될수 있도록 하십시오.<br><br>
                    - 제보하신 영상은 관리자의 확인 후 3일 내로 영상제보 게시판에 게시됩니다. <br><br>
                    - 영상 외에 다른 첨부파일을 선택하시면 게시물이 삭제됩니다. <br>
                    
                </span>
            </div>
            <div class="submitArea">
                <input type="checkbox" name="accept" id="accept"><label for="accept"> <span style="color:red">*</span> 개인정보 수집 및 이용에 동의합니다.</label>
                <br>
                <!--동의해야만 활성화 되도록 조건처리-->
                <button type="submit" id="submitBtn" disabled>제보하기</button>
            </div>
        </form>
    </div>
    <%} %>
    <script>
    $(function(){     
        $("#accept").click(function(){
            if($("#accept").is(":checked")==true){
                $("#submitBtn").attr("disabled",false);
            }else{
                $("#submitBtn").attr("disabled",true);
            }
        });
        
    });
    
    </script>

</body>
</html>