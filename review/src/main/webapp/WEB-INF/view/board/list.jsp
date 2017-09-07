<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>

<div class="container">
	<h1>게시판</h1>
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
		
		<ul id="list-ul">
			<c:forEach items="${board}" var ="board">
				<li>
					<div class="row form-inline">
		 				<div class="form-group area-20" >
		            		<img src="${book[board.search_no].image }">
		              	</div>
		           		<div id="block">
		              		<a href="#" id="block">${book[board.search_no].author }</a>
		                   	<a href="#">${book[board.search_no].publisher }</a>
		                	<p>${board.detail }</p>
		              	</div>
	         		</div>
	        	</li>
	        	<hr/>
        	</c:forEach>
		</ul>
		
		<div class="align-right">
			<button type="button" class="btn " onclick="location.href='book-write'">글쓰기</button>
		</div>
		
		<div class="text-center">
     		<ul class="pagination  justify-content-center">
     			<c:if test="${startBlock>1}">
     				<li class="page-item"><a href="${pageContext.request.contextPath}+${url}&page=${startBlock-1}" class="page-link">&lt;이전&gt;</a></li>
				</c:if>
				<%-- 번호 출력 (startBlock ~ endBlock --%>
				<c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
					<c:choose>
						<c:when test="${i==pageNo}">
							${i}
						</c:when> 
						<c:otherwise>
							<li class="page-item"><a href="${url}&page=${i}" class="page-link">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${endBlock<blockTotal}">
					<li class="page-item"><a href="${url}&page=${endBlock+1}" class="page-link">[다음]</a></li>
				</c:if>
    		</ul>
    	</div>
	</div>
</div>

<script type="text/javascript" src="/js/bootstrap.js"></script>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
