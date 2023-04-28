<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.qaboard.model.vo.Question, 
    								com.bbbox.common.model.vo.PageInfo"%>
    
<%

	ArrayList<Question> qList = (ArrayList<Question>)request.getAttribute("qList");
	PageInfo pi = (PageInfo)request.getAttribute("pageInfo");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1문의 게시판(관리자)</title>
<style>
	
    div, input, textarea, h2{
        border: 1px solid black;
        box-sizing: border-box;
    }
    
    .outer{
        border: 1px solid black;
        width: 1200px;
        margin: auto;
    }

    #content{
        width: 1000px;
		margin: auto;
		margin-top: 10px;
    }
    
	#thead{
		background-color: gainsboro;
	}

   
    
    
</style>
</head>
<body>
<%@ include file = "../common/mainMenu.jsp" %>

	<div class="outer">
		<h2 align="center" style="border: none;">1:1 문의 게시판</h2>
		<hr>
		<div id="content">
			<div id="btn-area" style="height:10%; border:none;" align="right">
				<button onclick="questionWrite();" style="margin: 10px">글쓰기</button>
			</div>
			<script>
				function questionWrite(){
					location.href="<%=contextPath%>/insert.qa";
				}
			</script>
			
			<table style="width:100%; box-sizing:border-box; text-align: center" id="board-list">
				<thead  id="thead">
					<tr>
						<th width="50">글번호</th>
						<th width="420">제목</th>
						<th width="80">작성자</th>
						<th width="80">작성일</th>
						<th width="50">공개여부</th>
						<th width="50">답변여부</th>
					</tr>
				</thead>
				<tbody id="qa-list">
					<%if(!qList.isEmpty()){%>
					<!-- 작성된 1:1 문의가 비어있지 않을경우-->
						<%for (Question q : qList){ %>
								<tr>
									<td><%=q.getqNo()%></td>
									<td style="text-align: left; padding-left: 5px;"><%=q.getTitle()%></td>
									<td><%=q.getqWriter()%></td>
									<td><%=q.getDate()%></td>
									<%if(q.getOpen().equals("N")){%>
										<td><b>비공개</b></td> <!-- 나중에 아이콘으로 변경하기  -->
									<%}else{ %>
										<td><b>공개</b></td>
									<%} %>
									<!-- 답변 여부  -->
									<%if(q.getAnswer() == null){%>
										<td><b style = "color : blue">대기중</b></td> 
									<%}else{ %>
										<td><b style = "color : green">완료</b></td>
									<%} %>
									
								</tr>
							<%} %>
					<%}else{%>
						<tr>
							<td colspan="6">작성된 게시글이 없습니다.</td>
						</tr>
					<%} %>
				</tbody>
			</table>
				
				<script>
				<%if(loginUser != null){ %>
					$(function(){
						var loginUser ='<%=loginUser.getUserId()%>';
						var admin = '<%=loginUser.getAdmin()%>';
						
						$("#qa-list").on('click','tr' ,function(){
							
							var qWriter = $(this).children().eq(2).text();
						
							if(loginUser == qWriter || admin =="Y"){
								var qno = $(this).children().eq(0).text(); //글번호	
								
								location.href="<%=contextPath%>/detail.qa?qno="+qno; //해당 글 상세페이지로 이동 
								
							}else{
								alert("해당 게시글은 비공개 글입니다.");
								
							}
						
						})
						
					}); //함수 끝  
				<%}else{ %>
					$(function(){
						
						$("#qa-list").on('click','tr',function(){z
							alert("해당 게시글은 비공개 글입니다.");
						});

					});	//함수 끝			
					
				<%}%>
				</script>
		</div>
		<br><br>
		<div align ="center" class = "paging-area">
			<%if(pi.getCurrentPage() != 1) {%>
			<button onclick = "location.href='<%=contextPath%>/list.qa?currentPage=<%=pi.getCurrentPage()-1%>'">&lt;</button>
			<%} %>
			
			<%for (int i=pi.getStartPage() ;  i<=pi.getEndPage() ; i++){%>
			<!-- 내가 보고있는 페이지 버튼은 비활성화 시키기 -->
				<%if(i !=pi.getCurrentPage()) {%>
					<button onclick = "location.href='<%=contextPath%>list.qa?currentPage=<%=i%>';"><%=i%></button>				
				<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같으면 i와 currenPage -->
					<button  disabled><%=i %></button>
				<%} %>
			<%} %>
			
			<%if(pi.getCurrentPage() != pi.getMaxPage()){ %>
			<button onclick = "location.href='<%=contextPath%>/list.qa?currentPage=<%=pi.getCurrentPage()+1%>'">&gt;</button>
			<%}%>
		</div>
	</div>
</body>
</html>