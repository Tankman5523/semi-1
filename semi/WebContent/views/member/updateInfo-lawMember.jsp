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
                        <th>email</th>
                        <td><input type="email" id="email" name="newEmail" value="<%=loginUser.getEmail()%>"> <button class="btn btn-light btn-sm "type="button" id="applyEmail">이메일 인증</button> </td>
                    </tr>
                    <tr>
                    	<th></th>
                    	<td><input type="text" id="authentication" name="authentication" placeholder="인증번호를 입력해주세요"> <button class="btn btn-light btn-sm "type="button" id="authEmail">확인</button></td>
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
	            <button class = "btn btn-secondary" onclick ="return cancel();">취소</button>
	            <button class = "btn btn-primary" type="submit" onclick ="intoUpdate();">저장하기</button>
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
    	console.log(address);
    	
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
	<script>
	/* 이메일 변경시 이메일 재 인증 script */
   	var autKey = ""; // 인증번호 담을 변수 
   	
   	$(function(){
       	$('#email').on('click', function(){
       		
       		if(confirm('이메일 변경시, 이메일을 재인증 해야합니다 변경하시겠습니까?')){
       			
       			$('#email').val("");
       		}
       	
       	});
   		
   	});
   	
   	/*인증창 키업*/
   	$(function(){
   		/*인증창 숨겨두기*/
   		$('#info tr:eq(7)').hide()
   		
   		$('#applyEmail').on('click',function(){
   			
       		var $email = $('#email').val();
	   		console.log($email);
   			
	   		if($email =="" ||!($email.includes("@"))){
   				
   				alert("올바른 형식의 이메일을 작성해주세요");
   				return false;
   				
   			}else{
   				
   				/*이메일 중복 체크*/
   				$.ajax({
   					url : "email.chk.me",
   					
   					data :{testEmail : $email},
   					
   					type : "post",
					
					success : function(result){
						console.log(result);
						
						if(result == "YYYYY" ){
								Authentication(); // 인증번호 발송 함수 호출
						}else{
							alert("이미 사용중인 이메일 입니다. 다시 입력해주세요");
						}
								
					},
					
					error : function(){
						console.log("통신 실패");
					}
   				
   				})
       		}
   		})
   });
   	
   	/* 이메일 발송 함수 */
		function Authentication(){
			
			var $sendEmail = $('#email');
			
			$.ajax({
				url : "authentication.me",
				
				data : {sendEmail : $sendEmail.val()},
				
				type: "post",
				
				success: function (key){
					
					console.log(key);
					
					if(key.using == 'Y'){
						
						authKey = key.chord;
						
						console.log(authKey);
						
						$('#info tr:eq(7)').show()
						
						alert("이메일 인증번호 발송 완료! 이메일을 확인해주세요");
						
					}
					
					
				},
				
				error: function(){
					console.log("통신실패");
				}
			
			});
			
		}	
   	
   	/*인증번호 확인 함수*/
   	$(function(){
   		
   		$('#authEmail').on('click', function(){
   			
   			if("" == authKey){
				alert("인증번호를 입력해주세요");
				return false;
    		
    		}else if(($("#authentication").val()) == authKey){
    			
    			if(confirm("이메일 인증이 완료되었습니다.!")){
        			$("#authentication").attr("readonly",true);
    			}	
    			
    		}else{
    			alert("이메일 인증에 실패하였습니다. 다시 시도해 주세요");
    			return false;
    		}
   			
   		});
   	});
	
	</script>
	
</body>
</html>