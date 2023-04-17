<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .content{
        width: 800px;
        box-sizing: border-box;
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
<div class="content">
    <h2>마이페이지</h2>
    <h4>기본정보</h4>
    <hr>
    <!-- 기본정보 뷰 -->
        <table id="info">
            <tr>
                <td width="150">아이디 *</td>
                <td width="200">user01</td>
                <td></td>
            </tr>
            <tr>
                <td>이름 *</td>
                <td>홍길동</td>
                <td></td>
            </tr>
            <tr>
                <td>email *</td>
                <td>hong@naver.com</td>
                <td></td>
            </tr>
            <tr>
                <td>회원타입</td>
                <td>일반회원</td>
                <td><button>변호사신청(조건걸기)</button></td>
            </tr>
        </table>
    <hr>
    <!-- 찜한리스트 뷰 -->
    <h3>내가 찜한 변호사 (회원일때 보이게)</h3>
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
    <!-- 상담리스트 뷰 -->
    <h3>내 상담 내역 (회원일때 보이게)</h3>
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
    <h3>상담 내역 (변호사일때 보이게)</h3>
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
    <br>
    <!-- 버튼 -->
    <div id="btn" align="center">
        <button>메인으로</button>
        <button>수정하기</button>
    </div>

</div>
</body>
</html>