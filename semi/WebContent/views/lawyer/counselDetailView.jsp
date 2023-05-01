<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	Counsel c = (Counsel)request.getAttribute("c");
	Lawyer l = (Lawyer)request.getAttribute("l");
%>
<%@ include file = "../common/header.jsp" %>
	<style>
    /* 영역잡기 */
    #content *{
	   	color: white;
	   	margin: auto;
   		text-align: center;
    }
	#enroll-area{
	   width: 60%;
	   height: 100%;
	   margin: auto;
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
	}
	#comment{
	   height: 5%; /* 일단 삭제된 상태 */
	}
	#enroll-form{
	   height: 80%;
	}
	#button{
	   line-height: 100px;
	}
	#enroll-form *{
	color: black;
	font-size: 18px;
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
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	#content *{
		font-family: 'Pretendard-Regular';
	}
	#info-td{
		position: relative;
	}
	#info{
		position: absolute;
		margin: auto;
		bottom: 10px;
		left: 0;
		right: 0;
	}
	
	</style>

	<div id="content">
       <div id="enroll-area">
            <div id="title"><h2>상담내용 확인</h2></div>
            <div id="comment"></div>
            <form  id="enroll-form" action="<%=contextPath%>/counselUpdate.la" method="get">
                <input type="hidden" name="cno" value="<%=c.getCsNo() %>">
                <input type="hidden" name="aResult" value="X">
                <table align="center">
                    <tr>
                        <th width="100px" height="40px">분야</th>
                        <td width="400px"><%=l.getRefPno() %></td>
                    </tr>
                    <tr>
                        <th height="40px">변호사</th>
                        <td><%=l.getRefUno() %></td>
                    </tr>
                    <tr>
                        <th height="40px">제목</th>
                        <td><%=c.getCsTitle() %></td>
                    </tr>
                    <tr>
                        <th height="200px">내용</th>
                        <td><%=c.getCsContent() %></td>
                    </tr>
                    <%if(c.getCsAnswer() != null){ %>
                     <tr>
                         <th height="230px">답변</th>
                         <td id="info-td">
                         	<div id="answer"><%=c.getCsAnswer() %></div>
                         	<%if(!(c.getAccept().equals("N"))){ %> <!-- 변호사의 거절일 경우 개인정보 x -->
                         	<div id="info"><br><br><br>사무실 번호 : <%=l.getCompanyPn() %><br>사무실 주소 : <%=l.getCompanyAddress() %></div>
                         	<%} %>
                         </td>
                     </tr>
                    <%} %>
                </table>
                <div id="button">
                	<%if(loginUser.getAdmin().equals("Y")){ %> <!-- 관리자라면 -->
                		<button type="button" onclick="history.back()">확인</button>
                	<%}else{ %>
                 	<%if(c.getCsAnswer() == null){ %> <!-- 아직 답변이 없는 경우 수정 가능 -->
                     	<button type="submit">수정하기</button>
                      <button type="button" onclick="history.back()">취소</button>
                     <%}else{ %>
                     	<%if(c.getAccept().equals("W")){ %> <!-- 회원의 수락/거절 답변 전-->
                      	<button type="submit" id="acceptBtn">매칭 수락하기</button>
                      	<!-- 수락버튼 클릭시 컴펌 후 accept y로 바꾸기 -->
                      	<button type="submit" id="declineBtn">상담 종료하기</button>
                      	<!-- 이대로 상담을 종료하시겟습니까 띄우고 완료 / accept n으로 바꾸기 -->
                      <%}else{ %> <!-- 매칭실패 or 상담완료일 경우 -->
                      	<button type="button" onclick="history.back()">확인</button>
                     	<%} %>
                     <%} %>
                	<%} %>
                </div>
             </form>
        </div>
    </div>
    
    <script>
    	//아직 기능 확인 안함
    	function counselDelete(){
    		if(confirm=("상담내역을 삭제하시겠습니까? 삭제하시면 내용을 복구할 수 없습니다.")){
    			location.href="<%=contextPath%>/counselDelete.la?cno=<%=c.getCsNo()%>";
    		}
    	};
    	
    	$(function(){
    		$("#acceptBtn").click(function(){
        		$("#enroll-form>input[name=aResult]").val("accept");
        	});
    		
    		$("#declineBtn").click(function(){
        		$("#enroll-form>input[name=aResult]").val("decline");
        	});
    	});
    </script>

<%@ include file = "../common/footer.jsp" %>