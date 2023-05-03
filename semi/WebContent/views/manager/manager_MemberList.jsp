<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.member.model.vo.Member" %>
<%
	ArrayList <Member> mList = (ArrayList<Member>)request.getAttribute("memberList");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원 관리</title>

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
	

	#member-list{
        width: 1200px;
        hegight : 800px
        box-sizing: border-box;
        margin : auto;
        margin-top: 20px;
    }
    
    #member-list>h2{
   		 font-family: 'SBAggroB';
   		 font-size : 30px;
   		 font-weight : 300;
   		 color: white;
   		 padding-top: 10px;
    }
    
    table{
    	width: 100%;
    	
    }
    
    table th{
    	font-family: 'Cafe24Ohsquare';
    	font-size: 18px;
    	height : 35px;
    }
    
    table td{
    	font-family: 'HallymGothic-Regular';
    	font-size: 15px;
    	text-align: center;
    	color : white; 
    	height : 30px;
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
	</style>
</head>
<body>

<%@ include file="manager_header.jsp" %>

<div id="content" style="overflow-y:scroll;">
	
	<div id="member-list">
	<h2 align="center">회원 관리</h2>
	<hr>
        <table>
            <thead id="List">
                <tr>
                    <th width="50">회원번호</th>
                    <th width="70">아이디</th>
                    <th width="70">이름</th>
                    <th width="70">회원 타입</th>
                    <th width="100">가입일</th>
                    <th width="50">회원 권한</th>
                    <th width="50">작성 게시글 수</th>
                    <th width="50">작성 댓글 수</th>
                </tr>
            </thead>
            <!-- 전체 회원 조회 -->
            <%if(!mList.isEmpty()){%>
            <tbody id="apply-list">
	          	<%for (Member m : mList){ %> 
	            <tr>
	                <td><%=m.getUserNo()%></td>
	                <td><%=m.getUserId() %></td>
	                <td><%=m.getUserName() %></td>
	               	<%if(m.getLawyer().equals("Y")){ %>
		                <td>변호사 회원</td>
	               	<%}else{ %>
	               		<td>일반 회원</td>
	               	<%} %>
	                <td><%=m.getEnrollDate()%></td>
	                <td><%=m.getStatus() %></td>
	                <td><%=m.getBoardCount()%></td>
	                <td><%=m.getReplyCount()%></td>
	            </tr>
				<%} %>	            
	       <%}else{ %>
	       		<!-- 회원이 없을 경우 -->
	       		<tr>
	       			<td></td>
	       			<td colspan ="8">조회된 회원이 없습니다.</td>
	       		</tr>
	       <%} %>
            </tbody>
        </table>
	</div>
</div>
	
<%@ include file="../common/footer.jsp" %>