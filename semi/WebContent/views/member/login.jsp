<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
<!-- 카카오 로그인 script -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
  integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
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
        /* ------  로그인 폼 영역 ------- */
        .login-form{
            width: 100%;
        }
        .login-area>form, h1{
            width: 1400px;
            margin: auto;
        }
        #login-area>table{
            margin: auto;
            /* padding-left: 20px; */
            padding-top: 30px;
        }

        #login-area input{
            margin-top: 5px;
            margin-bottom: 5px;
        }

        #btn-area {
            width: 50%;
            height: 150px;
            margin: auto;
        }
        #btn-area div{
            width: 20%;
            height: 50px;
            box-sizing: border-box;
        }
  
        #btn-area button{
            width: 100%;
            height: 80%;
            
        }

    </style>
</head>
<body>
	<%@  include file = "../common/header.jsp"%> 
	
    <div class="login-form">
        <br>
        <h1 align="center">로그인</h1>
        <form id="login-area" action="<%=contextPath%>/login.me" method="post">
            <table>
                <tr> 
                    <td><label for="inputId">아이디</label></td>
                </tr>
                <tr>
                    <td><input type="text" name="userId" id="inputId" maxlength="12" required></td>
                </tr>  
                <tr>
                    <td><label for="inputPwd">비밀번호</label></td>
                </tr>  
                <tr>
                    <td><input type="password" name="userPwd" id="inputPwd" maxlength="15" required></td>
                </tr>
            </table>        
            <br><br>

            <div id="btn-area" align="center">
                <div>
                    <button type="submit">로그인</button>
                </div>
                <div>
                	<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=405e99a60ff40f242008ab5a0bca8d36
                			&redirect_uri=http://localhost:8888/semi/kakaologin.me?cmd=callback&">
                	<img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="218" height="45"
   						 alt="카카오 로그인 버튼" /></a>
                    <button type="button">카카오로그인</button> 
                </div>
                <div>
                    <button type="button">회원가입</button>
                </div>
		   </div>
        </form>
        
       <script>
       /* 카카오 로그인  */
       //초기화 함수 호출 
        Kakao.init('f472cfc784f413f280466bde3fe97c4f');
       	Kakao.isInitialized();
       
       	//초기화 확인
       	console.log(Kakao.isInitialized());

       	//로그인 시도
       	function kakaoLogin(){
	       	
       		Kakao.Auth.authorize()({
       			
	       		success : function (authObj){
	       			console.log(authObj); //access 토큰 값 
	       			Kakao.Auth.setAccessToken(authObj.access_token); //access토큰값 저장 
	       			
	       			getInfo(); //사용자 정보 조회 메소드 호출
	       			
	       		},
	       		fail :function (err){
	       			console.log(err);
	       		}
	       	});
       		
	       	
       		//엑세스 토큰 발급 후 사용자 정보 받아올 함수 실행 
	       	function getInfo(){
       			//API호출하기 
       			Kakao.API.request({
       				url : 'v2/user/me',
       				
       				success : function(res){
       					console.log(res);
       					//이메일, 닉네임 
       					var email = res.kakao_account.email;
       					var nickname = res.kakao_account.profile.nickname;

       					console.log(email, nickname); //확인용 
       					
       				},
       				
       				fail :function(error){
       					alert('카카오 로그인에 실패하였습니다. 관리자에게 문의하세요' + JSON.stringify(error));
       				}
       				
       			});
       		}	
       	}
       	
       </script>
	</div>
        <br><br><br><br>
</body>

</html>