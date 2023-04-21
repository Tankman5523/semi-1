<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.*"%>
<%
	ArrayList<Lawyer> lawList = (ArrayList<Lawyer>)request.getAttribute("lawList");
	ArrayList<PartCategory> pList = (ArrayList<PartCategory>)request.getAttribute("pList");
	
%>
<%@ include file = "../common/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 영역잡기 */
.wrap div{
   border: 0px;
   box-sizing: border-box;
}
.wrap{
   border: 1px solid black;
   width: 1200px;
   height: 600px;
   margin: auto;
}
#enroll-area{
   width: 60%;
   height: 100%;
   margin: auto;
}
#enroll-area>div{
   width: 100%;
   text-align: center;
}
#title{
   height: 15%;
   line-height: 100px;
}
h2{
   margin: 0;
}
#comment{
   height: 10%;
}
#enroll{
   height: 75%;
}
#enroll-form{
   width: 100%;
   height: 100%;
}
#enroll-form>table{
   height: 80%;
}
#enroll-form input{
   width: 80%;
   height: 70%;
}
#button{
   height: 20%;
   line-height: 100px;
}
table,td,th{
   border-collapse : collapse;
   border: 2px solid rgb(248, 222, 214);
}
</style>
</head>
<body>
	<div class="wrap">
	   <div id="enroll-area">
	       <div id="title"><h2>상담신청</h2></div>
	       <div id="comment">온라인 상담 신청을 해주시면 전문가가 신속히 답변 드리겠습니다.</div>
	       <div id="enroll">
	           <form  id="enroll-form" action="<%=contextPath%>/counsel.la" method="post">
	               <input type="hidden" name="userNo" value="<%=loginUser.getUserNo() %>">
	               <table align="center">
	                   <tr>
	                       <td width="100px">분야</td>
	                       <td width="400px">
	                           <select name="cateKey" id="part" onchange="partChange();">
			                    	<option value="전체" onclick="lawAll();">전체</option>
			                    	<!-- 전체 눌렀을때 변호사 전체 옵션 되게.......... -->
			                    	<%for(PartCategory p : pList) { %>
			                    		<option value="<%=p.getPartName() %>"><%=p.getPartName() %></option>
			                    	<%} %>
			                    </select>
	                       </td>
	                   </tr>
	                   <tr>
	                       <td>변호사</td>
	                       <td>
	                           <select name="lawNameKey" id="lawName" onchange="lawChange();">
	                               <!-- <option value="0">변호사선택</option> -->
	                               <%for(Lawyer l : lawList) { %>
			                    		<option value="<%=l.getLawNo() %>"><%=l.getRefUno() %> 변호사</option>
			                    	<%} %>
	                           </select>
	                       </td>
	                   </tr>
	                   <tr>
	                       <td>제목</td>
	                       <td><input type="text" name="title" id="title" required></td>
	                   </tr>
	                   <tr>
	                       <td>내용</td>
	                       <td><textarea name="content" id="content" cols="50" rows="15" style="resize:none" required></textarea></td>
	                   </tr>
	               </table>
	               <div id="button">
	               <!-- ajax사용하여 뭘 선택했을때는 그에 해당하는 사람만 선택되록 해야함 -->
	                   <button type="submit">신청하기</button>
	                   <button onclick="history.back()">취소</button>
	               </div>
	           </form>
	       </div>
	   </div>
	</div>
	
	<script>
	
	$(function(){ //이거 사용하려면 분야 value가 대인/대물 이어야 함.
		//상세페이지 변호사의 정보가 selected 되어있도록
		//변호사 selected 는 삭제해도 되도록 / 넘길때도 해당변호사 분야만 넘겨도 됨
		var $part = "<%=((Lawyer)request.getAttribute("l")).getRefPno() %>";
		var $lno = <%=((Lawyer)request.getAttribute("l")).getLawNo() %>;
		$("#part").val($part).prop("selected",true);
		$("#lawName").val($lno).prop("selected",true);
	});
	
	
	//분야 카테고리가 바뀌었을 경우
	function partChange(){
		if($("#part").val()=="전체"){
			$("#lawName").html(str);
		}else{
			$.ajax({
				url : "counselOption.la",
				data : {cateKey:$("#part").val()},
				type : "get",
				success : function(list){
					var str= "";
					if(list.length==0){
						str="<option>해당 분야의 변호사가 존재하지 않습니다.</option>"
					}else{ //해당 분야의 변호사만 option에 넣기
						for(var i=0; i<list.length; i++){
							
							str+= "<option value=\""+list[i].lawNo+"\">"
									+list[i].refUno+" 변호사</option>"
						}
					}
					$("#lawName").html(str);
				}
			});
		}
	};
	
	//변호사 이름을 선택했을때 분야 자동 selected 하기
	function lawChange(){
		
		$.ajax({
			url : "counselOption.la",
			data : {lawNameKey:$("#lawName").val()},
			type : "post",
			success : function(result){
				
				$("#part").val(result.partName).prop("selected",true);
				
			}
		});
	};
	
	
	</script>
</body>
</html>