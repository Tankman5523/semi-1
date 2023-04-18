<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 영역잡기 */
    div{
        /* border: 1px solid black; */
        box-sizing: border-box;
    }
    .wrap{
        width: 1000px;
        height: 800px;
        margin: auto;
    }
    .wrap>div{
        width: 100%;
    }
    #head{
        height: 10%;
    }
    #search{
        height: 5%;
    }
    #content{
        height: 85%;
    }
    #content>div{
        height: 100%;
        float: left;
    }
    #content_1{
        width: 80%;
        overflow-y: scroll;
    }
    #content_2{
        width: 20%;
        position: relative;
    }

    /* 대표 문구 */
    #head>p{
        text-align: center;
        font-size: 20px;
        font-weight: 900;
        line-height: 50px;
    }

    /* 검색창 */
    #search_form{
        width: 80%;
        height: 100%;
        margin: auto;
    }
    #search_form>div{
        height: 100%;
        float: left;
        margin: 0px 10px;
    }
    
    /* 변호사 나열 */
    #content_1>table{
        margin: auto;
        margin-top: 50px;
    }

    /* 우측 하단 고정바 */
    #fixedbar{
        border: 2px solid rgb(162, 162, 162);
        width: 150px;
        height: 200px;
        position: absolute;
        margin: auto;
        bottom: 10%;
        left: 0;
        right: 0;
        text-align: center;
        font-size: 12px;
    }
    img{
        width: 100%;
        height: 100%;
    }

</style>
</head>
<body>
    <br><br><br><br>
    
    <div class="wrap">
        <div id="head">
            <p>검증된 교통 전문 변호사를 찾아보세요.</p>
        </div>
        <div id="search">
            <form id="search_form">
                <div>변호사이름
                    <input type="search" name="nameKey" placeholder="변호사 이름 입력">
                    <button>검색</button>
                </div>
                <div> 분야별
                    <select name="category">
                        <option value="1">대인</option>
                        <option value="2">대물</option>
                        <option value="3">음주</option>
                        <option value="4">뺑소니</option>
                    </select>
                    <button>검색</button>
                </div>
                <div>지역별
                    <select name="location">
                        <option value="1">서울</option>
                        <option value="2">경기도</option>
                        <option value="3">강원도</option>
                        <option value="4">전라도</option>
                        <option value="5">충청도</option>
                        <option value="6">경상도</option>
                    </select>
                    <button>검색</button>
                </div>
            </form>
        </div>
        <div id="content">
            <div id="content_1" >
                <table >
                    <tr>
                        <td rowspan="3" width="100px" height="100px"><img src="data:image/jpeg;base64,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" alt=""></td>
                        <td rowspan="3" width="20px"></td>
                        <td width="300px">유재석 변호사</td>
                    </tr>
                    <tr>
                        <td>한빛 법률 사무소</td>
                    </tr>
                    <tr>
                        <td>변호사 약력 변호사 약력 변호사 약력</td>
                    </tr>
                </table>

                <table >
                    <tr>
                        <td rowspan="3" width="100px" height="100px"><img src="data:image/jpeg;base64,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" alt=""></td>
                        <td rowspan="3" width="20px"></td>
                        <td width="300px">유재석 변호사</td>
                    </tr>
                    <tr>
                        <td>한빛 법률 사무소</td>
                    </tr>
                    <tr>
                        <td>변호사 약력 변호사 약력 변호사 약력</td>
                    </tr>
                </table>
                <table >
                    <tr>
                        <td rowspan="3" width="100px" height="100px"><img src="data:image/jpeg;base64,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" alt=""></td>
                        <td rowspan="3" width="20px"></td>
                        <td width="300px">유재석 변호사</td>
                    </tr>
                    <tr>
                        <td>한빛 법률 사무소</td>
                    </tr>
                    <tr>
                        <td>변호사 약력 변호사 약력 변호사 약력</td>
                    </tr>
                </table>
                <table >
                    <tr>
                        <td rowspan="3" width="100px" height="100px"><img src="data:image/jpeg;base64,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" alt=""></td>
                        <td rowspan="3" width="20px"></td>
                        <td width="300px">유재석 변호사</td>
                    </tr>
                    <tr>
                        <td>한빛 법률 사무소</td>
                    </tr>
                    <tr>
                        <td>변호사 약력 변호사 약력 변호사 약력</td>
                    </tr>
                </table>
                <table >
                    <tr>
                        <td rowspan="3" width="100px" height="100px"><img src="data:image/jpeg;base64,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" alt=""></td>
                        <td rowspan="3" width="20px"></td>
                        <td width="300px">유재석 변호사</td>
                    </tr>
                    <tr>
                        <td>한빛 법률 사무소</td>
                    </tr>
                    <tr>
                        <td>변호사 약력 변호사 약력 변호사 약력</td>
                    </tr>
                </table>
                
            </div>
            <div id="content_2">
                <div id="fixedbar">
                    <br><br>
                    <b>이용방법</b><br><br>
                    1. 상담신청서 작성<br><br>
                    2. 온라인 상담받기<br><br>
                    3. 방문/전화 상담받기<br><br>
                </div>
            </div>
        </div>
    </div>
</body>
</html>