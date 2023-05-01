<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

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
		    font-family: 'SUIT-Regular';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
		    font-weight: normal;
		    font-style: normal;
		}
		
        .enroll-form{
            width: 80% ;
            height: 90%;
            margin:auto;
            padding-top: 35px;
        }
        
        .enroll-form>h1{
            font-family: 'SBAggroB';
            font-size : 45px;
            font-weight: 300;
            color : white;
        }
        
        #enroll-table{
        	height : 100%;
            margin-left: 350px;
			margin-top : 50px;
			margin-bottom : 50px;
			
        }
		
		#enroll-table tr {
			height: 35px;
		}
		tbody th{
			text-align: left;
			font-family: 'SBAggroB';
			font-size:18px;
			font-weight: 300;
			color : white;
		}
		
		tbody label{
			margin-bottom:0px;
		}
		
		#checkResult{
			margin-left : 10px;
		}

        #enroll-btn{
            width: 50%;
            height: 50px;
            margin: auto;
            
        }
        #enroll-btn button{
            width: 20%;
            margin-top: 13px;
            margin-left: 20px;
            margin-right: 20px;
            
        }
        
      

    </style>

<%@ include file ="../common/header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
       
    	/* 아이디 중복확인 + 올바른 형식 */
        function chkId(){
        	
    		var idCheck =/^[a-zA-Z]{1}[a-zA-Z0-9]{3,11}$/;
        	
        	var $chkId = $('#join-form input[name=inputId]');
        	
        	$.ajax({
        		url : "idCheck.me",
        		
        		data : {id : $chkId.val() },
        		
        		type : "get",
        		
        		success : function(result){
        			if(result =='NNNN'){
        				var fail = "이미 사용중이거나 탈퇴한 회원의 아이디 입니다."
        				$('#checkResult').html(fail);
        				$chkId.focus();
        			
        			}else{//아이디 중복에 걸리지 않았을 경우 
        				
        				if(!idCheck.test($chkId.val())){
                            alert("아이디형식이 올바르지 않습니다. 다시 입력해주세요")
                            userId.select();
                            return false;
                        }
        				
						var success = "사용 가능한 아이디 입니다."
							$('#checkResult').html(success).css("color","white");
        			}
        		}
        	});
        }
        	
        	
    </script>
    
 <div id="content">
    <div class="enroll-form">
        <br>
        <h1 align="center">회원가입</h1>
        <form action="<%=request.getContextPath()%>/enroll.me" method="post">
            <table id="enroll-table">
                <tr> 
                    <th width="150" height="40"><label for="userId" >아이디</label></th>
                    <td width="500"><input class="input-group-sm" type="text" name="inputId" id="userId" maxlength="12" required placeholder = "아이디를 입력해주세요"> 
                    	<button class="btn btn-light btn-sm" id ="check_btn" type="button" onclick = "return chkId();"> 중복확인 </button> <label id="checkResult"></label></td>
                </tr>
                <tr>
                	<th></th>
               		<td><p style="color:yellow">영어와 숫자만을 사용하여 4~11자로 작성해주세요</p></td>
                </tr>  
                <tr>
                    <th><label for="userPwd">비밀번호</label></th>
                    <td><input type="password" name="inputPwd" id="userPwd" maxlength="15" required placeholder = "숫자,영어,특수문자를 포함하여 4~15자로 작성해주세요" ></td>
                </tr>
                <tr>
                    <th><label for="chkPwd">비밀번호 확인</label></th>
                    <td><input type="password" id="checkPwd" name="checkPwd"maxlength="15" required placeholder = "숫자,영어,특수문자를 포함하여 4~15자로 작성해주세요"></td>
                </tr>  
                <tr>
                	<th></th>
                    <td><label id="success">비밀번호가 일치합니다.</label> <label id="fail">비밀번호가 일치하지 않습니다.</label></td> <!-- 비밀번호일치 keyUP영  -->                  
                </tr>
                <tr>
                	<th><label for="userName">이름</label></th>
                    <td><input type="text" name = "inputName" id="userName" required placeholder="예)홍길동"></td>
                </tr>
                <tr>
                    <th><label for="inputEmail">이메일</label></th>
                	<td><input type="text" name="email"id="inputEmail" required>
                		<button class="btn btn-light btn-sm" type="button" onclick="return doubleChk();"  >이메일 확인</button> <label id="emailTestResult"></label> </td>
                </tr>
                <tr>
                	<th>이메일 인증</th>
					<td><input id="authentication" type ="text" required >
						<button class="btn btn-light btn-sm" type="button" onclick="return emailSubmit();">인증하기</button> <label id=emailChk></label> </td>
                </tr>
                <tr>
                    <th><label for="inputPhone">핸드폰 번호</label><br></th>
                    <td> <input type="text" name="phone" id="inputPhone"></td>
                </tr>
                <tr>
                    <th><label for="inputAddress">주소</label></th>
                    <td><input type="text" name="address" id="inputAddress"></td>
                </tr>
            </table>
            
            <div id="enroll-btn" align="center">
                    <button class="btn btn-outline-success" type="button" onclick = "reset();">취소</button> <!-- 클릭시 메인으로 돌아가기-->
                    <button  class="btn btn-outline-warning" id="submit_btn" type="submit" onclick="return enroll_test();" disabled>가입하기</button>
            </div>
            <br><br>
        </form>
    </div> 
</div>   
    
        
	<script>
        /* 취소 버튼 script영역 */
        function reset(){
        	
        	// location.href ="<%=request.getContextPath()%>/";
        }
        
        /* 비밀번호 확인 script, 비밀번호, 비밀번호 확인 일치 여부  */
        $(function(){
            $("#success").css("color","yellow").hide();
            $("#fail").css("color","red").hide();

            $("input").keyup(function(){
                var $userPwd = $("#userPwd").val();

                var $chkPwd = $("#checkPwd").val();
                
                if($userPwd != "" || $chkPwd !=""){
                    if($userPwd == $chkPwd){
                        $("#success").show();
                        $("#fail").hide();
                        
                    }else{
                        $("#fail").show();
                        $("#success").hide();
                        $("button[type=submit]").attr("disabled");
                    }
                }
                
            })
			
            
        });

	</script>
        
	<script>
        	
            function enroll_test(){
            	
                var inputId = $('#userId').val();
                var userPwd = $('#userPwd').val();
                var checkPwd = $('#checkPwd').val();

                var idCheck =/^[a-zA-Z0-9]{4,11}$/;
                var pwdCheck = /^[a-zA-Z0-9!@#$%^&*]{8,15}$/;

                if(!idCheck.test(inputId)){
                    alert("아이디형식이 올바르지 않습니다. 다시 입력해주세요")
                    userId.select();
                    return false;
                }

                if(!pwdCheck.test(userPwd)){
                    alert("비밀번호는 영문자,숫자,특수문자(!@#$%^&*)가 포함된 8~15를 입력해주세요.")
                    return false;
                  
                }
                
                if(userPwd != "" || checkPwd !=""){
                	if(userPwd != checkPwd){
                		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다 다시 입력해주세요.");
                		return false;
                	}
                
            	}else{
            		alert("비밀번호엔 공백이 포함될 수 없습니다. 다시 입력해주세요.");
            	}
                
                
            } 	
        </script>
        
        <script type="text/javascript">
        	
        	var authKey = ""; // 이메일 인증 번호 담을 변수 
        	/* 이메일 중복 확인  */
			
        	function doubleChk(){
				
				var $email = $('#inputEmail');
				
				if(($email.val()) == "" || $email.val().indexOf('@') ){
					alert("올바른 형식의 이메일을 작성해 주세요");
					return false;
				}
				
				$.ajax({
					url : "email.chk.me",
							
					data : {testEmail : $email.val()},
					
					type : "post",
					
					success : function(result){
						console.log(result);
						
						if(result == "YYYYY" ){
							
							if(confirm("사용가능한 이메일입니다. 사용하시겠습니까?")){
								Authentication(); // 인증번호 발송 함수 호출
							}else{
								$email.focus();
							}
							
							var succMsg = "사용 가능한 이메일 입니다.";
							$('#emailTestResult').html(succMsg);
							
							
						}else{
							var failMsg = "이미 사용중인 이메일 입니다. 다시 입력해주세요";
							$('#emailTestResult').html(failMsg);
							$email.focus();
								
						}
								
					},
					
					error : function(){
						console.log("통신 실패");
					}
				}); 
        	}	
        	
        	/* 이메일 발송 함수 */
			function Authentication(){
				
				var $sendEmail = $('#inputEmail');
				
				$.ajax({
					url : "authentication.me",
					
					data : {sendEmail : $sendEmail.val()},
					
					type: "post",
					
					success: function (key){
						
						console.log(key);
						
						if(key.using == 'Y'){
							
							authKey = key.chord;
							
							console.log(authKey);
							
							alert("이메일 인증번호 발송 완료! 이메일을 확인해주세요")
							
						}
						
						
					},
					
					error: function(){
						console.log("통신실패");
					}
				
				});
				
			}		
			
        	function emailSubmit(){
        		
        		if("" == authKey){
					alert("인증번호를 입력해주세요");
					return false;
        		
        		}else if(($("#authentication").val()) == authKey){
        			
        			if(confirm("이메일 인증이 완료되었습니다.!")){
	        			$("#authentication").attr("readonly",true);
    	    			$("#enroll-btn button[type=submit]").attr("disabled", false);
        			}	
        			
        		}else{
        			alert("이메일 인증에 실패하였습니다. 다시 시도해 주세요");
        			return false;
        		}
        			
        		
        	} 
								
        </script>
<%@include file="../common/footer.jsp" %>    
        
</body>
</html>