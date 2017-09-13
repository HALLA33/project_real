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
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link active" href="#">전체</a>
			</li>
			<li class="nav-item">
      			<a class="nav-link " href="#">새로운 글</a>
          	</li>
         	<li class="nav-item">
         		<a class="nav-link" href="#">많이 본 글</a>
      		</li>             
  		</ul>
		<br>
		
		<c:forEach items="${board}" var ="board">
			<div class="row form-inline" style="height:90px">
				<div class="form-group area-20" style="border: 1px darkseagreen ;">
		 			<img style="width:80px; height:100px" src="${book[board.search_no].image }">
		    	</div>
		 		<div class="area-80"> 
		 			<div style="padding-top:10px">
		 				<a href="<c:url value="book-detail?no=${board.no }&item_no=${board.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${book[board.search_no].title}</a>
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
