<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
            <div id="footer">
                <!-- 푸터영역 -->
               <div style="text-align:center;"><br>@Copyright By 일석일조
            		<%if(loginUser!=null&&loginUser.getAdmin().equals("Y")){ %>
            			<%if(mode==1){ %>
                			<button onclick="location='<%=contextPath%>/views/manager/manager_header.jsp'" style="background-color:red; color:white;"><b>관리자 모드</b></button>
              	 		<%}else{ %>
              	 			<button onclick="location='<%=contextPath%>/views/common/mainPage.jsp'" style="background-color:blue; color:white;"><b>일반 모드</b></button>	
              	 		<%} %>
              	 	<%} %>
               </div>
            </div>
        </div>
        <div id="line"><img src="<%=contextPath%>/resources/common/menu-top.jpg" alt="" style="width: 100%; height: 100%;"></div>
    </div>
</body>
</html>