<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.bbbox.member.model.vo.Member"%>

<%
	int mode = 2;
	
	String contextPath = request.getContextPath();
	Member loginUser = (Member)session.getAttribute("loginUser");

	String alertMsg = (String)session.getAttribute("alertMsg");
	
	String errorMsg = (String)session.getAttribute("errorMsg");
%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Including</title>

 	<!-- 아이콘 CDN (font-awesome Copy Link Tag) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>

    
    <style>
        /* ============================================전체 영역 */
        body{
        	margin: 0;
        	padding: 0;
        }
        .wrap{
            width: 100%;
            height: 1000px;
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
            line-height: 50px;
            margin: 0px 20px;
        }
        #navi a:hover{
            color: rgb(248, 245, 63);
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
<!-- 관리자 아니면 뒤로 날려버리기 -->

<% if(loginUser == null &&loginUser.getAdmin().equals("N")){  
	
	session.setAttribute("alertMsg", "로그인한 유저만 이용할 수 있습니다.");
	response.sendRedirect(contextPath+"/index.jsp");
	
}%>
<body>
    <div class="wrap">
        <div id="line"><img src="<%=contextPath%>/resources/common/menu-top.jpg" alt="" style="width: 100%; height: 100%;"></div>
        <div id="outer">
            <div id="header">
                <div id="logo-area">블변<span style="font-size: 40px;">의 </span>법칙<i class="fa-sharp fa-solid fa-gear fa-l" style="color: #bd0000;"></i></div>
                <div id="navi-area">
                    <div id="navibar">
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
                                    <li><a href="<%=contextPath %>/counselList.ma">상담 게시판 관리</a></li>
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
									<li><a href="<%=contextPath%>/manage.delete.me">탈퇴회원관리</a></li>
			                        <li><a href="<%=contextPath%>/manage.list.qa">1:1 문의</a></li>
			                    </ul>
			                </li> 
                               
                            <li>
    	               			<a href="<%=contextPath%>/logout.me">로그아웃</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        <script>
        
       	/*메인으로 이동*/
       	$(function(){
       		$('#logo-area').on('click',function(){
   				location.href="<%=contextPath%>/views/manager/manager_index.jsp";
   			})	
       	});
        </script> 
        
        <div id="content">
        </div>
        
<%@ include file="../common/footer.jsp"%>