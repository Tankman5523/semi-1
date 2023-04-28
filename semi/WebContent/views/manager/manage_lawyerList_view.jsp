<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	ArrayList<Lawyer> lawList = (ArrayList<Lawyer>)request.getAttribute("lawList");
	ArrayList<PartCategory> pList = (ArrayList<PartCategory>)request.getAttribute("pList");
%>
<%@ include file="manager_menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 영역잡기 */
    .wrap div{
        /* border: 1px solid black; */
        border: 0px;
        box-sizing: border-box;
    }
    .wrap{
        /* border: 1px solid black; */
        width: 1200px;
        height: 600px;
        margin: auto;
    }
    .wrap>div{
        width: 100%;
    }
    #head{
        height: 10%;
    }
    #search{
        height: 10%;
    }
    #content{
        height: 80%;
    }
    #content>div{
        height: 100%;
    }
    #lawList{
        width: 80%;
        overflow-y: scroll;
        margin: auto;
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
        width: 90%;
        height: 100%;
        margin-left: 100px;
    }
    #search_form>div{
        height: 100%;
        float: left;
        margin: 0px 10px;
    }
    
    /* 변호사 나열 */
    #lawList table{
        width: 100%;
        text-align: center;
    }
    #List-title{
        background-color: rgb(223, 220, 220);
    }
    a{
        text-decoration: none;
        color: black;
        display: block;
    }

</style>
</head>
<body>
    <div class="wrap">
        <div id="head">
            <p>변호사 관리 [관리자용]</p>
        </div>
        <div id="search">
            <form id="search_form" action="<%=contextPath%>/lawyerList.ma" method="post">
                <div id="searchName">변호사이름
                    <input type="search" name="nameKey" placeholder="변호사 이름 입력">
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
                	<fieldset>
                		<legend>정렬</legend>
                		<label><input type="radio" name="sort" value="solvedAccCount">해결영상 수</label>
	                	<label><input type="radio" name="sort" value="counselMatchCount">상담매칭 수</label>
	                	<label><input type="radio" name="sort" value="reviewAverage">리뷰 평점순</label>
                	</fieldset>
                </div>
                <div>
                    <button type="submit">검색</button>
                </div>
            </form>
        </div>
        <div id="content">
            <div id="lawList" >
                <table>
                    <thead id="List-title">
                        <tr>
                            <td width="10">No.</td>
                            <td width="30">변호사 번호</td>
                            <td width="30">이름</td>
                            <td width="30">분야</td>
                            <td width="40">해결영상 개수</td>
                            <td width="40">상담매칭 개수</td>
                            <td width="40">리뷰 평점</td>
                            <td width="40">변호사 권한</td>
                        </tr>
                    </thead>
                    <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
                    <%if(!lawList.isEmpty()){ %>
                    <tbody id="apply-list">
                        <%for(int i= 0 ; i < lawList.size(); i++){%>
                        <tr>
                            <td><%=i+1%><input type="hidden" name="lno" value="<%=lawList.get(i).getLawNo()%>"></td>
                            <td><%=lawList.get(i).getLawNo()%></td>
                            <td><%=lawList.get(i).getRefUno()%></td>
                            <td><%=lawList.get(i).getRefPno()%></td>
                            <td><%=lawList.get(i).getSolvedAccCount()%></td>
                            <td><%=lawList.get(i).getCounselMatchCount()%></td>
                            <td><%=lawList.get(i).getReviewAverage()%></td>
                            <%if(lawList.get(i).getLawyer().equals("Y")){ %>
                                <td><button id="onBtn" style="color: green">ON</button></td>
                            <%}else if(lawList.get(i).getLawyer().equals("N")){ %>
                                <td><button id="offBtn" style="color: red">OFF</button></td>
                           	<%}else { %>
                           		<td>대기중</td>
                            <%} %>
                        </tr>
                        <%} %>
                     <%}else{ %>   
                    <!-- 찜한 변호사 리스트가 비어있다면  -->    
                           <tr>
                               <td></td>
                               <td colspan ="5">변호사 회원이 존재하지 않습니다.</td>
                           </tr>
                    </tbody>
                    <%} %>
                </table>
            </div>
        </div>
    </div>
    
    <script>
    	$("#apply-list ").on("click", "td", function(){ //변호사 상세페이지로 이동시키는 함수
    		var lno = $(this).parent().find("input").val();
    		location.href="<%=contextPath%>/manageLawDetail.ma?lno="+lno;
    		/* 관리자용 변호사 모든정보 확인할 수 있는 상세보기 페이지로 이동시키기 */
    		/* lawyer 상태값 상관없이 가져오기 */
    	});
    	
    	$("#apply-list ").on("click", "button", function(){ //변호사 권한 바꾸기
    		
    		var $lno = $(this).parent().siblings().find("input").val();
    		var $button = $(this).html(); //"ON"/"OFF"
    		
    		if(confirm("변호사 권한을 변경하시겠습니까?")){
    			$.ajax({
        			url: "manageLawLawyer.ma",
        			data: {
        				lno : $lno,
        				button : $button
        			},
        			type: "get",
        			success : function(result){
        				if(result == "YY"){
        					if($button == "ON"){
            					$(this).html("OFF");
            					$(this).css("color", "red");
            				}else{
            					$(this).html("ON");
            					$(this).css("color", "green");
            				}
        					$("#apply-list button").load(location.reload());
        				}else{
        					alert("변호사 권한 변경을 실패했습니다.");
        				}
        			}
        		});
    		}
    	});
    	
    	
    </script>
</body>
</html>