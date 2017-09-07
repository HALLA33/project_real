<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<script>
	$(document).ready(function(){
		var text = '${board.detail}'
		var detail = text_replace(text);
		
		t_detail.innerText = detail;
		
		function text_replace(text){
			text = text.replace(/<br\/>/ig, "\n"); 
			text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
			return text;
		}
		
	});
</script>

<article>
<%-- 컨테이너 영역 --%>
<c:choose>
	<c:when test="${mode eq 'write'}">
		<h3>상세보기</h3>		        
	</c:when>
	<c:when test="${mode eq 'preview'}">
		<h3>미리보기</h3>
	</c:when>
</c:choose>

<div class="container">
	<table class="table table-bordered">
	 	<thead></thead>
		<tbody>
			<tr class="form-inline">
				<td class="area-20" style="border: none">제목</td>
				<td class="area-20" style="border: none">${board.title}</td>
			</tr>
			<tr class="form-inline">
				<td class="area-20" style="border: none">${board.b_item_no }</td>
				<td style="border: none">${board.b_head }</td>
				<td style="border: none">${board.tag }</td>	
			</tr>			
			<tr>
				<td>
					<div class="row form-inline" style="border: 1px; margin:10px">
						<div class="form-group area-20" >
							<img id="image" src="${book.image }">
						</div>
						<div style="padding-left: 10px">
							<h5 style="font-size: 15px; width: 500px">${book.title }</h5>
							<h5 style="font-size: 15px">${book.author }</h5>
							<h5 style="font-size: 15px">${book.publisher }</h5>
							<h5 style="font-size: 15px">${book.pubdate }</h5>
						</div>   
					</div>
	    		</td>
	      	</tr>
	    	<tr>
	      		<td>
	      			<textarea id="t_detail" class="nse_content" style="width:100%; height:412px; min-width:610px;" readonly></textarea>
	      		</td>
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
		<c:choose>
		    <c:when test="${mode eq 'write'}">
		    	<input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/book-write'" value="글쓰기">	        
		    </c:when>
		    <c:when test="${mode eq 'preview'}">
		        <input type="button" class="btn" id="register" value="등록하기">
		        <input type="button" class="btn" id="revise" value="수정하기">
		    </c:when>
		</c:choose>
		<input type="button" class="btn" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/list';"/>	
	</div>
	<script>
		$('#register').on("click", function(){
			 var $form = $('<form></form>');
		     $form.attr('action', '${pageContext.request.contextPath}/book-write/write');
		     $form.attr('method', 'post');
		     $form.appendTo('body');
		     
		     form_hidden($form);
		});
		
		$('#revise').on("click", function(){
			 var $form = $('<form></form>');
		     $form.attr('action', '${pageContext.request.contextPath}/book-revise');
		     $form.attr('method', 'post');
		     $form.appendTo('body');
		     
		     form_hidden($form);
		});
		
		function form_hidden($form){
			//book
		     var image = $('<input type="hidden" value="${book.image}%" name="image">');
		     var book_title = $('<input type="hidden" value="${book.title}" name="book_title">');
		     var author = $('<input type="hidden" value="${book.author}" name="author">');
		     var publisher = $('<input type="hidden" value="${book.publisher}" name="publisher">');
		     var pubdate = $('<input type="hidden" value="${book.pubdate}" name="pubdate">');
		     
		     //board
		     var item_no = $('<input type="hidden" value="${board.item_no}" name="item_no">');
		     var head = $('<input type="hidden" value="${board.head}" name="head">');
		     var writer = $('<input type="hidden" value="${board.writer}" name="writer">');
		     var title = $('<input type="hidden" value="${board.title}" name="title">');
		     var detail = $('<input type="hidden" value="${board.detail}" name="ir1">');
		     
		     $form.append(image).append(book_title).append(author).append(publisher).append(pubdate).
		     				append(item_no).append(head).append(writer).append(title).append(detail);
	     	 $form.submit();
		}
	</script>
	
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
