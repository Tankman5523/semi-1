<%@page import="com.bbbox.common.model.vo.PageInfo"%>
<%@page import="com.bbbox.board.model.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("blist");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사건 영상 게시판</title>
<style>
        div{
            border: 1px solid black;
            box-sizing: border-box;
        }
        .outer{
            width: 1200px;
            height: 1200px;
            margin: auto;
        }

        /*헤더 영역*/
        #accidentBoardHead{
            height: 10%;
            position: relative;
        }
        #accidentBoardbody{
            height: 90%;
        }
        #accidentBoardHead>div{
            float: left;
        }

        /*게시판 이름 영역*/
        .boardName{
            width: 300px;
        }
        .boardName>*{
            float: left;
            margin-left: 20px;
        }
        .boardName>p{
            font-size: 20px;
            font-weight: bold;
        }

        /*서치 영역*/
        .search{
            width: 600px;
            position: absolute;
            top: 60px;
            left: 595px;
            
        }
        .search>form>div{
            width: 50%;
            float: left;
        }
        .typeFilter>*{
            width: 30%;
            height: 30px;
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

        /*게시글 영역*/
        #accidentBoardList-area{
            width: 100%;
            height: 95%;
        }
        #accidentBoardList-area>table{
            float: left;
            margin: 14px;
            border: 1px solid black;
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
            border: 1px solid black;
            width: 200px;
            height: 200px;
        }
        .accidentBoardList video:hover{
			
		
		}
        /*하단 페이징*/
        .pageMover{
            height: 5%;
        }

    </style>
    <title>Document</title>
</head>
<body>

<%@include file="../common/mainMenu.jsp" %>

	
    <div class="outer">
        <div id="accidentBoardHead">
            <div class="boardName">
                <p>사건 영상 게시판</p>
            </div>
            <div class="sort" style="float: right;margin-top: 20px;" >
                <form action="list.ac">
                <input type="radio" name="searchSort" id="sortRecommend" value="recommend"><label for="sortRecommend">추천순</label>
                <input type="radio" name="searchSort" id="sortView" value="view"><label for="sortView">조회순</label>
                <input type="radio" name="searchSort" id="sortNew" value="date"><label for="sortNew">최신순</label>
                <input type="submit" value="정렬">
                </form>
            </div> 
            <div class="search">
                <form action="search.ac">
                	<input type="hidden" name="categoryNo" value="3">
                    <div class="typeFilter">
                        <select name="region" id="region">
                            <option value="">지역별</option>
                            <option value="서울">서울</option>
                            <option value="경기">경기</option>
                            <option value="충청">충청</option>
                            <option value="전라">전라</option>
                            <option value="경상">경상</option>
                            <option value="강원">강원</option>
                            <option value="제주">제주</option>
                        </select>
                        <select name="partType" id="type">
                            <option value="0">사건유형</option>
                            <option value="1">대인</option>
                            <option value="2">대물</option>
                            <option value="3">음주운전</option>
                            <option value="4">뺑소니</option>
                        </select>
                        <select name="insurance" id="insurance">
                            <option value="">과실처리</option>
                            <option value="합의">합의</option>
                            <option value="보험">보험</option>
                        </select>
                    </div>
                    <div>
                    <!-- 
                        <div class="sort">
                            <input type="radio" name="searchSort" id="sortRecommend" value="recommend"><label for="sortRecommend">추천순</label>
                            <input type="radio" name="searchSort" id="sortView" value="view"><label for="sortView">조회순</label>
                            <input type="radio" name="searchSort" id="sortNew" value="date"><label for="sortNew">최신순</label>
                        </div> -->
                        <div class="searchInput">
                            <div class="searchFilter">
                                <select name="title_writer" id="filter">
                                    <option value="제목">제목</option>
                                    <option value="제보자">제보자</option>
                                </select>
                            </div>
                            <div class="searchBar">
                                    <div style="width: 15%; height: 23px;"><button type="submit" style="height: 100%; width:100%">?</button></div>
                                    <div style="width: 85%;"><input type="text" name="keyword" placeholder="검색어를 입력해주세요" required></div>
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
	                 <table class="accidentBoardList" onclick="location.href='<%=contextPath%>/detail.ac?bno='+<%=blist.get(i).getBoardNo()%>">
	                    <tr>
	                        <td colspan="2">
	                        	
	                        	<video preload="metadata" src="<%=contextPath%><%=blist.get(i).getFilePath()%>#t=1.0"></video>
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
                	게시물이 없습니다.
                <%} %>
            </div>
            <!-- 페이징바 -->
            <div class="pageMover" align="center">
               	 <%if(pi.getCurrentPage() != 1){ %>
					<button onclick="location.href='<%=contextPath%>/list.ac?currentPage=<%=pi.getCurrentPage()-1%>'">&lt;</button>
				<%} %>
			
				<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
				<!-- 내가 보고있는 페이지 버튼은 비활성화 -->
					<%if(i != pi.getCurrentPage()){ %>
						<button onclick="location.href='<%=contextPath%>/list.ac?currentPage=<%=i%>';"><%=i %></button>
					<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같으면 i와 currenPage -->
						<button disabled><%=i%></button>
					<%} %>
				<%} %>
				
				<%if(pi.getCurrentPage() != pi.getMaxPage()) {%>
					<button onclick="location.href='<%=contextPath%>/list.ac?currentPage=<%=pi.getCurrentPage()+1%>'">&gt;</button>
				<%} %>	
            </div>
        </div>
    </div>
</body>
</html>   