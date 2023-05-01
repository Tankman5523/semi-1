<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 수정 페이지 </title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <style>
    
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
	
	.outer{
        border: 1px solid white;
        background-color : white;
        width: 1200px;
        height: 600px;
        margin: auto;
        padding-top: 50px;
        
    }
    
    .outer>h2{
    	
    	padding-top:30px;
    	font-family: 'SBAggroB';
    	
    }
    
    .outer table{
    	border : 1px solid black;
    	width : 900px
    }
    
    #insertqa th{
    	font-family: 'Cafe24Ohsquare';
    	width: 120px;
    	text-align: center;
    }
    
    #insertqa td{
    	font-family: 'HallymGothic-Regular';
    	
    }
    
  	#option{
        margin: auto;
        width: 80%;
        margin-bottom: 20px;
    }
    #insertqa>#submit-area{
    	text-align: center;
    }
    
    #updateForm>table * , #reply-form>table *{
    	margin: 10px;
    }
    </style>
    
<%@ include file = "../../common/header.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<div id="content">
	<div class="outer">
		<h2 align="center" style="height:10%">1:1 문의</h2>
		<form action="<%=contextPath%>/insert.qa" method="post" id="insertqa">
			<input type="hidden" name="userNo">
            <div id="option" class="option">
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
						<input type="text" name="title" style="width: 100%;" required placeholder="제목을 입력해주세요.">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="30" name="content" style="resize:none; width:100%; height:100%;" required placeholder="내용을 입력하세요."></textarea>
					</td>
				</tr>
			</table>
			
			<div id="submit-area" style="border:none; padding:10px; height:10%;">
				<button class = "btn btn-primary" type="submit">작성하기</button>
			</div>
		</form>
        
	</div>
</div>
<%@ include file = "../../common/footer.jsp" %>
