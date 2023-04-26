<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재 확인 페이지 </title>

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
        .chk-pwd p{
            text-align: center;
            font-size: 14px;
            font-weight: 500;
            color: darkslateblue;
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
            width: 50px;
            height: 100%;
        }
    </style>
</head>
<body>
	<%@ include file = "../common/header.jsp" %>
    <div class="chk-pwd">
        <br>
        <h2 align="center" >비밀번호 재확인 </h2>
        <hr>
        <p>개인정보 보호를 위해 회원님의 비밀번호를 다시 한번 확인합니다. <br>
        	회원탈퇴시 기존 아이디 복구 및 재 가입이 불가능 합니다. </p>
        
      
        <form id="chkPwd-area" action="<%=contextPath%>/delete.me" method="post">
            <table id= "pwdarea"border="1">
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
                <button type="submit" onclick="return confirmPass();">확인</button>
            </div>
        </form>

        <br><br><br><br>
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
     
</html>