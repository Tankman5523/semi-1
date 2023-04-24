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
	   width: 170px;
	   height: 200px;
	   object-fit: cover;
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
	   </div>
	   <div id="content">
	       <div id="left">
	           <div id="left_top">
	               <table id="info"> <!-- 변호사 소개글 영역 -->
	                   <tr>
	                       <td rowspan="4" width="180px" height="180px"><img src="<%=contextPath + law.getLawImg()%>"></td>
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
	                             <td id="heart" height="40px"><i id="emptyHeart" class="fa-sharp fa-regular fa-heart fa-lg" style="color: #ff0000;"></i></td>
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
	            center:new google.maps.LatLng(37.5642135, 127.0016985)
	            // 줌 레벨 : 5
	               , zoom:9
	      };
	      
	      // 2. 구글 지도 생성(만들기)
	      // var map = new google.maps.Map(맵캔버스, 맵옵션들 );
	      var map = new google.maps.Map( 
	             document.getElementById("map") 
	            , mapOptions );
	   }
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAJwp5ZEf5Vi5Gz_5RiU4Sxzt2IfSTeuDM&callback=myMap"></script>
	
	
	<%if(loginUser != null){ %>
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
	
		</script>
	<%}else{ %>
		<script>
			$("#addFunction tr:eq(0),#addFunction tr:eq(1)").click(function(){
				if(confirm("로그인한 회원만 이용가능한 메뉴입니다.")){
					location.href="<%=contextPath%>/enroll.me";
				}
			});
		</script>
	<%} %>
	<script>
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