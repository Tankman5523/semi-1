<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.member.model.vo.Member"%>
<%

	ArrayList <Member> applyLaw = (ArrayList<Member>)request.getAttribute("applyLaw");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>변호사회원 전환신청 관리 페이지</title>

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
	

	#apply-law{
        width: 1200px;
        box-sizing: border-box;
        margin : auto;
        margin-top: 20px;
    }
    
   #apply-law>h2{
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
    }	 
    #List{
        background-color: rgb(223, 220, 220);
    }
    
    
    a{
        text-decoration: none;
        display: block;
		color : white;        
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

<div id="content" style="overflow:auto;">
	<div id="apply-law">
	<h2 align="center">변호사회원 전환신청 관리</h2>
	<hr>
        <table>
            <thead id="List">
                <tr>
                    <th width="50">No.</th>
                    <th width="100">이름</th>
                    <th width="100">아이디</th>
                    <th width="100">가입일</th>
                    <th width="100">상태</th>
                </tr>
            </thead>
            <!-- 신청한 변호사 내역이 존재할 경우 -->
            <%if(!applyLaw.isEmpty()){ %>
            <tbody id="apply-list">
				<%for(int i= 0 ; i < applyLaw.size() ; i++){%>
	            <tr>
	                <td><%=i+1%></td>
	                <td><a href="<%=contextPath%>/detail.apply.me?uno=<%=applyLaw.get(i).getUserNo()%>"><%=applyLaw.get(i).getUserName()%></a></td>
	                <td><%=applyLaw.get(i).getUserId()%></td>
	                <td><%=applyLaw.get(i).getEnrollDate()%></td>
	                <%if(applyLaw.get(i).getLawyer().equals("W")){ %>
	                	<td style="color: green">대기중</td>
	                <%}else if(applyLaw.get(i).getLawyer().equals("Y")){ %>
	                	<td style="color: blue">승인</td>
	                <%}else{ %>
		                <td style="color: red">거절</td>
	                <%} %>	
	            </tr>
	            <%} %>
	         <%}else{ %>   
	       		<tr>
	       			<td></td>
	       			<td colspan ="5">신청 회원이 존재하지 않습니다.	</td>
	       		</tr>
            </tbody>
            <%} %>
        </table>
	</div>
</div>

<%@ include file = "../common/footer.jsp" %>
</body>
</html>