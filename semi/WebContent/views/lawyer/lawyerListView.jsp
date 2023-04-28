<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	ArrayList<Lawyer> lawList = (ArrayList<Lawyer>)request.getAttribute("lawList");
	ArrayList<PartCategory> pList = (ArrayList<PartCategory>)request.getAttribute("pList");
%>
<%@ include file = "../common/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 검색 페이지</title>
<style>
    /* 영역잡기 */
    .wrap div{
        /* border: 1px solid black; */
        border: 0px;
        box-sizing: border-box;
    }
    .wrap{
        width: 1200px;
        height: 600px;
        margin: auto;
    }
    .wrap>div{
        width: 100%;
    }
    #head{
        height: 15%;
    }
    #search{
        height: 5%;
    }
    #content{
        height: 80%;
    }
    #content>div{
        height: 100%;
        float: left;
    }
    #lawList{
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
        margin-left: 200px;
    }
    #search_form>div{
        height: 100%;
        float: left;
        margin: 0px 10px;
    }
    
    /* 변호사 나열 */
    #lawList div{
        margin: auto;
        width: 60%;
        margin-top: 50px;
        margin-bottom: 50px;
        /* background-color: lightblue; */
        cursor: pointer;
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
        width: 100px;
        height: 110px;
        object-fit: cover;
    }
    p{
    	margin: 0;
    	padding-top: 20px
    }

</style>
</head>
<body>
    <div class="wrap">
        <div id="head">
            <p>검증된 교통 전문 변호사를 찾아보세요.</p>
        </div>
        <div id="search">
            <form id="search_form" action="<%=contextPath%>/list.la" method="post">
                <div id="searchName">변호사이름
                    <input type="search" id="name" name="nameKey" placeholder="변호사 이름 입력">
                </div>
                <div> 분야별
                    <select name="cateKey" id="category">
                    	<option value="전체">전체</option>
                    	<%for(PartCategory p : pList) { %>
                    		<option value="<%=p.getPartNo() %>"><%=p.getPartName() %></option>
                    	<%} %>
                    </select>
                </div>
                <div>지역별
                    <select name="localKey" id="local">
                    	<option value="전체">전체</option>
                        <option value="서울">서울</option>
                        <option value="경기">경기도</option>
                        <option value="강원">강원도</option>
                        <option value="충청">충청도</option>
                        <option value="전라">전라도</option>
                        <option value="경상">경상도</option>
                        <option value="제주">제주도</option>
                    </select>
                </div>
	            <div>
	            	<button type="submit">검색</button>
	            </div>
            </form>
        </div>
        <div id="content">
            <div id="lawList" >
                <%if(lawList.isEmpty()){ %>
					<div style="pointer-events: none;">
                		존재하는 변호사가 없습니다.
					</div>
                <%}else{ %>
                	<%for(Lawyer l : lawList){ %>
	                	<div>
			                <input type="hidden" name="lno" value="<%=l.getLawNo() %>">
			                <table id="list-area">
			                    <tr>
			                        <td rowspan="3" width="100px" height="100px"><img src="<%=contextPath + l.getLawImg()%>"></td>
			                        <td rowspan="3" width="20px"></td>
			                        <td width="300px"><%=l.getRefUno() %> 변호사</td>
			                    </tr>
			                    <tr>
			                        <td><%=l.getCompanyName() %></td>
			                    </tr>
			                    <tr>
			                        <td><%=l.getRefPno() %> 전문</td>
			                    </tr>
			                </table>
			            </div>
                	<%} %>
                <%} %>
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
    
    <script>
    	//변호사 상세페이지로 이동시키는 함수
    	$("#lawList>div").click(function(){
    		location.href="<%=contextPath%>/detail.la?lno="+$(this).children("input[name=lno]").val();
    	});
    </script>
</body>
</html>