<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.bbbox.member.model.vo.Member" %>
<%
	String contextPath = request.getContextPath();
	
	Member loginUser = (Member)session.getAttribute("loginUser");

	String alertMsg = (String)session.getAttribute("alertMsg");
	
	String errorMsg = (String)session.getAttribute("errorMsg");
%>     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>MainMenu</title>
 
 	<!-- 아이콘 CDN (font-awesome Copy Link Tag) -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

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
		
		var errmsg ="<%=errorMsg%>";
		
		if(msg != "null"){
			alert(msg);	
			
			<% session.removeAttribute("alertMsg"); %>
		}
		
		if(errmsg != "null"){
			alert(errmsg);
			<% session.removeAttribute("errorMsg"); %>
		}
		
	</script>
	
	<!-- 관리자 아니면 뒤로 날려버리기 -->
	<% if(loginUser == null &&loginUser.getAdmin().equals("N")){  
		
		session.setAttribute("alertMsg", "로그인한 유저만 이용할 수 있습니다.");
		response.sendRedirect(contextPath+"/index.jsp");
		
	}%>
    
    <div class ="header">
        <div id="header1"></div>
        <div id="header2">
            <a href="<%=contextPath%>/views/manager/manager_index.jsp">불변의 법칙 #관리자</a>
                <!-- 관리자 빨간색 태그 처리 -->
        </div>
        <div id="header3">
            <div id="user-info">
                 <div id = "username">
						<a href="<%=contextPath%>" style="color:blue;text-decoration:none;font-weight:bold">일반모드 </a>
						<br>
						<b><%=loginUser.getUserName()%> 님</b>						
                </div>
                <div id="mypage" align = "center">
                    <a href="<%=contextPath%>/logout.me">로그아웃</a>
                </div>
            </div>
        </div>
    </div>
	
    <!-- 메뉴바 영역 -->
    <div class="menubar">
            <ul id="navi">
                <li><a href="<%=contextPath%>/list.mac?currentPage=1">블랙박스 영상</a>
                    <ul>
                        <li><a href="<%=contextPath%>/list.mac?currentPage=1">사건 영상 관리</a></li>
                        <li><a href="<%=contextPath%>/list.mrb?currentPage=1">해결 영상 관리</a></li>
                    </ul>
                </li>    
                <li><a href="<%=contextPath %>/lawyerList.ma">변호사</a>
                    <ul>
                        <li><a href="<%=contextPath %>/lawyerList.ma">변호사 관리</a></li>
                        <li><a href="">상담 게시판 관리</a></li>
                    </ul>

                </li>    
                <li><a href="<%=contextPath%>/manage.bo">자유게시판</a>
                    <ul>
                        <li><a href="<%=contextPath%>/manage.bo">게시판 관리</a></li>
                    </ul>
                </li>    
                <li><a href="<%=contextPath%>/manage.info.me">회원관리</a>
                    <ul>
                    	<li><a href="<%=contextPath%>/manage.info.me">회원조회</a></li>
                    	<li><a href="<%=contextPath%>/manage.apply.la">신청관리</a></li>
<<<<<<< HEAD
                    	<li><a href="<%=contextPath%>/manage.delete.me">탈퇴회원관리</a></li>
                        <li><a href="<%=contextPath%>/manage.list.qa">1:1 문의</a></li>
                 
=======
                    	<li><a href="">탈퇴회원관리</a></li>
                        <li><a href="">1:1 문의</a></li>
>>>>>>> refs/remotes/origin/master
                        
                    </ul>
                </li>    
            </ul>
    </div>
	
	<script>
		function mypage(){
			//홈페이지 관리자 클릭 시 메인화면으로
			
<<<<<<< HEAD
			$('#header2').on('click',function(){
				location.href="<%=contextPath%>/views/manager/manager_index.jsp";
				
			});
		
=======
>>>>>>> refs/remotes/origin/master
		}
	</script>

</body>
</html>