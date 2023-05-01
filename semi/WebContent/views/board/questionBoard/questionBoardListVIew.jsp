<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.qaboard.model.vo.Question, 
    								com.bbbox.common.model.vo.PageInfo"%>
<%

	ArrayList<Question> qList = (ArrayList<Question>)request.getAttribute("qList");
	
	System.out.print(qList);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1문의 게시판</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
	
	@font-face{
   		font-family: 'SBAggroB';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');	
   		font-weight: normal;
		font-style: normal;
	}    
	
	@font-face {
    font-family: 'Cafe24Ohsquare';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/Cafe24Ohsquare.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	@font-face {
    font-family: 'HallymGothic-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2204@1.0/HallymGothic-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
	}
    
    #content>h2{
    	font-family: 'SBAggroB';
    	font-size: 30px;
		font-weight:300;
		color : white;    	
    	
    	padding-top: 70px;
    
    }
    #board{
		background-color : white;
        width: 1200px;
        height : 550px;
        margin: auto;
    }
    
	thead {
		background-color: gainsboro;
	}
	
	thead th{
		 font-family: 'Cafe24Ohsquare';
		 font-size: 20px;
		
	}
	
	tbody td{
		 font-family: 'HallymGothic-Regular';
		 font-size: 18px;
		 height: 35px;
	}
	
	
</style>
<%@ include file = "../../common/header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


<div id="content" style="overflow: auto">
		<h2 align="center" style="border: none;">1:1 문의 게시판</h2>
		<hr>
		<div id="board">
			<%if (loginUser != null) {%>
			<div id="btn-area" style="height:10%; border:none;" align="right">
				<button class="btn btn-primary"onclick="questionWrite();" style="margin: 10px">글쓰기</button>
			</div>
			<%} %>
			
			<script>
				/*글쓰기 버튼 눌렀을 때 발생하는 이벤트 */
				function questionWrite(){
					location.href="<%=contextPath%>/insert.qa";
				}
			</script>
			
			<table style="width:100%; box-sizing:border-box; text-align: center" id="board-list">
				<thead>
					<tr>
						<th width="50">글번호</th>
						<th width="420">제목</th>
						<th width="80">작성자</th>
						<th width="80">작성일</th>
						<th width="50">공개여부</th>
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
								</tr>
							<%} %>
					<%}else{%>
						<tr>
							<td colspan="5">작성된 게시글이 없습니다.</td>
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
							//console.log(qWriter); // 작성자
							
							var open = $(this).children().eq(4).text();
							//console.log(open); // 공개여부 
								
							var qno = $(this).children().eq(0).text(); //글번호	
							
							if(loginUser == qWriter || admin =="Y" || open == "공개"){
								
								location.href="<%=contextPath%>/detail.qa?qno="+qno; //해당 글 상세페이지로 이동 
								
							}else{
								alert("해당 게시글은 비공개 글입니다.");
								
							}
						
						})
						
					}); //함수 끝  
				<%}else{ %> 
					$(function(){
						$("#qa-list").on('click','tr',function(){
							
							var qno = $(this).children().eq(0).text(); //글번호	
							
							var open = $(this).children().eq(4).text();
							
							if(open == "공개"){
								
								location.href="<%=contextPath%>/detail.qa?qno="+qno; //해당 글 상세페이지로 이동 
								
							}else{
								alert("해당 게시글은 비공개 글입니다.");
							} 	
						});

					});	//함수 끝			
					
				<%}%>
				</script>
		</div>
		<br><br>
	</div>
<%@ include file = "../../common/footer.jsp" %>