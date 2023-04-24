<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 회원 신청 페이지</title>
<style>
       .content{
            width: 1200px;
            box-sizing: border-box;
            margin-top:10px;
        }
        
        .law_content{
        	width:1000px;
            margin: auto;
        }
        #info, #lawInfo, #lawComent{
            width: 70%;
            margin-left: 200px;
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
    <div class="content">
    	<form class ="law_content" action="<%=contextPath%>/apply_Lawyer.me" method="post" enctype="multipart/form-data">
	        <h2 align="center">변호사 회원 신청</h2>
	        <hr>
	        <!-- 기본정보 뷰 -->
	            <table id="info">
	            	<thead>
		            	<tr>
		            		<td height ="30"><b>[기본회원 정보]</b></td>
	    	        	</tr>
	            	</thead>
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
	                    <td><input type="text" name="pass" id="pass" placeholder="숫자만 입력해주세요"></td>
	                </tr>
	                <tr>
	                    <td>합격년도</td>
	                    <td><input type="text" name="passdate" id="passdate" placeholder="숫자만 입력해주세요"></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>전문분야</td>
	                    <td><select name="category" id="category">
	                        <option value="0">분야를 선택해주세요</option>
	                        <option value="1">대인</option>
	                        <option value="2">대물</option>
	                        <option value="3">음주</option>
	                        <option value="4">뺑소니</option>
	                    </select></td>
	                </tr>
	                <tr>
	                    <td>주소</td>
	                    <td><select name="region" id="region">
	                        <option value="지역">지역 선택</option>
	                        <option value="서울 ">서울</option>
	                        <option value="경기도 ">경기도</option>
	                        <option value="강원도 ">강원도</option>
	                        <option value="충청도 ">충청도</option>
	                        <option value="전라도 ">전라도</option>
	                        <option value="경상도 ">경상도</option>
	                        <option value="제주도 ">제주도</option>
	                    </select> <input type="text" name="address" id="address"></td>
	                    <td><input type="hidden" id="resultAddress" name="resultAddress"></td>  <!-- 주소 합쳐서 문자열로 데이터베이스에 넘기기 -->
	                </tr>
	                <tr>
	                    <td>사무소 이름</td>
	                    <td><input type="text" name="companyName"></td>
	                </tr>
	                <tr>
	                    <td>사무소 번호</td>
	                    <td><input type="text" name="companyPhone"></td>
	                </tr>
	            </table> 
	        <hr>
	            <table id="lawComent">
	                <tr>
	                    <td width="150">한줄소개</td>
	                    <td><textarea name="comment" id="" cols="40" rows="3" style="resize: none;"></textarea></td>
	                </tr>
	                <tr>
	                    <td>경력</td>
	                    <td><textarea name="career" id="" cols="40" rows="5" style="resize: none;"></textarea></td>
	                </tr>
	            </table>    
	        <hr>    
	        <!-- 버튼 -->
	        <br><br>
	        <div id="btn" align="center">
	            <button onclick ="return cancel();">취소</button>
	            <button type="submit" onclick ="applyla();">신청하기</button>
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
</body>
</html>