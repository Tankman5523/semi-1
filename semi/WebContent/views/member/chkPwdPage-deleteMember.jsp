<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재 확인 페이지 </title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
    
    	@font-face {
		    font-family: 'SUIT-Regular';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
		    font-weight: normal;
		    font-style: normal;
		}
		
		@font-face{
    		font-family: 'SBAggroB';
  			src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');	
    		font-weight: normal;
   			font-style: normal;
		}    
		
		
        .chk-pwd{
            width: 1400px;
            height: 100%;
            margin: auto;
        }
        
        .chk-pwd>h2{
        	padding-top: 100px;
        	font-family: 'SBAggroB';
        	font-size: 35px;
        	foont-weight: 300;
        	color: white;
        
        }
        .chk-pwd p{
        	font-family: 'SBAggroB';
            text-align: center;
            font-size: 20px;
            font-weight: 300;
            color: darkslateblue;
        }
        
        table label, b{
        	font-family: 'SBAggroB';
        	 font-size: 15px;
            font-weight: 300;
            color: white;
        }
        
        
        
        #chkPwd-area>table{
            margin: auto;
        }

        #chkPwd-area>table td{
            width: 200px;
            height: 30px;
        }

        #btn-area{
            width: 100%;
            height: 35px;
        }

        #btn-area>button{
            width: 100px;
            height: 100%;
        }
    </style>
</head>
<body>
<%@ include file = "../common/header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
<div id="content">    
    <div class="chk-pwd">
        <br>
        <h2 align="center" >비밀번호 재확인 </h2>
        <hr>
        <p>개인정보 보호를 위해 회원님의 비밀번호를 다시 한번 확인합니다. <br>
        	회원탈퇴시 기존 아이디 복구 및 재 가입이 불가능 합니다. </p>
        
      
        <form id="chkPwd-area" action="<%=contextPath%>/delete.me" method="post">
            <table>
                <tr> 
                    <td><label for="inputId" name="inputId">아이디</label></td>
                </tr>
                <tr>
                    <td><b><%=loginUser.getUserId()%></b></td>
                </tr>  
                <tr>
                    <td><label for="inputPwd">비밀번호</label></td>
                </tr>  
                <tr>
                    <td><input type="password" name="inputPwd" id=pwd maxlength="15" required></td>
                </tr>
            </table>        
            <br>
            <div id="btn-area" align="center">
                <button class="btn btn-light" type="submit" onclick="return confirmPass();">확인</button>
            </div>
        </form>

        <br><br><br><br>
    </div>
</div>    
    <script>
    	
	     function confirmPass(){
				
	    	 var userPwd = '<%=loginUser.getUserPwd()%>';
				
	    	 var $inputPwd = $("#pwd").val();
	    	 
	    	 if(userPwd == $inputPwd){
	    		 console.log("통과")
	    		 
	    	 }else{
	    		 alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요")
	    		 return false;
	    		 
	    	 }
	    	 
	     };
    
    </script>
<%@ include file = "../common/footer.jsp" %>    
</html>