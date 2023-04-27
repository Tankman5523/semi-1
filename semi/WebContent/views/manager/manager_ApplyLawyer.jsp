<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.member.model.vo.Member"%>
<%

	ArrayList <Member> applyLaw = (ArrayList<Member>)request.getAttribute("applyLaw");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사회원 전환신청 관리 페이지</title>

	<style>
	.content{
	        width: 800px;
	        box-sizing: border-box;
	        margin : auto;
	        margin-top: 20px;
	    }
	    #info, table{
	        width: 100%;
	    }
	    #List{
	        background-color: rgb(223, 220, 220);
	    }
	    a{
	        text-decoration: none;
	        color: black;
	        display: block;
	    }
	    
	    #counsel-list a{
	    	width : 50%;
	    	float : left;
	    }
	    
	    #review-btn{
	    	margin-left: 10px;
	    }
	    a:hover +{
	        cursor: pointer;
	        
	    }
	</style>
</head>
<body>

<%@ include file="manager_menu.jsp" %>

<div class="content">
	
	<h2 align="center">변호사회원 전환신청 관리</h2>
	<hr>
        <table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="100">이름</td>
                    <td width="100">아이디</td>
                    <td width="100">가입일</td>
                    <td width="100">상태</td>
                    <td width="50">변경</td>
                </tr>
            </thead>
            <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
            <%if(!applyLaw.isEmpty()){ %>
            <tbody id="apply-list">
				<%for(int i= 0 ; i < applyLaw.size() ; i++){%>
	            <tr>
	                <td><%=i+1%></td>
	                <td><a href="<%=contextPath%>/detail.apply.me?nuo="<%=applyLaw.get(i).getUserNo()%>><%=applyLaw.get(i).getUserName()%></a></td>
	                <td><%=applyLaw.get(i).getUserId()%></td>
	                <td><%=applyLaw.get(i).getEnrollDate()%></td>
	                <%if(applyLaw.get(i).getLawyer().equals("W")){ %>
	                	<td style="color: green">대기중</td>
	                <%}else if(applyLaw.get(i).getLawyer().equals("Y")){ %>
	                	<td style="color: blue">승인</td>
	                <%}else{ %>
		                <td style="color: red">거절</td>
	                <%} %>	
	                <td><button>변경하기</button></td>
	            </tr>
	            <%} %>
	         <%}else{ %>   
	        <!-- 찜한 변호사 리스트가 비어있다면  -->    
	       		<tr>
	       			<td></td>
	       			<td colspan ="5">신청 회원이 존재하지 않습니다.	</td>
	       		</tr>
            </tbody>
            <%} %>
        </table>
        
        <script>
        /*신청내역 상세보기*/
        
        
        </script>
</div>

</body>
</html>