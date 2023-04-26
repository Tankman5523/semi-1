<%@page import="com.bbbox.board.model.vo.Board"%>
<%@page import="com.bbbox.common.model.vo.PageInfo"%>
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
<title>해결 영상 게시판 관리</title>
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
        #accidentBoardList-area>table>tbody tr:hover{
            cursor: pointer;
            background-color: bisque;
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
</head>
<body>
<%@ include file="manager_menu.jsp" %>
	
    <div class="outer">
        <div id="accidentBoardHead">
            <div class="boardName">
                <p>사건 게시판 관리</p>
            </div>
          
            <div class="sort" style="float: right;margin-top: 20px;" >
                <form action="list.mac">
                <input type="radio" name="searchSort" id="sortRecommend" value="recommend"><label for="sortRecommend">추천순</label>
                <input type="radio" name="searchSort" id="sortDislike" value="dislike"><label for="sortDislike">비추순</label>
                <input type="radio" name="searchSort" id="sortView" value="view"><label for="sortView">조회순</label>
                <input type="radio" name="searchSort" id="sortNew" value="date"><label for="sortNew">최신순</label>
                <input type="submit" value="정렬">
                </form>
            </div> 
            <div class="search">
                <form action="search.mac">
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
                    <div style="height: 100%;">
                   
                        <div class="searchInput"  >
                            <div class="searchFilter" >
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
                <input type="button" value="일괄삭제">
                <input type="button" value="일괄게시">
                <br>
                <table class="accidentBoardList" style="text-align: center; display: inline-table;" >
                    <thead style="background-color: lightgray;">
                    	<tr>
                            <th><input type="checkbox" name="selectBoard" ></th>
                            <th>글번호</th>
                            <th>작성자</th>
                            <th>제목</th>
                            <th>조회수</th>
                            <th>제보일</th>
                            <th>사고유형</th>
                            <th>보험유형</th>
                            <th>지역</th>
                            <th>추천</th>
                            <th>비추천</th>
                            <th>담당변호사</th>
                            <th>글게시</th>
                            <th>상태변경</th>
                        </tr>
                    </thead>
	                <tbody>
	                	<%if(blist!=null){ %>
		                	<%for(int i=0;i<blist.size();i++){ %>
		                    <tr>
		                        <td><input type="checkbox" name="selectBoard"></td>
		                        <td><%=blist.get(i).getBoardNo()%></td>
		                        <td><%=blist.get(i).getBoardWriter()%></td>
		                        <td><%=blist.get(i).getTitle()%></td>
		                        <td><%=blist.get(i).getCount()%></td>
		                        <td><%=blist.get(i).getCreateDate()%></td>
		                        <td><%=blist.get(i).getRef_pno()%></td>
		                        <td><%=blist.get(i).getInsuranceType()%></td>
		                        <td><%=blist.get(i).getRegion()%></td>
		                        <td><%=blist.get(i).getLiked()%></td>
		                        <td><%=blist.get(i).getReportCount()%></td>
		                        <td><%=blist.get(i).getCategoryName()%></td>
		                        <!-- 아직 게시되지 않았다면 -->
		                        <%if(blist.get(i).getStatus().equals("N")) {%>
		                        	<td><button onclick="location='<%=contextPath%>/statusOn.mac?bno='<%=blist.get(i).getBoardNo()%>" name="statusOn" class="statusOn" style="background-color: red; color: white;">OFF</button></td>
		                        <%}else{ %>
		                        <!-- 글이 게시 되어있다면 -->
		                        	<td><button onclick="location='<%=contextPath%>/statusOff.mac?bno='<%=blist.get(i).getBoardNo()%>" name="statusOff" class="statusOff" style="background-color: green; color: white;">ON</button></td>
		                        <%} %>
		                        <td><button onclick="location='<%=contextPath%>/delete.mac?bno='<%=blist.get(i).getBoardNo()%>" name="delete" class="">글삭제</button></td>
		                    </tr>
		                    <%} %>
		                    
		                 <%}else if(blist.size()==0){ %>
	                    	<tr>
	                    		<td colspan="11">데이터가 없습니다.</td>
	                    	</tr>
	                    <%} %>   
	                    
	                </tbody>    
            	</table>
	        <!-- 글게시 on/off 토글처리 -->
	        <script>
	        $(this).ready.function(){
	        	
	        }
	        
	        $(".statusOn").click.function(){
	        	$.ajax({
			        
	        		url: statusOn.ac,
	        		data:{
	        			
	        		},
	        		success: function(){
	        			
	        		},
	        		error: function(){
	        			
	        		}
	        	});
	        }
	        
	        $(".statusOff").click.function(){
	        	$.ajax({
			        
	        		url: statusOff.ac,
	        		data:{
	        			
	        		},
	        		success: function(){
	        			
	        		},
	        		error: function(){
	        			
	        		}
	        	});
	        }
	        
	        var statusList = function(){
	        	
	        }
	        
	        </script>       
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