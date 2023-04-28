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
%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My page</title>

<style>
    .content{
        width: 800px;
        box-sizing: border-box;
        margin : auto;
        margin-top: 20px;
    }
    #info, table{
        width: 100%;
    }
    #List{
        background-color: rgb(223, 220, 220);
    }
    a{
        text-decoration: none;
        color: black;
        display: block;
    }
    
    #counsel-list a{
    	width : 50%;
    	float : left;
    }
    
    #review-btn{
    	margin-left: 10px;
    }
    a:hover +{
        cursor: pointer;
        
    }
</style>
</head>
<body>
<%@ include file = "../common/header.jsp" %>

<div class="content">
    <h2 align="center">마이페이지</h2>
    <h4>기본정보</h4>
    <hr>
    <!-- 기본정보 뷰 -->
        <table id="info">
            <tr>
                <td width="150">아이디 </td>
                <td width="200"><%=loginUser.getUserId()%></td>
                <td></td>
            </tr>
            <tr>
                <td>이름 </td>
                <td><%=loginUser.getUserName()%></td>
                <td></td>
            </tr>
            <tr>
                <td>email </td>
                <td><%=loginUser.getEmail()%></td>
                <td></td>
            </tr>
            <tr>
                <td>회원타입 </td>
            <%if(!loginUser.getLawyer().equals("Y")){ %>
	            <td>일반회원</td>
               	<td><button id="applyLawyer" onclick = "return apply();">변호사회원 신청하기</button></td>
             <%}else{%>
	         	<td>변호사회원</td>   
	         <%} %>	
            </tr>
        </table>
        <br>
    <!-- 버튼 -->

	    <div id="btn" align="center">
	        <button onclick = "home();">메인으로</button>
	        <button id="modify">수정하기</button>
	        <button onclick = "memberDelete();"> 회원탈퇴 </button>
	    </div>
    
    <script>
		/* 변호사회원 신청페이지로 이동 */
		function apply(){
			/* 클릭시 이미 신청한 회원이라면, 알림 띄워주기 */
			$.ajax({
			 	url : "chkapply.me",
			 	
			 	data : { userNo : <%=loginUser.getUserNo()%>},
			 	
			 	type : "post",
			 	
			 	success : function(result){
			 			console.log(result);
			 			
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
			
		}//함수 끝 
	    
		/* 메인페이지 버튼 클릭 함수 script */
		function home(){
			
			location.href="<%=contextPath%>";
		}
		
		
		/* 회원정보 수정페이지로 이동 script */
		$("#modify").on('click',function(){
			
			if(<%=loginUser.getLawyer().equals("Y")%>){
				/* 변호사 회원 정보 수정 */
				location.href="<%=contextPath%>/update_info.la";
			}else{
				/*일반회원 정보 수정 */
				location.href="<%=contextPath%>/update_info.me";
				
			}
			
		});		
		
		
	    /* 회원 탈퇴 스크립트 영역  */
		function memberDelete(){
			
			if(confirm("회원 탈퇴시 해당 아이디 복구 및 재가입이 불가능 합니다. 탈퇴 하시겠습니까?")){
			
			}
			
		}
	    
	</script>
	
    <%if(loginUser.getLawyer().equals("N")){ %>
    <hr>
    <!-- 찜한리스트 뷰 (일반회원일 경우)-->
    <h3>내가 찜한 변호사</h3>
    <hr>
        <table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="300">변호사</td>
                    <td width="100"></td>
                </tr>
            </thead>
            <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
            <% if (!lawList.isEmpty()){ %>
            <tbody id="dibs-lawyer">
	            <% for(int i =0; i<lawList.size() ;i++){ %>
	            <tr>
	                <td><%= i+1 %></td>
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
    	<hr>
    	
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
        <%} %>
    <% if(loginUser.getLawyer().equals("Y")){ %>
    <!-- 변호사 회원으로 로그인 했을 때 -->
    <h3>해결 사건 관리</h3>
    <hr>
    	<table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="230">게시글 내용 </td>
                </tr>
            </thead>
            <% if(!accRev.isEmpty()){ %>
            <!-- 해결사건 리스트가 비어있지 않다면  -->
            	<%for(int i = 0 ; i < accRev.size() ; i++){ %>
		            <tr>
		                <td><%= i+1 %></td>
		                <td><a href=""><%= accRev.get(i).getContent() %></a></td>
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
        <h3>내 사건 관리</h3>
    	<!-- 내가 맡은 사건(해결X)-->
    	<hr>
    	<% if(!accident.isEmpty()){ %>
    	<table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="230">게시글 제목 </td>
                    <td width="70">분야</td>
                    <td width="50">해결여부</td>
                    <td width="50">리뷰작성</td>
                </tr>
            </thead>
            <!-- 사건 리스트가 비어있지 않다면  -->
            	<% for (int i = 0 ; i < accident.size() ; i++){ %>
		            <tr>
		                <td><%=i+1%></td>
		                <td><a href=""><%=accident.get(i).getTitle()%></a></td>
		               	<td><%=accident.get(i).getPartName()%></td>
		                <td><%=accident.get(i).getSolve()%></td>
		                <td><button type="button">리뷰 작성</button></td>
		            </tr>
            	<%} %>
			<!-- 사건 리스트가 비어있다면  -->	
    	<%}else{%>
				<tr>
	       			<td></td>
	       			<td colspan="4"> 조회된 게시글이 없습니다. </td>
	       		</tr>
    	<%} %>
        </table>
        <h3>내 상담 내역</h3>
	    <hr>
	        <table>
	            <thead id="List">
	                <tr>
	                    <td width="50">No.</td>
	                    <td width="260">상담 제목</td>
	                    <td width ="70">상태</td>
	                    <td width="70">상담 일자</td>
	                </tr>
	            </thead>
	            <% if(!cListLaw.isEmpty()){ %>
	            <tbody id="counsel-list-law">
	            	<% for(int i = 0 ; i < cListLaw.size() ; i++){ %>
		            <tr>
		                <td><%= i+1 %></td>
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
	<%}else{ %>
	<!-- 일반 회원 로그인시 보이는 마이페이지 영역  -->
    <h3>내 게시글 관리 </h3>
    <hr>
    	<table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="230">게시글 제목 </td>
                    <td width="70">작성 게시판</td>
                    <td width="100">작성 날짜</td>
                    <td width="50">삭제</td>
                </tr>
            </thead>
            <!-- 게시글 리스트가 비어있지 않다면  -->
            <% if(!boardList.isEmpty()){%>
			<tbody id="board-list">
		      	<%for(int i=0; i<boardList.size(); i++){ %>
				 <tr>
	                <td><%=i+1 %></td>
	                <td><a href="<%=contextPath%>/detail.bo?bno=<%=boardList.get(i).getBoardNo()%>"><%=boardList.get(i).getTitle()%></a></td>
	                <%if(boardList.get(i).getCategoryName().equals("해결")){ %>
	               	 	<td><%=boardList.get(i).getCategoryName()%> <button id="review-btn">리뷰작성</button></td>
	                <%}else{ %>
	                <td><%=boardList.get(i).getCategoryName()%></td>
	                <%} %>
	                <td><%= boardList.get(i).getCreateDate()%></td>
	                <td><button id=board-delete>삭제</button> <input type="hidden" id=bno value="<%=boardList.get(i).getBoardNo()%>"></td>
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
        
        <script>
        /* 내 게시글 삭제 script*/
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
        				
        			}); // ajax 끝 
        		}
        		
        	})	
        
        });
        
        </script>
        
    <h3>1:1 문의 </h3>
    <hr>
    	<table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="230">게시글 제목 </td>
                    <td width="70">작성 게시판</td>
                    <td width="100">작성 날짜</td>
                    <td width="50">삭제</td>
                </tr>
            </thead>
            <!-- 1대1 문의 게시글이 비어있지 않다면  -->
            <% if(!qList.isEmpty()){%>
			<tbody id="question-list">
		      	<%for(int i=0; i<qList.size(); i++){ %>
				 <tr>
	                <td><%=i+1 %></td>
	                <td><a href="<%=contextPath%>/detail.qa?qno=<%=qList.get(i).getqNo()%>"><%=qList.get(i).getTitle()%></a></td>
	                <td><%=qList.get(i).getCategoryName()%></td>
	                <td><%=qList.get(i).getDate()%></td>
	                <td><button id=board-delete>삭제</button> <input type="hidden" id=bno value="<%=qList.get(i).getqNo()%>"></td>
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
                    <td width="50">No.</td>
                    <td width="230">댓글 내용</td>
                    <td width="70">작성 게시판</td>
                    <td width="100">작성 날짜</td>
                    <td width = "50">삭제</td>
                </tr>
            </thead>
             <!-- 댓글 리스트가 비어있지 않다면  -->
            <% if(!replyList.isEmpty()){%> 
			<tbody id="reply-list">
				<%for(int i = 0 ; i<replyList.size() ; i++){%>
	            <tr>
	                <td><%=i+1 %><input type = "hidden" value = "<%=replyList.get(i).getRefBno()%>"></td>
	                <td><%=replyList.get(i).getContent()%><input type = "hidden" value ="<%=replyList.get(i).getStatus()%>"></td>
					<td><%= replyList.get(i).getCategoryName()%></td>               
	                <td><%= replyList.get(i).getDate()%></td>
	                <td><button>삭제</button> <input type="hidden" value="<%=replyList.get(i).getRpNo()%>"></td>
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
        /*삭제된 게시글에 달렸던 댓글 조회시 이벤트 함수 영역*/
        $(function(){
        	$('#reply-list tr').on('click', 'td', function(){
        		
        		var $boardStatus = $(this).children().val(); // 참조 게시글의 상태값 
        		
        		var $bno = $(this).prev().children().val(); // 참조 게시글의 번호
        		
        		if($boardStatus == 'N'){
        			alert("이미 삭제된 게시글로 댓글을 조회할 수 없습니다.")
        		}else{
        			location.href="<%=contextPath%>/detail.bo?bno="+$bno;
        		}
        	})
        }); //함수 끝 
        
        
        /*댓글 삭제 script */
         $(function(){
        	 
        	 $("#reply-list tr td").on('click','button', function(){
        		 
        		 if(confirm("삭제한 댓글 은 복구가 불가능 합니다. 정말 삭제하시겠습니까?")){
         			var $rpno = $(this).next().val();
         			
         			$.ajax({
         				
         				url : "delRp",
         				
         				data : { rpNo : $rpno },
         				
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
        
	    <!-- 상담리스트 뷰 -->
	    <h3>내 상담 내역</h3>
	    <hr>
	        <table>
	            <thead id="List">
	                <tr>
	                    <td width="50">No.</td>
	                    <td width="200">상담 제목</td>
	                    <td width ="40">상태</td>
	                    <td width="70">상담 일자</td>
	                    <td width="50">삭제</td>
	                </tr>
	            </thead>
	            <% if(!cList.isEmpty()){ %>
	            <tbody id="counsel-list">
	            	<% for(int i = 0 ; i < cList.size() ; i++){ %>
		            <tr>
		                <td><a href=""><%= i+1 %></a></td>
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
		                <td><button>삭제</button> <input type="hidden" value = "<%=cList.get(i).getCsNo()%>"></td>
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
	    <!-- 리뷰 내역 -->
	    <h3>리뷰</h3>
	   		 <hr>
	         <table>
	            <thead id="List">
	                <tr>
	                    <td width="50">No.</td>
	                    <td width="300">내용</td>
	                    <td width="100">별점</td>
	                    <td width="50">삭제</td>
	                    
	                </tr>
	            </thead>
	    <% if(loginUser.getLawyer().equals("Y")){ %>
			<!-- 변호사 회원의 사건 리뷰 위치  -->
			<tbody>
				<tr>
					<td></td> <!-- 누를시에 어디로 이동할지 정하기  -->
			        <td><a href=""></a></td>
			   		<td><a href=""></a></td>
			   		<td><button>삭제하기</button></td>
					
				</tr>	    
			</tbody>
	    <%}else{ %>
	    <!-- 일반 회원 리뷰 영역  -->
				<% if(!lawRev.isEmpty()){%>
					<tbody id=user-review>
					<%for(int i = 0 ; i < lawRev.size() ; i++){ %>
		            <tr>
		                <td><%= i+1 %></td> <!-- 누를시에 어디로 이동할지 정하기  -->
		                <td><a href=""><%= lawRev.get(i).getReviewContent()%></a></td>
		                <td><a href=""><%= lawRev.get(i).getStar()%></a></td>
		                <td><button>삭제</button> <input type=hidden value = "<%=lawRev.get(i).getReviewNo()%>"></td>
		            </tr>
		            <%} %>
					</tbody>
	            <%}else{ %>
	            <tr>
	            	<td></td>
	            	<td colspan="3">조회된 리뷰 내역이 없습니다. </td>
	            </tr>
	            <%} %>
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
		
	});//함수 끝 

	</script>			
	
</body>
</html>