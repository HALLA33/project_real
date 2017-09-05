<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div class="container">
	<table class="table table-striped">
	 	<thead></thead>
		<tbody>
			<tr>
				<td>번호 제목 분류 장르 작성일</td>
			</tr>
			<tr>
				<td>작성자</td>
			</tr>
			<tr>
				<td>
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
	    		</td>
	      	</tr>
	    	<tr>
	      		<td>
	     			<p>내용</p>
				</td>
	 		</tr>
	  		<tr>
	   			<td>좋아요</td>
				<td>싫어요</td>
	 		</tr>
	  		<tr>
	     		<td>
	                            댓글 공간
	  			</td>
	     	</tr>  
		</tbody>
	</table>            
	<hr/>
	<div class="align-right">
		<button type="button" class="btn ">글쓰기</button>
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

</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
