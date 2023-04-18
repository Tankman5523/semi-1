<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.bbbox.member.model.vo.Member" %>
<%
	String contextPath = request.getContextPath();
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	//System.out.println(loginUser);

	String alertMsg = (String)session.getAttribute("alertMsg");
%>     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>헤더+메뉴바</title>

	<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>


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

        /* ----------- menubar 영역 -------------- */
        .menubar{ /*메뉴바 높이 고정*/
            width: 1200px;
            height: 80px;
            margin: auto;
            background-color: rgb(214, 172, 214);
        }
       
       .menubar ul{
            list-style-type: none;
            padding: 0px;
            margin: 0px;
            height: 100%;
       }

       #navi>li{
        display: inline-block;
        width: 24%;
        height: 100%;
        text-align: center;
        vertical-align: middle;
        line-height: 80px;
       }

       #navi li ul{
        display: none;
        
        }
    
        #navi a{
        text-decoration: none;
        color: black;
        font-size: 20px;
        font-weight: 700;
        display: block;
        }

        #navi>li a:hover{
            color: navy;
            font-size: 23px;
        }

        #navi li a:hover+ul{
            display: block;
        }

        #navi>li>ul:hover{
            display: block;        
        }


    </style>
</head>
<body>
	
	<script>
		var msg = "<%=alertMsg%>";
		
		if(msg != "null"){
			alert(msg);	
			
			<% session.removeAttribute("alertMsg"); %>
		}
		
	
	</script>


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
            <a href="">블변의 법칙</a>    
        </div>
        <div id="header3">
            <div id="user-info">
                <div id = "username">
                    <b><%=loginUser.getUserName()%></b>
                </div>
                <div id="mypage" align = "center">
                    <a href="">마이페이지</a>
                    <a href="">로그아웃</a>
                </div>
            </div>
        </div>
    </div>
	<%} %>
    <!-- 메뉴바 영역 -->
    <div class="menubar">
            <ul id="navi">
                <li><a href="">블랙박스 영상</a>
                    <ul>
                        <li><a href="<%=contextPath%>/list.ac?currentPage=1">사건 영상</a></li>
                        <li><a href="<%=contextPath%>/list.rb?currentPage=1">해결 영상</a></li>
                        <li><a href="">제보 페이지</a></li>
                    </ul>
                </li>    
                <li><a href="">변호사</a>
                    <ul>
                        <li><a href="<%=contextPath %>/list.la">변호사 검색</a></li>
                        <li><a href="">소송 가이드</a></li>
                        <li><a href="">상담 게시판</a></li>
                    </ul>

                </li>    
                <li><a href="">일반게시판</a>
                    <ul>
                        <li><a href="">자유 게시판</a></li>
                        <li><a href="">영상 게시판</a></li>
                    </ul>
                </li>    
                <li><a href="">고객문의</a>
                    <ul>
                        <li><a href="">1:1 문의</a></li>
                        <li><a href="">FQA</a></li>
                        
                    </ul>
                </li>    
            </ul>
    </div>


</body>
</html>