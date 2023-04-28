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

	<style>
		.delete_mem_list{
	        width: 800px;
	        box-sizing: border-box;
	        margin : auto;
	        margin-top: 20px;
		}
		
		.delete-btn-area{
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
	    
	    #chek-area{
	    	width:50px;
	    	
	    }
	    
	  
	</style>
</head>
<body>

	<%@ include file="manager_menu.jsp" %>
	
	<div class="delete_mem_list">
		
		<h2 align="center">탈퇴 회원 관리</h2>
		<hr>
	        <table>
	            <thead id="List">
	                <tr>
	                	<th>선택</th>
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
		            	<td id="chek-area" align="center" ><input type ="checkbox"></td>
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
		
		<div class="delete-btn-area">
			<button id="delete-btn">선택 삭제</button>
		</div>
		
		<script>
		/*선택 삭제시, 데이터 완전 삭제 */
		
		$(function(){
			
			$('#memberList').on('click','input',function(){
				
				var chk_list = $(this);
				
				for(var i = 0 ; i<chk_list.length ; i++){
					chk_list[i].check = this.chked;
				}
				
				var userNo = $(this).parent().next().text(); //회원번호 
				
			
			});
			
			
		}); //함수 끝 
		
		</script>
</body>
</html>