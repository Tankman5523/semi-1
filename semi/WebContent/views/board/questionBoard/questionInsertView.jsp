<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 작성 페이지 </title>
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
		
		<form action="<%=contextPath%>/insert.qa" method="post" id="insertForm-area">
			<input type="hidden" name="userNo">
            <div class="option">
                <select name="open" id="open">
                    <option value="N">공개여부를 선택해 주세요</option>
                    <option value="Y">공개</option>
                    <option value="N">비공개</option>
                </select>
            </div>
			<table align="center" border="1" style="width:80%; height:70%;">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style="width: 80%;" required placeholder="제목을 입력해주세요.">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="30" name="content" style="resize:none; width:80%; height:100%;" required placeholder="내용을 입력하세요."></textarea>
					</td>
				</tr>
			</table>
			
			<div id="submit-area" style="border:none; padding:10px; height:10%;">
				<button type="submit">작성하기</button>
			</div>
		</form>
        
        <!-- 관리자에게만 보이는 여역 -->
        <form action="" id="reply-form">
            <table id="reply" align="center" border="1" style="width:80%; height:70%;">
                <tr>
                    <th>작성자</th>
                    <td colspan="2">내용</td>
                </tr>
                <tr>
                    <th>관리자</th>
                    <td>
                        <textarea name="reply-content" cols="30" rows="3" style="resize:none; width:90%; height:100%;"></textarea>
                    </td>
                    <td>
                        <button style="width:30%; height: 80% ;"> 등록 </button>
                    </td>
                </tr>
            </table>

        </form>
	</div>
</body>
</html>