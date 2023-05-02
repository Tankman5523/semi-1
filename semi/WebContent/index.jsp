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
            width: 1400px;
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
            width: 20%;
            font-size: 50px;
            font-weight: 900;
        }
        #navi-area{
            height: 100%;
            width: 80%;
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
            height: 100%;
            float: left;
        }
        #content-left-area{
            width: 50%;
            position: relative;
            
        }
        
        #content-right-area{
            width: 50%;
        }
        #content-right-area>div{
            width: 100%;
            height: 50%;
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
            font-size: 20px;
            font-weight: 800;

            width: 100%;
            height: 100%;
            display: block;
            line-height: 50px;
            margin: 0px 20px;
        }
        #navi a:hover{
            color: rgb(248, 245, 63);
            font-size: 22px;
        }
        #navi>li>ul{
            list-style-type: none;
            padding: 0;
            display: none;
            background-color:rgba(0,0,0,0.7);
        }
        #navi>li>ul a{
            font-size: 18px;
        }
        #navi>li>ul a:hover{
            font-size: 20px;
        }
        #navi>li>a:hover+ul{
            display: block;
        }
        #navi>li>ul:hover{
            display: block;
        }
        
        
        
        /*----좌측 홈페이지 소개----*/
        
        #left{
            width: 100%;
            height:100%;
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
                                    <li><a href="">소송 가이드</a></li>
                                </ul>
            
                            </li>    
                            <li><a href="">자유게시판</a>
                                <ul>
                                    <li><a href="<%=contextPath%>/list.bo?currentPage=1">일반 게시판</a></li>
                                    <li><a href="<%=contextPath%>/list.vi?currentPage=1">영상 게시판</a></li>
                                </ul>
                            </li>    
                            <li><a href="">고객문의</a>
                                <ul>
                                    <li><a href="<%=contextPath%>/list.qa">1:1 문의</a></li>
                                    <li><a href="">FQA</a></li>
                                </ul>
                            </li>
                            <%if(loginUser == null) {%>
                            <li><a href="<%=contextPath%>/login.me">로그인</a></li>
                            <li><a href="<%=contextPath%>/enroll.me">회원가입</a></li>
                            <%}else{ %>
	                            <li><form action="<%=contextPath%>/confirm.me" method = "post">
	                            	<button type="submit" style = "margin-top: 12px;"> 마이페이지 </button></form></li>
    	               		<li><a href="<%=contextPath%>/logout.me">로그아웃</a></li>
							<%} %>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="content">
                <div id="content-left-area">
                    <div id="left">
                    	<img src="resources/common/introImg1.jpg" style="width:100%;height:100%">
                    </div>
                </div>
                <div id="content-right-area">
                    <div id="right-top">

                    </div>
                    <div id="right-bottom">

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


<%@ include file = "views/common/footer.jsp" %>	


