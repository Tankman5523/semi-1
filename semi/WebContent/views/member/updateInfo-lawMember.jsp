<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.bbbox.lawyer.model.vo.Lawyer" %>
<%
	
 	Lawyer lawInfo = (Lawyer)request.getAttribute("lawInfo");

	String lat = (String)request.getAttribute("lat");

%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 회원정보 수정 페이지</title>

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
		width:1000px;
		height:100%;
	    margin: auto;
		overflow-y:scroll;
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
	}	
	
	h4{
		font-family: 'SBAggroB';
		font-weight:300;
		font-size: 20px;
		color:white;
		
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
<%@ include file="../common/header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <div id="content">
    	<form class ="law_content" action="<%=contextPath%>/update_info.la" method="post" enctype="multipart/form-data">
	        <h2 align="center">회원정보</h2>
	        <hr>
	        <!-- 기본정보 뷰 -->
	      	<h4  align="center" >INFO</h4>
	            <table id="info">
	                <tr>
	                    <td width="150">아이디</td>
	                    <td><%=loginUser.getUserId()%></td>
	                    <td></td>
	                </tr>
	                 <tr>
                        <td>비밀번호 변경</td>
                        <td><input type="password" name="newPwd" id="pwd" value="<%=loginUser.getUserPwd()%>"></td> <!-- 회원가입이랑 동일하게 keyup 사용-->
                    </tr>
                    <tr>
                        <td>비밀번호 확인</td>
                        <td><input type="password" name="chkPwd" id="chkPwd"></td>
                    </tr>
                    <tr>
                     <td></td>
                        <td><div class="match" style="color: blue">비밀번호가 일치합니다</div><div class="nomatch" style="color: red;">비밀번호가 일치하지 않습니다.</div></td>
                    </tr>
	                <tr>
                        <td>이름</td>
                        <td><input type="text" id="name" name="newName" value="<%=loginUser.getUserName()%>"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>핸드폰</td>
                        <td><input type="text" id="phone" name="newPhone" placeholder="-포함하여 입력해주세요" value="<%=loginUser.getPhone()%>"></td>
                    </tr>
                    <tr>
                        <td>email</td>
                        <td><input type="email" id="email" name="newEmail" value="<%=loginUser.getEmail()%>"> <button class= "btn btn-light btn-sm"type="button" >이메일 인증</button> </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><p style="font-size: 13px; color: yellow;">이메일주소는 개인정보찾기에 사용되어지니 정확한 이메일주소를 입력해주세요</p></td>
                    </tr>
                    <tr>
                        <td>주소</td>
                        <td><input type="text" name="newAddress" id="address" value="<%=loginUser.getAddress()%>"></td>
                    </tr>
	            </table>
	        <hr>
	            <table id="lawInfo">
	                <tr>
	                    <td rowspan="4" width="150">사진</td>
	                    <td rowspan="4" colspan ="4" id="profile" ><img width="150" height="180" src="<%=contextPath+lat%>"></td>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                	<td></td>
	                    <td><input type="file" name="profile"></td>
	                </tr>    
	                <tr>
	                    <td>시험</td>
	                    <td><%=lawInfo.getExam()%></td>
	                </tr>
	                <tr>
	                    <td>회차</td>
	                    <td><%=lawInfo.getExamSession()%>회</td>
	                </tr>
	                <tr>
	                    <td>합격년도</td>
	                    <td><%=lawInfo.getPassDate()%>년도</td>
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
	                    	<option id="userRegion"></option>
	                        <option value="서울 ">서울</option>
	                        <option value="경기 ">경기도</option>
	                        <option value="강원 ">강원도</option>
	                        <option value="충청 ">충청도</option>
	                        <option value="전라 ">전라도</option>
	                        <option value="경상 ">경상도</option>
	                        <option value="제주 ">제주도</option>
	                    </select> <input type="text" name="address" id="companyaddress" required></td>
	                    <td><input type="hidden" id="resultAddress" name="resultAddress" required></td> 
	                </tr>
	                <tr>
	                    <td>사무소 이름</td>
	                    <td><input type="text" name="companyName" required value="<%=lawInfo.getCompanyName()%>"></td>
	                </tr>
	                <tr>
	                    <td>사무소 번호</td>
	                    <td><input type="text" name="companyPhone" required value="<%=lawInfo.getCompanyPn()%>"></td>
	                </tr>
	            </table> 
	        <hr>
	            <table id="lawComent">
	                <tr>
	                    <td width="150">한줄소개</td>
	                    <td><textarea name="comment" cols="40" rows="3" style="resize: none;" required> <%=lawInfo.getLawComment()%> </textarea></td>
	                </tr>
	                <tr>
	                    <td>경력</td>
	                    <td><textarea name="career" cols="40" rows="5" style="resize: none;" required><%=lawInfo.getCareer()%></textarea></td>
	                </tr>
	            </table>    
	        <hr>    
	        <!-- 버튼 -->
	        <br><br>
	        <div id="btn" align="center">
	            <button onclick ="return cancel();">취소</button>
	            <button type="submit" onclick ="intoUpdate();">저장하기</button>
	        </div>
	        <br><br>
    	</form>
    </div>
    
    <script>
    	
   	 /*사진변경 */
    	$(function(){
    		$('#photo').hide() //파일 첨부 영역 숨기기
    		
    		$('#profile').click(function(){
    			$('#file1').click()
    		});
    		
    	})	
    /*주소 잘라서 보여주기 */
    $(function(){
    	
    	var address = '<%=lawInfo.getCompanyAddress()%>' //전체 주소 
    	
    	//지역
    	var region = address.substring(0,2);
    	$('#userRegion').val(region);
    	$('#userRegion').text(region);
    	
    	//상세주소 
    	var detailaddress = address.substring(2); 
    	
    	$('#companyaddress').val(detailaddress);
    	
    
    })
    
    
    	/* 취소 */
    	function cancel(){
    		if(confirm("작성한 내용은 저장되지 않습니다. 취소하시겠습니까?")){
    			location.href="<%=contextPath%>/myPage.me"
    		}else{
	    		return false;
    		}
    	}
    	
    	/* 저장하기  */
    	function intoUpdate(){
    		
    		var $result = $('#resultAddress');
    		
    		var $region = $('#region').val();
    		
    		var $address = $('#address').val();
    		
    		$result.val($region + $address);
    		
    		
    		
    	};


        /* 비밀번호 유효성 검사 script*/
        $(function(){
            $(".match").css("color","blue").hide();
            $(".nomatch").css("color","red").hide();

            $("input").keyup(function(){
                var $newPwd = $("#info input[name=newPwd]").val();

                var $chkPwd = $("#info input[name=chkPwd]").val();
                
                if($newPwd != "" || $chkPwd !=""){
                    if($newPwd == $chkPwd){
                        $(".match").show();
                        $(".nomatch").hide();
                        
                    }else{
                        $(".nomatch").show();
                        $(".match").hide();
                        $("button[type=submit]").attr("disabled");
                    }
                }
                
            })
            
        });
        	
       	function access(){
       		
       		var pwd = $("#pwd").val();
       		
       		var chk = $("#chkPwd").val();
       		
       		var num = pwd.search(/[0-9]/g);
       		
       		var eng = pwd.search(/[a-z]/ig);
       		
       		var spe = pwd.search(/[~!@#$%^&*?]/gi);
       		
    			if(pwd != chk){
    				alert("비밀번호가 일치하지 않습니다.");
 	       		return false;
 	       		
    			}else if(pwd.length < 8 || 15< pwd.length){
    				alert("8자리 이상, 15자리 이하로만 입력해주세요.");
    				$("#pwd").focus();
    				return false;
    				
    			}else if(pwd.search(/\s/)!=-1){
    				alert("비밀번호는 공백 없이 입력해주세요.");
    				$("#pwd").focus();
    				return false;
    				
    			}else if((num<0 && eng <0)||(eng<0 && spe <0 )||(spe <0 && num <0)){
    				alert("영문자,숫자,특수문자 중 2가지 이상을 혼합하여 입력해주세요");
    				$("#pwd").focus();
    				return false;
    			}
       			
       			console.log("통과");
       			
       			
       		}
       	
	</script>
	
</body>
</html>