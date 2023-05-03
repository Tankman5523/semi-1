<%@page import="java.awt.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.lawyer.model.vo.*,
    								com.bbbox.board.model.vo.*,
    								com.bbbox.qaboard.model.vo.Question" %>
<%
	ArrayList <Lawyer> lawList = (ArrayList <Lawyer>)request.getAttribute("lawList");
	
	ArrayList <Board> boardList = (ArrayList <Board>)request.getAttribute("boardList");
	
	ArrayList <Reply> replyList = (ArrayList <Reply>)request.getAttribute("replyList");
	
	ArrayList <Counsel> cList = (ArrayList<Counsel>)request.getAttribute("cList");
	
	ArrayList <LawReview> lawRev = (ArrayList<LawReview>)request.getAttribute("lawRev");
	
	ArrayList <AccidentReview> accRev =(ArrayList<AccidentReview>)request.getAttribute("accRev");
	
	ArrayList <Accident> accident = (ArrayList<Accident>)request.getAttribute("accident");
	
	ArrayList <Counsel> cListLaw = (ArrayList<Counsel>)request.getAttribute("cListLaw");
	
	ArrayList <Question> qList = (ArrayList<Question>)request.getAttribute("qList");
	
	String lat =(String)request.getAttribute("lat");
	
	String arNo =(String)request.getAttribute("arNo");
%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My page</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>

	/* 폰트 */
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

    #info{
        width: 1000px;
        height:100%;
        box-sizing: border-box;
        margin : auto;
        background-color: white;
        overflow-y:scroll;
        
    }
    #List{
        background-color: rgb(223, 220, 220);
    }
 	
 	table{
        width: 100%;
        text-align : center;
    }
    
    
    hr{
    	border : solid 1.5px gray;
    	
    }
    #info>h2, h3{
    	padding-top: 50px;
    	font-family: 'SBAggroB';
    
    }
    
    #info>h4{
    	padding-top: 5px;
    	margin-left: 20px;
    	font-family: 'SBAggroB';
    	font-size: 20px;
    }
    
    #info h3{
    	margin-left:20px;
    }
	
	/*변호사 회원 정보*/
	#law-info{
		width: 50%;
		margin: auto;
		font-family: SBAggroB; 
		font-weight: 300;
	}
	
	/*일반회원정보*/
	#user-info{
		width: 60%;
		margin-left:300px;
		font-family: SBAggroB; 
		font-weight: 300;
	}
	
	#user-info td, #law-info td{
		text-align: left;
	}
	
	thead th{
		font-family: 'Cafe24Ohsquare';
		font-size: 18px;
		height: 38px;
	}
	
	tbody td{
		font-family: HallymGothic-Regular;
		font-size: 18px;
		height: 38px;	
	}
	    
    a{
        text-decoration: none;
        color: black;
        display: block;
    }
    
    #review-btn{
    	margin-left: 10px;
    }
    a:hover +{
        cursor: pointer;
        
    }
    
    button{
    	margin-top: 5px;
    }
    #pointer:hover{
    	cursor: pointer;
    }
</style>
<%@ include file = "../common/header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<div id="content">
	<div id="info">
	    <h2 align="center">마이페이지</h2>
	    <hr>
		<h4>INFO</h4>
		<hr>
	    <!-- 기본정보 뷰(일반회원) -->
	    <%if((loginUser.getLawyer().equals("N")) || (loginUser.getLawyer().equals("W"))){ %>
	    	<form action="<%=contextPath%>/apply_Lawyer.me" method ="get">
		        <table id="user-info">
		            <tr>
		                <th width="150" height ="40" >아이디 </th>
		                <td width="200"><%=loginUser.getUserId()%></td>
		                <td></td>
		            </tr>
		            <tr>
		                <th height ="40">이름 </th>
		                <td><%=loginUser.getUserName()%></td>
		                <td></td>
		            </tr>
		            <tr>
		                <th height ="40">email </th>
		                <td><%=loginUser.getEmail()%></td>
		                <td></td>
		            </tr>
		            <tr>
		                <th height ="40" >회원타입 </th>
			            <td>일반회원 </td>
		            </tr>
		            <tr>
		            	<th></th>
			            <td height ="40" id="pointer"><a><i class="fa-solid fa-scale-balanced fa-xl" style="color: #fd7c26;"></i> 변호사회원 신청하기</a></td>
					</tr>		        
		        </table>
	    	</form>
	        <br>
		    <div id="btn" align="center">
		        <button  class="btn btn-secondary" onclick = "home();">메인으로</button>
		        <button  class="btn btn-dark" id="modify">수정하기</button>
		        <button  class="btn btn-warning" onclick = "memberDelete();"> 회원탈퇴 </button>
		    </div>
	    <%}else{ %>
	    <!-- 기본정보 뷰 (변호사 회원) -->
	        <table id="law-info">
	        	<tr>
	        		<th>사진</th>
	        		<td> <img colspan="4" width= 150 height="180" src="<%=contextPath+lat%>"></td>
	        		<td colspan="4" width= 150 height="180"></td>
	        	</tr>
	            <tr>
	                <th width="150">아이디 </th>
	                <td width="200"><%=loginUser.getUserId()%></td>
	                <td></td>
	            </tr>
	            <tr>
	                <th>이름 </th>
	                <td><%=loginUser.getUserName()%></td>
	                <td></td>
	            </tr>
	            <tr>
	                <th>email </th>
	                <td><%=loginUser.getEmail()%></td>
	                <td></td>
	            </tr>
	            <tr>
	                <th>회원타입 </th>
		            <td>변호사 회원</td>
	            </tr>
	        </table>
        <br>
	    <div id="btn" align="center">
	        <button class="btn btn-secondary"  onclick = "home();">메인으로</button>
	        <button class="btn btn-dark" id="modify">수정하기</button>
	        <button class="btn btn-warning"  onclick = "memberDelete();"> 회원탈퇴 </button>
	    </div>
	    <%} %>
	   
	   <script> 
		    /* 메인페이지 버튼 클릭 함수 script */
			function home(){
				location.href="<%=contextPath%>";
	
		    }
		    
			/* 클릭시 이미 신청한 회원이라면, 알림 띄워주기 */
			/* 변호사회원 신청페이지로 이동 */
			$(function(){
				$("#user-info").on('click',function(){
					
					console.log($(this));
					
					$.ajax({
					 	url : "chkapply.me",
					 	
					 	data : { userNo : <%=loginUser.getUserNo()%>},
					 	
					 	type : "post",
					 	
					 	success : function(result){
					 			
					 			if(result == 'W'){
					 			 	alert("이미 신청하였습니다.");
					 			 	return false;
					 			}else{
									location.href="<%=contextPath%>/apply_Lawyer.me"
					 			}
					 	},
					 	
					 	error : function(){
					 		console.log("통신 실패")
					 	}
					}); //ajax 끝
					
				});
			
			}); //함수 끝 
			

			 /*회원정보 수정 스크립트 영역*/	
			$(function(){
			
			    $('#modify').on('click',function(){
			    	
			    	if(<%=loginUser.getLawyer().equals("Y")%>){
			    		location.href="<%=contextPath%>/update_info.la";
			    	
			    	}else{
			    		location.href="<%=contextPath%>/update_info.me";
			    	}
			    		
			    	
			    });
			
			});
		    
			/* 회원 탈퇴 스크립트 영역  */
			function memberDelete(){
				
				if(confirm("회원 탈퇴시 해당 아이디 복구 및 재가입이 불가능 합니다. 탈퇴 하시겠습니까?")){
					
					location.href="<%=contextPath%>/confirm.me";
				}	
				
			}

		</script>	
		
	    <%if(loginUser.getLawyer().equals("N")){ %>
	    <!-- 찜한리스트 뷰 (일반회원일 경우)-->
	    <h3>내가 찜한 변호사</h3>
	    <hr>
	        <table>
	            <thead id="List">
	                <tr>
	                    <th width="100">No.</th>
	                    <th width="300">변호사</th>
	                    <th width="100"></th>
	                </tr>
	            </thead>
	            <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
	            <% if (!lawList.isEmpty()){ %>
	            <tbody id="dibs-lawyer">
		            <% for(int i =0; i<lawList.size() ;i++){ %>
		            <tr>
		                <td><%= i+1 %>.</td>
		                <td><a href="<%=contextPath %>/detail.la?lno=<%=lawList.get(i).getLawNo()%>"><%= lawList.get(i).getRefUno()%></a><input type ="hidden" name ="lawNO" value = "<%=lawList.get(i).getLawNo()%>" ></td>
		                <td id="heart"><i id="solidHeart" class="fa-sharp fa-solid fa-heart fa-lg" style="color: #ff0000;"></i><input type = "hidden" value ="solidHeart"> <input type ="hidden" name ="lawNO" value = "<%=lawList.get(i).getLawNo()%>" ></td>
		            </tr>
		            <%} %>
		        <!-- 찜한 변호사 리스트가 비어있다면  -->    
		       <%}else{ %>
		       		<tr>
		       			<td></td>
		       			<td colspan ="2"> 찜한 변호사가 없습니다</td>
		       		</tr>
		       <%} %>     
	            </tbody>
	        </table>
	    <%} %>
	    	
	    	<script>
		    	/* 찜하기 취소 script*/
		    	$(function(){
		    		
		    		$("#dibs-lawyer tr td").on('click','i',function(){
		    			
		    			var $heart = $(this).nextAll().eq(0).val();  //solidHeart
						var $lawNo = $(this).nextAll().eq(1).val(); //변호사 번호 
		    			
						if(confirm("찜하기를 취소하시겠습니까?")){
							
							$.ajax({
								url : "dibs.la",
								
								data : {lawNo : $lawNo,
										userNo : '<%=loginUser.getUserNo()%>',
										heart : $heart},
										
								type : "post",
								
								success: function(result){
									if(result == 2){
										alert("찜하기 취소를 완료하였습니다.");
										location.reload();
									}						
								}
								
							}); //ajax 끝 			
						}	    			
		    		});//하트 아이콘 클릭시 발생하는 이벤트 함수 끝 
		    		
		    	}); //함수 끝 
	    	</script>
	    	
	    <% if(loginUser.getLawyer().equals("Y")){ %>
	    <!-- 변호사 회원으로 로그인 했을 때 -->
	    <h3>해결 사건 리뷰</h3>
	    <hr>
	    	<table>
	            <thead id="List">
	                <tr>
	                    <th width="100">No.</th>
	                    <th width="400">게시글 내용 </th>
	                </tr>
	            </thead>
	            <% if(!accRev.isEmpty()){ %>
	            <!-- 해결사건 리스트가 비어있지 않다면  -->
	            	<%for(int i = 0 ; i < accRev.size() ; i++){ %>
			            <tr>
			                <td><%= i+1 %>.</td>
			                <td><%= accRev.get(i).getContent() %></td>
			            </tr>
		            <%} %>
		        <%}else{ %>    
				<!-- 해결된 사건 리스트가 비어있다면  -->	
					<tr>
		       			<td></td>
		       			<td colspan="3"> 조회된 게시글이 없습니다. </td>
		       		</tr>
		       	<%} %>	
	        </table>
	        
        <h3>내 상담 내역</h3>
	    <hr>
	        <table>
	            <thead id="List">
	                <tr>
	                    <th width="100">No.</th>
	                    <th width="260">상담 제목</th>
	                    <th width ="70">상태</th>
	                    <th width="70">상담 일자</th>
	                </tr>
	            </thead>
	            <% if(!cListLaw.isEmpty()){ %>
	            <tbody id="counsel-list-law">
	            	<% for(int i = 0 ; i < cListLaw.size() ; i++){ %>
		            <tr>
		                <td><%= i+1 %>.</td>
		                <td><a href="<%=contextPath %>/counselDetailLaw.la?cno=<%=cListLaw.get(i).getCsNo()%>"><%= cListLaw.get(i).getCsTitle()%></a></td> 
		              	<% if(cListLaw.get(i).getAccept().equals("W")){%>
		                	<%if(cListLaw.get(i).getCsAnswer() == null){ %>
			                	<td><b style = "color : red ">답변 대기중</b></td>
		                	<%}else{ %>
		                		<td><b style = "color : blue ">수락 대기중</b></td> 	
		                	<%} %>
		                <%}else { %>
		               		<td><b style = "color : green ">상담 종료</b></td> 	
		                <%} %>
		                <td><%= cListLaw.get(i).getCreateDate()%></td>
		            </tr>
		            <%} %>
		         </tbody>
	            <%}else{ %>
	            	<tr>
	            		<td></td>
	            		<td colspan="3">상담 내역이 존재하지 않습니다.</td>
	            	</tr>
	            <%} %>
	        </table>
		 
	    <h3>내 게시글 관리 </h3>
	    <hr>
	    	<table>
	            <thead id="List">
	                <tr>
	                    <th width="70">No.</th>
	                    <th width="230">게시글 제목 </th>
	                    <th width="100">작성 게시판</th>
	                    <th width="70">작성 날짜</th>
	                    <th width="30">삭제</th>
	                </tr>
	            </thead>
	            <!-- 게시글 리스트가 비어있지 않다면  -->
	            <% if(!boardList.isEmpty()){%>
				<tbody id="board-list">
			      	<%for(int i=0; i<boardList.size(); i++){ %>
					 <tr>
		                <td><%=i+1 %>.</td>
		                <td><a href="<%=contextPath%>/detail.bo?bno=<%=boardList.get(i).getBoardNo()%>"><%=boardList.get(i).getTitle()%></a></td>
		                <td><%=boardList.get(i).getCategoryName()%></td>
		                <td><%= boardList.get(i).getCreateDate()%></td>
		                <td><button class= "btn btn-outline-danger">삭제</button> <input type="hidden" id=bno value="<%=boardList.get(i).getBoardNo()%>"></td>
		            </tr>
					<%} %>
				<!-- 게시글 리스트가 비어있다면  -->	
				<%}else{%>
					<tr>
		       			<td></td>
		       			<td colspan="4"> 조회된 게시글이 없습니다. </td>
		       		</tr>
				<%} %>
				</tbody>
	        </table>
		<%}else{ %>
		
		<!-- 일반 회원 로그인시 보이는 마이페이지 영역  -->
	    <h3>내 게시글 관리 </h3>
	    <hr>
	    	<table>
	            <thead id="List">
	                <tr>
	                    <th width="70">No.</th>
	                    <th width="230">게시글 제목 </th>
	                    <th width="100">작성 게시판</th>
	                    <th width="70">작성 날짜</th>
	                    <th width="30">삭제</th>
	                </tr>
	            </thead>
	            <!-- 게시글 리스트가 비어있지 않다면  -->
	            <% if(!boardList.isEmpty()){%>
				<tbody id="board-list">
			      	<%for(int i=0; i<boardList.size(); i++){ %>
					 <tr>
		                <td><%=i+1 %>.</td>
		                <td><a href="<%=contextPath%>/detail.bo?bno=<%=boardList.get(i).getBoardNo()%>"><%=boardList.get(i).getTitle()%></a></td>
		                <%if(boardList.get(i).getCategoryName().equals("해결")){ %>
		               	 	<%if(boardList.get(i).getRevNo() == null){ %>
			               	 	<td><%=boardList.get(i).getCategoryName()%> <a class="review-btn" style="color :blue" >리뷰작성</a> <input type=hidden name="refAccNo" value = <%=boardList.get(i).getAccNo()%>></td>
		               	 	<%}else{ %>	 
		               	 		<td><%=boardList.get(i).getCategoryName()%></td>
		               	 	<%} %>	
		                <%}else{ %>
		                <td><%=boardList.get(i).getCategoryName()%></td>
		                <%} %>
		                <td><%= boardList.get(i).getCreateDate()%></td>
		                <td><button class= "btn btn-outline-danger">삭제</button> <input type="hidden" id=bno value="<%=boardList.get(i).getBoardNo()%>"></td>
		            </tr>
					<%} %>
				<!-- 게시글 리스트가 비어있다면  -->	
				<%}else{%>
					<tr>
		       			<td></td>
		       			<td colspan="4"> 조회된 게시글이 없습니다. </td>
		       		</tr>
				<%} %>
				</tbody>
	        </table>
			<%} %>	        
	        <script>
	       
	       
	        $(function(){
	        	$("#board-list tr td").on('click','button',function(){
					
	        		if(confirm("삭제한 글은 복구가 불가능 합니다. 정말 삭제하시겠습니까?")){
	        			var $bno = $(this).next().val();
	        			console.log(bno);
	        			
	        			$.ajax({
	        				
	        				url : "delete.bo",
	        				
	        				data : { bno : $bno },
	        				
	        				type : "post",
	        				
	        				success : function(result){
	        					
	        					if(result=="YY"){
	        						alert("게시글 삭제가 완료되었습니다.")
	        						location.reload();
	        					}else{
	        						alert("게시글 삭제에 실패하였습니다. 다시 시도해주세요");
	        						location.reload();
	        					}
	        				}
	        				
	        			}); 
	        		}
	        		
	        	})	
	        
	        });
	       
	        
	        /*회원이 작성하는 변호사 리뷰 */
	        $('#board-list tr td ').on('click','.review-btn',function(){
					var accNo = $(this).next().val();
		        	console.log(accNo);
	        	if(confirm('리뷰 작성 페이지로 이동하시겠습니까?')){
		        	
	        		location.href = "<%=contextPath%>/review.la?accNo="+accNo;
	        		
	        	}
	        	
	        	
	        	
	        });//함수 끝 
	        
	        </script>
	        
	    <h3>1:1 문의 </h3>
	    <hr>
	    	<table>
	            <thead id="List">
	                <tr>
	                    <th width="100">No.</th>
	                    <th width="230">게시글 제목 </th>
	                    <th width="70">작성 게시판</th>
	                    <th width="70">작성 날짜</th>
	                    <th width="30">삭제</th>
	                </tr>
	            </thead>
	            <!-- 1대1 문의 게시글이 비어있지 않다면  -->
	            <% if(!qList.isEmpty()){%>
				<tbody id="question-list">
			      	<%for(int i=0; i<qList.size(); i++){ %>
					 <tr>
		                <td><%=i+1 %>.</td>
		                <td><a href="<%=contextPath%>/detail.qa?qno=<%=qList.get(i).getqNo()%>"><%=qList.get(i).getTitle()%></a></td>
		                <td><%=qList.get(i).getCategoryName()%></td>
		                <td><%=qList.get(i).getDate()%></td>
		                <td><button class= "btn btn-outline-danger">삭제</button> <input type="hidden" id=bno value="<%=qList.get(i).getqNo()%>"></td>
		            </tr>
					<%} %>
				<!-- 1대1 문의 게시글이 비어있다면  -->	
				<%}else{%>
					<tr>
		       			<td></td>
		       			<td colspan="4"> 조회된 게시글이 없습니다. </td>
		       		</tr>
				<%} %>
				</tbody>
	        </table>
	        
	        <script>
	        /* 1대1 문의  삭제 script*/
	        $(function(){
	        	$("#question-list tr td").on('click','button',function(){
					
	        		if(confirm("삭제한 글은 복구가 불가능 합니다. 정말 삭제하시겠습니까?")){
	        			var $qno = $(this).next().val();
	        			console.log($qno);
	        			
	        			$.ajax({
	        				
	        				url : "delete.qa",
	        		
	        				data : { qno : $qno },
	        				
	        				type : "post",
	        				
	        				success : function(result){
	        					
	        					if(result=="YY"){
	        						alert("게시글 삭제가 완료되었습니다.")
	        						location.reload();
	        					}else{
	        						alert("게시글 삭제에 실패하였습니다. 다시 시도해주세요");
	        						location.reload();
	        					}
	        				}
	        				
	        			}); // ajax 끝 
	        		}
	        		
	        	})	
	        
	        });
	        
	        </script>     
	           
	    <h3>내 댓글 관리</h3>
	    <hr>
	    	<table>
	            <thead id="List">
	                <tr>
	                    <th width="100">No.</th>
	                    <th width="230">댓글 내용</th>
	                    <th width="70">작성 게시판</th>
	                    <th width="70">작성 날짜</th>
	                    <th width ="30">삭제</th>
	                </tr>
	            </thead>
	             <!-- 댓글 리스트가 비어있지 않다면  -->
	            <% if(!replyList.isEmpty()){%> 
				<tbody id="reply-list">
					<%for(int i = 0 ; i<replyList.size() ; i++){%>
		            <tr>
		                <td><%=i+1 %>.<input type = "hidden" value = "<%=replyList.get(i).getRefBno()%>"></td>
		                <%if(replyList.get(i).getStatus().equals("N")){%>
		               		<td>삭제된 게시글 입니다. </td>
		               	<%}else{ %>
		                	<td><a href="<%=contextPath%>/detail.bo?bno=<%=replyList.get(i).getRefBno()%>"><%=replyList.get(i).getContent()%></a></td>
		                <%} %>
		                
						<td><%= replyList.get(i).getCategoryName()%></td>               
		                <td><%= replyList.get(i).getDate()%></td>
		                <td><button class= "btn btn-outline-danger" >삭제</button> <input type="hidden" value="<%=replyList.get(i).getRpNo()%>"></td>
		            </tr>
		            <%} %>
		         <!-- 댓글 리스트가 비어있다면  -->   
		        <%}else{ %>
		        	<tr>
		       			<td></td>
		       			<td colspan="4"> 조회된 댓글이 없습니다. </td>
		       		</tr>
		        <%} %>    
				</tbody>
	        </table>
	        
	        <script>
	        
	        /*댓글 삭제 script */
	         $(function(){
	        	 
	        	 $("#reply-list tr td").on('click','button', function(){
	        		 
	        		 if(confirm("삭제한 댓글 은 복구가 불가능 합니다. 정말 삭제하시겠습니까?")){
	         			var $rpno = $(this).next().val();
	         			var $bno = $(this).parent().prevAll().eq(3).children().val();
	         			
	         			$.ajax({
	         				
	         				url : "delRp",
	         				
	         				data : { rpNo : $rpno,
	         						 bno : $bno},
	         				
	         				type : "get",
	         				
	         				success : function(result){
	         					
	         					if(result>0){
	         						alert("댓글 삭제가 완료되었습니다.")
	         						location.reload();
	         					}else{
	         						alert("댓글 삭제에 실패하였습니다. 다시 시도해주세요");
	         						location.reload();
	         					}
	         				}
	         				
	         			}); // ajax 끝 
	         		}
	        	
	        	 })
	        	 
	         }); //함수 끝 
	        
	        </script>
	        
	        <%if(loginUser.getLawyer().equals("N")){ %>
		    <!-- 상담리스트 뷰 -->
		    <h3>내 상담 내역</h3>
		    <hr>
		        <table>
		            <thead id="List">
		                <tr>
		                    <th width="100">No.</th>
		                    <th width="230">상담 제목</th>
		                    <th width ="70">상태</th>
		                    <th width="70">상담 일자</th>
		                    <th width="30">삭제</th>
		                </tr>
		            </thead>
		            <% if(!cList.isEmpty()){ %>
		            <tbody id="counsel-list">
		            	<% for(int i = 0 ; i < cList.size() ; i++){ %>
			            <tr>
			                <td><%= i+1 %>.</td>
			                <td><a href="<%=contextPath %>/counselDetail.la?cno=<%=cList.get(i).getCsNo()%>"><%= cList.get(i).getCsTitle()%></a></td> 
			                	<!-- 답변 상태값 영역 -->
			                <% if(cList.get(i).getAccept().equals("W")){%>
			                	<% if(cList.get(i).getCsAnswer() == null){%>
				                	<td><b style = "color : red ">대기중</b></td>
				                <%}else{ %>
				               		<td><b style = "color : blue ">답변 완료</b></td> 	
				                <%} %>
			                <%}else{ %>
			               		<td><b style = "color : green ">상담 종료</b></td> 	
			                <%} %>
			               	<td><%= cList.get(i).getCreateDate()%></td>
			                <td><button class= "btn btn-outline-danger" >삭제</button> <input type="hidden" value = "<%=cList.get(i).getCsNo()%>"></td>
			            </tr>
			            <%} %>
		            <%}else{ %>
		            	<tr>
		            		<td></td>
		            		<td colspan ="4">상담 내역이 존재하지 않습니다.</td>
		            	</tr>
		            <%} %>
			         </tbody>
		        </table>
		    <hr>
		   
		    <script>
	        /*내 상담 내역 삭제 script*/
	        $(function(){
	        	
	        	$("#counsel-list tr td").on('click','button',function(){
	        		
	        		 if(confirm("삭제한 상담 내용은 복구가 불가능 합니다. 정말 삭제하시겠습니까?")){
	          			
	        			var $cno = $(this).next().val(); //상담 번호 
	          			
	          			$.ajax({
	          				
	          				url : "counselDelete.la",
	          				
	          				data : { cno : $cno },
	          				
	          				type : "post",
	          				
	          				success : function(result){
	          					
	          					if(result=="YY"){
	          						alert("상담내역 삭제가 완료되었습니다.")
	          						location.reload();
	          					}else{
	          						alert("상담내역 삭제에 실패하였습니다. 다시 시도해주세요");
	          						location.reload();
	          					}
	          				}
	          				
	          			}); // ajax 끝 
	          		}       	
	        		
	        	});
	        })
	        </script>
		    <!-- 리뷰 내역(일반회원)-->
		    <h3>리뷰</h3>
		   		 <hr>
		         <table>
		            <thead id="List">
		                <tr>
		                    <th width="100">No.</th>
		                    <th width="300">내용</th>
		                    <th width="70">별점</th>
		                    <th width="30">삭제</th>
		                    
		                </tr>
		            </thead>
					<% if(!lawRev.isEmpty()){%>
						<tbody id=user-review>
						<%for(int i = 0 ; i < lawRev.size() ; i++){ %>
			            <tr>
			                <td><%= i+1 %>.</td>
			                <td><a href="<%=contextPath%>/reviewDetail.la?reNo=<%=lawRev.get(i).getReviewNo()%>"><%= lawRev.get(i).getReviewContent()%></a></td>
			                <td><%= lawRev.get(i).getStar()%></td>
			                <td><button class= "btn btn-outline-danger">삭제</button> <input type=hidden value = "<%=lawRev.get(i).getReviewNo()%>"></td>
			            </tr>
			            <%} %>
						</tbody>
		            <%}else{ %>
		            <tr>
		            	<td></td>
		            	<td colspan="3">조회된 리뷰 내역이 없습니다. </td>
		            </tr>
		            <%} %>
		        </table>
		    <%} %>    
	    <br><br><br>
	</div>
		<script>
		/*리뷰 삭제 script 영역 */
		
		$(function(){
			
			$("#user-review tr td").on('click','button',function(){
				
				if(confirm("삭제한 리뷰내역은 복구가 불가능 합니다. 정말 삭제하시겠습니까?")){
					
					var $reNo = $(this).next().val(); //리뷰 번호 
					
					$.ajax({
	      				
	      				url : "reviewDelete.la",
	      				
	      				data : { reNo : $reNo },
	      				
	      				type : "post",
	      				
	      				success : function(result){
	      					
	      					if(result=="YY"){
	      						alert("리뷰내역 삭제가 완료되었습니다.")
	      						location.reload();
	      					}else{
	      						alert("리뷰내역 삭제에 실패하였습니다. 다시 시도해주세요");
	      						location.reload();
	      					}
	      				}
	      				
	      			}); // ajax 끝 
					
				}
				
	
			});
			
		}); //함수 끝 
	
		</script>	
</div>	
		
<%@ include file = "../common/footer.jsp" %>	
</body>
		
</html>