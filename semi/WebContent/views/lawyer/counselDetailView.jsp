<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	Counsel c = (Counsel)request.getAttribute("c");
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
   /* border: 1px solid black; */
   border: 0px;
   width: 1200px;
   height: 600px;
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
   line-height: 100px;
}
h2{
   margin: 0;
}
#comment{
   height: 10%; /* 일단 삭제된 상태 */
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
   border: 2px solid rgb(248, 222, 214);
}
input, textarea{
   border: none;	
}

</style>
</head>
<body>
    <div class="wrap">
        <div id="enroll-area">
            <div id="title"><h2>상담내용 확인</h2></div>
            <div id="enroll">
                <form  id="enroll-form" action="<%=contextPath%>/counselUpdate.la" method="get">
                    <input type="hidden" name="cno" value="<%=c.getCsNo() %>">
                    <input type="hidden" name="aResult" value="X">
                    <table align="center">
                        <tr>
                            <th width="100px">분야</th>
                            <td width="400px"><%=l.getRefPno() %></td>
                        </tr>
                        <tr>
                            <th>변호사</th>
                            <td><%=l.getRefUno() %></td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" value="<%=c.getCsTitle() %>" readonly></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td><textarea cols="50" rows="15" style="resize:none" readonly><%=c.getCsContent() %></textarea></td>
                        </tr>
                        <%if(c.getCsAnswer() != null){ %> <!-- ACCETP가 'Y'가 되는기준이 변호사 답변인지/회원의 수락인지 확인 후 조건 수정하기 -->
	                        <tr>
	                            <th>답변</th>
	                            <td><textarea cols="50" rows="15" style="resize:none" readonly><%=c.getCsAnswer() %></textarea></td>
	                        </tr>
                        <%} %>
                    </table>
                    <div id="button">
                    	<%if(c.getCsAnswer() == null){ %> <!-- 아직 답변이 없는 경우 수정 가능 -->
                        	<button type="submit">수정하기</button>
	                        <button type="button" onclick="history.back()">취소</button>
                        <%}else{ %>
                        	<%if(c.getAccept().equals("W")){ %> <!-- 회원의 수락대기중인 상태 -->
	                        	<button type="submit" id="acceptBtn">매칭 수락하기</button>
	                        	<!-- 수락버튼 클릭시 컴펌 후 accept y로 바꾸기 -->
	                        	<button type="submit" id="declineBtn">상담 종료하기</button>
	                        	<!-- 이대로 상담을 종료하시겟습니까 띄우고 완료 / accept n으로 바꾸기 -->
	                        <%}else{ %> <!-- 거절답변 or 매칭실패일 경우 -->
	                        	<button type="button" onclick="history.back()">확인</button>
                        	<%} %>
                        <%} %>
                        
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
    	//아직 기능 확인 안함//이거는 그냥 마이페이지 에다가 해놓자
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
</body>
</html>