<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.lawyer.model.vo.*,com.bbbox.board.model.vo.Accident"%>
<%
	LawReview re = (LawReview)request.getAttribute("re");
	Accident ac = (Accident)request.getAttribute("ac");
	Lawyer l = (Lawyer)request.getAttribute("l");
%>
<%@ include file = "../common/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 영역잡기 */
.wrap div{
   border: 0px;
   box-sizing: border-box;
}
.wrap{
   border: 1px solid black;
   width: 1200px;
   height: 600px;
   margin: auto;
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
   line-height: 100px;
}
h2{
   margin: 0;
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
#enroll-form input{
   width: 80%;
   height: 70%;
}
#button{
   height: 20%;
   line-height: 100px;
}
table,td,th{
   border-collapse : collapse;
   border: 2px solid rgb(206, 255, 201);
}
.star{
    cursor: pointer;
}
textarea{
	border: 0;
}
</style>
</head>
<body>
<div class="wrap">
   <div id="enroll-area">
       <div id="title"><h2>리뷰 작성</h2></div>
       <div id="comment">나의 사건을 해결해준 변호사님께 간단한 리뷰를 남겨주세요.</div>
       <div id="enroll">
           <form  id="enroll-form" action="<%=contextPath%>/reviewDelete.la" method="post">
               <input type="hidden" name="reNo" value="<%=re.getReviewNo() %>">
               <table align="center">
                   <tr>
                       <th width="100px">사건 제목</th>
                       <td width="400px"><%=ac.getTitle() %></td>
                   </tr>
                   <tr>
                       <th>변호사</th>
                       <td><%=l.getRefUno() %></td>
                   </tr>
                   <tr>
                       <th>별점</th> <!-- 문자열 길이만큼 for문 돌려서 별점처럼 작성하기  -->
                       <td>
                           <div class="star-box">
                               <span class="star">☆</span>
                               <span class="star">☆</span>
                               <span class="star">☆</span>
                               <span class="star">☆</span>
                               <span class="star">☆</span>
                           </div>
                       </td>
                   </tr>
                   <tr>
                       <th>내용</th>
                       <td>
                           <textarea cols="40" rows="4" maxlength="80" style="resize:none" readonly><%=re.getReviewContent() %></textarea>
                       </td>
                   </tr>
               </table>
               <div id="button">
               		<!-- 만약 변호사 상세페이지에서 클릭해서 조회하는 상황 고려하여  userNo랑 loginUser 같을때로 조건걸기 / 조건 문법 맞는지 확인하기-->
               	   <%if(re.getUserNo() == loginUser.getUserNo()){ %>
	                   <button type="submit">삭제하기</button>
               	   <%} %>
                   <button type="button" onclick="history.back()">취소</button>
               </div>
           </form>
       </div>
   </div>
</div>
</body>
</html>