<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.lawyer.model.vo.*"%>
<%
	Lawyer law = (Lawyer)request.getAttribute("law");
%>
<%@ include file = "../common/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- font-awesome Copy Link Tag (아이콘 사용) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
    /* 영역잡기 */
.wrap div{
   /* border: 1px solid black; */
   border: 0px;
   box-sizing: border-box;
}
.wrap{
   width: 1200px;
   height: 600px;
   margin: auto;
}
.wrap>div{
   width: 90%;
   margin: auto;
}
#head{
   height: 5%;
}
#content{
   height: 95%;
}

#content>div{
   height: 100%;
   float: left;
}
#left{
   width: 70%;
}
#right{
   width: 30%;
}
#left>div{
   width: 100%;
}
#left_top{
   height: 50%;
   position: relative;
}
#left_bottom{
   height: 50%;
}
#left_bottom>div{
   width: 50%;
   height: 100%;
   float: left;
}

/* 기본정보 */
#info{
   position: absolute;
   margin: auto;
   left: 0;
   right: 0;
   top: 0;
   bottom: 0;
}
img{
   width: 100%;
   height: 100%;
}
#career>li{
    margin-top: 20px;
    font-size: 13px;
    color: rgb(103, 99, 174);
}
#career>li>p{
    font-size: 14px;
    color: black;
}
 #add{
    margin: auto;
    margin-top: 20px;
}
a{
    text-decoration: none;
    color: rgb(91, 84, 104);
    font-weight: 700;
    cursor: pointer;
}

</style>
</head>
<body>
	<div class="wrap">
	   <div id="head">
	       뒤로 가기 등 
	   </div>
	   <div id="content">
	       <div id="left">
	           <div id="left_top">
	               <table id="info">
	                   <tr>
	                       <td rowspan="4" width="150px" height="150px"><img src="data:image/jpeg;base64,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" alt=""></td>
	                       <td rowspan="4" width="20px"></td>
	                       <td width="300px"><h2><%=law.getRefUno() %> 변호사</h2></td>
	                   </tr>
	                   <%if(law.getLawComment() != null ){ %>
		                   <tr>
		                       <td><h3>"<%=law.getLawComment() %>"</h3></td>
		                   </tr>
	                   <%} %>
	                   <!-- not null 안할거면  !=null 조건 걸기 -->
	                   <tr>
	                       <td><b><%=law.getCompanyName()+"  "+law.getCompanyPn() %></b></td>
	                   </tr>
	                   <tr>
							<td><%=law.getCompanyAddress() %></td>
	                   </tr>
	               </table>
	           </div>
	           <div id="left_bottom">
	               <div>
	               		<!-- input type="hidden" 넣기 -->
	               		<table id="add">
	                         <tr>
	                             <td height="40px"><i class="fa-regular fa-heart fa-lg" style="color: #9db9fb;"></i></td>
	                             <!-- <td height="40px"><i class="fa-solid fa-heart fa-lg" style="color: #9db9fb;"></i></td> -->
	                             <td><a href="">찜하기</a></td>
	                         </tr>
	                         <tr>
	                             <td height="40px"><i class="fa-solid fa-message fa-lg" style="color: #fcff33;"></i></td>
	                             <td><a href="">상담바로가기</a></td>
	                         </tr>
	                         <tr>
	                             <td height="40px"><i class="fa-solid fa-location-dot fa-lg" style="color: #ff1a1a;"></i></td>
	                             <td><a href="">지도보기</a></td>
	                         </tr>
	                     </table>
	                     <div style="margin-top:30px"><i class="fa-solid fa-quote-left"></i> <a><%=law.getRefUno() %> 변호사의 해결사례가 궁금하다면?</a></div>
	               </div>
	               <div>
	                   <ul id="career">
	                       <li>분야 <p>교통사고 / <%=law.getRefPno() %> 전문</p></li>
	                       <li>학력(경력으로 되어있음)<P><%=law.getCareer() %></P></li>
	                       <li>자격<P><%=law.getPassDate()+"년도 "+law.getExam() %> 합격</P></li>
	                   </ul>
	               </div>
	           </div>
	           
	       </div>
	       <div id="right">
	           <div id="review">
	               리뷰 영역 (스크롤)
	           </div>
	       </div>
	   </div>
	</div>
	
	<script>
		window.onload=function(){
			console.log("하이");
		}
	</script>
</body>
</html>