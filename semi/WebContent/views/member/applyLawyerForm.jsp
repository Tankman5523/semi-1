<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 회원 신청 페이지</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
       /* 폰트 */
   	@font-face{
   		font-family: 'SBAggroB';
 		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');	
   		font-weight: normal;
  		font-style: normal;
	}    
	
	@font-face {
	    font-family: 'Cafe24Ohsquare';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/Cafe24Ohsquare.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	@font-face {
	    font-family: 'HallymGothic-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2204@1.0/HallymGothic-Regular.woff2') format('woff2');
	    font-weight: 400;
	    font-style: normal;
	}
       
	.law_content{
		width:1200px;
		height:100%;
	    margin: auto;
	}
	
	hr{
		background : white;
		height: 1.5px;
		border:0;
	}
	.law_content h2{
		font-family: 'SBAggroB';
		font-weight:300;
		font-size: 30px;
		color:white;
		padding-top : 50px;
	}	
	
	h4{
		font-family: 'SBAggroB';
		font-weight:300;
		font-size: 20px;
		color:white;
		margin-left: 250px;
		margin-bottom: 20px;
		
	}	
	
	#info, #lawInfo, #lawComent{
	    width: 60%;
	    margin-left: 250px;
	 }
	 
	td{
		 font-family: 'Cafe24Ohsquare';
		 color: white;
		 height: 36px;
		 font-size: 18px;
	} 
	 
	 
	a{
	    text-decoration: none;
	    color: black;
	    display: block;
	}
	
	#btn button{
	    margin-left: 20px;
	    margin-right: 20px;
        }
    </style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<<<<<<< HEAD
    <div id="content" style = "overflow:auto">
=======
    <div class="content">
>>>>>>> refs/remotes/origin/master
    	<form class ="law_content" action="<%=contextPath%>/apply_Lawyer.me" method="post" enctype="multipart/form-data">
	        <h2 align="center">변호사 회원 신청</h2>
	        <hr>
          	<h4>INFO</h4>
	        <!-- 기본정보 뷰 -->
	            <table id="info">
	                <tr>
	                    <td width="150">아이디</td>
	                    <td><%=loginUser.getUserId()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>이름</td>
	                    <td><%=loginUser.getUserName()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>핸드폰번호</td>
	                    <td><%=loginUser.getPhone()%></td>
	                </tr>
	                <tr>
	                    <td>email</td>
	                    <td><%=loginUser.getEmail()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>주소</td>
	                    <td><%=loginUser.getAddress()%></td>
	                </tr>
	            </table>
	        <hr>
	            <table id="lawInfo">
	                <tr>
	                    <td width="150">사진</td>
	                    <td><input type="file" onchange ="" id="file1" name = "profile" required></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>시험</td>
	                    <td><select name="test" id="test">
	                        <option value="출신시험">출신시험 선택</option>
	                        <option value="사법고시">사법고시</option>
	                        <option value="변호사시험">변호사시험</option>
	                        <option value="고등고시">고등고시</option>
	                    </select></td>
	                </tr>
	                <tr>
	                    <td>회차</td>
	                    <td><input type="text" name="pass" id="pass" placeholder="숫자만 입력해주세요" required></td>
	                </tr>
	                <tr>
	                    <td>합격년도</td>
	                    <td><input type="text" name="passdate" id="passdate" placeholder="숫자만 입력해주세요" required></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>전문분야</td>
	                    <td><select name="category" id="category" required>
	                        <option value="1">대인</option>
	                        <option value="2">대물</option>
	                        <option value="3">음주</option>
	                        <option value="4">뺑소니</option>
	                    </select></td>
	                </tr>
	                <tr>
	                    <td>주소</td>
	                    <td><select name="region" id="region" required >
	                        <option value="서울 ">서울</option>
	                        <option value="경기도 ">경기도</option>
	                        <option value="강원도 ">강원도</option>
	                        <option value="충청도 ">충청도</option>
	                        <option value="전라도 ">전라도</option>
	                        <option value="경상도 ">경상도</option>
	                        <option value="제주도 ">제주도</option>
	                    </select> <input type="text" name="address" id="address" required></td>
	                    <td><input type="hidden" id="resultAddress" name="resultAddress" required></td>  <!-- 주소 합쳐서 문자열로 데이터베이스에 넘기기 -->
	                </tr>
	                <tr>
	                    <td>사무소 이름</td>
	                    <td><input type="text" name="companyName" required></td>
	                </tr>
	                <tr>
	                    <td>사무소 번호</td>
	                    <td><input type="text" name="companyPhone" required></td>
	                </tr>
	            </table> 
	        <hr>
	            <table id="lawComent">
	                <tr>
	                    <td width="150">한줄소개</td>
	                    <td><textarea name="comment" id="" cols="40" rows="3" maxlength="30" style="resize: none;" placeholder="30자 이하로 작성해주세요" required></textarea></td>
	                </tr>
	                <tr>
	                    <td>경력</td>
	                    <td><textarea name="career" id="" cols="40" rows="5" maxlength="80" style="resize: none;" placeholder="80자 이하로 작성해주세요" required></textarea></td>
	                </tr>
	            </table>    
	        <hr>    
	        <!-- 버튼 -->
	        <br><br>
	        <div id="btn" align="center">
	            <button class = "btn btn-secondary"onclick ="return cancel();">취소</button>
	            <button class = "btn btn-warning" type="submit" onclick ="applyla();">신청하기</button>
	        </div>
	        <br><br>
    	</form>
    </div>
    
    <script>
    	/* 취소 */
    	function cancel(){
    		if(confirm("작성한 내용은 저장되지 않습니다. 취소하시겠습니까?")){
    			location.href="<%=contextPath%>/myPage.me"
    		}else{
	    		return false;
    		}
    	}
    	
    	/*신청하기 */
    	function applyla(){
    		
    		var $result = $('#resultAddress');
    		
    		var $region = $('#region').val();
    		
    		var $address = $('#address').val();
    		
    		$result.val($region + $address);
    		
    		
    		
    	};
    </script>
<%@ include file = "../common/footer.jsp"%>