<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../common/header.jsp" %>

<style>
   /* 폰트, 색상 */
    @font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	#content{
		text-align: center;
	}
    #title-area>p{
        color: rgb(255, 236, 173);
        font-size: 35px;
        font-weight: 900;
        line-height: 150px;
        font-family: 'Pretendard-Regular';
    }
	#content>img{
		border: 7px solid rgb(255, 236, 173);
	}
</style>

<div id="content">
    <div id="title-area">
        <p>소송가이드</p>
    </div>
	<img src="<%=contextPath%>/resources/common/guideImg.png" alt="" style="width: 60%; height: 70%;">
</div>

<%@ include file = "../common/footer.jsp" %>