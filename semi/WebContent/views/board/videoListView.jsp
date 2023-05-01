<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.bbbox.board.model.vo.Board, com.bbbox.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> vlist = (ArrayList<Board>)request.getAttribute("vlist");
	PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
	ArrayList<Board> nlist = (ArrayList<Board>)request.getAttribute("noticeList");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
	
    div, input, textarea, h2, table, video, span{
        border: 1px solid black;
        box-sizing: border-box;
    }
    
    .outer{
        border: 1px solid black;
        width: 1200px;
        height: 800px;
        margin: auto;
    }

    
    
    
    .notice_line:hover{
    	cursor: pointer;
    	color: gray;
    }
    
    .videos{
    	cursor: pointer;
    	float: left;
    	
    }
    
    
</style>
</head>
<body>
	
<%@include file="../common/header.jsp" %>
	
	<div class="outer">
 		<div id="header" style="height: 10%">
		<h2 align="center" style="border: none;">
			영상 게시판
		</h2>
		</div>

		<div id="content" style="height: 90%">
    
			<div id="sort-area" align="right"style="height: 10%;">

				<form action="list.vi" id="search-area" style="border: none;">
					<select name="kind">
						<option value="title">제목</option>
						<option value="content">글 내용</option>
						<option value="userId">작성자</option>
					</select>
					<input type="text" id="search-text" name="keyword" style="width: 300px; height:100%;" placeholder="키워드를 입력해주세요.">
					<button type="submit">검색</button>
				</form>
				
			</div>
	
			<div id="" style="display: inline-block; width: 100%; height: 90%;">

				<table border="1" style="width:100%; box-sizing:border-box; text-align: center" id="board-list">
					<thead>
	            	<%if(!nlist.isEmpty()){ %>
	            		<%for(Board b : nlist){ %>
	            		<tr class="notice_line">
							<td>공지<input type="hidden" name="bno" value="<%=b.getBoardNo() %>"></td>
							<td style="text-align: left; padding-left: 5px;">
								<%=b.getTitle()%>	
								<%if(b.getRpCount()>0){ %>
									[<%=b.getRpCount()%>]
								<%} %>
							</td>
							<td><%=b.getBoardWriter()%></td>
							<td><%=b.getCreateDate()%></td>
							<td><%=b.getCount()%></td>
						</tr>
	            		<%} %>
	            	<%} %>
	            	</thead>
	            </table>
	            <div class="video-area" style="margin:auto;">
	            	<%if(vlist.isEmpty()){ %>
	            		<div align="center">
	            			<span>작성된 게시글이 없습니다.</span>
	            		</div>
	            	<%}else{ %>
	            		<%for(Board b : vlist){ %>
						<table style="height:350px; width:350px;"border="1" class="videos" onclick="location.href='<%=contextPath%>/detail.vi?bno='+<%=b.getBoardNo()%>">
		                    <tr>
		                        <td colspan="6"><video style="height:100%; width:100%" preload="metadata" src="<%=contextPath+b.getFilePath()+b.getChangeName()%>#t=1.0"></video></td>
		                    </tr>
		                    <tr>
		                    	<th>제목</th>
		                        <td colspan="6"><%=b.getTitle()%></td>
		                    </tr>
		                    <tr>
		                    	
		                        <th width="100">작성일</th>
		                        <td width="100"><%=b.getCreateDate()%></td>
		                        <th width="100">작성자</th>
		                    	<td width="100"><%=b.getBoardWriter()%></td>
		                    </tr>
		                    <tr>
		                    	<th>댓글</th>
		                        <td><%=b.getRpCount()%></td>
		                        <th>조회수</th>
		                        <td><%=b.getCount()%></td>
		                        <th>추천</th>
		                        <td><%=b.getLiked()%></td>
		                    </tr>
		                </table>
						<%} %>	
					<%} %>
				</div>
            
			
				
				<div id="page-area" align="center" style="height:20%; border: none;">
					<div style="margin-top: 20px; border:none;">
						<%if(pi.getCurrentPage()!=1){ %>
				 		<button onclick="location.href='<%=contextPath%>/list.vi?currentPage=<%=pi.getCurrentPage()-1%>'">prev</button>
						 <%} %>
						 
						 <%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
						 	<%if(i != pi.getCurrentPage()){ %>
						 		<button onclick="location.href='<%=contextPath%>/list.vi?currentPage=<%=i%>'"><%=i%></button>			 		
						 	<%}else{ %>
						 		<button disabled><%=i%></button>
						 	<%} %>
						 <%} %>
						 
						 <%if(pi.getCurrentPage()!=pi.getMaxPage()){ %>
						 	<button onclick="location.href='<%=contextPath%>/list.vi?currentPage=<%=pi.getCurrentPage()+1%>'">next</button>
						 <%} %>
					</div>
				</div>
				
				<div id="btn-area" style="height:10%; border:none;" align="right">
				<%if(loginUser != null){ %>
					<button onclick="location.href='<%=contextPath%>/insert.vi'" style="margin: 10px">글쓰기</button>
				<%} %>
				</div>
			</div>
		</div>
		
		<script>
			
			
			
			
			//공지 게시글
			$(function(){
				$(".notice_line").on("click", function(){
					
					var bno = $(".notice_line input[type=hidden]").val();
					
					location.href = "<%=contextPath%>/detail.bo?bno="+bno;
					
				});
			});
			
			
		</script>


	</div>
	
	<%@include file="../common/footer.jsp" %>
	
	<script>
		$(function(){
			$("input").attr("autocomplete", "off");
		});
	</script>
	
		
</body>
</html>