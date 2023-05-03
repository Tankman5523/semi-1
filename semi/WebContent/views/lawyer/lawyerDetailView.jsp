<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	Lawyer law = (Lawyer)request.getAttribute("law");
	String lawName = law.getRefUno(); //변호사 이름 (자주 사용해서 변수로 만듦)
	ArrayList<LawReview> rList =  (ArrayList<LawReview>)request.getAttribute("rList");
%>
<%@ include file = "../common/header.jsp" %>

<!-- 구글맵 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
	/* 영역잡기 */
    #content *{
   		color: white;
    }
	#content>div{
		width: 100%;
	}
	#space{
		height: 5%;
	}
	#head{
	   height: 5%;
	}
	#content-area{
	   height: 90%;
	}
	#content-area>div{
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
	   height: 100%;
	   float: left;
	}
	#left_bottom_left{
		width: 60%;
	}
	#left_bottom_right{
	width: 40%;
	}
	/* 기본정보 */
	#info{
	   border-collapse: collapse;
	   position: absolute;
	   margin: auto;
	   top: 0;
	   bottom: 0;
	   right: 100px;
	   border: 5px solid rgb(255, 243, 218);
	}
    #info td{
    	background-color: rgb(255, 243, 218);
    }
    #info *{
    	color: black;
    	font-size: 18px;
    }
	th>img{
	   width: 100%;
	   height: 100%;
	   object-fit: cover;
	   display: block;
	   border: 0;
	}
	/* 추가 커리어 */
	#career>li{
	    margin-top: 23px;
	    font-size: 20px;
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
        cursor: pointer;
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
        box-shadow: 0px 0px 12px 12px rgba(160, 197, 253, 0.7);
    }
    #map{
    	width: 100%;
    	height: 100%;
    }
    #review-content{
    	font-size: 13px;
    }
    /* 폰트, 색상 */
    @font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	#career *, #info *, span, #review-area td{
		font-family: 'Pretendard-Regular';
	}
	#career>li{
		list-style-type: none;
		color: rgb(252, 239, 179);
		font-size: 18px
	}
	#career>li>p{
		color: white;
		margin: 10px 0px;
		font-size: 20px;
	}
	span{
		font-size: 20px;
		font-weight: 500;
	}
	#review-area td, #review-area span{
		color: black;
		font-size: 17px
	}
	#info h2{
		margin: 0;
		margin-top: 10px;
		font-size: 27px;
	}
	#info h3{
		margin: 0;
	}
</style>

<div id="content">
   <div id="space"></div>
   <div id="head"> <!-- 뒤로가기 버튼 -->
      <a href="<%=contextPath %>/list.la" style="margin-left:50px;"><i class="fa-solid fa-angle-left fa-2xl" style="color: #878787;"></i></a>
   </div>
   <div id="content-area">
       <div id="left">
           <div id="left_top">
               <table id="info"> <!-- 변호사 소개글 영역 -->
                   <tr>
                       <th rowspan="4" width="180px" height="220px"><img src="<%=contextPath + law.getLawImg()%>"></th>
                       <td rowspan="4" width="50px"></td>
                       <td width="400px" height="70px"><h2><%=lawName %> 변호사</h2></td>
                   </tr>
                   <%if(law.getLawComment() != null ){ %>
	                   <tr>
	                       <td><h3 style="font-size:22px">"<%=law.getLawComment() %>"</h3></td>
	                   </tr>
                   <%} %>
                   <tr>
                       <td height="17px"><b><%=law.getCompanyName()+"&nbsp;&nbsp;|&nbsp;&nbsp;"+law.getCompanyPn() %></b></td>
                   </tr>
                   <tr>
						<td><%=law.getCompanyAddress() %></td>
                   </tr>
               </table>
           </div>
           <div id="left_bottom">
               <div id="left_bottom_left">
               		<table id="addFunction"> <!-- 상세페이지 안 추가 기능 영역 -->
                         <tr>
                             <td id="heart" height="50px"><i id="emptyHeart" class="fa-sharp fa-regular fa-heart fa-lg" style="color: #ff0000;"></i></td>
                             <td><span>&nbsp;&nbsp;찜하기</span></td>
                         </tr>
	                         <tr>
                             <td height="50px"><i class="fa-solid fa-message fa-lg" style="color: #fcff33;"></i></td>
                             <td><span>&nbsp;&nbsp;상담 바로가기</span></td>
                         </tr>
                         <tr>
                             <td height="50px"><i class="fa-solid fa-location-dot fa-lg" style="color: #0011ff;"></i></td>
                             <td><span>&nbsp;&nbsp;지도 보기</span></td>
                         </tr>
                     </table>
                     <div style="margin-top:50px; margin-left:180px;">
                     	<i class="fa-solid fa-quote-left"></i>
                     	<a href="<%=contextPath%>/list.rb?currentPage=1">변호사님의 해결사례가 궁금하다면?</a>
                     </div>
               </div>
               <div id="left_bottom_right">
                   <ul id="career"> <!-- 변호사 추가정보 영역 -->
                       <li>분야 <p>교통사고 / <%=law.getRefPno() %> 전문</p></li>
                       <li>학력/경력<P><%=law.getCareer() %></P></li>
                       <li>자격<P><%=law.getPassDate()+"년도 "+law.getExam() %> 합격</P></li>
                   </ul>
               </div>
           </div>
       </div>
       <div id="right"> <!-- 리뷰 영역 -->
	   		<div id="review-title"><span>고객추천의 글&nbsp;&nbsp;</span><i class="fa-solid fa-user-group fa-lg" style="color: #00bd7e;"></i></div>
			<div id="review-area">
				<%if(rList.isEmpty()){ %>
					<table id="emptyReview">
						<tr>
							<td>아직 남겨진 리뷰가 없습니다.<br>
							<b><span><%=lawName %>변호사님께 상담신청을 해보세요.</span></b></td>
						</tr>
					</table>
				<%}else{ %>
					<%for(LawReview r : rList){ %>
						<input type="hidden" value="<%=r.getReviewNo() %>">
						<table>
							<tbody>
								<tr>
									<td><%=r.getStar() %></td>
									<td><%=r.getUserId() %></td>
								</tr>
								<tr id="review-content">
									<td colspan="2"><%=r.getReviewContent() %></td>
								</tr>
							</tbody>
						</table>
					<%} %>
				<%} %>
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
		   
			var address = "<%=law.getCompanyAddress()%>";
			var local = address.substring(0,2); //주소에서 앞 두글자만 가져오기
			var markerLat = 0;
			var markerLng = 0;
			var label = "";
			
			switch(local){
			case "서울" : markerLat=37.4961; markerLng=127.0113; label="서울중앙지방법원"; break;
			case "경기" : markerLat=37.4431; markerLng=126.6676; label="인천지방법원"; break;
			case "강원" : markerLat=37.8673; markerLng=127.7348; label="춘천지방법원"; break;
			case "충청" : markerLat=36.7854; markerLng=127.155; label="대전지방법원"; break;
			case "전라" : markerLat=35.1505; markerLng=126.9346; label="광주지방법원"; break;
			case "경상" : markerLat=35.8622; markerLng=128.6285; label="대구지방법원"; break;
			case "제주" : markerLat=33.494; markerLng=126.5355; label="제주지방법원"; break;
			}
		   
	      var mapOptions = { //구글 맵의 옵션 
	            center:new google.maps.LatLng(markerLat, markerLng), //지도의 중앙 위치
	            zoom:13 // 줌 레벨 
	      };
	      
	      var map = new google.maps.Map( //구글 지도 생성 (맵캔버스, 맵옵션들 )
	             document.getElementById("map") 
	            , mapOptions );
	      
	      var MarkerPoint = { lat: markerLat, lng: markerLng};
	      var subMarker = new google.maps.Marker({
	          position: MarkerPoint,
	          map: map,
	          label: label,
	          icon: {
	            url: "http://maps.google.com/mapfiles/ms/icons/red-dot.png",
	            labelOrigin: new google.maps.Point(20, 47),
	            anchor: new google.maps.Point(50,32)
	          }
	        });
	   }
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAJwp5ZEf5Vi5Gz_5RiU4Sxzt2IfSTeuDM&callback=myMap"></script>
	
	<!-- 관리자일 경우는 관리자 만들 때  -->
	<%if(loginUser != null && loginUser.getLawyer().equals("N")){ %> <!-- 일반회원일 경우 -->
	
		<script>
			 $(function(){ //현재 찜한 여부 확인
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
			$("#addFunction tr:eq(0)").click(function(){ //찜하기 클릭 시 찜하기 상태 변경
			
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
		
			$("#addFunction tr:eq(1)").click(function(){ //상담신청 페이지로 이동
				location.href="<%=contextPath%>/counselEnroll.la?lno=<%=law.getLawNo() %>";
			});
			
			$(function(){ //리뷰 상세보기로 이동
				$("#review-area table").on("click", "tbody", function(){
					var reNo = $(this).parent().prev().val();
					location.href="<%=contextPath%>/reviewDetail.la?reNo="+reNo;
				});
			});
			
			$("#emptyReview").click(function(){ //상담신청 페이지로 이동
				location.href="<%=contextPath%>/counselEnroll.la?lno=<%=law.getLawNo() %>";
			});
			
		</script>
		
	<%}else if(loginUser != null && (loginUser.getLawyer().equals("Y")||loginUser.getAdmin().equals("Y"))){ %> <!-- 변호사 회원일 경우 -->
	
		<script>
			$("#addFunction tr:eq(0),#addFunction tr:eq(1),#emptyReview").click(function(){
				alert("일반회원만 이용 가능한 메뉴입니다.");
			});
			
			$(function(){ //리뷰 상세보기로 이동 (중복되는 메서드 조건 수정하면 삭제하기)
				$("#review-area table").on("click", "tbody", function(){
					var reNo = $(this).parent().prev().val();
					location.href="<%=contextPath%>/reviewDetail.la?reNo="+reNo;
				});
			});
		</script>
		
	<%}else { %>
	
		<script>
			//로그인 전에는 찜하기/상담기능/리뷰 상세보기 기능 막기
			$("#addFunction tr:eq(0),#addFunction tr:eq(1),#review-area>table").click(function(){
				if(confirm("로그인한 회원만 이용가능한 메뉴입니다. 로그인 페이지로 이동하시겠습니까?")){
					location.href="<%=contextPath%>/login.me";
				}
			});
		</script>
	
	<%} %>
	
	<script>
		$("#addFunction tr:eq(2)").click(function(){ //지도 모달창 띄우기
			$("#popup-wrap").css('display','block');
		});
		
		$("#popup-wrap").click(function(e){ //모달 배경 클릭 시 나가기
			if(e.target != e.currentTarget) return;
				$("#popup-wrap").css('display','none');
		});
	</script>
</div>

<%@ include file = "../common/footer.jsp" %>