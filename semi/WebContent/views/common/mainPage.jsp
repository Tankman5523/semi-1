<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.bbbox.member.model.vo.Member" %>
<%
	String contextPath = request.getContextPath();
	Member loginUser = (Member)session.getAttribute("loginUser");

	String alertMsg = (String)session.getAttribute("alertMsg");
	
	String errorMsg = (String)session.getAttribute("errorMsg");
	
	int mode = 1;
%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MainPage</title>
<!-- 아이콘 CDN (font-awesome Copy Link Tag) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
      
    <style>
        /* ============================================전체 영역 */
        body{
        	margin:0;
            padding:0;
        }
        .wrap{
            width: 100%;
            height: 1000px;
            background-image: url("https://cdn.pixabay.com/photo/2016/10/03/14/24/car-1711788_1280.jpg");
            background-size: cover;
            
            margin:0;
            padding:0;
            
        }
        #line{
            width: 100%;
            height: 2%;
        }
        #outer{
            width: 1300px;
            height: 96%;
            margin: auto;
        }
        #outer div{
           /* border : 1px solid white;*/ /* 구역 확인용 나중에 지우기*/
            box-sizing: border-box;
        }
        #outer>div{
            width: 100%;
        }
        #header{
            height: 10%;
            color: white;
        }
        #content{
            height: 80%;
            background-color: rgba(0, 0, 0, 0.7);
        }
        #footer{
            height: 10%;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
        }
        /* ============================================헤더 영역 */
        #header>div{
            float: left;
        }
        #logo-area{
            height: 100%;
            width: 30%;
            font-size: 50px;
            font-weight: 900;
        }
        #navi-area{
            height: 100%;
            width: 70%;
            position: relative;
        }
        #navibar{
            width: 100%;
            height: 50%;
            color: white;
            position: absolute;
            margin: auto;
            /* bottom: 0; */
        }
        /* ============================================컨텐트 영역 */
        #content>div{
            height: 80%;
            float: left;
            margin-top:100px;
        }
        #content-left-area{
            width: 60%;
            position : relative;
        }
        
        #left{
        	width: 90%;
        	height: 80%;
        	top: 0;
        	right: 0;
        	left:0;
        	bottom:0;
        }
        #content-right-area{
            width: 40%;
            box-sizing: border-box;
        }
        #lawyer-area{
        	width: 85%;
        	height:90%;
        }
        
        #lawyer-area>div{
        	width: 100%;
        	height:50%;
        	position : relative;
        	
        }
        
        #right-top>div{
        	width:95%;
        	height:70%;
        	background-color: white;
        	position : absolute;
        	margin:auto;
        	top: 0;
        	right: 0;
        	left:0;
        	bottom:0;
        }
        
         #right-bottom>div{
        	width:95%;
        	height:70%;
        	background-color: white;
        	position : absolute;
        	margin:auto;
        	top: 80px;
        	right: 0;
        	left:0;
        }
        
        
        #content-top{
        	width: 100%;
        	height: 100%;
        }
        #content-top>div{
        	height:100%;
        	float:left;
        }
        #content-top>#content-top-img{
        	width:50%;
        	position: relative;
        }
        #content-top-img>img{
        	position: absolute;
        	margin: auto;
        	left: 0;
        	right: 0;
        	top: 0;
        	bottom: 0;
        }
        #content-top-comment{
        	width:50%;
        	position: relative;
        }
        #lawTable1{
        	position: absolute;
        	margin: auto;
        	left: 0;
        	top: 0;
        	bottom: 0;
        	text-align: center;
        }
        #lawTable1 th{
        	font-size: 20px;
        	font-weight: bold;
        }
        
        
        #content-bottom{
        	width: 100%;
        	height: 100%;
        }
        #content-bottom>div{
        	height:100%;
        	float:left;
        }
        #content-bottom>#content-bottom-img{
        	width:50%;
        	position: relative;
        }
        #content-bottom-img>img{
        	position: absolute;
        	margin: auto;
        	left: 0;
        	right: 0;
        	top: 0;
        	bottom: 0;
        }
        #content-bottom-comment{
        	width:50%;
        	position: relative;
        }
        #lawTable2{
        	position: absolute;
        	margin: auto;
        	left: 0;
        	top: 0;
        	bottom: 0;
        	text-align: center;
        }
        #lawTable2 th{
        	font-size: 20px;
        	font-weight: bold;
        }
        
        /* ============================================ 네비바 */
        #navi{
            list-style-type: none;
            margin: 0px;
            padding: 0px;
            height: 100%;
            z-index:100;
        }
        #navi>li{
            float: left;
            width: 15%;
            height: 100%;
            text-align: center;
            z-index:100;
        }
        #navi a{
            text-decoration: none;
            color: white;
            font-size: 19px;
            font-weight: 800;

            width: 100%;
            height: 100%;
            display: block;
            line-height: 50px;
            margin: 0px 20px;
            z-index:100;
        }
        #navi a:hover{
            color: rgb(248, 245, 63);
            font-size: 20px;
        }
        #navi>li>ul{
            list-style-type: none;
            padding: 0;
            display: none;
            background-color:rgba(0,0,0,0.7);
        }
        #navi>li>ul a{
            font-size: 17px;
        }
        #navi>li>ul a:hover{
            font-size: 18px;
        }
        #navi>li>a:hover+ul{
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
<body>
    <div class="wrap">
        <div id="line"><img src="<%=contextPath%>/resources/common/menu-top.jpg" alt="" style="width: 100%; height: 100%;"></div>
        <div id="outer">
            <div id="header">
                <div id="logo-area">블변<span style="font-size: 40px;">의</span> 법칙</div>
                <div id="navi-area">
                    <div id="navibar">
                        <ul id="navi">
                            <li><a href="<%=contextPath%>/list.ac?currentPage=1">블랙박스 영상</a>
                                <ul>
                                    <li><a href="<%=contextPath%>/list.ac?currentPage=1">사건 영상</a></li>
                                    <li><a href="<%=contextPath%>/list.rb?currentPage=1">해결 영상</a></li>
                                    <li><a href="<%=contextPath%>/enroll.ac">제보 페이지</a></li>
                                </ul>
                            </li>    
                            <li><a href="<%=contextPath %>/list.la">변호사</a>
                                <ul>
                                    <li><a href="<%=contextPath %>/list.la">변호사 검색</a></li>
                                    <li><a href="<%=contextPath %>/guide.la">소송 가이드</a></li>
                                </ul>
            
                            </li>    
                            <li><a href="<%=contextPath%>/list.bo?currentPage=1">자유게시판</a>
                                <ul>
                                    <li><a href="<%=contextPath%>/list.bo?currentPage=1">일반 게시판</a></li>
                                    <li><a href="<%=contextPath%>/list.vi?currentPage=1">영상 게시판</a></li>
                                </ul>
                            </li>    
                            <li>
                            	<a href="<%=contextPath%>/list.qa">1:1 문의</a>
                            </li>
                            <%if(loginUser == null) {%>
	                            <li><a href="<%=contextPath%>/enroll.me">회원가입</a></li>
	                            <li><a href="<%=contextPath%>/login.me">로그인</a></li>
                            <%}else{ %>
		                        <li><a href="<%=contextPath%>/entry.me">마이페이지</a></li>
	    	               		<li><a href="<%=contextPath%>/logout.me">로그아웃</a></li>
							<%} %>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="content">
                <div id="content-left-area">
                    <div id="left">
                    	<img src="<%=contextPath%>/resources/common/introImg.png" style="width:75%;height:100%; margin-left: 80px;">
                    </div>
                </div>
                <div id="content-right-area">
                    <div id="lawyer-area">
	                    <div id="right-top">
							<div id="content-top">
								<div id="content-top-img">
									<img src="<%=contextPath%>/resources/common/IMG_6301.JPG" width= "150" height="180" >
								</div>
								<div id="content-top-comment">
									<table id="lawTable1" align="center">
										<tr><th height="50px">유지현 변호사</th></tr>
										<tr><td height="30px">서울대 법대 수석 졸업</td></tr>
										<tr><td height="30px">2022 리뷰 평점 1위</td></tr>
										<tr><td height="30px">교통/뺑소니 전문 변호사</td></tr>
									</table>
								</div>
							</div>
	                    </div>
	                    <script>
	                    	//상담바로가기
	                    	$(function(){
	                    		$("#content-top").on("click", function(){
	                    			location.href="<%=contextPath%>/detail.la?lno=7";
	                    		});
	                    		$("#content-bottom").on("click", function(){
	                    			location.href="<%=contextPath%>/detail.la?lno=8";
	                    		});
	                    	});
	                    </script>
	                    <div id="right-bottom">
							<div id="content-bottom">
								<div id="content-bottom-img">
									<img src="<%=contextPath%>/resources/common/IMG_6323.JPG" width= "150" height="180" >
								</div>
								<div id="content-bottom-comment">
									<table id="lawTable2" align="center">
										<tr><th height="50px">최현우변호사</th></tr>
										<tr><td height="30px">2017 변호사시험 수석 합격</td></tr>
										<tr><td height="30px">2022 상담률 1위 달성</td></tr>
										<tr><td height="30px">교통/대인 전문 변호사</td></tr>
									</table>
								</div>
							</div>
	                    </div>
                    </div>
                    <div id="icon-area">
                    </div>
                </div>
            </div>
            <div id="footer">
                <!-- 푸터영역 -->
               <div style="text-align:center;"><br>@Copyright By 일석일조
            		<%if(loginUser!=null&&loginUser.getAdmin().equals("Y")){ %>
            			<%if(mode==1){ %>
                			<button onclick="location='<%=contextPath%>/views/manager/manager_index.jsp'" style="background-color:red; color:white;"><b>관리자 모드</b></button>
              	 		<%}else{ %>
              	 			<button onclick="location='<%=contextPath%>/views/common/mainPage.jsp'" style="background-color:blue; color:white;"><b>일반 모드</b></button>	
              	 		<%} %>
              	 	<%} %>
               </div>
              
            </div>
        </div>
        <div id="line"><img src="<%=contextPath%>/resources/common/menu-top.jpg" alt="" style="width: 100%; height: 100%;"></div>
    </div>
    
</body>
</html>