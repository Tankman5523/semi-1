<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

	<!-- jquery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
    <style>
        div{
            border : 1px solid black;
            box-sizing: border-box;
        } 
       
        .outer{
            width: 1200px;
            height: 100%;
            margin: auto;
        }
        /* ---------- header ------------- */
        .header{ /*헤더 높이 고정*/
            width: 1200px;
            height: 150px;
            margin: auto;
            background-color: bisque;
        }

        .header div{ /*헤더의 모든 div요소의 높이 고정, 왼쪽으로 붙도록 */
            height: 100%;
            float :left;
        }
        #header1, #header3{ /*헤더 영역 넓이 나누기*/
            width: 20%;
            background-color: rgb(62, 118, 152);
        }
        
        #header2{
            width: 60%;
            height: 100%;
            position: relative;
        }

        #header2>a{
            text-decoration: none;
            color: black;
            font-size: xx-large;
            text-align: center;
            font-weight: 900;

            width: 80%;
            height: 30%;
            margin: auto;

            position: absolute;
            top: 0px;
            left: 0px;
            bottom: 0px;
            right: 0px;
        }
        /* ------  회원가입 폼 영역 ------- */
        .enroll-form{
            width: 1200px ;
            margin:auto;
        }
        .enroll-form>form, h1{
            width: 100%;
        }
        #join-form>table{
            padding-left: 100px;
        }

        #join-form input{
            margin: 2px;
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
</head>
<body>
	<%@ include file ="../common/header.jsp" %>
    <script type="text/JavaScript">
        /* 아이디 중복확인 */
        
        function chkId(){
        	
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
        			
        			}else{
						var success = "사용 가능한 아이디 입니다."
							$('#checkResult').html(success);
        			}
        		}
        	});
        }
        	
        	
    </script>
    
    
    <div class="enroll-form">
        <br>
        <h1 align="center">회원가입</h1>
        <form id="join-form" action="<%=request.getContextPath()%>/enroll.me" method="post">
            <table align = "center">
                <tr> 
                    <td colspan ="5" height="30" align="left" ><label for="userId" >아이디</label></td>
                </tr>
                <tr>
                    <td><input type="text" name="inputId" id="userId" maxlength="12" required> <button id ="check_btn" type="button" onclick = "return chkId();"> 중복확인 </button></td>
                </tr>  
                <tr>
                	<td><label id="checkResult"></label></td>
                </tr>
                <tr>
                    <td><label for="userPwd">비밀번호</label></td>
                </tr>  
                <tr>
                    <td><input type="password" name="inputPwd" id="userPwd" maxlength="15" required></td>
                </tr>
                <tr>
                    <td><label for="chkPwd">비밀번호 확인</label></td>
                </tr>
                <tr>
                    <td><input type="password" id="checkPwd" name="checkPwd"maxlength="15" required></td>
                </tr>
                <tr>
                    <td><label id="success">비밀번호가 일치합니다.</label> <label id="fail">비밀번호가 일치하지 않습니다.</label></td>                    
                </tr>
                <tr>
                    <td><label for="userName">이름</label></td>
                </tr>
                <tr>
                    <td><input type="text" name = "inputName" id="userName" required></td>
                </tr>
                <tr>
                    <td><label for="inputEmail">이메일</label></td>
                </tr>
                <tr>
                	<td><input type="text" name="email"id="inputEmail"><button type="button" onclick="doubleChk();">이메일 확인</button></td>
                </tr>
				<tr>
					<td><label id="emailTestResult"></label></td>
				</tr>
					<td><input id="authentication" type ="text"><button type="button">인증하기</button></td>
				<tr>
                <tr>
                	<td><label id=emailChk></label></td>
                </tr>
                <tr>
                    <td><label for="inputPhone">핸드폰 번호</label><br></td>
                </tr>
                <tr>
                    <td> <input type="text" name="phone" id="inputPhone"></td>
                </tr>
                <tr>
                    <td><label for="inputAddress">주소</label></td>
                </tr>
                <tr>
                    <td><input type="text" name="address" id="inputAddress"></td>
                </tr>
            </table>
            
            <br><br>
            <div id="enroll-btn" align="center">
                    <button type="button" onclick = "reset();">취소</button> <!-- 클릭시 메인으로 돌아가기-->
                    <button type="submit"  onclick="return enroll_test();">가입하기</button>
            </div>
            <br><br>
        </form>
    </div> 
        <br><br><br><br>

        
        <script type="text/JavaScript">
        /* 취소 버튼 script영역 */
        function reset(){
        	
        	// location.href ="<%=request.getContextPath()%>/";
        }
        
        /* 비밀번호 확인 script, 비밀번호, 비밀번호 확인 일치 여부  */
        $(function(){
            $("#success").css("color","blue").hide();
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

                var idCheck =/^[a-zA-Z]{1}[a-zA-Z0-9]{3,11}$/;
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
                
            	}
                
            } 	
        </script>
        
        <script type="text/javascript">
        	/* 이메일 확인  */
			function doubleChk(){
				
					var $email = $('#inputEmail');
					
						$.ajax({
							url : "authentication.me",
							
							data : {testEmail : $email.val()},
							
							type : "post",
							
							success : function(result, authKey){
								if(result == 'YYYYY'){
									if(confirm("이메일 인증 코드 발송 완료!")){
									
									console.log(authkey);
									}
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
				
				
					
        </script>
        
</body>
</html>