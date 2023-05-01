<%@page import="com.bbbox.board.model.vo.Board"%>
<%@page import="com.bbbox.common.model.vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("blist");
%>        

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보 영상 게시판 관리</title>
    <style>
        div{
            box-sizing: border-box;
        }
        #content{
        	border:none;
            width: 1300px;
            height: 1200px;
            margin: auto;
            color:white;
        }
		#content>div{
           border:none;
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
            width: 300px;
            float: left;
            height:100%;
            color: rgb(255, 236, 173);
        }
        .boardName>*{
            float: left;
            margin-left: 20px;
        }
        .boardName>h2{
            margin:0;
            margin-top:20px;
            margin-left:30px;
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
            overflow-y: scroll; 
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
       	
       	/*버튼 커스텀*/
		.yellowBtn{
        	background-color: #f9d700;
        	border-radius: 0;
		    border-top-left-radius: 0px;
		    border-bottom-left-radius: 0px;
		    padding: 8px 12px;
		    border: 0;
        }
        .searchKeywordInput{
        	border:none;
        	height:100%;
        	padding:0;
        	margin:0;
        }
    </style>
</head>
<body>
<%@ include file="managerMainPage.jsp" %>
    <div id="content">
        <div id="accidentBoardHead">
            <div class="boardName">
                <h2>제보 영상 게시판 관리</h2>
            </div>
          	
            <!-- 검색 필터 및 검색바 -->
            <div class="search">
                <form action="search.mac">
                	<input type="hidden" name="categoryNo" value="3">
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
                        <select name="partType" id="type">
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
                    <div style="height: 100%;">
                   
                        <div class="searchInput"  >
                            <div class="searchFilter" >
                                <select name="searchFilter" id="filter">
                                    <option value="title">제목</option>
                                    <option value="writer">제보자</option>
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
            <!-- 기준별 순서 정렬 -->
            <div class="sort" style="float:left;margin-top: 20px;margin-right:10px;" >
                <form action="list.mac">
                <input type="radio" name="searchSort" id="sortRecommend" value="recommend"><label for="sortRecommend">추천순</label>
                <input type="radio" name="searchSort" id="sortDislike" value="dislike"><label for="sortDislike">비추순</label>
                <input type="radio" name="searchSort" id="sortView" value="view"><label for="sortView">조회순</label>
                <input type="radio" name="searchSort" id="sortNew" value="date"><label for="sortNew">최신순</label>
                <input type="submit" class="yellowBtn" value="정렬" style="margin-left:5px;">
                </form>
            </div>
        </div>
        <div id="accidentBoardbody">
            <!-- 게시글 정보 테이블 -->
            <div id="accidentBoardList-area">
                <input type="button" id="statusShiftOn" value="일괄게시">
                <input type="button" id="statusShiftOff" value="일괄회수">
                <input type="button" id="deleteAll" value="일괄삭제">
                <br>
                <table class="accidentBoardList" style="text-align: center; display: inline-table;" >
                    <thead style="background-color: lightgray;">
                    	<tr>
                            <th><input type="checkbox" name="selectBoard" id="allCheck" ></th>
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
                            <th>상태변경</th>
                            <th>영구삭제</th>
                        </tr>
                    </thead>
	                <tbody id="boardList" style="box-sizing: border-box;">
	                	<!-- 게시글 정보 띄우기 -->
	                	<%if(blist!=null){ %>
		                	<%for(int i=0;i<blist.size();i++){ %>
			                  	<tr onclick="location.href='<%=contextPath%>/detail.ac?bno='+<%=blist.get(i).getBoardNo()%>">
			                        <th class="noEvent">
			                        	<input type="checkbox" name="selectBoard">
			                        </th>
			                        <td><%=blist.get(i).getBoardNo()%></td>
			                        <td><%=blist.get(i).getBoardWriter()%></td>
			                        <td><%=blist.get(i).getTitle()%></td>
			                        <td><%=blist.get(i).getCount()%></td>
			                        <td><%=blist.get(i).getCreateDate()%></td>
			                        <td><%=blist.get(i).getChangeName()%></td>
			                        <td><%=blist.get(i).getInsuranceType()%></td>
			                        <td><%=blist.get(i).getRegion()%></td>
			                        <td><%=blist.get(i).getLiked()%></td>
			                        <td><%=blist.get(i).getReportCount()%></td>
		                        	<th id="statusShift" class="noEvent statusShift">
                        				<input type="hidden" class="hideBno" value="<%=blist.get(i).getBoardNo()%>">
			                        	<%if(blist.get(i).getStatus().equals("N")) {%>
					                        <!-- 아직 게시되지 않았다면 -->
			                        		<button  name="statusOn" class="statusOn" style="background-color: red; color: white; width:100%;height:100%">OFF</button>
			                        		<!-- <input type="button" class="statusOn" value="OFF" style="background-color: red; color: white; width:100%;height:100%"> -->
				                        <%}else{ %>
					                        <!-- 글이 게시 되어있다면 -->
				                        	<button name="statusOff" class="statusOff" style="background-color: green; color: white; width:100%;height:100%">ON</button>
				                        	<!-- <input type="button" class="statusOff" value="ON" style="background-color: green; color: white; width:100%;height:100%"> -->
			                        	<%} %>
			                        </th>
			                        <th class="noEvent"><!-- DB에서 전부 날려버리기 -->
			                        	<input type="hidden" class="hideBno" value="<%=blist.get(i).getBoardNo()%>">
			                        	<button name="delete" class="deleteBoardBtn" id="deleteBoardBtn" style="width:100%;height:100%">글삭제</button>
		                        	</th>
			                    </tr>
		                    <%} %>
		                    
		                 <%}else if(blist.size()==0){ %>
	                    	<tr>
	                    		<td colspan="11">데이터가 없습니다.</td>
	                    	</tr>
	                    <%} %>   
	                    
	                </tbody>    
            	</table>
            </div>
            <!-- 페이징바 -->
            <div class="pageMover" align="center">
            
            </div>
        </div>
    </div>
    
    <script>
        
      	//게시판 이름 누르면 새로고침
        $(function(){
        	$(".boardName>p").on("click",function(){
        		window.location.reload();
        	});
        });
        
        //해당 영역에 이벤트 안걸리게하기
        $(function(){
        	$(".noEvent").on("click",function(){
        		event.cancelBubble = true;
        	});
        });
        
        //일괄 체크-해제
        $(function(){
        	$("#allCheck").click(function(){
        		var allcheck = $("#allCheck").is(":checked");
        		
        		if(allcheck){
        			$("input:checkbox").prop("checked",true);
        		}else{
        			$("input:checkbox").prop("checked",false);
        		}
        	});
        });
        
        //체크된 게시글 일괄삭제
        $(function(){
        	$("#deleteAll").click(function(){
        		var control = confirm("선택된 게시물을 모두 삭제하시겠습니까?");
        		
        		if(confirm){
        			$("#boardList>tr>th>input:checkbox:checked").each(function(index){
     						var bno = $(this).parent().siblings(".statusShift").children().eq(0).val();
        				
     						$.ajax({
   			        		url: "deleteReal.mac",
   			        		data:{
   			        			bno: bno
   			        		},
   			        		success: function(result){
   			        			if(result>0){
   			        				console.log("성공");
   			        			}else{
   			        				console.log("실패");
   			        			}
   			        		},
   			        		error: function(){
   			        			alert("통신 연결 실패");
   			        		},
   			        		complete: function() {
   			                    $('#boardList>button').load(location.reload());
   			                }
   			        	});
        			});
        		}
        	});
        });
        
        
        //체크된 게시글 일괄 게시
        $(function(){
        	$("#statusShiftOn").click(function(){
        		var control = confirm("선택된 게시물을 모두 게시하시겠습니까?");
        			
        		if(confirm){
        			//체크되어있는 박스 모두 확인
        			$("#boardList>tr>th>input:checkbox:checked").each(function(index){
     						var bno = $(this).parent().siblings(".statusShift").children().eq(0).val();
        			
      					$.ajax({
    		        		url: "statusOn.mac",
    		        		data:{
    		        			bno: bno
    		        		},
    		        		success: function(result){
    		        			if(result>0){
    		        				console.log("상태값 변경 성공!");
    		        			}else{
    		        				console.log("상태값 변경 실패!");
    		        			}
    		        		},
    		        		error: function(){
    		        			alert("통신 연결 실패");
    		        		},
    		        		complete: function() {
    		        			$(this).parent().siblings(".statusShift").load(location.reload());
    		                }
    		        	});
     					
        			});
        		}
        	});
        });
      //체크된 게시글 일괄 회수
        $(function(){
        	$("#statusShiftOff").click(function(){
        		var control = confirm("선택된 게시물을 모두 회수하시겠습니까?");
        			
        		if(confirm){
        			//체크되어있는 박스 모두 확인
        			$("#boardList>tr>th>input:checkbox:checked").each(function(index){
     						var bno = $(this).parent().siblings(".statusShift").children().eq(0).val();
     					
      					$.ajax({
    		        		url: "statusOff.mac",
    		        		data:{
    		        			bno: bno
    		        		},
    		        		success: function(result){
    		        			if(result>0){
    		        				console.log("상태값 변경 성공!");
    		        			}else{
    		        				console.log("상태값 변경 실패!");
    		        			}
    		        		},
    		        		error: function(){
    		        			alert("통신 연결 실패");
    		        		},
    		        		complete: function() {
    		        			$(this).parent().siblings(".statusShift").load(location.reload());
    		                }
    		        	});
     					
        			});
        		}
        	});
        })
        
           // 글게시 
        $(function statusOn(){
        	$(".statusOn").on("click",function(){
	        	$.ajax({
	        		url: "statusOn.mac",
	        		data:{
	        			bno:$(this).parent().children("input[type=hidden]").val()
	        		},
	        		success: function(result){
	        			if(result>0){
	        				alert("상태값 변경 성공!");
	        			}else{
	        				alert("상태값 변경 실패!");
	        			}
	        		},
	        		error: function(){
	        			alert("통신 연결 실패");
	        		},
	        		complete: function() {
	                    $('.statusShift').load(location.reload());
	                }
	        	});
	        });
        });
        
        
        
      	//글 회수
        $(function(){
        	$(".statusOff").on("click",function(){
	        	$.ajax({
	        		url: "statusOff.mac",
	        		data:{
	        			bno:$(this).parent().children("input[type=hidden]").val()
	        		},
	        		success: function(result){
	        			if(result>0){
	        				alert("상태값 변경 성공!");
	        			}else{
	        				alert("상태값 변경 실패!");
	        			}
	        		},
	        		error: function(){
	        			alert("통신 연결 실패");
	        		},
	        		complete: function() {
	                    $('.statusShift').load(location.reload());
	                }
	        	});
	        });
        });
      
      	//DB에서 삭제
        $(function(){
        	$(".deleteBoardBtn").on("click",function(){
        		var control = confirm("정말로 삭제하시겠습니까?");
        		if(control==true){
		        	$.ajax({
		        		url: "deleteReal.mac",
		        		data:{
		        			bno:$(this).parent().children("input[type=hidden]").val()
		        		},
		        		success: function(result){
		        			if(result>0){
		        				alert("게시글 완전삭제 성공!");
		        			}else{
		        				alert("상태값 변경 실패!");
		        			}
		        		},
		        		error: function(){
		        			alert("통신 연결 실패");
		        		},
		        		complete: function() {
		                    $('#boardList>button').load(location.reload());
		                }
		        	});
        		}
	        });
        });
        
   </script>       
<%@ include file="../common/footer.jsp" %>