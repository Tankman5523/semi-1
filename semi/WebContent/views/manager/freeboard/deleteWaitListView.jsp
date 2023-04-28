<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.bbbox.board.model.vo.Board"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("boardList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 게시글 관리 페이지</title>
<style>
	div{
	    border: 1px solid black;
	    box-sizing: border-box;
	}
	.outer{
        border: 1px solid black;
        width: 1200px;
        height: 600px;
        margin: auto;
        text-align: center;
    }
    
    tbody>tr:hover{
    	cursor: pointer;
    	background-color: gray;
    }
    
    table{
    	display: block;
	    width: %;
	    border-collapse: collapse;
	    height: 70%;
    }
    
    table th{
    	border: 1px solid black;
    	background-color: hotpink;
    }
	table td{
		border: 1px solid black;
		border-top: 0;
	}
	table>tbody{
	    display: block;
	    height: 400px;
	    overflow: auto;
	}
	table th:nth-of-type(1), table td:nth-of-type(1) {width: 5%;}
	table th:nth-of-type(2), table td:nth-of-type(2) {width: 5%;}
	table th:nth-of-type(3), table td:nth-of-type(3) {width: 7%;}
	table th:nth-of-type(4), table td:nth-of-type(4) {width: 15%;}
	table th:nth-of-type(5), table td:nth-of-type(5) {width: 5%;}
	table th:nth-of-type(6), table td:nth-of-type(6) {width: 10%;}
	table th:nth-of-type(7), table td:nth-of-type(7) {width: 5%;}
	table th:nth-of-type(8), table td:nth-of-type(8) {width: 5%;}
	table th:nth-of-type(9), table td:nth-of-type(9) {width: 5%;}
	table th:nth-of-type(10), table td:nth-of-type(10) {width: 5%;}
	table th:nth-of-type(11) {width: 5%;}
	table td:nth-of-type(11) {width: 5%-18px;}

	
	
</style>
</head>
<body>
	<%@include file="../manager_menu.jsp"%>
	
	<div class="outer">
		<div class="sort_area" style="height: 10%;">
			정렬기준 :
			<button type="button" name="sort" value="recent">최신순</button>
			<button type="button" name="sort" value="old">오래된 순</button>

		</div>
		
		<script>
			$(function(){
				
	            $(".sort_area button").on("click", function(){
	            	
	            	location.href = "<%=contextPath%>/deleteWait.ma?sort="+$(this).val();
	            });
			});
		</script>

		
		<div class="list_area">
			<table border="1" align="center">
				<thead>
					<tr>
						<th>글번호</th>
						<th>작성자</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>추천수</th>
						<th>비추천수</th>
						<th>댓글수</th>
						<th>상태변경</th>
						<th>영구삭제</th>
					</tr>
				</thead>
				
				<tbody>
					<%if(list != null){ %>
						<%for(Board b : list){ %>
							<tr>
								<td><%=b.getBoardNo()%></td>
								<td><%=b.getBoardWriter()%></td>
								<td>
									<%if(b.getCategoryNo()==1){%>
										일반게시판
									<%}else if(b.getCategoryNo()==2){ %>
										영상게시판
									<%} %>
									</td>
								<td><%=b.getTitle()%></td>
								<td><%=b.getCount()%></td>
								<td><%=b.getCreateDate()%></td>
								<td><%=b.getLiked()%></td>
								<td><%=b.getReportCount()%></td>
								<td><%=b.getRpCount()%></td>
								<td id="statusShift" class="noEvent">
									<input type="hidden" class="hideBno" value="<%=b.getBoardNo()%>">
									<button  name="statusOn" class="statusOn" style="background-color: darkblue; color: white; width:100%;height:100%">click!</button>
								</td>
								<td class="noEvent">
									<!-- DB에서 전부 날려버리기 -->
									<input type="hidden" class="hideBno" value="<%=b.getBoardNo()%>">
									<button name="delete" class="deleteBoardBtn" id="deleteBoardBtn" style="width:100%;height:100%">글삭제</button>
								</td>
							</tr>
						<%} %>
					<%}else{ %>
						<tr>
							<td>조회된 게시글이 없습니다.</td>
						</tr>
					<%} %>
				</tbody>
			</table>
			
			<script>
				$(function(){
		        	$(".noEvent").on("click",function(){
		        		event.cancelBubble = true;
		        	});
	        	});
				
	        
				//게시글 관리로 이동시키기
		        $(function(){
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
			                    $('#statusShift').load(location.reload());
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
				        		url: "boardDel.ma",
				        		data:{
				        			bno:$(this).parent().children("input[type=hidden]").val()
				        		},
				        		success: function(result){
				        			if(result>0){
				        				alert("영구 삭제 성공!");
				        			}else{
				        				alert("영구 삭제 실패!");
				        			}
				        		},
				        		error: function(){
				        			alert("통신 연결 실패");
				        		},
				        		complete: function() {
				                    $('#boardList').load(location.reload());
				                }
				        	});
		        		}
			        });
		        });
			</script>
		</div>
		
		<div class="page-trans" style="height:10%">
			<a href="<%=contextPath%>/boardList.ma" style="padding: 10px;">자유게시글 관리페이지로</a>
			<a href="<%=contextPath%>/noticeList.ma" style="padding: 10px;">공지사항 관리페이지로</a>
		</div>
	</div>
	
</body>
</html>