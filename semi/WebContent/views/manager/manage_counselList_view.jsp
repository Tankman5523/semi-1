<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	ArrayList<Counsel> cList = (ArrayList<Counsel>)request.getAttribute("cList");
%>
<%@ include file = "manager_header.jsp" %>
<style>
	/* 폰트, 색상 */
    @font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
    /* 영역잡기 */
    #content *{
    	color: white;
    	font-family: 'Pretendard-Regular';
    	font-size: 18px;
        margin: auto;
    }
	#content>div{
        width: 100%;
    }
    #space{
    	height: 10%;
    }
	#title{
        height: 10%;
    }
    #list-area{
        height: 80%;
        border-collapse: collapse;
    }
    #list-area>div{
        height: 100%;
    }
    #lawList{
        width: 90%;
        overflow-y: auto;
        margin: auto;
    }
    #lawList button{
    	color: black;
    }
    /* 대표 문구 */
    #title>p{
        text-align: center;
        font-size: 30px;
        font-weight: 900;
        line-height: 50px;
    }
    /* 변호사 나열 */
    #lawList table{
        width: 100%;
        text-align: center;
    }
    #list-title{
        background-color: rgb(223, 220, 220);
    }
    #lawList th{
    	color: black;
    	height: 40px;
    }
    #lawList td{
    	height: 40px;
    }
    a{
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
	#apply-list>tr:hover{
		background-color: rgb(138, 138, 138);
		cursor: pointer;
	}
</style>

<div id="content">
	<div id="space"></div>
	<div id="title">
		<p>상담 관리 페이지</p>
	</div>
	<div id="list-area">
		<div id="lawList">
			<table>
				<thead id="list-title">
					<tr>
						<th width="80px">No.</th>
						<th width="80px">상담번호</th>
						<th width="100px">변호사</th>
						<th width="100px">회원ID</th>
						<th width="200px">상담제목</th>
						<th width="150px">상담내용</th>
						<th width="150px">작성날짜</th>
						<th width="100px">변호사답변</th>
						<th width="150px">상태값</th>
						<th width="80px">삭제</th>
					</tr>
				</thead>
				<%if(!cList.isEmpty()){ %> <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
					<tbody id="apply-list">
						<%for(int i= 0 ; i < cList.size(); i++){%>
							<tr>
								<td><%=i+1%><input type="hidden" name="csNo" value="<%=cList.get(i).getCsNo()%>"></td>
								<td><%=cList.get(i).getCsNo()%></td>
								<td><%=cList.get(i).getRefLno()%></td>
								<td><%=cList.get(i).getCsWriter()%></td>
								<td><%=cList.get(i).getCsTitle()%></td>
								<td><%=cList.get(i).getCsContent()%></td>
								<td><%=cList.get(i).getCreateDate()%></td>
								<td><%=cList.get(i).getCsAnswer()%></td>
								<% if(cList.get(i).getAccept().equals("W")){%>
									<% if(cList.get(i).getCsAnswer().equals("미등록")){%>
										<td><b style="color: red">답변 대기중</b></td>
									<%}else{ %>
										<td><b style="color: blue">수락 대기중</b></td>
									<%} %>
								<%}else{ %>
									<td><b style="color: green">상담 종료</b></td>
								<%} %>
								<%if(cList.get(i).getStatus().equals("Y")){ %>
									<td width="40"><button id="deleteBtn">삭제</button></td>
								<%} %>
							</tr>
						<%} %>
				<%}else{ %> <!-- 찜한 변호사 리스트가 비어있다면  -->
						<tr>
							<td></td>
							<td colspan="5">상담 리스트가 존재하지 않습니다.</td>
						</tr>
					</tbody>
				<%} %>
			</table>
		</div>
	</div>
</div>

<script>
   	$("#apply-list tr").on("click", "td:not(:last-child)", function(e){ //상담신청 상세보기로 이동
   		var csNo = $(this).parent().find("input").val();
   		location.href="<%=contextPath%>/counselDetail.la?cno="+csNo;
   	});
   	
   	$("#apply-list ").on("click", "#deleteBtn", function(){ //상담내역 삭제
   		var csNo = $(this).parent().siblings().find("input").val();
   		if(confirm("해당 상담글을 삭제하시겠습니까?")){
   			$.ajax({
       			url: "counselDelete.la",
       			data: { cno : csNo },
       			type: "post",
       			success : function(result){
       				if(result == "YY"){
       					alert("상담글 삭제를 성공했습니다.");
       					$("#apply-list").load(location.reload());
       				}else{
       					alert("상담글 삭제를 실패했습니다.");
       				}
       			}
       		});
   		}
   	});
</script>

<%@ include file = "../common/footer.jsp" %>