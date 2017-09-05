<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>
<style>
.movie_ul{
	list-style: none; 
	margin: 0; 
	padding: 0;
}

.movie_ul > li{
	margin: 10 10 10 10;
	padding: 0 0 0 0;
	border: 0;
	float: left;
}
</style>
<script>
	$(document).ready(function() {
		$(".movie_ul > li").on("click", function() {
			console.log($(this).children().text());
		});
	});
</script>
<article>
<%-- 컨테이너 영역 --%>

<div class="container">
	<h1>영화 게시판</h1>
	<br>
	<div class="emtpy-wrap">
			<ul class="movie_ul">
				<li><a href="#">SF/판타지</a></li>
				<li><a href="#">드라마</a></li>
				<li><a href="#">전쟁/모험</a></li>
				<li><a href="#">미스터리/스릴러</a></li>
				<li><a href="#">애니메이션</a></li>
				<li><a href="#">코미디</a></li>
				<li><a href="#">액션/느와르</a></li>
				<li><a href="#">기타</a></li>
			</ul>
		</div>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>장르</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
                    
		</tbody>
	</table>
	<hr/>
	
	<div class="align-right">
		<button type="button" class="btn " onclick="location.href='movie-write'">글쓰기</button>
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

<script type="text/javascript" src="/js/bootstrap.js"></script>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
