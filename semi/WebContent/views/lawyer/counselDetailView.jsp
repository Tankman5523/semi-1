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
                    	<%if(c.getCsAnswer() != null){ %>
                        	<button type="button" onclick="counselDelete();">삭제하기</button>
                        <%}else{ %>
                        	<button type="submit">수정하기</button>
                        <%} %>
                        <button type="button" onclick="history.back()">취소</button>
                        
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
    	//아직 기능 확인 안함
    	function counselDelete(){
    		if(confirm=("상담내역을 삭제하시겠습니까? 삭제하시면 내용을 복구할 수 없습니다.")){
    			location.href="<%=contextPath%>/counselDelete.la?cno=<%=c.getCsNo()%>";
    		}
    	};
    </script>
</body>
</html>