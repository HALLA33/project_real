<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<script>
function login(context, flag, no, item_no){
	var session = '${sessionScope.member.id}';
	if(session<=0)
		alert("로그인해주세요");
	else{
		switch(flag){
		case 1:
			$(context).attr("href", "${pageContext.request.contextPath}/book-detail?no="+no+"&item_no="+item_no+"");
			break;
		case 2:
			$(context).attr("href", "${pageContext.request.contextPath}/movie/movie-detail?no="+no+"&item_no="+item_no+"");
			break;
		case 5:
			$(context).attr("href", "${pageContext.request.contextPath}/etc/etc-detail?no="+no+"&item_no="+item_no+"");
			break;
		case 7:
			$(context).attr("href", "${pageContext.request.contextPath}/free/free-detail?no="+no+"&item_no="+item_no+"");
			break;
		}
	}
		
} 
</script>
<article>
<%-- 컨테이너 영역 --%>
 
<div class="container">
	<c:choose>
		<c:when test="${item_no eq 0 }"><h1>공지사항</h1></c:when>
		<c:when test="${item_no eq 1 }"><h1>국내 도서 게시판
			<c:choose>
				<c:when test="${head eq 1 }">&#40;SF/판타지/무협&#41;</c:when>
				<c:when test="${head eq 2 }">&#40;추리&#41;</c:when>
				<c:when test="${head eq 3 }">&#40;로맨스&#41;</c:when>
				<c:when test="${head eq 4 }">&#40;공포/스릴러&#41;</c:when>
				<c:when test="${head eq 5 }">&#40;역사&#41;</c:when>
				<c:when test="${head eq 6 }">&#40;시/에세이&#41;</c:when>
				<c:when test="${head eq 7 }">&#40;철학/종교&#41;</c:when>
				<c:when test="${head eq 8 }">&#40;과학&#41;</c:when>
				<c:when test="${head eq 99 }">&#40;기타&#41;</c:when>
			</c:choose>
		</h1></c:when>
		<c:when test="${item_no eq 2 }"><h1>해외 도서 게시판
			<c:choose>
				<c:when test="${head eq 1 }">&#40;SF/판타지/무협&#41;</c:when>
				<c:when test="${head eq 2 }">&#40;추리&#41;</c:when>
				<c:when test="${head eq 3 }">&#40;로맨스&#41;</c:when>
				<c:when test="${head eq 4 }">&#40;공포/스릴러&#41;</c:when>
				<c:when test="${head eq 5 }">&#40;역사&#41;</c:when>
				<c:when test="${head eq 6 }">&#40;시/에세이&#41;</c:when>
				<c:when test="${head eq 7 }">&#40;철학/종교&#41;</c:when>
				<c:when test="${head eq 8 }">&#40;과학&#41;</c:when>
				<c:when test="${head eq 99 }">&#40;기타&#41;</c:when>
			</c:choose>
		</h1></c:when>
		<c:when test="${item_no eq 3 }"><h1>국내 영화 게시판
			<c:choose>
				<c:when test="${head eq 101 }">&#40;SF/판타지&#41;</c:when>
				<c:when test="${head eq 102 }">&#40;드라마&#41;</c:when>
				<c:when test="${head eq 103 }">&#40;로맨스&#41;</c:when>
				<c:when test="${head eq 104 }">&#40;미스터리/스릴러&#41;</c:when>
				<c:when test="${head eq 105 }">&#40;애니메이션&#41;</c:when>
				<c:when test="${head eq 106 }">&#40;코미디&#41;</c:when>
				<c:when test="${head eq 107 }">&#40;액션/느와르&#41;</c:when>
				<c:when test="${head eq 199 }">&#40;기타&#41;</c:when>
			</c:choose>
		</h1></c:when>
		<c:when test="${item_no eq 4 }"><h1>해외 영화 게시판
		<c:choose>
				<c:when test="${head eq 101 }">&#40;SF/판타지&#41;</c:when>
				<c:when test="${head eq 102 }">&#40;드라마&#41;</c:when>
				<c:when test="${head eq 103 }">&#40;로맨스&#41;</c:when>
				<c:when test="${head eq 104 }">&#40;미스터리/스릴러&#41;</c:when>
				<c:when test="${head eq 105 }">&#40;애니메이션&#41;</c:when>
				<c:when test="${head eq 106 }">&#40;코미디&#41;</c:when>
				<c:when test="${head eq 107 }">&#40;액션/느와르&#41;</c:when>
				<c:when test="${head eq 199 }">&#40;기타&#41;</c:when>
			</c:choose>
			</h1></c:when>
		<c:when test="${item_no eq 5 or item_no eq 6}"><h1>기타 리뷰 게시판</h1></c:when>
		<c:when test="${item_no eq 7 }"><h1>자유 게시판</h1></c:when>
	</c:choose>
      
      <br>
      <div class="container">
      <ul class="nav nav-tabs" id="listSubtitle">
         <li class="nav-item" value="0">
            <a class="nav-link " href="${pageContext.request.contextPath}/list_read?item_no=${item_no}&head=${head}&alignVal=1&tag=${tag}" >최신순</a>
         </li>
         <li class="nav-item" value="1">
               <a class="nav-link active">조회수순</a>
             </li>            
        </ul>
      <br>
      <c:choose>
      	<c:when test="${item_no==5 or item_no==6 or item_no==7 }">
      		<table class="table table-hover">
      			<tr>
	      			<th>번호</th>
	      			<th>장르</th>
	      			<th>제목</th>
	      			<th>작성자</th>
	      			<th>작성일</th>
	      		</tr>
	      		<c:forEach items="${board}" var ="board">
	      			<tr>
	      				<td>${board.no }</td>
	      				<td>&#91;${board.b_item_no}&#93;</td>
	      				<td>
	      					<c:choose>
	      						<c:when test="${item_no==7 }">
	      							<a href="#" onclick="login(this, 7,${board.no}, ${board.item_no })">${board.title }</a>
	      						</c:when>
	      						<c:when test="${item_no==5 or item_no==6 }">
	      							<a href="#" onclick="login(this, 5,${board.no}, ${board.item_no })">${board.title }</a>
	      						</c:when>
	      					</c:choose>
						<span style="padding-left:15px">조회수 : ${board.read }개</span>
		                	<span><img src="${pageContext.request.contextPath}/img/good.png" width="20" height="20">${board.good }개</span>
		                	<span><img src="${pageContext.request.contextPath}/img/bad.png" width="20" height="20">${board.bad }개</span>
	      				</td>
	      				<td>${nickname[board.no]}</td>
	      				<td>${board.reg}</td>
	      			</tr>
	       		</c:forEach>
       		</table>
      	</c:when>
      	<c:otherwise>
      		<c:forEach items="${board}" var ="board">
      			<div class="row form-inline" style="height:90px" id="testing">
		            <div class="form-group area-20" style="border: 1px darkseagreen ;">
		            	<c:if test="${item_no==1 or item_no==2 }">
		                	<img style="width:80px; height:100px" src="${book[board.search_no].image }">
		                </c:if>
		                <c:if test="${item_no==3 or item_no==4 }">
		                	<img style="width:80px; height:100px" src="${movie[board.search_no].image }">
		                </c:if>
		              <c:if test="${item_no==8 or item_no == 9}">
		                	<c:if test = "${board.item_no == 1 or  board.item_no == 2}">
		                		<img style="width:80px; height:100px" src="${book[board.search_no].image }">
		                	</c:if>
		                	<c:if test = "${board.item_no == 3 or  board.item_no == 4}">
		                		<img style="width:80px; height:100px" src="${movie[board.search_no].image }">
		                	</c:if>
		                </c:if>
		             </div>
		             <div class="area-80"> 
				      <h5 style="font-size: 13px">${board.title}</h5>
		                <div>
		                	<c:if test="${item_no==1 or item_no==2 }">
		                		<a href="#" style="font-size: 13px; width:600px; margin-top:10px" onclick="login(this,1,${board.no}, ${board.item_no })">
		                			${book[board.search_no].title}
		                		</a>
		                	</c:if>
		                   <c:if test="${item_no==3 or item_no==4 }">
		                   		<a href="#" style="font-size: 13px; width:600px; margin-top:10px" onclick="login(this, 2,${board.no}, ${board.item_no })">
		                			${movie[board.search_no].title}
		                		</a>
		                	</c:if>
		                	<c:if test = "${item_no == 8 or item_no == 9}">
		                		<c:if test = "${board.item_no == 1 or board.item_no ==2 }">
		                			<a href="#" style="font-size: 13px; width:600px; margin-top:10px" onclick="login(this, 1,${board.no}, ${board.item_no })">
		                				${book[board.search_no].title}
		                			</a>
		                		</c:if>
		                		<c:if test = "${board.item_no == 3 or board.item_no ==4 }">
		                			<a href="#" style="font-size: 13px; width:600px; margin-top:10px" onclick="login(this, 2,${board.no}, ${board.item_no })">
		                				${movie[board.search_no].title}
		                			</a>
		                		</c:if>
		                	</c:if>
					
		                  </div>
		                  <div class="align-left">
		                      <h5 style="font-size: 13px">${nickname[board.no]}</h5>
		                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
		                     <h5 style="font-size: 13px">${board.reg}</h5>
		                  </div>
		                  <div id="detail"></div>
		                <h5 id="detail" style="font-size: 13px;">${board.detail}</h5>
		               <div class="align-left">
		                      <h5 style="font-size: 13px">${board.b_item_no}</h5>
		                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
		                     <h5 style="font-size: 13px">${board.b_head}</h5>
		                     <h5 style="padding-left:15px; font-size: 13px">조회수 : ${board.read }개</h5>
		                	  <h5 style="padding-left:10px;font-size: 13px"><img src="${pageContext.request.contextPath}/img/good.png" width="20" height="20">${board.good }개</h5>
		                	  <h5 style="padding-left:10px;font-size: 13px"><img src="${pageContext.request.contextPath}/img/bad.png" width="20" height="20">${board.bad }개</h5>
		                  </div>
		              </div>
		         </div>
		      <hr/>
		    </c:forEach>
      		</c:otherwise>
      </c:choose>
      
      <div class="align-right">
      <c:choose>
      <c:when test="${sessionScope.member.id == null}">
          <button type="button" class="btn " disabled>글쓰기</button>
      </c:when>
 	 <c:otherwise>
         <button type="button" class="btn " onclick="location.href='book-write?item_no=${item_no}&head=${head }'">글쓰기</button>
     </c:otherwise>      
      </c:choose>
      </div>
      
      <div class="text-center">
           <ul class="pagination  justify-content-center">
              <c:if test="${startBlock>1}">
                 <li class="page-item"><a href="${pageContext.request.contextPath}+${url}&page=${startBlock-1}&item_no=${item_no}" class="page-link">&lt;이전&gt;</a></li>
            </c:if>
            <%-- 번호 출력 (startBlock ~ endBlock --%>
            <c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
               <c:choose>
                  <c:when test="${i==pageNo}">
                     ${i}
                  </c:when> 
                  <c:otherwise>
                     <li class="page-item"><a href="${url}&page=${i}&item_no=${item_no}" class="page-link">${i}</a></li>
                  </c:otherwise>
               </c:choose>
            </c:forEach>
            <c:if test="${endBlock<blockTotal}">
               <li class="page-item"><a href="${url}&page=${endBlock+1}&item_no=${item_no}" class="page-link">[다음]</a></li>
            </c:if>
          </ul>
       </div>
   </div>
</div>

<script type="text/javascript" src="/js/bootstrap.js"></script>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
