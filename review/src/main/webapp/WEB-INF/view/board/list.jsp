<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>

<div class="container">
	<h1>영화 게시판</h1>
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
			<li>
				<div class="row form-inline">
 					<div class="form-group area-20" >
            			<img src="http://placehold.it/100x100">
              		</div>
           			<div id="block">
              			<a href="#" id="block">제목</a>
                   		<a href="#">지은이</a>
                		<p>내용</p>
              		</div>
         		</div>
        	</li>
		</ul>
		
		<div class="align-right">
			<button type="button" class="btn " onclick="location.href='book-write'">글쓰기</button>
		</div>
		
		<div class="text-center">
     		<ul class="pagination  justify-content-center">
   				<li class="page-item"><a class="page-link" href="#">1</a></li>
         		<li class="page-item"><a class="page-link" href="#">2</a></li>
           		<li class="page-item"><a class="page-link" href="#">3</a></li>
           		<li class="page-item"><a class="page-link" href="#">4</a></li>
         		<li class="page-item"><a class="page-link" href="#">5</a></li>
    		</ul>
    	</div>
	</div>
</div>

<script type="text/javascript" src="/js/bootstrap.js"></script>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
