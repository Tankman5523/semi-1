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
   /* border: 1px; solid black; */
   border: 0;
   box-sizing: border-box;
}
.wrap{
   /* border: 1px solid black; */
   border: 0;
   width: 1200px;
   height: 600px;
   margin: auto;
}
.enroll-area{
   width: 60%;
   height: 100%;
   margin: auto;
}
.enroll-area>div{
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

.answer-area{
    width: 80%;
    height: 70%;
    margin: auto;
}
.answer-form{
	display: none;
}

</style>
</head>
<body>
    <div class="wrap">
        <div class="enroll-area">
            <div id="title"><h2>상담 내용 확인 (변호사)</h2></div>
            <div id="enroll">
                <div  id="enroll-form">
                    <input type="hidden" name="cno" value="<%=c.getCsNo() %>">
                    <table align="center">
                        <tr>
                            <th width="100px">제목</th>
                            <td width="400px" colspan="3"><input type="text" value="<%=c.getCsTitle() %>" readonly></td>
                        </tr>
                        <tr>
                            <th>회원 아이디</th>
                            <td><%=c.getCsWriter()%></td>
                            <th>분야</th>
                            <td><%=c.getRefLno()%></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td colspan="3"><textarea cols="50" rows="15" style="resize:none" readonly><%=c.getCsContent() %></textarea></td>
                        </tr>
                    </table>
                        <%if(c.getCsAnswer() != null){ %>
                        	<div class="answer-area" action="<%=contextPath%>/counselUpdate.la" method="get"">
			                    <table align="center">
			                        <tr>
			                            <th>답변</th>
			                        </tr>
			                        <tr>
			                            <td><textarea cols="50" rows="15" style="resize:none" readonly><%=c.getCsAnswer() %></textarea></td>
			                        </tr>
			                    </table>
			                    <br>
			                    <div>
			                        <button type="button">뒤로가기</button>
			                    </div>
			                </div>
                        <%}else{ %>
		                    <div id="button">
		                        <button type="button" id="acceptBtn">수락메세지 작성</button>
		                        <button type="button" id="declineBtn">거절메세지 작성</button>
		                        <button type="button">뒤로가기</button>
		                    </div>
		                <%} %>
                </div>
                <form class="answer-form" action="<%=contextPath%>/counselUpdate.la" method="get"">
                    <table align="center">
                        <tr>
                            <th>답변</th>
                        </tr>
                        <tr>
                            <td><textarea name="answer" cols="50" rows="15" style="resize:none" required></textarea></td>
                        </tr>
                    </table>
                    <br>
                    <div id="button_2">
                        <button type="submit">답변 저장 (수정못하게 막기)</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
    	$(function(){
    		$("#acceptBtn").click(function(){
        		$(".answer-form").
        	});
    	});
    	
    	
    
    </script>
</body>
</html>