<%@page import="com.bbbox.board.model.vo.Search"%>
<%@page import="com.bbbox.common.model.vo.PageInfo"%>
<%@page import="com.bbbox.board.model.vo.Board"%>
<%@page import="com.bbbox.board.model.vo.Attachment"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("blist");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	Search s = (Search)request.getAttribute("search");
	int a = (int)request.getAttribute("a");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>해결된 영상 게시판</title>
<style>
        #content{
        	border:none;
            width: 1300px;
            height: 1200px;
            margin: auto;
            color:white;
            z-index:-1;
        }
		#content div{
			border:none;
		}
		#contentSizing{
        	width: 102%;
        	height: 100%;
        	overflow-y: scroll; 
        }
		
        /*헤더 영역*/
        #accidentBoardHead{
            height: 10%;
        }
        #accidentBoardbody{
            height: 90%;
        }
        #accidentBoardHead>div{
        
        }

        /*게시판 이름 영역*/
        .boardName{
           	width: 400px;
            float: left;
            height:100%;
            color: rgb(255, 236, 173);
        }
        .boardName>*{
            float: left;
            margin-left: 20px;
        }
        .boardName>h1{
            font-size: 30px;
            font-weight: bold;
        }

        /*서치 영역*/
        .search{
            width: 600px;
            float:right;
            margin-top:20px;	
        }
        .search>form{
        	height:30%;
        }
        
        .search>form>div{
            width: 50%;
            height:30px;
            float: left;
        }
        .search>form>div *{
            height:30px;
        }
        .typeFilter>*{
            width: 30%;
            height:30px;
        }
        .searchInput{
            width: 100%;
        }
        .searchInput>div{
            float: left;
        }
        .searchFilter{
            width: 25%;
        }
        .searchBar{
            width: 75%;
        }
        .searchBar div{
            float: left;
        }
		.searchBar button:hover{
			cursor: pointer;
		}
		.yellowBtn{
        	height: 100%; width:100%;
        	background-color: #f9d700;
        	border-radius: 0;
		    border-top-left-radius: 0px;
		    border-bottom-left-radius: 0px;
		    padding: 8px 12px;
		    border: 0;
        }
        .yellowBtn:hover{
        	cursor: pointer;
        }
        .searchKeywordInput{
        	border:none;
        	height:100%;
        	padding:0;
        	margin:0;
        }
		
		
		
        /*게시글 영역*/
        #accidentBoardList-area{
            width: 100%;
            height: 95%;
        }
        
        #accidentBoardList-area>table{
        	height:290px;
        	width:210px;
        
            float: left;
            margin: 14px;
            margin-left:45px;
            border: 1px solid white;
        }
        /*게시글 호버시*/
        #accidentBoardList-area>table:hover{
            cursor: pointer;
            background-color: wheat;
        }
        
        .accidentBoardList{
            
        }
        
        /*썸네일 */
        .accidentBoardList video{
            width: 200px;
            height: 200px;
        }

        /*하단 페이징*/
        .pageMover{
            height: 5%;
        }
		#noBoard{
			text-align:center;
			margin-top:20%;
			height:100%;
		}
    </style>
    <title>해결된 영상 게시판 목록</title>
</head>
<body>
	
<%@include file="../common/header.jsp" %>
	<%	
	//로그인 안됬으면 홈으로 보내기
	if(loginUser==null){
		session.setAttribute("alertMsg", "로그인한 유저만 이용할 수 있습니다.");
		response.sendRedirect(contextPath);
	}
	%>	
    <div id="content">
    	<div id="contentSizing">
	        <div id="accidentBoardHead">
	            <div class="boardName">
	                <h1>해결된 영상 게시판</h1>
	            </div>
	            <div class="sort" style="float: right;margin-top: 20px;" >
	            <!-- 솔트 하지마 
	                <form action="list.ac">
		                <input type="radio" name="searchSort" id="sortRecommend" value="recommend"><label for="sortRecommend">추천순</label>
		                <input type="radio" name="searchSort" id="sortView" value="view"><label for="sortView">조회순</label>
		                <input type="radio" name="searchSort" id="sortNew" value="date"><label for="sortNew">최신순</label>
		                <input type="submit" value="정렬">
	                </form>
	             -->    
	            </div> 
	            <div class="search">
	                <form action="search.rb">
	                   	<input type="hidden" name="currentPage" value="1">
	                    <div class="typeFilter">
	                        <select name="region" id="region">
	                            <option value="none">지역별</option>
	                            <option value="서울">서울</option>
	                            <option value="경기">경기</option>
	                            <option value="충청">충청</option>
	                            <option value="전라">전라</option>
	                            <option value="경상">경상</option>
	                            <option value="강원">강원</option>
	                            <option value="제주">제주</option>
	                        </select>
	                        <select name="partType" id="partType">
	                           <option value="0">사건유형</option>
	                            <option value="1">대인</option>
	                            <option value="2">대물</option>
	                            <option value="3">음주운전</option>
	                            <option value="4">뺑소니</option>
	                        </select>
	                        <select name="insuranceType" id="insuranceType">
	                            <option value="none">과실처리</option>
	                            <option value="합의">합의</option>
	                            <option value="보험">보험</option>
	                        </select>
	                    </div>
	                    <div>
	                        <div class="searchInput">
	                            <div class="searchFilter">
	                                <select name="title_writer" id="filter">
	                                    <option value="제목">제목</option>
	                                    <option value="제보자">제보자</option>
	                                </select>
	                            </div>
	                            <div class="searchBar">
	                                    <div style="width: 15%; height: 23px;"><button type="submit" class="yellowBtn"><i class="fa-sharp fa-solid fa-magnifying-glass" style="color: #000000;"></i></button></div>
	                                    <div style="width: 85%;"><input type="text" class="searchKeywordInput" name="keyword" placeholder="검색어를 입력해주세요" required></div>
	                            </div>
	                        </div>
	                     </div>
	                </form>
	            </div>
	        </div>
	        <div id="accidentBoardbody">
	            <div id="accidentBoardList-area">
					<%if(blist.size()!=0){ %>
		            	<%for(int i=0;i<blist.size();i++){ %>
		                 <table class="accidentBoardList" onclick="location.href='<%=contextPath%>/detail.rb?bno='+<%=blist.get(i).getBoardNo()%>" >
		                    <tr>
		                        <td colspan="2">
		                        	<video preload="metadata" src="<%=contextPath%><%=blist.get(i).getFilePath()%>#t=1.0" style="width:100%"></video>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td colspan="2"><%=blist.get(i).getTitle()%></td>
		                    </tr>
		                    <tr>
		                        <td>제보일</td>
		                        <td><%=blist.get(i).getCreateDate()%></td>
		                    </tr>
		                    <tr>
		                        <td>조회수</td>
		                        <td><%=blist.get(i).getCount()%></td>
		                    </tr>
		                </table>
		                <%} %>
	               <%}else{%><!-- 게시물이 없을시 처리 -->
	                	<div id="noBoard">게시물이 없습니다.</div>
	                <%} %>
	            </div>
	             <!-- 페이징바 -->
	            <div class="pageMover" align="center">
	            <%if(a==1){ %>
	            		<%if(pi.getCurrentPage() != 1){ %>
							<button onclick="location.href='<%=contextPath%>/search.rb?currentPage=<%=pi.getCurrentPage()-1%>&categoryNo=4&region=<%=s.getRegion()%>&partType=<%=s.getPartType()%>&insuranceType=<%=s.getInsuranceType()%>&searchFilter=<%=s.getSearchFilter()%>&keyword=<%=s.getKeyword()%>'">prev</button>
						<%} %>
						<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
						<!-- 내가 보고있는 페이지 버튼은 비활성화 -->
							<%if(i != pi.getCurrentPage()){ %>
								<button onclick="location.href='<%=contextPath%>/search.rb?currentPage=<%=i%>&categoryNo=4&region=<%=s.getRegion()%>&partType=<%=s.getPartType()%>&insuranceType=<%=s.getInsuranceType()%>&searchFilter=<%=s.getSearchFilter()%>&keyword=<%=s.getKeyword()%>'"><%=i %></button>
							<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같으면 i와 currenPage -->
								<input type="button" disabled value="<%=i%>">
							<%} %>
						<%} %>
						<%if(pi.getCurrentPage() != pi.getMaxPage()) {%>
							<button onclick="location.href='<%=contextPath%>/search.rb?currentPage=<%=pi.getCurrentPage()+1%>&categoryNo=4&region=<%=s.getRegion()%>&partType=<%=s.getPartType()%>&insuranceType=<%=s.getInsuranceType()%>&searchFilter=<%=s.getSearchFilter()%>&keyword=<%=s.getKeyword()%>'">next</button>
						<%} %>
						
	            	<%}else if(a == 0){ %>
		               	<%if(pi.getCurrentPage() != 1){ %>
							<button onclick="location.href='<%=contextPath%>/list.rb?currentPage=<%=pi.getCurrentPage()-1%>'">prev</button>
						<%} %>
					
						<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
						<!-- 내가 보고있는 페이지 버튼은 비활성화 -->
							<%if(i != pi.getCurrentPage()){ %>
								<button onclick="location.href='<%=contextPath%>/list.rb?currentPage=<%=i%>';"><%=i %></button>
							<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같으면 i와 currenPage -->
								<button disabled><%=i%></button>
							<%} %>
						<%} %>
						
						<%if(pi.getCurrentPage() != pi.getMaxPage()) {%>
							<button onclick="location.href='<%=contextPath%>/list.rb?currentPage=<%=pi.getCurrentPage()+1%>'">next</button>
						<%} %>	
					<%} %>
	            </div>
	        </div>
        </div>
    </div>
    
	<script>
	 $(function(){
    	$(".boardName>h1").on("click",function(){
    		window.location.reload();
    	});
     });
	</script>    
    
<%@include file="../common/footer.jsp" %>
</body>
</html>   