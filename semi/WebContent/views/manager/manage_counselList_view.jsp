<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.bbbox.lawyer.model.vo.Counsel"%>
<%
	ArrayList<Counsel> cList = (ArrayList<Counsel>)request.getAttribute("cList");
%>
<%@ include file="manager_menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 영역잡기 */
    .wrap div{
        /* border: 1px solid black; */
        border: 0px;
        box-sizing: border-box;
    }
    .wrap{
        /* border: 1px solid black; */
        width: 1200px;
        height: 600px;
        margin: auto;
    }
    .wrap>div{
        width: 100%;
    }
    #head{
        height: 15%;
    }
    #content{
        height: 85%;
    }
    #content>div{
        height: 100%;
    }
    #lawList{
        width: 80%;
        overflow-y: scroll;
        margin: auto;
    }

    /* 대표 문구 */
    #head>p{
        text-align: center;
        font-size: 20px;
        font-weight: 900;
        line-height: 50px;
    }
    
    /* 변호사 나열 */
    #lawList table{
        width: 100%;
        text-align: center;
    }
    #List-title{
        background-color: rgb(223, 220, 220);
    }
    a{
        text-decoration: none;
        color: black;
        display: block;
    }

</style>
</head>
<body>
    <div class="wrap">
        <div id="head">
            <p>상담 관리 [관리자용]</p>
        </div>
        <div id="content">
            <div id="lawList" >
                <table>
                    <thead id="List-title">
                        <tr>
                            <td width="10">No.</td>
                            <td width="10">상담번호</td>
                            <td width="30">변호사</td>
                            <td width="30">회원ID</td>
                            <td width="50">상담제목</td>
                            <td width="50">상담내용</td>
                            <td width="40">작성날짜</td>
                            <td width="40">변호사답변</td>
                            <td width="40">상태값</td>
                            <td width="40">삭제</td>
                        </tr>
                    </thead>
                    <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
                    <%if(!cList.isEmpty()){ %>
                    <tbody id="apply-list">
                        <%for(int i= 0 ; i < cList.size(); i++){%>
                        <tr>
                            <td><%=i+1%><input type="hidden" name="csNo" value="<%=cList.get(i).getCsNo()%>"></td>
                            <td><%=cList.get(i).getCsNo()%></td>
                            <td><%=cList.get(i).getRefLno()%></td>
                            <td><%=cList.get(i).getCsWriter()%></td>
                            <td><%=cList.get(i).getCsTitle()%></td>
                            <td><%=cList.get(i).getCsContent()%></td>
                            <td><%=cList.get(i).getCreateDate()%></td>
                            <td><%=cList.get(i).getCsAnswer()%></td>
                            <% if(cList.get(i).getAccept().equals("W")){%>
			                	<% if(cList.get(i).getCsAnswer().equals("미등록")){%>
				                	<td><b style = "color : red ">답변 대기중</b></td>
				                <%}else{ %>
				               		<td><b style = "color : blue ">수락 대기중</b></td> 	
				                <%} %>
			                <%}else{ %>
			               		<td><b style = "color : green ">상담 종료</b></td> 	
			                <%} %>
                            <%if(cList.get(i).getStatus().equals("Y")){ %>
	                            <td width="40"><button id="deleteBtn">삭제</button></td>
                            <%} %>
                        </tr>
                        <%} %>
                     <%}else{ %>   
                    <!-- 찜한 변호사 리스트가 비어있다면  -->    
                           <tr>
                               <td></td>
                               <td colspan ="5">상담 리스트가 존재하지 않습니다.</td>
                           </tr>
                    </tbody>
                    <%} %>
                </table>
            </div>
        </div>
    </div>
    
    <script>
    	$("#apply-list ").on("click", "td", function(){ //상담신청 상세페이지로 이동시키는 함수
    		var csNo = $(this).parent().find("input").val();
    		location.href="<%=contextPath%>/counselDetail.la?cno="+csNo;
    	});
    	
    	$("#apply-list ").on("click", "#deleteBtn", function(){
    		//event.cancelBubble = true; /* 취소 눌렀을때 다시 리스트 보여주기 */
    		var csNo = $(this).parent().siblings().find("input").val();
    		
    		if(confirm("해당 상담글을 삭제하시겠습니까?")){
    			$.ajax({
        			url: "counselDelete.la",
        			data: {
        				cno : csNo
        			},
        			type: "post",
        			success : function(result){
        				if(result == "YY"){
        					alert("상담글 삭제를 성공했습니다.");
        					$("#apply-list").load(location.reload());
        				}else{
        					alert("상담글 삭제를 실패했습니다.");
        				}
        			}
        		});
    		}
    		
    	});
    	
    	
    </script>
</body>
</html>