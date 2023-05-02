<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.bbbox.board.model.vo.Board, com.bbbox.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> vlist = (ArrayList<Board>)request.getAttribute("vlist");
	PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
	ArrayList<Board> nlist = (ArrayList<Board>)request.getAttribute("noticeList");
	int a = (int)request.getAttribute("a");
	String kind = (String)request.getAttribute("kind");
	String keyword = (String)request.getAttribute("keyword");
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
        /*
        border: 1px solid white;
        */
        box-sizing: border-box;
    }
    .notice_line:hover{
    	cursor: pointer;
    	color: gray;
    }

	/*전체 영역잡기*/    
    #content>div{
    	width: 100%;
    }
    
    #header{
    	height: 10%;
    }
    
    #sort-area{
    	height: 10%;
    }
    
    /* 공지사항 영역 */
    #notice-area{
    	background-color: rgb(70, 0, 0);
    }
    
    #notice-area>table{
    	width: 100%;
    }
    
    /* 비디오 리스트영역 */
    #video-area{
    	height: 60%;
    	overflow: auto;
    }
    
    #videoBody{
    	width: 80%;
    	
    }
    
    #videos{
    	width: 100%;
    }
    
    
    #videos>table{
    	height: 350px;
    	width: 300px;
    	float:left;
    	margin: 20px;
    	border: 1px solid white;
    }
    
    #videos>table:hover{
    	cursor: pointer;
    	color: gray;
    }
    
    #page-area{
    	height: 5%;
    }
    
    #btn-area{
    	height: 5%;
    }
    
    
    
</style>
</head>
<body>
	
<%@include file="../common/header.jsp" %>
	<div id="content">
 		<div id="header">
			<h2 align="center" style="border: none;">
				영상 게시판
			</h2>
		</div>
		
		<div id="sort-area" align="right">
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
	
		<div id="notice-area">
			<table border="1"  id="board-list">
				<thead>
				<%if(!nlist.isEmpty()){ %>
					<%for(Board b : nlist){ %>
					<tr class="notice_line" align="center">
						<input id="bno" type="hidden" name="bno" value="<%=b.getBoardNo() %>">
						<th>공지</th>
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
		</div>
			
		<div id="video-area">
			<div id="videoBody" style="margin:auto;">
				<%if(vlist.isEmpty()){ %>
					<div align="center">
						<span>작성된 게시글이 없습니다.</span>
					</div>
				<%}else{ %>
					<%for(Board b : vlist){ %>
					<div id="videos" align="center">
						<table border="1" class="video" onclick="location.href='<%=contextPath%>/detail.vi?bno='+<%=b.getBoardNo()%>">
							<tr>
								<td colspan="6"><video style="height:200px; width:100%" preload="metadata" src="<%=contextPath+b.getFilePath()+b.getChangeName()%>#t=1.0"></video></td>
							</tr>
							<tr>
								<th>제목</th>	
								<td colspan="6"><%=b.getTitle()%></td>
							</tr>
							<tr>
								
								<th width="100">작성일</th>
								<td width="100" style="font-size: 14px"><%=b.getCreateDate()%></td>
								<th width="100">작성자</th>
								<td width="100"><%=b.getBoardWriter()%></td>
							</tr>
							<tr>
								<th>댓글</th>
								<td><%=b.getRpCount()%></td>
								<th>조회수</th>
								<td><%=b.getCount()%></td>
								
							</tr>
						</table>
					</div>
					<%} %>	
				<%} %>
			</div>
		</div>
            
			
				
		<div id="page-area" align="center">
			<div style="margin-top: 20px; border:none;">
				<%if(a == 0){ %>
				<!-- 전체 페이징 -->
					<%if(pi.getCurrentPage()!=1){ %>
						<button class="btn btn-light" onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()-1%>'">prev</button>
					<%} %>
				
					<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
						<%if(i != pi.getCurrentPage()){ %>
							<button class="btn btn-light" onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=i%>'"><%=i%></button>			 		
						<%}else{ %>
							<button class="btn btn-light" disabled><%=i%></button>
							<%} %>
					<%} %>
						
					<%if(pi.getCurrentPage()!=pi.getMaxPage()){ %>
						<button class="btn btn-light" onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()+1%>'">next</button>
					<%} %>
				
				<%}else if(a == 1){ %>
					<!-- 키워드에 의한 페이징 -->
					<!-- semi/list.bo?currentPage=1&kind=title&keyword=DM -->
					<%if(pi.getCurrentPage()!=1){ %>
						<button class="btn btn-light" onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()-1%>&kind=<%=kind%>&keyword=<%=keyword%>'">prev</button>
					<%} %>
					
					<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
						<%if(i != pi.getCurrentPage()){ %>
							<button class="btn btn-light" onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=i%>&kind=<%=kind%>&keyword=<%=keyword%>'"><%=i%></button>			 		
						<%}else{ %>
							<button class="btn btn-light" disabled><%=i%></button>
						<%} %>
					<%} %>
					
					<%if(pi.getCurrentPage()!=pi.getMaxPage()){ %>
						<button class="btn btn-light" onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()+1%>&kind=<%=kind%>&keyword=<%=keyword%>'">next</button>
					<%} %>
				<%} %>
			</div>
		</div>
		
		<div id="btn-area" style="height:10%; border:none;" align="right">
		<%if(loginUser != null){ %>
			<button class="btn btn-light" onclick="location.href='<%=contextPath%>/insert.vi'" style="margin: 10px">글쓰기</button>
		<%} %>
		</div>
		
		
		<script>
			
			
			
			
			//공지 게시글
			$(function(){
				$(".notice_line").on("click", function(){
					
					var bno = $(this).children().eq(0).val();
					
					location.href = "<%=contextPath%>/detail.bo?bno="+bno;
					
				});
			});
			
			
		</script>


	</div>
	
	<script>
		$(function(){
			$("input").attr("autocomplete", "off");
		});
	</script>
<%@include file="../common/footer.jsp" %>
</body>
</html>