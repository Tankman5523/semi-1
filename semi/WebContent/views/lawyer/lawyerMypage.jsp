<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.lawyer.model.vo.Lawyer" %>
<%
	ArrayList <Lawyer> lawList = (ArrayList <Lawyer>)request.getAttribute("lawList");
	/* ArrayList <Board> boardList = (ArrayList <Board>)request.getAttribute("boardList");
	ArrayList <Reply> replyList = (ArrayList <Reply>)request.getAttribute("replyList"); */
	
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 마이페이지</title>
<style>
    .content{
        width: 800px;
        box-sizing: border-box;
        margin : auto;
        margin-top: 20px;
    }
    #info,#counselList{
        width: 100%;
    }
    #counselList>thead{
        background-color: rgb(223, 220, 220);
    }
    a{
        text-decoration: none;
        color: black;
        display: block;
    }
    a:hover +{
        cursor: pointer;
    }
</style>
</head>
<body>

<%@ include file = "../common/header.jsp" %>

<div class="content">
    <h2 align="center">마이페이지</h2>
    <h4>기본정보</h4>
    <hr>
    <!-- 기본정보 뷰 -->
        <table id="info">
            <tr>
                <td width="150">아이디 </td>
                <td width="200"><%=loginUser.getUserId()%></td>
                <td></td>
            </tr>
            <tr>
                <td>이름 </td>
                <td><%=loginUser.getUserName()%></td>
                <td></td>
            </tr>
            <tr>
                <td>email </td>
                <td><%=loginUser.getEmail()%></td>
                <td></td>
            </tr>
            <tr>
                <td>회원타입 </td>
            <%if(loginUser.getLawyer().equals("N")){ %>
	            <td>일반회원</td>
               	<td><button>변호사회원 신청하기</button></td>
             <%}else{%>
	         	<td>변호사회원</td>   
	         <%} %>	
            </tr>
        </table>
    <hr>
    <%if(loginUser.getLawyer().equals("N")){ %>
    <!-- 찜한리스트 뷰 -->
    <h3>내가 찜한 변호사</h3>
    <hr>
        <table id="counselList">
            <thead>
                <tr>
                    <td width="100">No.</td>
                    <td width="300">변호사</td>
                    <td width="100"></td>
                </tr>
            </thead>
            <tr>
                
                <td><a href="">1</a></td>
                <td><a href="">함문철 변호사</a></td>
                <td><a href="">♥</a></td>
            </tr>
            <tr>
                <td><a href="">2</a></td>
                <td><a href="">홍길동 변호사</a></td>
                <td><a href="">♥</a></td>
            </tr>
        </table>
    <hr>
    <%}else {%>
	    <!-- 상담리스트 뷰 -->
	    <h3>내 상담 내역</h3>
	    <hr>
	        <table id="counselList">
	            <thead>
	                <tr>
	                    <td width="100">No.</td>
	                    <td width="300">상담 내용</td>
	                    <td width="100">상담 일자</td>
	                </tr>
	            </thead>
	            <tr>
	                
	                <td><a href="">1</a></td>
	                <td><a href="">사고 관련 상담 부탁드려요.</a></td>
	                <td><a href="">2023/04/17</a></td>
	            </tr>
	            <tr>
	                <td><a href="">2</a></td>
	                <td><a href="">상담문의 드립니다.</a></td>
	                <td><a href="">2023/04/01</a></td>
	            </tr>
	        </table>
	    <hr>
	    <!-- 상담리스트 뷰 -->
	    <h3>상담 내역</h3>
	    <hr>
	        <table id="counselList">
	            <thead>
	                <tr>
	                    <td width="100">No.</td>
	                    <td width="300">상담 내용</td>
	                    <td width="100">상담 일자</td>
	                </tr>
	            </thead>
	            <tr>
	                
	                <td><a href="">1</a></td>
	                <td><a href="">사고 관련 상담 부탁드려요.</a></td>
	                <td><a href="">2023/04/17</a></td>
	            </tr>
	            <tr>
	                <td><a href="">2</a></td>
	                <td><a href="">상담문의 드립니다.</a></td>
	                <td><a href="">2023/04/01</a></td>
	            </tr>
	        </table>
	<%} %>
	    <br>
    <!-- 버튼 -->
    <div id="btn" align="center">
        <button onclick = "main();">메인으로</button>
        <button onclick = "modify();">수정하기</button>
    </div>
</div>

	<script>
		/* 메인페이지 버튼 클릭 함수 script */
		function main(){
			location.href="<%=contextPath%>";
		}
		
		/* 회원정보 수정페이지로 이동 script */
		
		function modify(){
			location.href="<%=contextPath%>/update_info.me";
		}
	</script>
	
	<!-- 일단 내꺼에서 고쳐보기 / 분리할거면 mypageController에서 조건걸어서 나누기 -->
	<!-- main() 클릭시 메인페이지 이동은 mainMenu에  -->
</body>
</html>