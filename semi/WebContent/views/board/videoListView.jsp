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
	
    div, input, textarea, h2{
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
    
    
</style>
</head>
<body>
	
	<%@include file="../common/mainMenu.jsp" %>
	
	<div class="outer">
 		<div id="header" style="height: 10%">
		<h2 align="center" style="border: none;">
			영상 게시판
		</h2>
		</div>

		<div id="content" style="height: 90%">
    
			<div id="sort-area" align="right"style="height: 10%;">

				<form action="list.bo" id="search-area" style="border: none;">
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
							<td style="text-align: left; padding-left: 5px;"><%=b.getTitle()%></td>
							<td><%=b.getBoardWriter()%></td>
							<td><%=b.getCreateDate()%></td>
							<td><%=b.getCount()%></td>
						</tr>
	            		<%} %>
	            	<%} %>
	            	</thead>
	            </table>
	            <div id="video-area">
	            	<%if(vlist.isEmpty()){ %>
	            		<div align="center">
	            			<span>작성된 게시글이 없습니다.</span>
	            		</div>
	            	<%}else{ %>
	            		<%for(Board b : vlist){ %>
						<div id="thumnail">
							
						</div>
						<%} %>	
					<%} %>
				</div>
            
			
				
				<div id="page-area" align="center" style="height:20%; border: none;">
					<div style="margin-top: 20px; border:none;">
						<%if(pi.getCurrentPage()!=1){ %>
				 		<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()-1%>'">prev</button>
						 <%} %>
						 
						 <%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
						 	<%if(i != pi.getCurrentPage()){ %>
						 		<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=i%>'"><%=i%></button>			 		
						 	<%}else{ %>
						 		<button disabled><%=i%></button>
						 	<%} %>
						 <%} %>
						 
						 <%if(pi.getCurrentPage()!=pi.getMaxPage()){ %>
						 	<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()+1%>'">next</button>
						 <%} %>
					</div>
				</div>
				
				<div id="btn-area" style="height:10%; border:none;" align="right">
				<%if(loginUser != null){ %>
					<button onclick="boardWrite()" style="margin: 10px">글쓰기</button>
				<%} %>
				</div>
			</div>
		</div>
		
		<script>
			function boardWrite(){
				location.href = "<%=contextPath%>/insert.bo"
			}
			
			//일반 게시글
			$(function(){
				$("tbody>tr").on("click", function(){
					
					var bno = $(this).children().eq(0).text();
					
					location.href = "<%=contextPath%>/detail.bo?bno="+bno;
				});
			});
			
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