<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<script>
   $(document).ready(function() {
      var nick = "${sessionScope.member.nickname }";
      var point = "${sessionScope.member.point}"
      $("#stamp").on("click", function() {
         $.ajax({
            url:"login_attendance",
//             url:"attend",
            type:"post",
            data:{
               "nick":nick, 
               "point" : point,
               "greetings":$("#greetings").val(),
            },
            success:function() {
               console.log(nick);
               console.log($("#greetings").val());
               location.reload();
               alert("출석완료!!");
            }
         });
      });   
      
      setInterval(getTime, 100);
      
      function getTime(){
          var date = new Date();
          var year = date.getFullYear();
          var month = date.getMonth()+1;
          var day = date.getDate();
          var ho = date.getHours();
          var min = date.getMinutes();
          var sec = date.getSeconds();
          var text = year+"년 "+month+"월 "+day+"일 "+ho+"시 "+min+"분 "+sec+"초";
          
          var target = document.querySelector("#target");
          target.innerHTML = text;
          
      }
      
   });
</script>
	
<article>
<%-- 컨테이너 영역 --%>
<div>
            <div>
                <ul>
                <li>출석부</li>
                </ul>
                <div id = "target" align = "center">
                </div>
                <table border="1" class="c-table" style="width: 700px !important; margin:0 auto;">
                    <tr>
                        <th>출석점수</th>
                        <th>??</th>
                        <th>개근점수</th>
                        <th>자세히보기(drop)</th>
                        <th>랭킹점수</th>
                        <th>자세히보기(drop)</th>
                        <th>출석권한</th>
                        <th>??</th>
                    </tr>
                    <tr>
                        <th>출석시간</th>
                        <th>00:00:00 ~ 24:00:00</th>
                        <th>진행상태</th>
                        <th>??</th>
                        <th>출석여부</th>
                        <th>??</th>
                        <th><a href="#">개근분류</a></th>
                        <th>
                            <div class="attend-menu-wrap">
                                <a href="#">자세히보기▼</a>
                                <ul>
                                    <li>
                                        <table>
                                            <tr>
                                                <td>개근분류</td>
                                            </tr>
                                            <tr>
                                                <td>주 月 年<br><font color="red">최근만 표시</font></td>
                                            </tr>
                                        </table>
                                    </li>
                                </ul>
                            </div>
                        </th>
                    </tr>
                </table>
                <div>
                </div>
                <c:if test="${sessionScope.member eq null}">
                   <div class="login-view">
                          로그인을 하지 않았습니다
                   </div>
                </c:if>
                <c:if test = "${sessionScope.member ne null }">
                	<c:if test = "${sessionScope.member.checkflag eq false }">
                	<div class="login-view">
                          오늘은 이미 출석하셨습니다
                   </div>
                	</c:if>
                	<c:if test = "${sessionScope.member.checkflag eq true }">
                   <div class="login-view">
                          출석도장 찍으세요&nbsp;<input type="text" id="greetings"><input type="button" value="출석" id="stamp">
                   </div>
                	</c:if>
                </c:if>
            </div>
            <table border="0" id="line">
                <tr>
                    <td>순위</td>
                    <td>출석시간</td>
                    <td style="width: 50%">인사말</td>
                    <td>별명</td>
                    <td>포인트</td>
                    <td>개근</td>
                    <td>총 출석일</td>
                </tr>
                <c:forEach var="list_a" items="${at_list}">
               <tr>
                  <td>${list_a.rank}</td>
                  <td>${list_a.reg_check}</td>
                  <td>${list_a.greetings}</td>
                  <td>${list_a.nick}</td>
                  <td>${list_a.point}</td>
                  <td>${list_a.opening}</td>
                  <td>${list_a.total_check}</td>
               </tr>
            </c:forEach>
            </table>
            <div class="row">
                 <div class="paging-wrap">
                     <div class="paging-unit"><a href="#">&lt;</a></div>
                     <div class="paging-unit active"><a href="#">1</a></div>
                     <div class="paging-unit"><a href="#">2</a></div>
                     <div class="paging-unit"><a href="#">3</a></div>
                     <div class="paging-unit"><a href="#">4</a></div>
                     <div class="paging-unit"><a href="#">5</a></div>
                     <div class="paging-unit"><a href="#">6</a></div>
                     <div class="paging-unit"><a href="#">7</a></div>
                     <div class="paging-unit"><a href="#">8</a></div>
                     <div class="paging-unit"><a href="#">9</a></div>
                     <div class="paging-unit"><a href="#">10</a></div>
                     <div class="paging-unit"><a href="#">&gt;</a></div>
                 </div>
             </div>
        </div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 