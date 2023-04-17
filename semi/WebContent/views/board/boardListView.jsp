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
<style>
    div{
        border: 1px solid black;
    }
    .outer{
        border: 1px solid black;
        width: 800px;
        height: 1200px;
        margin: auto;
    }
</style>
</head>
<body>
	<div class="outer">
 		<div id="header" style="height: 10%">
		<h2 align="center">일반 게시판</h2>
		</div>

		<div id="content">
    
			<div id="sort-area" align="right"style="margin:10px;">
				<input type="radio" name="sort" id="resent"><label for="resent">최신순</label>
				<input type="radio" name="sort" id="recommend"><label for="recommend">추천순</label>
				<input type="radio" name="sort" id="viewed"><label for="viewed">조회순</label>
			</div>
	
			<div id="content_1" style="display: inline-block; width: 20%; height: 40%;">
			    	광고배너
			</div>
	
			<div id="content_2" style="display: inline-block">
				<table border="1" style="width:100%">
					<thead>
						<tr>
							<th width="40">글번호</th>
							<th width="300">제목</th>
							<th width="100">작성자</th>
							<th width="100">작성일</th>
							<th width="40">조회수</th>
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
							<td><%=b.getContent() %></td>
							<td><%=b.getBoardWriter() %></td>
							<td><%=b.getCreateDate() %></td>
							<td><%=b.getCount() %></td>
						</tr>
						<%} %>
					<%} %>
					</tbody>
				</table>
			</div>
		</div>



		<div class="footer" style="height:20%">
			<div id="footer_1">
				<a href="">이용약관</a> |
				<a href="">개인정보취급방침</a> |
				<a href="">인재채용</a> |
				<a href="">고객센터</a>
			</div>
	        
			<div id="footer_2">
				<p id="p1">
		                
				</p>
				<p id="p2">
					Copyright © 2023 블변의 법칙 All Right Reserved
				</p>
			</div>	
		</div>
	</div>
</body>
</html>