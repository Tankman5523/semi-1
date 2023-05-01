<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.bbbox.board.model.vo.Board, com.bbbox.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("boardList");
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

    
    #content_1,#content_2{
    	float: left;
    }
    
    /*호버*/
    #content_2 tbody>tr:hover{
    	cursor: pointer;
    	color: gray;
    }
    #chat-area{
    	width: 100%;
    	height: 100%;
    }
    
    #chat-area>div>*{
    	width: 100%;
    	height: 100%;
    }
    
    #board-list tr{
    	height: 30px;
    	font-size: 15px;
    }
    
    .notice_line:hover{
    	cursor: pointer;
    	color: gray;
    }
    
    
</style>
</head>
<body>
	
	<%@include file="../common/header.jsp" %>
	
	<div class="outer">
 		<div id="header" style="height: 10%">
		<h2 align="center" style="border: none;">
			일반 게시판
		</h2>
		</div>

		<div id="content" style="height: 90%">
    
			<div id="sort-area" align="right"style="height: 10%;">

				<form action="list.bo" id="search-area" style="border: none;">
					<input type="hidden" name="currentPage" value="1">
					<select name="kind">
						<option value="title">제목</option>
						<option value="content">글 내용</option>
						<option value="userId">작성자</option>
					</select>
					<input type="text" id="search-text" name="keyword" style="width: 300px; height:100%;" placeholder="키워드를 입력해주세요.">
					<button type="submit">검색</button>
				</form>
				
			
			</div>
	
			<div id="content_1" style="display: inline-block; width: 20%; height: 90%;">
				<div id="chat-area">
			    	<div style="height: 80%">			    	
			    		<textarea style="resize: none;" id="chat_output" readonly></textarea>
			    	</div>
			    	<div id="loginInfo" style="height: 5%;">
			    		<%if(loginUser != null){ %>
			    			<span><%=loginUser.getUserId() %>님</span>
			    		<%}else{ %>
			    			<span>로그인 후 이용해 주세요.</span>
			    		<%} %>
			    	</div>
		    		<div style="height: 5%">
		    			<%if(loginUser != null){ %>
			    		<input type="text" id="chat_input" required placeholder="메세지를 입력하세요.">
			    		<%}else{ %>
			    		<input type="text" id="chat_input" required readonly placeholder="메세지를 입력하세요.">
			    		<%} %>
			    		<button type="button" id="chat_btn">전송</button>
			    		<button type="button" id="chat_exit">채팅 종료</button>
		    		</div>
				</div>
			</div>
			
			<!-- 웹소켓 해보자!! -->
			<script>
				$(function(){
					var str = "";
					var webSocket = new WebSocket("ws://localhost:8888/<%=contextPath%>/webSocket");
					
					webSocket.onopen = function() {
						$("#chat_output").css("text-align", "center");
						$("#chat_output").val("----채팅을 시작합니다----");
					};
					   
					webSocket.onclose = function() {
						$("#chat_output").css("text-align", "center");
						$("#chat_output").val("----채팅을 종료합니다----");
					};
					
					webSocket.onerror = function() {
						$("#chat_output").html("----오류----");
					};
					// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
					webSocket.onmessage = function(message) {
						$("#chat_output").css("text-align", "left");
						
						str += message.data+"\n";
						$("#chat_output").val(str);
					};

					
					<%if(loginUser != null){%>
					$("#chat_input").on("keydown", function(e){
						if(e.keyCode == 13){
							e.preventDefault();
							$("#chat_btn").click();
						}
					});
					
					$("#chat_btn").on("click", function(){
						var input = $("#chat_input").val();
						
						
						webSocket.send("<%=loginUser.getUserId()%> : "+input);
						
						$("#chat_input").val("");
					});
					<%}%>
					
					$("#chat_exit").on("click", function(){
						webSocket.close();
					});
					 
				});
			</script>
			
			<div id="content_2" style="display: inline-block; width: 80%; height:90%;">
				<table border="1" style="width:100%; box-sizing:border-box; text-align: center" id="board-list">
					<thead>
						<tr>
							<th width="40">글번호</th>
							<th width="420">제목</th>
							<th width="80">작성자</th>
							<th width="80">작성일</th>
							<th width="40">조회수</th>
						</tr>
	            	<%if(!nlist.isEmpty()){ %>
	            		<%for(Board b : nlist){ %>
	            		<tr class="notice_line">
	            			<input id="bno" type="hidden" name="bno" value="<%=b.getBoardNo() %>">
							<td>공지</td>
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
	            	<tbody>
	            	<%if(list.isEmpty()){ %>
	            		<tr>
	            			<td colspan="5">작성된 게시글이 없습니다.</td>
	            		</tr>
	            	<%}else{ %>
	            		<%for(Board b : list){ %>
						<tr>
							<td><%=b.getBoardNo()%></td>
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
					</tbody>
				</table>
				
				<div id="page-area" align="center" style="height:20%; border: none;">
					<div style="margin-top: 20px; border:none;">
						<%if(a == 0){ %>
						<!-- 전체 페이징 -->
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
						
						<%}else if(a == 1){ %>
							<!-- 키워드에 의한 페이징 -->
							<!-- semi/list.bo?currentPage=1&kind=title&keyword=DM -->
							<%if(pi.getCurrentPage()!=1){ %>
								<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()-1%>&kind=<%=kind%>&keyword=<%=keyword%>'">prev</button>
							<%} %>
							
							<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
								<%if(i != pi.getCurrentPage()){ %>
									<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=i%>&kind=<%=kind%>&keyword=<%=keyword%>'"><%=i%></button>			 		
								<%}else{ %>
									<button disabled><%=i%></button>
								<%} %>
							<%} %>
							
							<%if(pi.getCurrentPage()!=pi.getMaxPage()){ %>
								<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage()+1%>&kind=<%=kind%>&keyword=<%=keyword%>'">next</button>
							<%} %>
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
				location.href = "<%=contextPath%>/insert.bo";
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
					
					var bno = $(this).children().eq(0).val();
					
					location.href = "<%=contextPath%>/detail.bo?bno="+bno;
					
					
					
				});
			});
			
			
		</script>


	</div>
	
	<%@include file="../common/footer.jsp"%>
	
	<script>
		$(function(){
			$("input").attr("autocomplete", "off");
		});
		
		
		
	</script>
	
		
</body>
</html>