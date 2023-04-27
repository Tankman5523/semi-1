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
    <style>
	.outer{
        border: 1px solid black;
        width: 1200px;
        height: 800px;
        margin: auto;
    }
    
    .outer>h2{
    	margin-top: 30px;
    }
    .outer table{
    	border : 1px solid black;
    	width : 900px
    }
    
    table th{
    	height : 30px;
    	
    }
    
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
    
    #content{
    	width : 100%;
    	height : 100%;
    }
    #insertForm-area>.option{
        margin: auto;
        width: 80%;
        margin-bottom: 20px;
    }
    #insertForm-area>#submit-area{
    	text-align: center;
    }
    
    #insertForm-area>table * , #reply-form>table *{
    	margin: 10px;
    }
    </style>
</head>
<body>	
	<%@ include file = "../../common/mainMenu.jsp" %>
	<div class="outer">
		<h2 align="center">1:1 문의</h2>
			<input type="hidden" name="userNo" value = <%=loginUser.getUserNo()%>>
			<br>
			<table align="center">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style = "width :95%; "value ="<%=qa.getTitle()%>" readonly>
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="100" name="content" style="resize:none;" readonly><%=qa.getContent()%></textarea>
					</td>
				</tr>
			</table>
		
		<div id=btn-area>
			<button>수정하기</button>
			<button>삭제하기</button>
		</div>
		<br>	
        <!-- 관리자만 작성 가능, 답변이 비어있지 않을 경우만 보여지게,  -->
            <table id="reply" align="center">
            	<tbody>
            	
            	</tbody>
		<%if(loginUser.getAdmin().equals("Y")){ %>	
            	<tfoot>
                <tr>
                	<th rowspan = "2" align="center">관리자</th>
                    <td rowspan="2">
                       <textarea name="reply-content" id="reply-content" cols="90" rows="5" style="resize:none;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <button id="reply-btn"> 등록 </button>
                    </td>
                </tr>
            	</tfoot>
            </table>
        <%} %>
	</div>
	
	<script>
	
		//안되는 이유 못찾겠음.. 확인하기 
		$(function(){
			answerView();
		/*답변 등록 script*/
		$("#reply-btn").on('click',function(){
			var qno = <%=qa.getqNo()%>; //글번호
			console.log(qno);
			
			var answer = $('#reply-content'); //답변 내용 
			console.log(answer.val());
			$.ajax({
				url : "answer.qa",
				
				data : { qno : qno, 
						 answer : answer.val()},
				
				type:"post",
				
				success: function(result){
					if(result == "YY"){
						alert("답변 등록 성공 ")
						$('#reply-content').val("")
						
						answerView();
					}else{
						alert("답변 등록 실패")
					}
				},
				
				error : function(result){
					console.log("통신 실패 ");
					
				}
				
			});
		});//함수 끝  
			
			/*답변 조회 리스트*/
		function answerView(){
				
				$.ajax({
				
					url : "answer.qa",
					
					data : {qno : '<%=qa.getqNo()%>' },
					
					type : "get",
					
					success : function(answer){
						console.log(answer);
						
						if(answer != null){
							
						var str = "";
						
						str += "<tr>"
							 + "<td rowspan = '2' align ='center'> 관리자 </th>"
							 + "<td rowspan = '2'>"
							 + "<textarea cols='90' rows='5' style='resize:none;'>" + answer + "</textarea>"
							 + "</td>"
						
						}
						$('#reply>tbody').html(str);
	
					},
					
					error: function(){
						console.log("통신실패");
					}
					
					
				})
			};
			
		});	
	</script>
</body>
</html>