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
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<style>
	tbody>tr:hover{
    	cursor: pointer;
    	background-color: gray;
    }
    
    h1{
        font-size: 30px;
        color: #fff;
        text-transform: uppercase;
        font-weight: 300;
        text-align: center;
        margin-bottom: 15px;
    }
    table{
        width:100%;
        table-layout: fixed;
    }

    .tbl-header{
        background-color: rgb(92, 91, 91);
        border: 1px solid rgb(255, 255, 255);
    }
    .tbl-content{
        background-color: rgb(43, 41, 41);
        height:400px;
        overflow-x:auto;
        margin-top: 0px;
        border: 1px solid rgb(255, 255, 255);
    }
    
    .tbl-header th{
        padding: 20px 15px;
        text-align: center;
        font-weight: 500;
        font-size: 12px;
        color: white;
        text-transform: uppercase;
    }
    td{
        padding: 15px;
        text-align: center;
        vertical-align:middle;
        font-weight: 300;
        font-size: 12px;
        color: white;
        border-bottom: solid 1px rgba(255,255,255);
    }
    
    

	/* 스크롤바 스타일 적용 */

    ::-webkit-scrollbar {
        width: 6px;
    } 
    ::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(255, 255, 255, 0.8); 
    } 
    ::-webkit-scrollbar-thumb {
        -webkit-box-shadow: inset 0 0 6px rgba(255, 255, 255, 0.8); 
    }



    .content{
        background-color: rgba(0, 0, 0, 0.8);
        width: 1300px;
        margin: auto;
        height: 600px;
    }

    .table_area{
        width: 90%;
        margin: auto;
    }

    
	.page-trans{
		font-weight: 400;
		font-size: 30px;
	}
	
	.page-trans>a{
		text-decoration: none;
		color: white;
		border: 1px solid white;
	}
	
	.sort_area>button{
		margin-top: 20px;
	}

	
	
</style>
</head>
<body>
	<%@include file="../manager_header.jsp"%>
	
	<div id="content">
		<h1>삭제 대기 관리 페이지</h1>
		
		<div class="sort_area" align="center" style="height: 10%;">
			<button type="button" class="btn btn-light" name="sort" value="recent">최신순</button>
			<button type="button" class="btn btn-light" name="sort" value="old">오래된 순</button>
		</div>
		
		<script>
			$(function(){
				
	            $(".sort_area button").on("click", function(){
	            	
	            	location.href = "<%=contextPath%>/deleteWait.ma?sort="+$(this).val();
	            });
			});
		</script>

		<div class="table_area" align="center" style="height: 80%;">
			<div class="tbl-header">
	               <table  border="0">
	                   <thead>
	                        <tr>
	                            <th width="50">글번호</th>
	                            <th width="50">작성자</th>
	                            <th width="70">카테고리</th>
	                            <th width="230">제목</th>
	                            <th width="80">작성일</th>
	                            <th width="50">조회수</th>
	                            <th width="40">추천</th>
	                            <th width="50">비추천</th>
	                            <th width="60">댓글수</th>
	                            <th width="70">상태변경</th>
	                            <th width="60">영구삭제</th>
	                        </tr>
	                    </thead>
	                </table>
	            </div>
	            <div class="tbl-content" align="center">
					<table>
						<tbody>
						<%if(list != null){ %>
							<%for(Board b : list){ %>
								<tr>
									<td width="50"><%=b.getBoardNo()%></td>
									<td width="50"><%=b.getBoardWriter()%></td>
									<td width="70">
										<%if(b.getCategoryNo()==1){%>
											<input type="hidden" name="cno" value="1">
											일반게시판
										<%}else if(b.getCategoryNo()==2){ %>
											<input type="hidden" name="cno" value="2">
											영상게시판
										<%} %>
									</td>
									<td width="230"><%=b.getTitle()%></td>
									<td width="80"><%=b.getCreateDate()%></td>
									<td width="50"><%=b.getCount()%></td>
									<td width="40"><%=b.getLiked()%></td>
									<td width="50"><%=b.getReportCount()%></td>
									<td width="60"><%=b.getRpCount()%></td>
									<td width="70" id="statusShift" class="noEvent">
										<input type="hidden" class="hideBno" value="<%=b.getBoardNo()%>">
										<button  name="statusOn" class="statusOn" style="background-color: darkblue; color: white; width:100%;height:100%">click!</button>
									</td>
									<td width="60" class="noEvent">
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
					
						//게시글 조회
		    			$(function(){
		    				$(".tbl-content>table>tbody>tr").on("click", function(){
		    					
		    					var bno = $(this).children().eq(0).text();
		    					var cno = $(this).children().eq(2).children().val();
		    					
		    					if(cno==1){
			    					location.href = "<%=contextPath%>/detail.bo?bno="+bno;	    						
		    					}else{
			    					location.href = "<%=contextPath%>/detail.vi?bno="+bno;
		    					}
		    					
		    				});
		    			});
						
						
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
				<div class="page-trans" style="height:10%; margin:40px;">
					<a href="<%=contextPath%>/boardList.ma" style="padding: 10px;">자유게시글 관리페이지로</a>
					<a href="<%=contextPath%>/noticeList.ma" style="padding: 10px;">공지사항 관리페이지로</a>
				</div>
			</div>
		</div>
		
		<%@include file="../../common/footer.jsp" %>

	
</body>
</html>