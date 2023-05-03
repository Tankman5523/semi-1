<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.lawyer.model.vo.Lawyer,com.bbbox.board.model.vo.Accident"%>
<%
	Accident ac = (Accident)request.getAttribute("ac");
	System.out.println(ac);
	
	Lawyer l = (Lawyer)request.getAttribute("l");
	System.out.println("jsp " +l);
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
	#enroll-form textarea{
	   border: none;
	   outline: none;
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
		cursor: pointer;
		color : gold;
		font-size: 25px;
	}
	button{
		width: 90px;
		padding: 7px;
		margin: 40px 5px;
		border-radius: 7px;
		border: 2px solid gray;
	}
	button:hover{
		background-color: rgb(218, 235, 255);
		border: 2px solid rgb(126, 171, 223);
		transition: 0.3s;
		cursor: pointer;
	}
</style>

<div id="content">
	<div id="enroll-area">
		<div id="title">
			<h2>리뷰 작성</h2>
		</div>
		<div id="comment">나의 사건을 해결해준 변호사님께 간단한 리뷰를 남겨주세요.</div>
		<div id="enroll">
			<form id="enroll-form" action="<%=contextPath%>/review.la" method="post">
				<input type="hidden" name="accNo" value="<%=ac.getAccNo()%>">
				<input type="hidden" name="star" value=""> <!-- 별점 히든으로 보내기 -->
				<table align="center">
					<tr>
						<th width="100px" height="50px">사건 제목</th>
						<td width="400px"><%=ac.getTitle()%></td>
					</tr>
					<tr>
						<th height="50px">변호사</th>
						<td><%=l.getRefUno()%></td>
					</tr>
					<tr>
						<th height="50px">별점</th>
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
							<textarea name="content" cols="40" rows="4" maxlength="80" style="resize: none" required></textarea><br>
							<p style="color: rgb(1, 63, 134);"><span id="count">0</span>/80자 </p>
						</td>
					</tr>
				</table>
				<div id="button">
					<button type="submit" disabled>작성하기</button>
					<button type="button" onclick="back();">취&nbsp;&nbsp;&nbsp;소</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	$(".star").on("click", function() { //별점 입력
		var index = $(this).index();
		var str = "";
		
		for(var i = 0; i <= index; i++) {
			$(".star").eq(i).html("★");
			str += "★";
		};
		for(var i = index + 1; i <= 5; i++) {
			$(".star").eq(i).html("☆");
		};
		
		$("#enroll-form>input[name=star]").val(str);
		$("#enroll-form button[type=submit]").attr("disabled",false);
	});

	$("#enroll-form textarea").keyup(function() { //리뷰 글자수 제한
		var content = $(this).val();
		var count = content.length;
		
		$("#count").html(count);
		
		if(count > 80) {
			alert("최대 80자까지 입력가능합니다.");
			$(this).val(content.substring(0, 80));
			$("#count").html(80);
		}
	});
	
	function back(){
		if(confirm("취소하시면 작성된 내용이 사라집니다. 취소하시겠습니까?")){
			history.back()
		}
	};
</script>

<%@ include file = "../common/footer.jsp" %>