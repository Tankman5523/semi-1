<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.bbbox.lawyer.model.vo.*" %>
<%
	Lawyer apply = (Lawyer)request.getAttribute("apply");

	String lat = (String)request.getAttribute("lat"); 
	
	Member applyMem = (Member)request.getAttribute("applyMem");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 회원 신청 조회 페이지</title>
<style>
       .content{
            width: 1200px;
            box-sizing: border-box;
            margin-top:10px;
            margin:auto;
        }
        
        #info, #lawInfo, #lawComent{
            width: 60%;
            margin-left: 400px;
         }
		
		#info td, #lawComent td{
			width: 80px;
			height: 35px;
		}
	
		#lawInfo td{
			width: 60px;
			height: 35px;
		}
    </style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
    <div class="content">
	        <h2 align="center">변호사 회원 신청</h2>
	        <hr>
	        <!-- 기본정보 뷰 -->
	            <table id="info">
	            	<thead>
		            	<tr>
		            		<td><b>[기본회원 정보]</b></td>
	    	        	</tr>
	            	</thead>
	                <tr>
	                    <td>아이디</td>
	                    <td><%=applyMem.getUserId()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>이름</td>
	                    <td><%=applyMem.getUserName()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>핸드폰번호</td>
	                    <td><%=applyMem.getPhone()%></td>
	                </tr>
	                <tr>
	                    <td>email</td>
	                    <td><%=applyMem.getEmail()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td>주소</td>
	                    <td><%=applyMem.getAddress()%></td>
	                </tr>
	            </table>
	        <hr>
	            <table id="lawInfo">
	                <tr>
	                    <td rowspan="4">사진</td>
	                    <td rowspan="4" colspan ="4"><img width="150" height="180" src="<%=contextPath+lat%>"></td>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                    <td>시험</td>
	                    <td><%=apply.getExam()%></td>
	                </tr>
	                <tr>
	                    <td>회차</td>
	                    <td><%=apply.getExamSession()%>회</td>
	                </tr>
	                <tr>
	                    <td>합격년도</td>
	                    <td><%=apply.getPassDate()%>년도</td>
	                </tr>
	                <tr>
	                    <td>전문분야</td>
	                    <td><%=apply.getRefPno()%></td>
	                </tr>
	                <tr>
	                    <td>주소</td>
	                    <td><%=apply.getCompanyAddress() %></td>
	                </tr>
	                <tr>
	                    <td>사무소 이름</td>
	                    <td><%=apply.getCompanyName() %></td>
	                </tr>
	                <tr>
	                    <td>사무소 번호</td>
	                    <td><%=apply.getCompanyPn()%></td>
	                </tr>
	            </table> 
	        <hr>
	            <table id="lawComent">
	                <tr>
	                    <td>한줄소개</td>
	                    <td><textarea name="comment" id="" cols="40" rows="3" style="resize: none;"><%=apply.getLawComment()%></textarea></td>
	                </tr>
	                <tr>
	                    <td>경력</td>
	                    <td><textarea name="career" id="" cols="40" rows="5" style="resize: none;"><%=apply.getCareer()%></textarea></td>
	                </tr>
	            </table>    
	        <hr>
	        
	       <div class="applybtn" align="center">
	       		<button id="accept">승인</button>
	       		<button id="refuse">거절</button>
	       </div>     
    </div>
  	<br><br><br>
  	
  	<script>
  		/* 승인버튼 클릭시 발생하는 이벤트 함수  */
  		$('#accept').on('click', function(){
  		
  			$.ajax({
  				url: "apply.ac",
  			
	  			data : {uno : <%=applyMem.getUserNo()%>,
  						resultNum : 1},
	  			
	  			type : "get",
	  			
	  			success: function(result){
	  				if(result ="YY"){
	  					alert("회원 전환이 완료되었습니다.");
	  					
	  				}else{
	  					alert("회원 전환이 실패하였습니다.")
	  				}
	  				
	  				location.href="<%=contextPath%>/manage.apply.la";
	  			},
	  			
	  			error : function(){
	  				console.log("통신 실패")
	  			}
  			}); //ajax 끝 
  		});
  		
  		/*거절 버튼 클릭시 발생하는 이벤트 함수*/
  		
  		$('#refuse').on('click', function(){
  		
  			$.ajax({
  				url: "apply.ac",
  			
	  			data : {uno : <%=applyMem.getUserNo()%>,
  						resultNum : 0},
	  			
	  			type : "get",
	  			
	  			success: function(result){
	  				if(result ="YY"){
	  					alert("회원전환 거절이 완료되었습니다.");
	  					
	  				}else{
	  					alert("회원전환 거절에 실패하였습니다.")
	  				}
	  				
	  				location.href="<%=contextPath%>/manage.apply.la";
	  			},
	  			
	  			error : function(){
	  				console.log("통신 실패")
	  			}
  			}); //ajax 끝 
  		});
  	
  	</script>
</body>
</html>