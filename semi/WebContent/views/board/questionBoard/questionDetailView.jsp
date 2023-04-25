<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="com.bbbox.qaboard.model.vo.Question"%>
<!DOCTYPE html>

<%
	Question qa = (Question)request.getAttribute("qa");

%>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 </title>
    <style>
	.outer{
        border: 1px solid black;
        width: 1200px;
        height: 600px;
        margin: auto;
    }
    #insertForm-area>.option{
        margin: auto;
        width: 80%;
        margin-bottom: 20px;
    }
    #insertForm-area>#submit-area{
    	text-align: center;
    }
    
    #insertForm-area>table * , #reply-form>table *{
    	margin: 10px;
    }
    </style>
</head>
<body>	
	<%@ include file = "../../common/mainMenu.jsp" %>
	<div class="outer">
		<h2 align="center" style="height:10%">1:1 문의</h2>
			<input type="hidden" name="userNo" value = <%=loginUser.getUserNo()%>>
			<br>
			<table align="center" border="1" style="width:80%; height:70%;">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style="width: 80%;" value ="<%=qa.getTitle()%>">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="30" name="content" style="resize:none; width:80%; height:100%;"><%=qa.getContent()%></textarea>
					</td>
				</tr>
			</table>
		
		<div id=but-area>
			<button>수정하기</button>
		</div>
			
		
		<%if(qa.getAnswer()!= null){ %>	
        <!-- 관리자만 작성 가능, 답변이 비어있지 않을 경우만 보여지게,  -->
        <form action="" id="reply-form">
            <table id="reply" align="center" border="1" style="width:80%; height:70%;">
                <tr>
                    <th>작성자</th>
                    <td colspan="2">내용</td>
                </tr>
                <tr>
                    <th>관리자</th>
                    <td>
                        <textarea name="reply-content" cols="30" rows="3" style="resize:none; width:90%; height:100%;"><%=qa.getAnswer()%></textarea>
                    </td>
                    <td>
                        <button style="width:30%; height: 80% ;"> 등록 </button>
                    </td>
                </tr>
            </table>
        </form>
        <%} %>
	</div>
</body>
</html>