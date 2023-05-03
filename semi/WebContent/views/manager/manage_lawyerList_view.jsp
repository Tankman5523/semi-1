<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	ArrayList<Lawyer> lawList = (ArrayList<Lawyer>) request.getAttribute("lawList");
	ArrayList<PartCategory> pList = (ArrayList<PartCategory>) request.getAttribute("pList");
%>
<%@ include file="manager_header.jsp"%>
<style>
/* 폰트, 색상 */
@font-face {
	font-family: 'Pretendard-Regular';
	src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')format('woff');
	font-weight: 400;
	font-style: normal;
}
/* 영역잡기 */
#content * {
	color: white;
	font-family: 'Pretendard-Regular';
	font-size: 18px;
	margin: auto;
}
#content>div {
	width: 100%;
}
#space {
	height: 10%;
}
#title {
	height: 5%;
}
#search-area {
	height: 10%;
}
#list-area {
	height: 75%;
	border-collapse: collapse;
}
#list-area>div {
	height: 100%;
}
#lawList {
	width: 80%;
	overflow-y: auto;
	margin: auto;
}
/* 대표 문구 */
#title>p {
	text-align: center;
	font-size: 30px;
	font-weight: 900;
	line-height: 30px;
}
/* 검색창 */
#search_form {
	width: 90%;
	height: 100%;
	margin-left: 150px;
}
#search_form>div {
	height: 100%;
	float: left;
	margin: 0px 10px;
}
#search_form select, #search_form option, #search_form button, #searchName>input {
	color: black;
}
/* 변호사 나열 */
#lawList table {
	width: 100%;
	text-align: center;
}
#list-title {
	background-color: rgb(223, 220, 220);
}
#lawList th {
	color: black;
	height: 40px;
}
#lawList td {
	height: 40px;
}
a {
	text-decoration: none;
	color: black;
	display: block;
}
button{
	width: 50px;
	padding: 3px;
	margin: 0px;
	border: 2px solid gray;
}
button:hover{
	border: 2px solid rgb(255, 229, 173);
	transition: 0.3s;
	cursor: pointer;
}
#detail{
	background-color: rgb(23, 103, 252);
	color: white;
}
#onBtn{
	background-color: green;
	color: white;
}
#offBtn{
	background-color: red;
	color: white;
}
</style>

<div id="content">
	<div id="space"></div>
	<div id="title">
		<p>변호사 관리 페이지</p>
	</div>
	<div id="search-area">
		<form id="search_form" action="<%=contextPath%>/lawyerList.ma" method="post">
			<div>
				<fieldset>
					<legend>정렬</legend>
					<label><input type="radio" name="sort" value="solvedAccCount">해결영상 수&nbsp;&nbsp;</label>
					<label><input type="radio" name="sort" value="counselMatchCount">상담매칭수&nbsp;&nbsp;</label>
					<label><input type="radio" name="sort" value="reviewAverage">리뷰 평점순</label>
				</fieldset>
			</div>
			<br>
			<div id="searchName"> 변호사이름
				<input type="search" name="nameKey" placeholder="변호사 이름 입력">
			</div>
			<div> 분야별 
				<select name="cateKey" id="category">
					<option value="전체">전체</option>
					<%for (PartCategory p : pList) {%>
						<option value="<%=p.getPartNo()%>"><%=p.getPartName()%></option>
					<%}%>
				</select>
			</div>
			<div> 지역별
				<select name="localKey" id="local">
					<option value="전체">전체</option>
					<option value="서울">서울</option>
					<option value="경기">경기도</option>
					<option value="강원">강원도</option>
					<option value="충청">충청도</option>
					<option value="전라">전라도</option>
					<option value="경상">경상도</option>
					<option value="제주">제주도</option>
				</select>
			</div>
			<div>
				<button type="submit">검색</button>
			</div>
		</form>
	</div>
	<div id="list-area">
		<div id="lawList">
			<table>
				<thead id="list-title">
					<tr>
						<th width="50px">No.</th>
						<th width="50px">변호사 번호</th>
						<th width="50px">이름</th>
						<th width="50px">분야</th>
						<th width="50px">해결영상 개수</th>
						<th width="50px">상담매칭 개수</th>
						<th width="50px">리뷰 평점</th>
						<th width="50px">상세보기</th> 
						<th width="50px">변호사 권한</th> 
					</tr>
				</thead>
				<%if (!lawList.isEmpty()) {%> <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
					<tbody id="apply-list">
						<%for (int i = 0; i < lawList.size(); i++) {%>
							<tr>
								<td><%=i + 1%><input type="hidden" name="lno" value="<%=lawList.get(i).getLawNo()%>"></td>
								<td><%=lawList.get(i).getLawNo()%></td>
								<td><%=lawList.get(i).getRefUno()%></td>
								<td><%=lawList.get(i).getRefPno()%></td>
								<td><%=lawList.get(i).getSolvedAccCount()%></td>
								<td><%=lawList.get(i).getCounselMatchCount()%></td>
								<td><%=lawList.get(i).getReviewAverage()%></td>
								<td><button id="detail">상세</button></td>
								<%if (lawList.get(i).getLawyer().equals("Y")) {%>
									<td><button id="onBtn">ON</button></td>
								<%} else if (lawList.get(i).getLawyer().equals("N")) {%>
									<td><button id="offBtn">OFF</button></td>
								<%} else {%>
									<td>대기중</td>
								<%}%>
							</tr>
						<%}%>
				<%} else {%> <!-- 찜한 변호사 리스트가 비어있다면  -->
						<tr>
							<td></td>
							<td colspan="5">변호사 회원이 존재하지 않습니다.</td>
						</tr>
					</tbody>
				<% } %>
			</table>
		</div>
	</div>
</div>

<script>

	$("#apply-list ").on("click", "#detail", function(){ //변호사 상세페이지로 이동시키는 함수
		var lno = $(this).parent().siblings().find("input").val();
		location.href="<%=contextPath%>/detail.apply.me?lno="+lno;
	});

	$("#apply-list ").on("click", "button[id$='Btn']", function() { //변호사 권한 변경
		var $lno = $(this).parent().siblings().find("input").val();
		var $button = $(this).html(); //"ON"/"OFF"

		if(confirm("변호사 권한을 변경하시겠습니까?")) {
			$.ajax({
				url : "manageLawLawyer.ma",
				data : { lno : $lno, button : $button },
				type : "get",
				success : function(result) {
					if(result == "YY") {
						if($button == "ON") {
							$(this).html("OFF");
							$(this).css("color", "red");
						}else {
							$(this).html("ON");
							$(this).css("color", "green");
						}
						$("#apply-list button").load(location.reload());
					}else {
						alert("변호사 권한 변경을 실패했습니다.");
					}
				}
			});
		}
	});
</script>

<%@ include file="../common/footer.jsp"%>