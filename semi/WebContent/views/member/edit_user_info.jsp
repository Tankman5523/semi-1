<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>

<style>
        .content{
            width: 800px;
            box-sizing: border-box;
            margin: auto;
            margin-top:10px;
        }
        #info{
            width: 70%;
            margin-left: 200px;
        }
        #address{
        	width : 350px
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
<%@include file="../common/header.jsp" %>

    <div class="content">
    <form id="update_Info" action="<%=contextPath%>/update_info.me" method="post">
        <h2 align ="center">마이페이지</h2>
        <h4>회원정보 수정</h4>
        <hr>
            <table id="info">
                <tbody>
                    <tr>
                        <td width="150">아이디 </td>
                        <td><%=loginUser.getUserId()%></td> <!-- loginUser Session에 저장된 정보 불러오기-->
                        <td></td>
                    </tr>
                    <tr>
                        <td>비밀번호 변경</td>
                        <td><input type="password" name="newPwd" id="pwd"></td> <!-- 회원가입이랑 동일하게 keyup 사용-->
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
                        <td><input type="text" id="name" name="newName" placeholder="-포함하여 입력해주세요" value="<%=loginUser.getUserName()%>"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>핸드폰</td>
                        <td><input type="text" id="phone" name="newPhone" value="<%=loginUser.getPhone()%>"></td>
                    </tr>
                    <tr>
                        <td>email</td>
                        <td><input type="email" id="email" name="newEmail" value="<%=loginUser.getEmail()%>"> <button type="button" disabled>이메일 인증</button> </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><p style="font-size: 10px; color: red;">이메일주소는 개인정보찾기에 사용되어지니 정확한 이메일주소를 입력해주세요</p></td>
                    </tr>
                    <tr>
                        <td>주소</td>
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
                <button type="button" onclick="back();">취소</button>
                <button type="submit" onclick="return access();">수정하기</button>
            </div>
            
	    </form>
	</div>
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
       		
       		var $pwd = $("#pwd").val();
       		
       		var $chk = $("#chkPwd").val();
       		
       		var num = $pwd.search(/[0-9]/g);
       		
       		var eng = $pwd.search(/[a-z]/ig);
       		
       		var spe = $pwd.search(/[~!@#$%^&*?]/gi);
       		
       		if($pwd == $chk){
       			if(!($pwd.length >= 8 || $pwd.length <= 15)){
       				alert("8자리 이상, 15자리 이하로 입력해주세요.");
       				$("#pwd").focus();
       				return false;
       			}
       			
       			if($pwd.search(/\s/)!=-1){
       				alert("비밀번호는 공백 없이 입력해주세요.");
       				$("#pwd").focus();
       				return false;
       			}	
       			
       			if((num<0 && eng <0)||(eng<0 && spe <0 )||(spe <0 && num <0)){
       				alert("영문자,숫자,특수문자 중 2가지 이상을 혼합하여 입력해주세요");
       				$("#pwd").focus();
       				return false;
       				
       			}
       				console.log("통과");
       		}
       		
       		
       	}
        
       	
        </script>
</body>
</html>