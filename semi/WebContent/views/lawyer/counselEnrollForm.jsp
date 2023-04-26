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
<title>상담신청</title>
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
	                       <th width="100px">분야</th>
	                       <td width="400px">
	                           <select name="partKey" id="part" onchange="partChange();">
			                    	<option value="전체">전체</option>
			                    	<%for(PartCategory p : pList) { %>
			                    		<option value="<%=p.getPartName() %>"><%=p.getPartName() %></option>
			                    	<%} %>
			                    </select>
	                       </td>
	                   </tr>
	                   <tr>
	                       <th>변호사</th>
	                       <td>
	                           <select name="lawNameKey" id="lawName" onchange="lawChange();">
	                               <%for(Lawyer l : lawList) { %>
			                    		<option value="<%=l.getLawNo() %>"><%=l.getRefUno() %> 변호사</option>
			                    	<%} %>
	                           </select>
	                       </td>
	                   </tr>
	                   <tr>
	                       <th>제목</th>
	                       <td><input type="text" name="title" required></td>
	                   </tr>
	                   <tr>
	                       <th>내용</th>
	                       <td><textarea name="content" cols="50" rows="15" style="resize:none" required></textarea></td>
	                   </tr>
	               </table>
	               <div id="button">
	                   <button type="submit">신청하기</button>
	                   <button onclick="history.back()">취소</button>
	               </div>
	           </form>
	       </div>
	   </div>
	</div>
	
	<script>
	//해당 변호사의 분야/이름 이 선택되어 있도록 하는 함수
	// ((Lawyer)request.getAttribute("l")) %> 가 null이 아닌 경우로 해서 거부된 상담내역에서 내용들고 바로 상담신청으로 갈 수 있도록 ? update로 가야하나..
	$(function(){
		var $part = "<%=((Lawyer)request.getAttribute("l")).getRefPno() %>";
		var $lno = <%=((Lawyer)request.getAttribute("l")).getLawNo() %>; 
		$("#part").val($part).prop("selected",true);
		$("#lawName").val($lno).prop("selected",true);
	});
	
	//분야 옵션을 바꿨을 경우
	function partChange(){
		$.ajax({
			url : "counselOption.la",
			data : {partKey:$("#part").val()},
			type : "get",
			success : function(list){
				var str= "";
				if(list.length==0){ //해당 분야의 변호사가 없으면
					str="<option>해당 분야의 변호사가 존재하지 않습니다.</option>"
				}else{ //있으면 해당 분야의 변호사만 옵션에 넣기
					for(var i=0; i<list.length; i++){
						str+= "<option value=\""+list[i].lawNo+"\">"
								+list[i].refUno+" 변호사</option>"
					}
				}
				$("#lawName").html(str);
			}
		});
	};
	
	//변호사 옵션을 바꿨을 경우 해당분야 selected 되도록
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