<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.member.model.vo.Member" %>

<%
	ArrayList <Member> deleteMemList = (ArrayList <Member>)request.getAttribute("deleteMemList");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴 회원 관리</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<style>
	/* 폰트 */
   	@font-face{
   		font-family: 'SBAggroB';
 		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');	
   		font-weight: normal;
  		font-style: normal;
	}    
	
	@font-face {
	    font-family: 'Cafe24Ohsquare';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/Cafe24Ohsquare.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	@font-face {
	    font-family: 'HallymGothic-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2204@1.0/HallymGothic-Regular.woff2') format('woff2');
	    font-weight: 400;
	    font-style: normal;
	}
	

	#delete_mem_list{
        width: 1200px;
        box-sizing: border-box;
        margin : auto;
        margin-top: 20px;
    }
    
   #delete_mem_list>h2{
   		 font-family: 'SBAggroB';
   		 font-size : 30px;
   		 font-weight : 300;
   		 color: white;
   		 padding-top: 30px;
    }
    
    table{
    	width: 100%;
    }
    
    table th{
    	font-family: 'Cafe24Ohsquare';
    	font-size: 18px;
    	text-align: center;
    	height : 35px;
    }
    
    table td{
    	font-family: 'HallymGothic-Regular';
    	font-size: 15px;
    	text-align: center;
    	color : white; 
    	height: 30px;
    }	 
    #List{
        background-color: rgb(223, 220, 220);
    }
    
    hr{
    	background: white;
    	height: 1.5px;
    	boarder : 0;
    }
    
    a{
        text-decoration: none;
        display: block;
		color : white;        
    }
    
    .delete-btn-area{
		margin-top: 30px;    
    
    }
 
	</style>

<%@ include file="manager_header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
<div id="content" style="overflow: auto;">	
	<div id="delete_mem_list">
		<h2 align="center">탈퇴 회원 조회</h2>
		<hr>
		
	        <table>
	            <thead id="List">
	                <tr>
	                    <th width="50">회원번호</th>
	                    <th width="70">아이디</th>
	                    <th width="70">이름</th>
	                    <th width="70">회원 타입</th>
	                    <th width="80">가입일</th>
	                    <th width="50">상태</th>
	                </tr>
	            </thead>
	            <!-- 전체 회원 조회 -->
	            <% if(!deleteMemList.isEmpty()) {%>
	            <tbody id="memberList">
		          	<%for(Member deletMem : deleteMemList){ %>
		            <tr>
		                <td><%=deletMem.getUserNo()%></td>
		                <td><%=deletMem.getUserId() %></td>
		                <td><%=deletMem.getUserName() %></td>
		              	<%if(deletMem.getLawyer().equals("Y")){ %>
			                <td>변호사 회원</td>
		               	<%}else{ %>
		               		<td>일반 회원</td>
		               	<%} %>
		                <td><%=deletMem.getEnrollDate()%></td>
		                <td><%=deletMem.getStatus() %></td>
		            </tr>
					<%} %>
				<%}else{ %>	
		       	<!-- 회원이 없을 경우 -->
		       		<tr>
		       			<td></td>
		       			<td colspan ="6">조회된 회원이 없습니다.</td>
		       		</tr>
		       	<%} %>	
	            </tbody>
	        </table>
		</div>
</div>
<%@ include file = "../common/footer.jsp" %>		
