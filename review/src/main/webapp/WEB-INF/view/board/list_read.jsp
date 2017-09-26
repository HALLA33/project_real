<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>

<div class="container">
   <h1>도서 게시판</h1>
   <br>
   <div class="container">
      <ul class="nav nav-tabs" id="listSubtitle">
         <li class="nav-item" value="0">
            <a class="nav-link" href="${pageContext.request.contextPath}/list?item_no=${item_no}&head=${head}&alignVal=0&tag=${tag}">최신순</a>
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
	      							<a href="<c:url value="free/free-detail?no=${board.no }&item_no=${board.item_no }" />">
			      						${board.title }
			      					</a>
	      						</c:when>
	      						<c:when test="${item_no==5 or item_no==6 }">
	      							<a href="<c:url value="etc/etc-detail?no=${board.no }&item_no=${board.item_no }" />">
			      						${board.title }
			      					</a>
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
		                <div style="padding-top:10px">
		                	<c:if test="${item_no==1 or item_no==2 }">
		                		<a href="<c:url value="book-detail?no=${board.no }&item_no=${board.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${book[board.search_no].title}</a>
		                	</c:if>
		                   <c:if test="${item_no==3 or item_no==4 }">
		                		<a href="<c:url value="/movie/movie-detail?no=${board.no }&item_no=${board.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${movie[board.search_no].title}</a>
		                	</c:if>
		                	<c:if test = "${item_no == 8 or item_no == 9}">
		                		<c:if test = "${board.item_no == 1 or board.item_no ==2 }">
		                			<a href="<c:url value="book-detail?no=${board.no }&item_no=${board.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${book[board.search_no].title}</a>
		                		</c:if>
		                		<c:if test = "${board.item_no == 3 or board.item_no ==4 }">
		                			<a href="<c:url value="/movie/movie-detail?no=${board.no }&item_no=${board.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${movie[board.search_no].title}</a>
		                		</c:if>
		                	</c:if>
					<span style="padding-left:15px">조회수 : ${board.read }개</span>
		                	<span><img src="${pageContext.request.contextPath}/img/good.png" width="20" height="20">${board.good }개</span>
		                	<span><img src="${pageContext.request.contextPath}/img/bad.png" width="20" height="20">${board.bad }개</span>
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
		                  </div>
		              </div>
		         </div>
		      <hr/>
		    </c:forEach>
      		</c:otherwise>
      </c:choose>
      
      <div class="align-right">
         <button type="button" class="btn " onclick="location.href='book-write?item_no=${item_no}'">글쓰기</button>
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
