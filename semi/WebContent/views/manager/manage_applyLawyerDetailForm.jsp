<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.bbbox.lawyer.model.vo.*" %>
<%
	Lawyer lawInfo = (Lawyer)request.getAttribute("lawInfo");

	String lat = (String)request.getAttribute("lat"); 
	
	Member applyMem = (Member)request.getAttribute("applyMem");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 회원 신청 조회 페이지</title>
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
       
	.law_content{
		width:1200px;
		height:100%;
	    margin: auto;
	}
	
	#info, #lawComent{
		width: 60%;
		margin:auto;		
	}
	
	#lawInfo{
		width :60%;
		margin:auto;
	}
	
	#info th, #lawComent th{
		width : 150px;
	
	}
	
	#lawInfo th{
		width : 72px;
	}
	hr{
		background : white;
		height: 1.5px;
		border:0;
	}
	.law_content h2{
		font-family: 'SBAggroB';
		font-weight:300;
		font-size: 30px;
		color:white;
		padding-top : 50px;
	}	
	
	h4{
		font-family: 'SBAggroB';
		font-weight:300;
		font-size: 20px;
		color:white;
		margin-left: 250px;
		margin-bottom: 20px;
		
	}	
	
	 
	td, th{
		 font-family: 'Cafe24Ohsquare';
		 color: white;
		 height: 36px;
		 width: 100px;
		 font-size: 18px;
	} 
	 
	a{
	    text-decoration: none;
	    color: black;
	    display: block;
	}
	
	#applybtn button{
	    margin-left: 20px;
	    margin-right: 20px;
    }
    </style>
    
<%@ include file="manager_header.jsp" %>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->	
<div id="content" style="overflow: auto;">
	<div class="law_content">
    	<h2 align="center">변호사 회원 신청</h2>
	        <hr>
	        <h4>INFO</h4>
	        <!-- 기본정보 뷰 -->
	            <table id="info">
	                <tr>
	                    <th>아이디</th>
	                    <td><%=applyMem.getUserId()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <th>이름</th>
	                    <td><%=applyMem.getUserName()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <th>핸드폰번호</th>
	                    <td><%=applyMem.getPhone()%></td>
	                </tr>
	                <tr>
	                    <th>email</th>
	                    <td><%=applyMem.getEmail()%></td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <th>주소</th>
	                    <td><%=applyMem.getAddress()%></td>
	                </tr>
	            </table>
	        <hr>
	            <table id="lawInfo">
	                <tr>
	                    <th>사진</th>
	                    <td rowspan="4" colspan ="4"><img width="150" height="180" src="<%=contextPath+lat%>"></td>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                </tr>
	                <tr>
	                </tr>
					<tr>
					</tr>	                
	                <tr>
	                    <th>시험</th>
	                    <td><%=lawInfo.getExam()%></td>
	                </tr>
	                <tr>
	                    <th>회차</th>
	                    <td><%=lawInfo.getExamSession()%>회</td>
	                </tr>
	                <tr>
	                    <th>합격년도</th>
	                    <td><%=lawInfo.getPassDate()%>년도</td>
	                </tr>
	                <tr>
	                    <th>전문분야</th>
	                    <td><%=lawInfo.getRefPno()%></td>
	                </tr>
	                <tr>
	                    <th>주소</th>
	                    <td><%=lawInfo.getCompanyAddress() %></td>
	                </tr>
	                <tr>
	                    <th>사무소 이름</th>
	                    <td><%=lawInfo.getCompanyName() %></td>
	                </tr>
	                <tr>
	                    <th>사무소 번호</th>
	                    <td><%=lawInfo.getCompanyPn()%></td>
	                </tr>
	            </table> 
	        <hr>
	            <table id="lawComent">
	                <tr>
	                    <th>한줄소개</th>
	                    <td><textarea name="comment" id="" cols="40" rows="3" style="resize: none;" readonly><%=lawInfo.getLawComment()%></textarea></td>
	                </tr>
	                <tr>
	                    <th>경력</th>
	                    <td><textarea name="career" id="" cols="40" rows="5" style="resize: none;" readonly><%=lawInfo.getCareer()%></textarea></td>
	                </tr>
	            </table>    
	        <hr>
	        
	       <div id="applybtn" align="center">
	       		<button class= "btn btn-primary" id="accept">승인</button>
	       		<button class= "btn btn-danger" id="refuse">거절</button>
	       </div>     
    </div>
</div>    
  	
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
  	
<%@ include file = "../common/footer.jsp"%>