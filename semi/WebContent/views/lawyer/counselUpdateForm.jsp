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
<title>상담신청 수정</title>
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
	</style>
</head>
<body>
	<div class="wrap">
	   <div id="enroll-area">
	       <div id="title"><h2>상담내용 수정</h2></div>
	       <div id="enroll">
	           <form  id="enroll-form" action="<%=contextPath%>/counselUpdate.la" method="post">
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
	                       <td><input type="text" name="title" value="<%=c.getCsTitle() %>" required></td>
	                   </tr>
	                   <tr>
	                       <th>내용</th>
	                       <td><textarea name="content" cols="50" rows="15" style="resize:none" required><%=c.getCsContent() %></textarea></td>
	                   </tr>
	               </table>
	               <div id="button">
	                   <button type="submit">수정하기</button>
	                   <button type="button" onclick="back();">취소</button> <!-- 마이페이지 이동으로 변경하기 -->
	               </div>
	           </form>
	       </div>
	   </div>
	</div>
	<script>
		function back(){
			if(confirm("취소하시면 작성 내용이 저장되지 않습니다.")){
				history.back();
			}
		};
	</script>
</body>
</html>