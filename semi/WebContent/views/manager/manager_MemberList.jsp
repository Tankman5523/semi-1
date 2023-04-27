<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.member.model.vo.Member" %>
<%
	ArrayList <Member> mList = (ArrayList<Member>)request.getAttribute("memberList");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원 관리</title>

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
	
	<h2 align="center">회원 관리</h2>
	<hr>
        <table>
            <thead id="List">
                <tr>
                    <td width="50">회원번호</td>
                    <td width="70">아이디</td>
                    <td width="70">이름</td>
                    <td width="70">회원 타입</td>
                    <td width="80">가입일</td>
                    <td width="50">탈퇴여부</td>
                    <td width="70">작성 게시글 수</td>
                    <td width="70">작성 댓글 수</td>
                </tr>
            </thead>
            <!-- 전체 회원 조회 -->
            <%if(!mList.isEmpty()){%>
            <tbody id="apply-list">
	          	<%for (Member m : mList){ %> 
	            <tr>
	                <td><%=m.getUserNo()%></td>
	                <td><%=m.getUserId() %></td>
	                <td><%=m.getUserName() %></td>
	               	<%if(m.getLawyer().equals("Y")){ %>
		                <td>변호사 회원</td>
	               	<%}else{ %>
	               		<td>일반 회원</td>
	               	<%} %>
	                <td><%=m.getEnrollDate()%></td>
	                <td><%=m.getStatus() %></td>
	                <td><%=m.getBoardCount()%></td>
	                <td><%=m.getReplyCount()%></td>
	            </tr>
				<%} %>	            
	       <%}else{ %>
	       		<!-- 회원이 없을 경우 -->
	       		<tr>
	       			<td></td>
	       			<td colspan ="8">조회된 회원이 없습니다.</td>
	       		</tr>
	       <%} %>
            </tbody>
        </table>
	</div>
</body>
</html>