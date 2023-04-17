<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.bbbox.board.model.vo.Board"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("boardList");
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
        width: 900px;
        height: 800px;
        margin: auto;
    }
    .footer{
		width: 900px;
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
    
</style>
</head>
<body>
	<div class="outer">
 		<div id="header" style="height: 10%">
		<h2 align="center">일반 게시판</h2>
		</div>

		<div id="content" style="height: 70%">
    
			<div id="sort-area" align="right"style="margin:10px;">
				<input type="text" style="height: 100%; width: 400px">
				<button>검색</button>
				<input type="radio" name="sort" id="resent"><label for="resent">최신순</label>
				<input type="radio" name="sort" id="recommend"><label for="recommend">추천순</label>
				<input type="radio" name="sort" id="viewed"><label for="viewed">조회순</label>
				
			</div>
	
			<div id="content_1" style="display: inline-block; width: 20%; height: 70%;">
				<form id="chat-area">
			    	<div style="height: 80%">			    	
			    		<textarea style="resize: none;" id="chat_output" readonly></textarea>
			    	</div>
		    		<div style="height: 10%">
			    		<input type="text" id="chat_input" required>
		    		</div>
			    	<button id="chat_submit" style="height: 10%">채팅 입력</button>
				</form>
			</div>
			
			<script>
				$("#chat_submit").on("click", function(){
					
					$.ajax({
						url:"chat.bo",
						data:{
							inputText:$("#chat_input").val()
						},
						success:function(result){
							
							
						},
						error:function(){
							alert("통신실패");
						}
					});
				});
			</script>
	
			<div id="content_2" style="display: inline-block; width: 80%;">
				<table border="1" style="width:100%; box-sizing:border-box;">
					<thead>
						<tr>
							<th width="50">글번호</th>
							<th width="300">제목</th>
							<th width="100">작성자</th>
							<th width="100">작성일</th>
							<th width="50">조회수</th>
						</tr>
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
							<td><%=b.getTitle()%></td>
							<td><%=b.getBoardWriter()%></td>
							<td><%=b.getCreateDate()%></td>
							<td><%=b.getCount()%></td>
						</tr>
						<%} %>
					<%} %>
					</tbody>
				</table>
				
				<button onclick="boardWrite()">글쓰기</button>
			</div>
		</div>
		
		<script>
			function boardWrite(){
				location.href = "/semi/insert.bo"
			}
			
			$(function(){
				$("tbody>tr").on("click", function(){
					
					var bno = $(this).children().eq(0).text();
					
					location.href = "/semi/detail.bo?bno="+bno;
				});
			});
		</script>


	</div>
	<div class="footer">
		<div id="footer_1">
			<a href="">이용약관</a> |
			<a href="">개인정보취급방침</a> |
			<a href="">인재채용</a> |
			<a href="">고객센터</a>
		</div>
        
		<div id="footer_2">
			<p id="p1">
	                
			</p>
			<p id="p2" align="center">
				Create By 블변의 법칙 Team
			</p>
		</div>	
	</div>
	
	<script>
		$(function(){
			$("input").attr("autocomplete", "off");
		});
	</script>
	
		
</body>
</html>