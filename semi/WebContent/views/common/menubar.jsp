<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴바</title>

    <style>
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
                    <li><a href="">변호사 검색</a></li>
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