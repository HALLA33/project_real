<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<script>
	$(document).ready(function(){
		var text = '${board.detail}'
		var detail = text_replace(text);
		
		t_detail.innerText = detail;
		
		function text_replace(text){
			text = text.replace(/<br>/ig, "\n"); 
			text = text.replace(/&nbsp;/ig, " "); 
			return text;
		}
		
		$("#good").on("click", function(){
			var no = '${board.no}';
			var item_no = '${board.item_no}';
			var allData = {"no":no, "item_no":item_no};
			
			$.ajax({
		        type: "POST", 
		        url: "${pageContext.request.contextPath}/goodCount", 
		        data: allData,
		        success: //호출이 성공하면 호출되는 함수를 정의한다.
		        function(){ //값을 data변수로 받아서 처리한다.
		    		window.opener.location.reload();
		        }
		    });
		});
		
		$("#bad").on("click", function(){
			var no = '${board.no}';
			var item_no = '${board.item_no}';
			var allData = {"no":no, "item_no":item_no};
			
			$.ajax({
		        type: "POST", 
		        url: "${pageContext.request.contextPath}/badCount", 
		        data: allData,
		        success: //호출이 성공하면 호출되는 함수를 정의한다.
		        function(){ //값을 data변수로 받아서 처리한다.
		    		window.opener.location.reload();
		        }
		    });
		});

	});
</script>

<article>
<%-- 컨테이너 영역 --%>
<h3>상세보기</h3>
<h1>${board.no}</h1>
<div class="container">
	<table class="table table-bordered">
	 	<thead></thead>
		<tbody>
			<tr class="form-inline">
				<td class="area-20" style="border: none">제목</td>
				<td class="area-20" style="border: none">${board.title}</td>
			</tr>
			<tr class="form-inline">
				<td class="area-20" style="border: none">작성자</td>
				<td class="area-20" style="border: none">${nickname}</td>
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
	 			<td>조회수 : ${board.read }</td>
	 		</tr>
	 		<tr>
	 			<td>
	 				<div class="form-inline">
	 					<div class="align-left">                                                                            
	 						<img src="<c:url value="img/good.png"/>" 
	 							style="width:30px; height:30px; " >
	 					</div>
	 					<label style="font-size:20px; padding-right:20px">${board.good }개</label>
	 					
	 					<div class="align-left">                                                                            
	 						<img src="<c:url value="img/bad.png"/>" 
	 							style="width:30px; height:30px; " >
	 					</div>
	 					<label style="font-size:20px">${board.bad }개</label>
	 				</div>
	 			</td>
	 		</tr>
	 		<tr>
	 			<td>
	 				<div class="row form-inline">
	 					<div class="align-left">  
		 					<button id="good" style="background:white; border:none">
		 						<img src="<c:url value="img/good.png"/>" style="align:left">	
		 						<span>좋아요</span>
		 					</button>
		 				</div>
		 				<div class="align-left">  
		 					<button id="bad" style="background:white; border:none">
		 						<img src="<c:url value="img/bad.png"/>" >	
		 						<span>싫어요</span>
		 					</button>
		 				</div>
	 				</div>	
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
		<input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/book-write?item_no=${board.item_no }'" value="글쓰기">
		<input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/book-revise/${board.no }/${board.item_no }'" value="수정하기">
		<input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/book-delete/${board.no }/${board.item_no }'" value="삭제하기">
		<input type="button" class="btn" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/list?item_no=${board.item_no }';"/>
	</div>

</div>

</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
