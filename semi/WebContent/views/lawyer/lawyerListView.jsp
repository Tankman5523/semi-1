<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	ArrayList<Lawyer> lawList = (ArrayList<Lawyer>)request.getAttribute("lawList");
	ArrayList<PartCategory> pList = (ArrayList<PartCategory>)request.getAttribute("pList");
%>
<%@ include file = "../common/header.jsp" %>
<style>
    /* 폰트, 색상 */
    @font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	#career *, #info *, span, #review-area td{
		font-family: 'Pretendard-Regular';
	}
    
    /* 영역잡기 */
    #content *{
    	color: white;
    }
	#content>div{
        width: 100%;
    }
    #space{
    	height: 5%;
    }
    #title-area{
        height: 13%;
  		color: white;
    }
    #search-area{
        height: 7%;
    }
    #list-area{
        height: 75%;
        border-collapse: collapse;
    }
    #list-area>div{
        height: 100%;
        float: left;
    }
    #lawList{
        width: 80%;
        overflow-y: scroll;
        -ms-overflow-y-style: none;
    }
    #lawList::-webkit-scrollbar { 
    display: none;
    width: 0 !important;
}
    #manual-area{
        width: 20%;
        position: relative;
    }

    /* 대표 문구 */
    #title-area>p{
        text-align: center;
        color: rgb(255, 236, 173);
        font-size: 35px;
        font-weight: 900;
        line-height: 50px;
    }

    /* 검색창 */
    #search-form{
        width: 80%;
        height: 100%;
        margin-left: 250px;
    }
    #search-form>div{
        height: 100%;
        float: left;
        margin: 0px 10px;
    }
    #search-form *{
    	font-size: 20px;
    	color: gray;
    }
    #search-form span{
    	color: white;
    }
    
    /* 변호사 나열 */
    #lawList div{
        margin: auto;
        width: 50%;
        margin-top: 50px;
        margin-bottom: 50px;
        cursor: pointer;
    }

    /* 우측 하단 고정바 */
    #manualbar{
        border: 5px solid white;
        width: 150px;
        height: 200px;
        position: absolute;
        margin: auto;
        bottom: 5%;
        left: 0;
        text-align: center;
        background-color: rgb(255, 236, 173);
        color: black;
        font-size: 15px;
    }
    #lawList img{
        width: 110%;
        height: 140%;
        display: block;
        object-fit: cover;
    }
    p{
    	margin: 0;
    	padding-top: 20px
    }
    button{
    	width: 60px;
    }
    td{
    	font-size: 18px;
    	font-weight: 500;
    }
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	#content *{
		font-family: 'Pretendard-Regular';
	}
</style>

<div id="content">
	<div id="space"></div>
    <div id="title-area">
        <p>검증된 교통 전문 변호사를 찾아보세요.</p>
    </div>
    <div id="search-area">
        <form id="search-form" action="<%=contextPath%>/list.la" method="post">
            <div id="searchName">
            	<span>변호사이름</span>
                <input type="search" id="name" name="nameKey" placeholder="변호사 이름 입력">
            </div>
            <div>
            	<span>분야별</span>
                <select name="cateKey" id="category">
                	<option value="전체">전체</option>
                	<%for(PartCategory p : pList) { %>
                		<option value="<%=p.getPartNo() %>"><%=p.getPartName() %></option>
                	<%} %>
                </select>
            </div>
            <div>
            	<span>지역별</span>
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
    <div id="list-area">
        <div id="lawList" >
            <%if(lawList.isEmpty()){ %>
				<div style="pointer-events: none;">
			        <span style="font-size:20px;">존재하는 변호사가 없습니다.</span>
				</div>
            <%}else{ %>
            	<%for(Lawyer l : lawList){ %>
             	<div>
               <input type="hidden" name="lno" value="<%=l.getLawNo() %>">
               <table id="list-area">
                   <tr>
                       <td rowspan="3" width="100px" height="100px"><img src="<%=contextPath + l.getLawImg()%>"></td>
                       <td rowspan="3" width="40px"></td>
                       <td width="350px" style="font-size:20px; font-weight:600;"><%=l.getRefUno() %> 변호사</td>
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
        <div id="manual-area">
            <div id="manualbar">
                <br><br>
                <b style="color:black">이용방법</b><br><br>
                1. 상담신청서 작성<br><br>
                2. 온라인 상담받기<br><br>
                3. 방문/전화 상담받기<br><br>
            </div>
        </div>
    </div>
    
    <script>
    	//변호사 상세페이지로 이동시키는 함수
    	$("#lawList>div").click(function(){
    		location.href="<%=contextPath%>/detail.la?lno="+$(this).children("input[name=lno]").val();
    	});
    </script>
</div>

<%@ include file = "../common/footer.jsp" %>