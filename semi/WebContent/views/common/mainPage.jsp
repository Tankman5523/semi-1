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
<title>MainPage</title>
<!-- 아이콘 CDN (font-awesome Copy Link Tag) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
  
    <style>
        /* ============================================전체 영역 */
        *{
        	margin: 0;
        	padding: 0;
        }
        .wrap{
            width: 100%;
            height: 1000px;  /* 100vh로 변경하면 더 좋을듯 */
            background-image: url("https://cdn.pixabay.com/photo/2016/10/03/14/24/car-1711788_1280.jpg");
            background-size: cover;
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
            /* border : 1px solid white; 구역 확인용 */
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
        }
        /* ============================================컨텐트 영역 */
        #content>div{
            height: 100%;
            float: left;
        }
        #content-left-area{
            width: 60%;
            position : relative;
        }
        #left{
        	width: 90%;
        	height: 80%;
        	position : absolute;
        	margin:auto;
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
        	width: 80%;
        	height:100%;
        	background-color: red;
        	float:left;
        }
        
        #lawyer-area>div{
        	width: 100%;
        	height:50%;
        	position : relative;
        	
        }
        
        #right-top>div{
        	width:90%;
        	height:60%;
        	background-color: yellow;
        	position : absolute;
        	margin:auto;
        	top: 0;
        	right: 0;
        	left:0;
        	bottom:0;
        }
        
         #right-bottom>div{
        	width:90%;
        	height:60%;
        	background-color: yellow;
        	position : absolute;
        	margin:auto;
        	top: 0;
        	right: 0;
        	left:0;
        }
        #content-top{
        	width: 100%;
        }
        #content-top>div{
        	height:90%;
        	float:left;
        	margin-top: 20px;
        }
        #content-top>#content-top-img{
        	width:50%;
        }
        
        #content-top>#content-top-comment{
        	width:50%;
        	margin-left: 50px;
        }
        
        #content-bottom{
        	width: 100%;
        }
        #content-bottom>div{
        	height:90%;
        	float:left;
        	margin-top: 20px;
        }
        #content-bottom>#content-bottom-img{
        	width:50%;
        }
        
        #content-bottom>#content-bottom-comment{
        	width:50%;
        	margin-left: 50px;
        }
        
        #counsel-area{
        	width:20%;
        	height:100%;
        	background-color:gray;
        	float:right;
        }
        
        #counsel-area>div{
        	width:100%;
        	height:50%;
        }
        
        #togo-counsel{
        	background-color:green;
        }
        
       
	
        
        /* ============================================ 네비바 */
        #navi{
            list-style-type: none;
            margin: 0px;
            padding: 0px;
            height: 100%;
        }
        #navi>li{
            float: left;
            width: 15%;
            height: 100%;
            text-align: center;
        }
        #navi a{
            text-decoration: none;
            color: white;
            font-size: 19px;
            font-weight: 800;

            width: 100%;
            height: 100%;
            display: block;
            line-height: 60px;
        }
        #navi a:hover{
            color: rgb(255, 230, 0);
            font-size: 20px;
        }
        #navi>li>ul{
        	background-color: rgba(0, 0, 0, 0.7);
            list-style-type: none;
            padding: 0;
            display: none;
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
                    	<div>
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
                            <li><a href="">자유게시판</a>
                                <ul>
                                    <li><a href="<%=contextPath%>/list.bo?currentPage=1">일반 게시판</a></li>
                                    <li><a href="<%=contextPath%>/list.vi?currentPage=1">영상 게시판</a></li>
                                </ul>
                            </li>    
                            <li>
                            	<a href="<%=contextPath%>/list.qa">1:1 문의</a>
                            </li>
                            <%if(loginUser == null) {%>
                            <li><a href="<%=contextPath%>/login.me"><i class="fa-solid fa-door-open fa-xl" style="color: #ffffff;"></i></a></li>
                            <li><a href="<%=contextPath%>/enroll.me">회원가입</a></li>
                            <%}else{ %>
	                        	<li><a href="<%=contextPath%>/entry.me">마이페이지</a></li>
    	               			<li><a href="<%=contextPath%>/logout.me">로그아웃</a></li>
							<%} %>
                        </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="content">
                <div id="content-left-area">
                    <div id="left">
                    	<img src="<%=contextPath%>/resources/common/introImg1.jpg" alt="" style="width: 100%; height: 100%;">
                    </div>
                </div>
                <div id="content-right-area">
                    <div id="lawyer-area">
	                    <div id="right-top">
							<div id="content-top">
								<div id="content-top-img">
									<img src="<%=contextPath%>/resources/common/IMG_6301.JPG" width= "150" height="180" >
								</div>
								<div id="content-top-coment">
									<span>
										가나다라 마바사 아자차카 
									
									</span>
								</div>
							</div>
	                    </div>
	                    <div id="right-bottom">
							<div id="content-bottom">
								<div id="content-bottom-img">
									<img src="<%=contextPath%>/resources/common/IMG_6323.JPG" width= "150" height="180" >
								</div>
								<div id="content-bottom-coment">
									<span>
										가나다라 마바사 아자차카 
									
									</span>
								</div>
							</div>
	                    </div>
                    </div>
                    <div id="counsel-area">
                    	<div id="togo-counsel">
                    		<div id="counsel-icon">
                    		</div>
                    		<div id="report-icon">
				            	<i class="fa-solid fa-camera fa-2xl" style="color: #f5b400;"></i>
                    		</div>   
                    	</div>
                    	
                    </div>
                </div>
            </div>
            <div id="footer">
                <!-- 푸터영역 -->
               <div style="text-align:center;"><br>@Copyright By 일석일조
            		<%if(loginUser!=null&&loginUser.getAdmin().equals("Y")){ %>
                		<button onclick="location='<%=contextPath%>/views/manager/manager_index.jsp'" style="background-color:red; color:white;"><b>관리자 모드</b></button>
              	 	<%} %>
               </div>
	        </div>
	    </div>
    <div id="line"><img src="<%=contextPath%>/resources/common/menu-top.jpg" alt="" style="width: 100%; height: 100%;"></div>
</div>    
</body>
</html>