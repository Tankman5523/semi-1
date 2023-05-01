<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.lawyer.model.vo.*,com.bbbox.board.model.vo.Accident"%>
<%
	LawReview re = (LawReview)request.getAttribute("re");
	Accident ac = (Accident)request.getAttribute("ac");
	Lawyer l = (Lawyer)request.getAttribute("l");
%>
<%@ include file = "../common/header.jsp" %>

	<style>
    /* 폰트, 색상 */
    @font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	#content *{
		font-family: 'Pretendard-Regular';
		font-size: 18px;
	}
	
	/* 영역잡기 */
    #content *{
   		color: white;
    }
	#enroll-area{
	   width: 50%;
	   height: 80%;
	   margin: auto;
	}
	#enroll-area>div{
	   width: 100%;
	   text-align: center;
	}
	#title{
	   height: 20%;
	   line-height: 150px;
	}
	#title>h2{
	   margin: 0;
	   font-size: 30px;
	   font-weight: 800;
	}
	#comment{
	   height: 10%;
	}
	#enroll{
	   height: 70%;
	}
	#enroll-form{
	   width: 80%;
	   height: 100%;
	   margin: auto;
	}
	#enroll-form>table{
	   height: 80%;
	}
	#button{
	   height: 20%;
	   line-height: 100px;
	}
	table,td,th{
	   border-collapse : collapse;
	   border: 2px solid rgb(200, 225, 255);
	}
	th{
		background-color: rgb(218, 235, 255);
	}
	td{
		background-color: white;
	}
	#enroll-form *{
		color: black;
	}
	#enroll-form .star{
		color : gold;
		font-size: 25px;
	}

	</style>
	
<div id="content">
   <div id="enroll-area">
       <div id="title"><h2>리뷰 상세보기</h2></div>
       <div id="comment"></div>
       <div id="enroll">
           <form  id="enroll-form" action="<%=contextPath%>/reviewDelete.la" method="post">
               <input type="hidden" name="reNo" value="<%=re.getReviewNo() %>">
               <table align="center">
                   <tr>
                       <th width="100px" height="50px">사건 제목</th>
                       <td width="400px"><%=ac.getTitle() %></td>
                   </tr>
                   <tr>
                       <th height="50px">변호사</th>
                       <td><%=l.getRefUno() %></td>
                   </tr>
                   <tr>
                       <th height="50px">별점</th>
                       <td>
                           <div class="star-box">
                           	<%for(int i=0; i<re.getStar().length(); i++){ %>
                           		<span class="star">★</span>
                           	<%} %>
                           </div>
                       </td>
                   </tr>
                   <tr>
                       <th>내용</th>
                       <td><%=re.getReviewContent() %></td>
                   </tr>
               </table>
               <div id="button">
               		<!-- 변호사 상세페이지에서 조회할 경우 본인이 작성한 리뷰면 삭제 가능 -->
               	   <%if(re.getUserNo() == loginUser.getUserNo()){ %>
	                   <button type="submit">삭제하기</button>
               	   <%} %>
                   <button type="button" onclick="history.back()">취소</button>
               </div>
           </form>
       </div>
   </div>
</div>

<%@ include file = "../common/footer.jsp" %>