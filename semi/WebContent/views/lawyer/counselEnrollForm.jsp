<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	ArrayList<Lawyer> lawList = (ArrayList<Lawyer>)request.getAttribute("lawList");
	ArrayList<PartCategory> pList = (ArrayList<PartCategory>)request.getAttribute("pList");
%>
<%@ include file = "../common/header.jsp" %>
<style>
    /* 영역잡기 */
    #content *{
    	color: white;
    	margin: auto;
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
	   height: 10%;
	}
	#enroll{
	   height: 75%;
	}
	#enroll-form{
	   width: 100%;
	   height: 100%;
	}
	#enroll-form>table{
	   height: 80%;
	}
	#enroll-form input, #enroll-form textarea{
	   width: 90%;
	   height: 90%;
	   border: none;
		outline: none;
	}
	#button{
	   height: 20%;
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
	#enroll-form input{
		width: 80%;
		height: 100%;
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
	#lawName{
		width: 80%;
		text-align: center;
	}
	button{
		width: 90px;
		padding: 7px;
		margin: 40px 5px;
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
			<h2>상담신청</h2>
		</div>
		<div id="comment">온라인 상담 신청을 해주시면 전문가가 신속히 답변 드리겠습니다.</div>
		<div id="enroll">
			<form id="enroll-form" action="<%=contextPath%>/counselEnroll.la" method="post">
				<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
				<table align="center">
					<tr>
						<th width="100px" height="40px">분야</th>
						<td width="400px">
							<select name="partKey" id="part" onchange="partChange();">
								<option value="전체">전체</option>
								<%for (PartCategory p : pList) {%>
									<option value="<%=p.getPartName()%>"><%=p.getPartName()%></option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<th height="40px">변호사</th>
						<td>
							<select name="lawNameKey" id="lawName" onchange="lawChange();" required>
								<%for (Lawyer l : lawList) {%>
									<option value="<%=l.getLawNo()%>"><%=l.getRefUno()%> 변호사</option>
								<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<th height="40px">제목</th>
						<td><input type="text" name="title" required></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="content" cols="45" rows="15" style="resize: none;"
							placeholder="해결을 원하는 사건에 대해 간단한 상담을 남겨주시면 담당 변호사가 확인 후 상담 가능여부에 대한 답변을 남겨드립니다."
							required></textarea>
						</td>
					</tr>
				</table>
				<div id="button">
					<button type="submit">신청하기</button>
					<button type="button" onclick="back();">취&nbsp;&nbsp;&nbsp;소</button>
				</div>
			</form>
		</div>
	</div>

	<script>
		$(function(){ //해당 변호사의 분야/이름 이 선택되어 있도록 하는 함수
			var $part = "<%=((Lawyer) request.getAttribute("l")).getRefPno()%>";
			var $lno = <%=((Lawyer) request.getAttribute("l")).getLawNo()%>;
			$("#part").val($part).prop("selected", true);
			$("#lawName").val($lno).prop("selected", true);
		});
		
		function partChange() { //분야 옵션을 바꿨을 경우
			$.ajax({
				url: "counselOption.la",
				data: { partKey : $("#part").val() },
				type: "get",
				success: function(list) {
					var str = "";
					if(list.length == 0) { //해당 분야의 변호사가 없으면
						str = "<option disabled>해당 분야의 변호사가 존재하지 않습니다.</option>"
					}else { //있으면 해당 분야의 변호사만 옵션에 넣기
						for(var i = 0; i < list.length; i++) {
							str += "<option value=\""+list[i].lawNo+"\">" + list[i].refUno + " 변호사</option>"
						}
					}
					$("#lawName").html(str);
				}
			});
		};

		//변호사 옵션을 바꿨을 경우 해당분야 selected 되도록
		function lawChange() {
			$.ajax({
				url: "counselOption.la",
				data: { lawNameKey : $("#lawName").val() },
				type : "post",
				success : function(result) {
					$("#part").val(result.partName).prop("selected", true);
				}
			});
		};
		
		//취소 버튼 클릭 시
		function back(){
			if(confirm("취소하면 작성된 내용이 삭제됩니다. 진행하시겠습니까?")){
				history.back();
			}
		};
		
	</script>
</div>

<%@ include file = "../common/footer.jsp" %>