<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<!-- 카카오 로그인 script -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
  integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
 
<!-- jquery CDN --> 
 <script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>  

<style>
        /* div{
            border : 1px solid black;
            box-sizing: border-box;
        }  */
        /* ------  로그인 폼 영역 ------- */
        .login-form{
            width: 1200px;
            margin:auto;
        }
        #login-area>h1{
            width: 100%;
            margin: auto;
        }
        #login-area table{
            width : 30%;
            margin-left: 510px;
            margin-top: 10px
        }

        #login-area input{
            margin-top: 5px;
            margin-bottom: 5px;
        }

        #login-area a{
            text-decoration: none;
            color: black;
        }
        #btn-area {
            width: 50%;
            height: 120px;
            margin: auto;
        }
        #btn-area div{
            width: 30%;
            height: 40px;
            box-sizing: border-box;
        }
  
        #btn-area button{
            width: 100%;
            height: 80%;
            
            
        }

        /* 모달창 style */
        .popup-wrap{ /*모달을 감싸는 박스*/
            background-color: rgb(0,0,0,0); /* 배경색 지정 */
            justify-content: center; /*수평 중앙정렬*/
            align-items: center; /*수직 중악정렬*/
            position: fixed; /*포지션 픽스, 화면이 스크롤되더라도 고정되기 위함*/

            top:0;
            left: 0;
            right: 0;
            bottom: 0;

            display: none; /*이벤트 발생 전까지 숨기기*/
            padding :15px;
        }

        .popup{ /*모달 팝업 몸체*/
            width: 100%; /*반응형 이기 때문에 가로값은 100%로 지정*/
            max-width: 400px; /*팝업의 최대 크기 지정*/
            border-radius: 10px; /*둥글둥글한 디자인을 위해 각을 없앱니다.*/
            overflow:hidden; /* 각을 없앴을 때 내부 영역이 튀어나오는걸 방지*/
            background-color: #457fdc; 

            box-shadow: 5px 10px 10px 1px rgba(0,0,0,3); /*그림자 효과*/
        }

        .popup-head{ /*모달 팝업 머리부분*/
            width:100%; /*부모 요소를 따라가기 때문에 굳이 가로값을 주진 않아도 되지만, 일부 ie에서 인식 못하는 문제가 있으므로 지정*/
            height: 100%; /*head영역 높이*/
            display: flex;/*로고 이미지나 텍스트를 중앙 정렬 하기 위해 flex및 정렬*/
            align-items: center;
            justify-content: center;


        }
        
        .popup-body{/*모달 팝업 몸통부분*/
            width:100%;
            background-color:#ffffff; /*컨텐츠 영역의 배경색*/
        }

        .body-content{ /*몸통 내부 컨텐츠 영역*/
        	margin: auto;
            width: 80%;
            padding: 20px; /*좌우 내용 붙음 방지 */
        }

        .body-titlebox{ /*컨텐츠 타이틀 영역*/
            text-align: center;
            width: 100%;
            height: 40px;
            margin-bottom:10px; /*내용과 간격 조정*/
           
        }
        
        .body-titlebox>h2{
        	margin:auto;
        	margin-top:5px;
        }
        	

        .body-contentbox{
            word-break:break-word;    /*단어가 짤리지 않음*/
            overflow-y:auto;          /*내부요소가 지정한 세로 값보다 클 경우 스크롤 생성 */
            min-height:100px;         /*최소 높이*/
            max-height:200px;         /*최대 높이*/
        }

        .popup-foot{
            width:100%;
            height:50px;
        }
        .pop-btn{ /*각각의 버튼*/
            display:inline-flex;            /*한줄로 나열하기 위한 inline속성과 flex속성 혼합*/
            width:50%;                      /*2개 버튼 각각 50% 영역*/
            height:100%;                    /*50px*/
            justify-content:center;         /*수평정렬*/
            align-items:center;             /*수직정렬*/
            float:left;                     /*좌측배치*/
            color:#ffffff;                /*글자색*/
            cursor:pointer;                 /*마우스 포인터 효과*/
        }
        .pop-btn.confirm{                    /*확인버튼*/
            border-right:1px solid #3b5fbf; /*오른쪽 줄*/
        }

</style>

</head>

<body>
<%@ include file ="../common/header.jsp" %>

 <div class="login-form">
        <br>
         <form id="login-area" action="<%=contextPath%>/login.me" method="post">
            <h1 align="center">로그인</h1>
            <table>
                <tbody>
                    <tr> 
                        <td><label for="inputId" name="inputId" style="font-size: 18px; font-weight: 600;">아이디</label></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="userId" maxlength="12" required></td>
                    </tr>  
                    <tr>
                        <td><label for="inputPwd" style="font-size: 18px; font-weight: 600;">비밀번호</label></td>
                    </tr>  
                    <tr>
                        <td><input type="password" name="userPwd" id=inputPwd maxlength="15" required oninput= "noempty()"></td>
                    </tr>
                    <tr>
                        <td><a id="findId">아이디 찾기</a> <a id="findPwd">비밀번호 찾기 </a> </td>
                    </tr>
                </tbody>
            </table> 
            <br>
            
            <div id="btn-area" align="center">
                <div>
                    <button type="submit">로그인</button>
                </div>
                <div>
                    <button type="button">카카오로그인</button> 
                </div>
                <div>
                    <button type="button">회원가입</button>
                </div>
		   </div>
        </form>

        <!-- modal 팝업 창 -->
        <div class="container">
            <div class="popup-wrap" id="popup"> <!-- 모달을 감싸줄 박스 -->
                <div class="popup"> <!-- 실질적 모달 팝업 -->
                    <div class="popup-head"> <!-- 로고영역 -->
                        <span class="head-title" style="font-size: 30px;">블변의 법칙</span>
                    </div>
                    
                    <div class="popup-body"> <!-- 컨텐츠 영역  -->
                        <div class="body-content">
                            <div class="body-titlebox">
                                <h2 id="id_pwd" align="center"></h2>
                            </div>
                            <div class="body-contentbox" align="center">
                                <p>이메일</p>
                                <input type="email" id="email"> <button id="chkemail">이메일확인</button>
                                <p id="resultemail"></p>
                                <br>
                            </div>
                        </div>
                    </div>
                    <div class="popup-foot" align="center"> <!-- 푸터 버튼 영역 -->
                        <span class="pop-btn-confirm" id="confirm">확인</span>
                        <span class="pop-btn-close" id="close">창닫기</span>
                    </div>
                </div>
            </div>
        </div>
	</div>
        <br><br><br><br>

    <script>
        $(function(){
            
        	$("#confirm").click(function(){
                modalClose();
            });
            
            $('#close').click(function(){
                modalClose(); //모달 닫기 함수 호출
            });

            function modalClose(){
                $('#popup').fadeOut(); //페이드아웃 효과 
            }

            //아이디찾기 클릭
            $('#findId').click(function(){
            	
                $("#popup").css('display','flex').hide().fadeIn(); /*팝업을 flex속성으로 바꿔준 후 hide로 숨기고 다시 fadeIn효과 */
                $("#id_pwd").html("아이디 찾기");
                
                $("#chkemail").click(function(){
                	
                	var $findemail = $(".body-contentbox input[type=email]");
                	
                	$.ajax({
                		url: "find_info.me",
                		
                		data : { email : $findemail.val() },
                		
                		type : "get",
                		
                		success : function(result){
                			
                			if(result != null){
                				Authentication2();
                			}
                		},
                		
                		error : function(){
                			var msg = "없는 회원 정보입니다. 다시 입력해주세요";
                			
                			$('#resultemail').html(msg);
                		}
                	
                	
                	}); //ajax 끝 
                	
                	
	            });
                	
               }); //#findId click function 끝 
                
            $('#findPwd').click(function(){
                $("#popup").css('display','flex').hide().fadeIn(); /*팝업을 flex속성으로 바꿔준 후 hide로 숨기고 다시 fadeIn효과 */
                $("#id_pwd").html("비밀번호 찾기");
                
                /* 임시 비밀번호 발급 함수영역 */
				$("#chkemail").click(function(){
                	
                	var $findemail = $(".body-contentbox input[type=email]");
                	
                	$.ajax({
                		url: "find_info.me",
                		
                		data : { email : $findemail.val() },
                		
                		type : "get",
                		
                		success : function(result){
                			
                			if(result != null){
                				Authentication3();
                			}
                		},
                		
                		error : function(){
                			var msg = "없는 회원 정보입니다. 다시 입력해주세요";
                			
                			$('#resultemail').html(msg);
                		}
                	
                	
                	}); //ajax 끝 
                	
	            });//비밀번호 찾기 함수 끝 

        }); //전체 함수 끝 
        
        // 아이디 찾기 함수
        function Authentication2(){
			
        	var $email = $(".body-contentbox input[type=email]");
			
			$.ajax({
				url : "email_id.me",
				
				data : {email : $email.val()},
				
				type: "post",
				
				success: function (userId){
					
					console.log(userId);
					
					if(userId == "Y"){
						
						alert("회원님의 이메일로 아이디가 발송되었습니다.");
						
					}
					
					
				},
				
				error: function(){
					console.log("통신실패");
				}
			
			});
        }
        
		//비밀번호 찾기 함수 
		function Authentication3(){
				
	        	var $email = $(".body-contentbox input[type=email]");
				
				$.ajax({
					url : "email_id.me",
					
					data : {email : $email.val()},
					
					type: "get",
					
					success: function (userId){
						
						console.log(userId);
						
						if(userId == "Y"){
							
							alert("회원님의 이메일로 임시 비밀번호가 발송되었습니다.");
							
						}
						
						
					},
					
					error: function(){
						console.log("통신실패");
					}
				
				});//ajax 함수 끝 
   		 	};
       });
    </script>

</body>
</html>