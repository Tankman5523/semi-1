<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../common/header.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>

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
		
	
	#update_Info{
		
		width: 1000px;
		height : 550px;
		margin: auto;
	
	}
	
	#update_Info>h2{
		font-family: 'SBAggroB';
		font-size: 30px;
		font-weight:300;
		color: white;
		
		padding-top: 70px;
	}
	
	#update_Info>h4{
		
		font-family: 'SBAggroB';
		font-size: 20px;
		font-weight:300;
		color: white;
		padding-top: 15px;	
		text-align:center;
		
	}

	#info{
		width: 70%;
		margin-left: 250px;
    }
    
    #info th{
    	font-family: 'SBAggroB';
    	color: white;
    	font-weight:300;
    	height : 36px;
    
    }
    
    #info td{
    	
    	font-family : HallymGothic-Regular;
    	color:white;
    	
    }
    
	#address{
		width : 500px;
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

<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<div id="content">
    <form id="update_Info" action="<%=contextPath%>/update_info.me" method="post">
        <h2 align ="center">마이페이지</h2>
        <h4>회원정보 수정</h4>
        <hr>
            <table id="info">
                <tbody>
                    <tr>
                        <th width="150">아이디 </th>
                        <td><%=loginUser.getUserId()%></td> <!-- loginUser Session에 저장된 정보 불러오기-->
                        <td></td>
                    </tr>
                    <tr>
                        <th>비밀번호 변경</th>
                        <td><input type="password" name="newPwd" id="pwd" value=<%=loginUser.getUserPwd()%>></td> <!-- 회원가입이랑 동일하게 keyup 사용-->
                    </tr>
                    <tr>
                        <th>비밀번호 확인</th>
                        <td><input type="password" name="chkPwd" id="chkPwd"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><div class="match" style="color: blue">비밀번호가 일치합니다</div><div class="nomatch" style="color: red;">비밀번호가 일치하지 않습니다.</div></td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td><input type="text" id="name" name="newName" value="<%=loginUser.getUserName()%>"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>핸드폰</th>
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
                        <td><p style="font-family: HallymGothic-Regular; font-size: 14px; color: yellow;">이메일주소는 개인정보찾기에 사용되어지니 정확한 이메일주소를 입력해주세요</p></td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td><input type="text" name="newAddress" id="address" value="<%=loginUser.getAddress()%>"></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <hr>
            
            <!-- 버튼 -->
            <br><br>
            <div id="btn" align="center">
                <button class="btn btn-light" type="button" onclick="back();">취소</button>
                <button class="btn btn-primary" type="submit" onclick="return access();">수정하기</button>
            </div>
            
	    </form>
        <br><br>
        
        <script>
        /* 취소시 이동경로 script */
        function back(){
        	location.href="<%=contextPath%>/"
        }
        
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
</div>        
<%@include file="../common/footer.jsp" %>        
