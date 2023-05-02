<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="com.bbbox.qaboard.model.vo.Question"%>
<!DOCTYPE html>

<%
	Question qa = (Question)request.getAttribute("qa");

%>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 </title>
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
	
	.outer{
        width: 1200px;
        height: 700px;
        margin:auto;
        background-color : white;
        overflow-y : scroll;
    }
    
    .outer>h2{
    	padding-top:30px;
    	font-family: 'SBAggroB';
    	
    }
    
    .outer table{
    	border : 1px solid black;
    	width : 900px
    }
    
    #insertqa th{
    	font-family: 'Cafe24Ohsquare';
    	width: 120px;
    	text-align: center;
    }
    
    #insertqa td{
    	font-family: 'HallymGothic-Regular';
    	
    }
	
	 /* -------------- 댓글 영역 --------------- */
    #reply_user th{
    	font-family: 'Cafe24Ohsquare';
    	width: 57px;
    	text-align: center;
    }
    
    #reply_user td, #reply_admin td{
    	font-family: 'HallymGothic-Regular';
    }
    
    #reply_admin th{
    	font-family: 'Cafe24Ohsquare';
    	width: 120px;
   		text-align:center;
    }

    /* -------------- 버튼 영역 ----------------- */
    #btn-area{
    	width : 900px;
    	height : 50px;
    	margin : auto;
		text-align:center;    	
    }
    
    #btn-area button{
    	margin: 12px;
    	margin-left : 10px;
    	margin-right : 10px ;
    }
    
    textarea{
    	width : 100%;
    }
    #insertForm-area>.option{
        margin: auto;
        width: 80%;
        margin-bottom: 20px;
    }

    #insertForm-area>table * , #reply-form>table *{
    	margin: 10px;
    }
    
    </style>

<%@ include file = "../../common/header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>	

<div id="content">
	<!-- 로그인 회원이 공개 개시글을 조회했을 때 -->
	<%if(loginUser != null){ %>
	<div class="outer">
		<h2 align="center">1:1 문의</h2>
			<br>
			<table id="insertqa" align="center">
				<tr>
					<th> 제목</th>
					<td>
						<input type="text" name="title" value ="<%=qa.getTitle()%>" style="width: 100%;" readonly>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="90" name="content" style="resize:none;" readonly><%=qa.getContent()%></textarea>
					</td>
				</tr>
			</table>
		<%if(loginUser.getUserId().equals(qa.getqWriter())){%>
		<div id=btn-area>
			<button class="btn btn-secondary" onclick = "modify_qa();">수정하기</button>
			<button class="btn btn-warning" id="question_del">삭제하기</button>
		</div>
		<%} %>
		<br>	
		<%if(loginUser.getAdmin().equals("Y")){ %>
			<%if(qa.getAnswer()==null){ %>	
            <table id="reply_admin" align="center">
            	<tbody>
	                <tr>
	                	<th width="">관리자</th>
	                    <td>
	                       <textarea name="reply-content" id="reply-content" cols="80" rows="5" style="resize:none;"></textarea>
	                    </td>
			             <td>
	                        <button class="btn btn-secondary" id="reply-btn">등록</button>
	                    </td>
	                </tr>
                </tbody>
            </table>
            <%}else{%>
	            <table id="reply_admin" align="center">
	            	<tbody>
		                <tr>
		                	<th width="">관리자</th>
		                    <td>
		                       <textarea name="reply-content" id="reply-content" cols="80" rows="5" style="resize:none;" readonly><%=qa.getAnswer()%></textarea>
		                    </td>
				             <td>
		                    </td>
		                </tr>
	                </tbody>
	            </table>
            <%} %>
        <%}else if(qa.getAnswer() != null){ %>
        <!-- 사용자에게 보이는 화면 -->
        	<table id="reply_user" align="center">
            	<tbody>
	            	<tr>
		                <th>관리자</th>
		                    <td rowspan="2">
		                       <textarea name="reply-content" id="reply-content" cols="90"  rows="5" style="resize:none;" readonly><%=qa.getAnswer()%></textarea>
		                    </td>
		                </tr>
                </tbody>
            </table>
        <%} %>
	<%}else{ %>
<!-- 로그인하지 않은 사용자가 조회할 경우  -->
		<div class="outer">
		<h2 align="center">1:1 문의</h2>
			<br>
			<table id="insertqa" align="center">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style = "width :100%;"value ="<%=qa.getTitle()%>" readonly>
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="90" name="content" style="resize:none;" readonly><%=qa.getContent()%></textarea>
					</td>
				</tr>
			</table>
		<br>	
        <!-- 사용자에게 보이는 답변 화면 -->
        	<table id="reply_user" align="center">
            	<tbody>
	            	<tr>
		                <th rowspan = "2" align="center">관리자</th>
		                    <td rowspan="2">
		                       <textarea name="reply-content" id="reply-content" cols="90" rows="5" style="resize:none; width: 100%; " readonly><%=qa.getAnswer()%></textarea>
		                    </td>
		                </tr>
                </tbody>
            </table>
	</div>
	<%} %>
	<script>
		$(document).ready;
		
		/*답변 등록 script --- 관리자 영역 */
		$("#reply-btn").on('click',function(){
			var qno = '<%=qa.getqNo()%>'; //글번호
			
			var answer = $('#reply-content'); //답변 내용 
			
			$.ajax({
				url : "answer.qa",
				
				data : { qno : qno, 
						 answer : answer.val()},
				
				type:"post",
				
				success: function(result){
					
					if(result == "YY"){
						alert("답변 등록 성공 ")
						
					}else{
						alert("답변 등록 실패");
					}
					
					location.href="<%=contextPath%>/manage.list.qa"
				},
				
				error : function(result){
					console.log("통신 실패 ");
					
				}
				
			});
		});//함수 끝  
		
		/*수정버튼 이벤트 발생 script*/
		function modify_qa(){
			
			var qno = "<%=qa.getqNo()%>"; //질문 번호
			
			location.href="<%=contextPath%>/modify.qa?qno="+qno;
		}
		
		/*삭제버튼 이벤트 발생 script	*/
		$(function(){
			
			$('#question_del').on('click',function(){
				var qno = "<%=qa.getqNo()%>";
				
				if(confirm("삭제한 게시글은 복구가 불가능 합니다. \n 정말 삭제하시겠습니까?")){
					
					$.ajax({
						
						url : "delete.qa",
						
						data : {qno : qno},
					
						type : "post",
						
						success : function(result){
							console.log(result);
							if(result == "YY"){
								alert("게시글 삭제가 성공적으로 완료되었습니다.");
							}else{
								alert('게시글 삭제에 실패하였습니다. 다시 시도해주세요');
								
							}
							
							location.href="<%=contextPath%>/list.qa" //알림 후 리스트로 돌아가기 
						},
					
						
					}); //ajax 끝 
				
				}
			}); //함수 끝 
			
		});
			
	</script>
	</div>
</div>			
<%@ include file = "../../common/footer.jsp" %>