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
	#title>h2{
	   margin: 0;
	   font-size: 30px;
	   font-weight: 800;
	   color: white;
	}
	#comment{
	   height: 5%;
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
		width: 30%;
		margin: auto;
		position: absolute;
		left: 0;
		right: 0;
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
	button{
		width: 90px;
		padding: 7px;
		margin: 0px 5px;
		border-radius: 7px;
		border: 2px solid gray;
	}
	button:hover{
		background-color: rgb(255, 243, 218);
		border: 2px solid rgb(255, 229, 173);
		transition: 0.3s;
		cursor: pointer;
	}
</style>

<div id="content">
	<div id="enroll-area">
		<div id="title">
			<h2>답변 작성</h2>
		</div>
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
					<td height="200px" width="400px" colspan="3" style="word-break:break-all"><%=c.getCsContent() %></td>
				</tr>
			<%if(c.getCsAnswer() != null){ %> <!-- 답변을 남긴 상태라면 확인만 -->
				<tr>
					<th height="200px">답변</th>
					<td height="200px" width="400px" colspan="3"><%=c.getCsAnswer() %></td>
				</tr>
			</table>
			<br>
			<div>
				<button onclick="history.back()">확&nbsp;&nbsp;&nbsp;인</button>
			</div>
			<%}else{ %> <!-- 아직 답변이 등록되어있지 않다면 -->
			</table>
			<br>
			<div id="button">
				<button type="button" id="acceptBtn">수락하기</button>
				<button type="button" id="declineBtn">거절하기</button>
				<button onclick="history.back()">뒤로가기</button>
			</div>
			<%} %>
		</div>
		<form id="answer-form" onsubmit="return confirm('답변을 저장하시면 더이상 수정이 불가능합니다. 답변 등록을 진행하시겠습니까?');" action="<%=contextPath%>/counselAnswer.la" method="post">
			<input type="hidden" name="result" value="">
			<input type="hidden" name="csNo" value="<%=c.getCsNo()%>">
			<table align="center">
				<tr>
					<th width="100px" height="200px">답변</th>
					<td width="400px" height="200px">
						<textarea id="answer" name="answer" placeholder="사건에 대한 간단한 답변을 남겨주세요." required></textarea>
					</td>
				</tr>
			</table>
			<br>
			<div id="button_2">
				<button type="submit">답변등록</button> <!-- 답변 작성 시 수정불가능 알림 넣기 -->
				<button type="button" onclick="back();">취&nbsp;&nbsp;&nbsp;소</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(function() {
		$("#acceptBtn").click(function() {
			$("#answer-form").css("display", "block");
			$("#button").css("display", "none");
			$("#answer-form>input[name=result]").val("accept");
		});

		$("#declineBtn").click(function() {
			$("#answer-form").css("display", "block");
			var info = "상담내용 확인해 보았으나, 현재 업무 스케줄상 담당하기 어려운 사건으로 보입니다. 사건이 원만히 해결되길 바랍니다. ";
			$("#answer").html(info);
			$("#button").css("display", "none");
			$("#answer-form>input[name=result]").val("decline");
		});
	});
	
	function back(){
		if(confirm("취소하시면 작성된 내용이 사라집니다. 취소하시겠습니까?")){
			history.back();
		};
	};
</script>

<%@ include file = "../common/footer.jsp" %>