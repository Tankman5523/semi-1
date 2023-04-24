<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bbbox.lawyer.model.vo.*,java.util.ArrayList"%>
<%@ include file = "../common/mainMenu.jsp" %>
<%
	Lawyer law = (Lawyer)request.getAttribute("law");
	String lawName = law.getRefUno(); //변호사 이름 (자주 사용해서 변수로 만들었음)
	ArrayList<LawReview> rList =  (ArrayList<LawReview>)request.getAttribute("rList");
	
	/* 지도확인용(나중에 지우기) */
	String referer = request.getHeader("Referer");
	System.out.println(referer);
	
	/* 이렇게 해야 되나.. */
	if(loginUser != null){
			int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사 상세페이지</title>

<!-- 구글맵 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 아이콘 CDN (font-awesome Copy Link Tag) -->
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
	#space{
		height: 5%;
	}
	#head{
	   height: 5%;
	}
	#content{
	   height: 90%;
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
	    margin-top: 23px;
	    font-size: 13px;
	    color: rgb(103, 99, 174);
	}
	#career>li>p{
	    font-size: 16px;
	    color: black;
	}
	#addFunction{
	    margin: auto;
	    margin-top: 20px;
	}
	#addFunction tr:hover{
		cursor: pointer;
	}
	a{
	    text-decoration: none;
	    color: rgb(91, 84, 104);
	    font-weight: 700;
	    cursor: pointer;
	}
	#right>div{
        width: 80%;
        margin: auto;
    }
    #review-title{
        height: 5%;
        text-align: center;
        font-size: 15px;
        font-weight: 800;
    }
    #review-area{
        width: 80%;
        height: 85%;
        overflow-y: scroll;
        background-color: rgb(243, 243, 243);
    }
    #review-area>table{
        background-color: rgb(255, 255, 255);
        border-radius: 7%;
        width: 80%;
        height: 20%;
        margin: auto;
        margin-top: 30px;
        margin-bottom: 30px;
    }
    /* 지도 모달창 */
	#popup-wrap{
        border: 0px;
        justify-content: center;
        align-items: center;
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        display: none;
    }
    #popup{
        background-color: white;
        width: 600px;
        height: 500px;
		margin: auto;
		margin-top: 200px;
        box-shadow: 10px 10px 20px 1px rgba(0,0,0,.3);
    }
    #map{
    	width: 100%;
    	height: 100%;
    }
    #review-content{
    	font-size: 13px;
    }
	
	</style>
</head>
<body>
	<div class="wrap">
	   <div id="space"></div>
	   <div id="head"> <!-- 뒤로가기 버튼 -->
	      <a href="<%=contextPath %>/list.la"><i class="fa-solid fa-angle-left fa-2xl" style="color: #878787;"></i></a>
	   	  <a href="<%=contextPath %>/mypage.la?lno=<%=law.getLawNo()%>">/테스트용 마이페이지/</a>
	   	  <a href="<%=contextPath %>/review.la?lno=<%=law.getLawNo()%>">/테스트용 리뷰작성폼/</a>
	   	  <a href="<%=contextPath %>/counselUpdate.la?cno=1">/테스트용 상담수정폼/</a>
	   </div>
	   <div id="content">
	       <div id="left">
	           <div id="left_top">
	               <table id="info"> <!-- 변호사 소개글 영역 -->
	                   <tr>
	                       <td rowspan="4" width="180px" height="180px"><img src="data:image/jpeg;base64,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" alt=""></td>
	                       <td rowspan="4" width="20px"></td>
	                       <td width="300px"><h2><%=lawName %> 변호사</h2></td>
	                   </tr>
	                   <%if(law.getLawComment() != null ){ %>
		                   <tr>
		                       <td><h3>"<%=law.getLawComment() %>"</h3></td>
		                   </tr>
	                   <%} %>
	                   <!-- * not null로 테이블 수정 안할거면 조건걸기 -->
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
	               		<table id="addFunction"> <!-- 상세페이지 안 추가 기능 영역 -->
	                         <tr>
	                             <td id="heart" height="40px"></td>
	                             <td>찜하기</td>
	                         </tr>
 	                         <tr>
	                             <td height="40px"><i class="fa-solid fa-message fa-lg" style="color: #fcff33;"></i></td>
	                             <td>상담바로가기</td>
	                         </tr>
	                         <tr>
	                             <td height="40px"><i class="fa-solid fa-location-dot fa-lg" style="color: #0011ff;"></i></td>
	                             <td>지도보기</td>
	                         </tr>
	                     </table>
	                     <div style="margin-top:40px; margin-left:30px;"><i class="fa-solid fa-quote-left"></i> <a><%=lawName %> 변호사의 해결사례가 궁금하다면?</a></div>
	               </div>
	               <div>
	                   <ul id="career"> <!-- 변호사 추가정보 영역 -->
	                       <li>분야 <p>교통사고 / <%=law.getRefPno() %> 전문</p></li>
	                       <li>학력(경력으로 되어있음)<P><%=law.getCareer() %></P></li>
	                       <li>자격<P><%=law.getPassDate()+"년도 "+law.getExam() %> 합격</P></li>
	                   </ul>
	               </div>
	           </div>
	       </div>
	       <div id="right">
		   		<div id="review-title">고객추천의 글 <i class="fa-solid fa-user-group fa-lg" style="color: #00bd7e;"></i></div>
				<div id="review-area">
					<%if(rList.isEmpty()){ %>
						<table>
							<tr>
								<td>아직 남겨진 리뷰가 없습니다.<br><a href="<%=contextPath%>/counsel.la?lno=<%=law.getLawNo() %>"><%=lawName %>변호사님께 상담신청을 해보세요.</a></td>
							</tr>
						</table>
					<%}else{ %>
						<%for(LawReview r : rList){ %>
							<table>
								<tr>
									<td><%=r.getStar() %></td>
									<td><%=r.getUserId() %></td>
								</tr>
								<tr id="review-content">
									<td colspan="2"><%=r.getReviewContent() %></td>
								</tr>
							</table>
						<%} %>
					<%} %>
					<table>
						<tr>
							<td>★★★</td>
							<td>테스트***</td>
						</tr>
						<tr id="review-content">
							<td colspan="2">정말최고이십니다.정말최고이십니다.정말최고이십니다.정말최고이십니다.정말최고이십니다.정말최고이십니다.정말최고이십니다.정말최고이십니다.정말최고이십니다</td>
						</tr>
					</table>
				</div>
	       </div>
	   </div>
	   <!-- 지도를 담기 위한 모달창 -->
	   <div id="popup-wrap">
			<div id="popup">
				<div id="map">
	
				</div>
			</div>
	   </div>
	</div>
	
	<!-- 구글맵 script -->
	<script>
	   function myMap(){
	      // 2-2. 구글 맵의 옵션 
	      var mapOptions = { 
	            // 지도의 중앙 위치 : 영국 런던
	            center:new google.maps.LatLng(51.508742, -0.120850)
	            // 줌 레벨 : 5
	               , zoom:5
	      };
	      
	      // 2. 구글 지도 생성(만들기)
	      // var map = new google.maps.Map(맵캔버스, 맵옵션들 );
	      var map = new google.maps.Map( 
	             document.getElementById("map") 
	            , mapOptions );
	   }
	</script>
	<!-- InvalidKey 에러 뜸 -->
	<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyADT30D3obKQery7gwCB8Nj6HmJCxFaAUw=?&callback=myMap"></script> -->
															
	<!-- NoApiKeys 에러 뜸 -->
	<!-- <script src="https://maps.googleapis.com/maps/api/js?AIzaSyADT30D3obKQery7gwCB8Nj6HmJCxFaAUw=?&callback=myMap"></script> -->
	<!-- <script src="https://maps.googleapis.com/maps/api/js?AIzaSyAJwp5ZEf5Vi5Gz_5RiU4Sxzt2IfSTeuDM=?&callback=myMap"></script> -->
	
	
	<!-- loginUser값이 null일 때 조건문이 안됨...........?????? -->
	<script>
		//현재 찜한 여부 확인
		 $(function(){
			$.ajax({ //찜한 여부 확인 후 하트영역에 빈하트or꽉찬하트 넣어주기
				url:"dibs.la",
				data:{
					userNo:<%=loginUser.getUserNo()%>, //로그인 유저 번호
					lawNo:<%=law.getLawNo() %> //상세페이지 변호사 번호
				},
				type:"get",
				success : function(result){
					
					if(result==0){ //찜하지 않은 상태일 때 (빈하트)
						$("#heart").html("<i id=\"emptyHeart\" class=\"fa-sharp fa-regular fa-heart fa-lg\" style=\"color: #ff0000;\"></i>");
					}else{ //찜한 상태일 때 (꽉찬하트)
						$("#heart").html("<i id=\"solidHeart\" class=\"fa-sharp fa-solid fa-heart fa-lg\" style=\"color: #ff0000;\"></i>");
					}	
				}
			});
		});
	
		//찜하기 클릭 시 찜하기 상태 변경
		$("#addFunction tr:eq(0)").click(function(){
		
			var $isTrue = false;
			var $lawName = "<%=lawName %>";
			
			if($("#heart>i").prop("id") == "emptyHeart"){ //클릭한 하트가 빈하트라면
				$isTrue = confirm($lawName+" 변호사를 찜하시겠습니까?");
			}else{ //아니라면
				$isTrue = confirm($lawName+" 변호사의 찜하기를 취소하시겠습니까?");
			}
			
			if($isTrue){//컨펌창에서 확인을 눌렀을 경우
				
				$.ajax({
					url:"dibs.la",
					data:{
						heart:$("#heart>i").prop("id"), //클릭했을때 하트값
						userNo:<%=loginUser.getUserNo() %>, 
						lawNo:<%=law.getLawNo() %>
					},
					type:"post",
					success : function(result){
						
						console.log(result);
						
						if(result == 0){ //찜하기 변경을 실패했다면 (등록or성공 뭐든)
							alert("찜하기 변경을 실패했습니다.");
						}else if(result == 1){ //찜하기 등록을 성공했다면
							$("#heart").html("<i id=\"solidHeart\" class=\"fa-sharp fa-solid fa-heart fa-lg\" style=\"color: #ff0000;\"></i>");
						}else{ //찜하기 취소를 성공했다면
							$("#heart").html("<i id=\"emptyHeart\" class=\"fa-sharp fa-regular fa-heart fa-lg\" style=\"color: #ff0000;\"></i>");
						}
						
					}
				});
			}
		});
	
		//상담신청 페이지로 이동
		$("#addFunction tr:eq(1)").click(function(){
			location.href="<%=contextPath%>/counsel.la?lno=<%=law.getLawNo() %>";
		});

		//지도 모달창 띄우기
		$("#addFunction tr:eq(2)").click(function(){
			$("#popup-wrap").css('display','block');
		});
		//모달 배경 클릭 시 나가기
		$("#popup-wrap").click(function(e){
			if(e.target != e.currentTarget) return;
				$("#popup-wrap").css('display','none');
		});
	</script>
</body>
</html>