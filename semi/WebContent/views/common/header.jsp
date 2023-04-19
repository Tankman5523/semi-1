<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.bbbox.member.model.vo.Member" %>
<%
	String contextPath = request.getContextPath();
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	String alertMsg = (String)session.getAttribute("alertMsg");
%>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>

    <style>
        div{
            border : 1px solid black; /*구역 확인용*/
            box-sizing: border-box;
        }
        /* ---------- header ------------- */
        .header{ /*헤더 높이 고정*/
            width: 1200px;
            height: 150px;
            margin: auto;
        }
        
        .header div{ /*헤더의 모든 div요소의 높이 고정, 왼쪽으로 붙도록 */
            height: 100%;
            float :left;
        }
        #header1, #header3{ /*헤더 영역 넓이 나누기*/
            width: 15%;
            background-color: rgb(62, 118, 152);
        }
        
        #header2{
            width: 70%;
            height: 100%;
            position: relative;
            background-color: bisque;
        }

        #header2>a{ /* 로고+사이트명 누를시 홈으로 이동하기 위해 a태그로 만듦*/
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
        /* ----------- 로그인, 회원가입 버튼 영역 -------- */
        #header3>div{
            width: 100%;
            height: 70%;
            margin-top: 20px;
        }

        #login-area div{
            width: 50%;
            height: 30%;
          
        }

        #login-area a{
            text-decoration: none;
            color: black;
            width: 100%;
            height: 50%;
        }

        /* ------ 로그인 후 영역 -------- */
        #user-info>div{
            width: 100%;
            height: 50%;
        }

        #username{
            text-align: center;
        }

        #mypage a{ /*로그아웃 + 마이페이지 이동영역*/
            text-decoration: none;
            color:black;
            margin-right: 10px;
            margin-left: 10px;
        }



    </style>
</head>
<script>
		var msg = "<%=alertMsg%>";
		
		if(msg != "null"){
			alert(msg);	
			
			<% session.removeAttribute("alertMsg"); %>
		}
		
	
	</script>

<body>
	<% if(loginUser == null){%>
    <!-- 로그인 전에 보여질 화면 -->
    <div class ="header">
        <div id="header1"></div>
        <div id="header2">
            <a href="<%=contextPath%>">블변의 법칙</a>    
        </div>
        <div id="header3">
            <div id="login-area" align = "right">
                <div id = "enroll">
                    <a href="<%=contextPath%>/enroll.me"> 회원가입 </a>
                </div>
                <div id="login">
                    <a href="<%=contextPath%>/login.me"> 로그인 </a>
                </div>
            </div>
        </div>
    </div>
     <%}else{%>
    <!-- 로그인 후에 보여질 화면 -->
    <div class ="header">
        <div id="header1"></div>
        <div id="header2">
            <a href="<%=contextPath%>">블변의 법칙</a>    
        </div>
        <div id="header3">
            <div id="user-info">
                <div id = "username">
					<%if(loginUser.getLawyer().equals("Y")){ %>
						<b>변호사</b> <br> <!-- 추후 변경(이미지 대체) -->
						<b><%=loginUser.getUserName()%> 님</b>						
					<%}else{ %>                	
                    <b><%=loginUser.getUserName()%> 님</b>
                    <%} %>
                </div>
                <div id="mypage" align = "center">
                    <a href="<%=contextPath%>/myPage.me">마이페이지</a>
                    <a href="<%=contextPath%>/logout.me">로그아웃</a>
                </div>
            </div>
        </div>
    </div>
	<%} %>

</body>
</html>