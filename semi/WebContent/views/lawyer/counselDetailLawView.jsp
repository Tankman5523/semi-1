<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	Counsel c = (Counsel)request.getAttribute("c");
	Lawyer l = (Lawyer)request.getAttribute("l");
%>
<%@ include file = "../common/header.jsp" %>
	<style>
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	#content *{
		font-family: 'Pretendard-Regular';
		font-size: 20px;
	}
    /* 영역잡기 */
   	#enroll-area{
   		width: 60%;
   		height: 100%;
   		margin: auto;
   		position: relative;
   	}
   	#enroll-area>div{
	   width: 100%;
	   text-align: center;
	}
	#title{
	   height: 15%;
	   line-height: 150px;
	}
	h2{
	   margin: 0;
	   font-size: 30px;
	   font-weight: 800;
	   color: white;
	}
	#comment{
	   height: 10%;
	   color: white;
	}
	#enroll-form input, #enroll-form textarea{ /* 수정 필요할수도 */
	   width: 90%;
	   height: 90%;
	   border: none;
	}
	#enroll-form>table, #answer-form>table{
		margin: auto;
	}
	#answer-form{
		position: relative;
	}
	#button_2{
		width: 15%;
		height: 15%;
		margin: auto;
		position: absolute;
		right: 0;
		left: 0;
	}
	#button_2>button{
		width: 100%;
		height: 100%;
	}
	#button{
	   height: 20%;
   	   line-height: 50px;
	}
	table,td,th{
	   border-collapse : collapse;
	   border: 2px solid rgb(255, 229, 173);
	}
	th{
		background-color: rgb(255, 243, 218);
	}
	td{
		background-color: white;
	}
	#answer-form{
		display: none;
	}
	#answer-form textarea{
		width: 100%;
		height: 90%;
		resize: none;
		border: none;
		outline: none;
	}
	</style>

	<div id="content">
         <div id="enroll-area">
            <div id="title"><h2>답변 작성</h2></div>
            <div id="comment">상담에 대한 답변을 반드시 작성해주세요.</div>
            <div id="enroll-form">
                    <input type="hidden" name="cno" value="<%=c.getCsNo() %>">
                    <table align="center">
                        <tr>
                            <th width="100px" height="40px">제목</th>
                            <td width="400px" colspan="3"><%=c.getCsTitle() %></td>
                        </tr>
                        <tr>
                            <th height="40px">회원 아이디</th>
                            <td><%=c.getCsWriter()%></td>
                            <th>분야</th>
                            <td><%=l.getRefPno()%></td>
                        </tr>
                        <tr>
                            <th height="200px">내용</th> <!-- 클릭 시 창 눌리는거 없애기 -->
                            <td colspan="3"><%=c.getCsContent() %></td>
                        </tr>
                    <%if(c.getCsAnswer() != null){ %> <!-- 답변을 남긴 상태라면 확인만 -->
		                       <tr>
		                           <th height="200px">답변</th>
		                           <td colspan="3"><%=c.getCsAnswer() %></td>
		                       </tr>
		                   </table>
		                   <br>
		                   <div>
		                       <button onclick="history.back()">뒤로가기</button> <!-- 수정하기 잘못된 알림 뜸 -->
		                   </div>
                   <%}else{ %> <!-- 아직 답변이 등록되어있지 않다면 -->
                   	  </table>
                   	  <br>
	                  <div id="button">
	                      <button type="button" id="acceptBtn">수락메세지 작성</button>
	                      <button type="button" id="declineBtn">거절메세지 작성</button>
	                      <button onclick="history.back()">뒤로가기</button>
	                  </div>
	              <%} %>
             </div> <!-- enroll-form 끝 -->
             <form id="answer-form"  onsubmit="return answer();" action="<%=contextPath%>/counselAnswer.la" method="post">
             <input type="hidden" name="result" value="">
             <input type="hidden" name="csNo" value="<%=c.getCsNo()%>">
                 <table align="center">
                     <tr>
                         <th width="100px" height="200px">답변</th>
                         <td width="400px" height="200px"><textarea id="answer" name="answer" placeholder="사건에 대한 간단한 답변을 남겨주세요." required></textarea></td>
                     </tr>
                 </table>
                 <br>
                 <div id="button_2">
                     <button type="submit">답변 저장</button> <!-- 답변 작성 시 수정불가능 알림 넣기 -->
                 </div>
            </form>
        </div> <!-- enroll 끝 -->
    </div><!-- 컨텐트 끝 -->
    
    <script>
    
    	$(function(){
    		$("#acceptBtn").click(function(){
        		$("#answer-form").css("display","block");
        		$("#button").css("display","none");
        		$("#answer-form>input[name=result]").val("accept");
        	});
    		
    		$("#declineBtn").click(function(){
        		$("#answer-form").css("display","block");
        		var info = "상담내용 확인해보았으나, 현재 업무 스케쥴상 담당하기 어려운 사건으로 보입니다. 블라블라";
        		$("#answer").html(info);
        		$("#button").css("display","none");
        		$("#answer-form>input[name=result]").val("decline");
        	});
    	});
    	
    	function answer(){ /* 마이페이지 넘어갈 때 다시 확인해보기 */
    		if(confirm("답변을 저장하시면 더이상 수정이 불가능합니다. 답변 등록을 진행하시겠습니까?")){
    			return true;
    		}else{
    			return false;
    		}
    	};
    	
    
    </script>

<%@ include file = "../common/footer.jsp" %>