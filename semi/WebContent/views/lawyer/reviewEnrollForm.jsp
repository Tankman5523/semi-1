<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.lawyer.model.vo.Lawyer,com.bbbox.board.model.vo.Accident"%>
<%
	Accident ac = (Accident)request.getAttribute("ac");
	Lawyer l = (Lawyer)request.getAttribute("l");
%>
<%@ include file = "../common/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰작성</title>
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
		color : gold;
		font-size: 20px;
	}
	</style>
</head>
<body>
	<div class="wrap">
	   <div id="enroll-area">
	       <div id="title"><h2>리뷰 작성</h2></div>
	       <div id="comment">나의 사건을 해결해준 변호사님께 간단한 리뷰를 남겨주세요.</div>
	       <div id="enroll">
	           <form  id="enroll-form" action="<%=contextPath%>/review.la" method="post">
	               <input type="hidden" name="accNO" value="<%=ac.getAccNo() %>">
	               <input type="hidden" name="star" value=""><!-- 별점 히든으로 보내기 -->
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
	                       <th>별점</th>
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
	                       	<textarea name="content" cols="40" rows="4" maxlength="80" style="resize:none" required></textarea>
	                       	<br><p style="font-size:13px; color:red;"><span id="count">0</span>/80자</p>
	                       </td>
	                   </tr>
	               </table>
	               <div id="button">
	                   <button type="submit">작성하기</button>
	                   <button onclick="history.back()">취소</button>
	               </div>
	           </form>
	       </div>
	   </div>
	</div>
	
	<script>
		//별점 입력
		$(".star").on("click",function(){
			var index = $(this).index();
			var str = "";
			for(var i=0; i<=index; i++){
				$(".star").eq(i).html("★");
				str += "★";
			};
			for(var i=index+1; i<=5; i++){
				$(".star").eq(i).html("☆");
			};
			$("#enroll-form>input[name=star]").val(str);
		});
	
		//리뷰 글자수 제한
		$("#enroll-form textarea").keyup(function(){
			var content = $(this).val();
			var count = content.length;
			$("#count").html(count);
			if(count>80){
				alert("최대 80자까지 입력가능합니다.");
				$(this).val(content.substring(0,80));
				$("#count").html(80);
			}
		});
	</script>
	
</body>
</html>