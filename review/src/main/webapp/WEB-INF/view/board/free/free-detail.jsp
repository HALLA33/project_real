<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
	$(document).ready(function(){
		var detail = '${board.detail}';
		$("#detail").append(detail);
		
		var session = '${sessionScope.member.id}';
		replyCheck(session);
		
		$("#replyRegister").on("click", function(){
			var title = '${board.title}'
			var writer = '${sessionScope.member.id}';
			var detail = $("#reply").val();
			var board_no = '${board.no}';
			var board_item_no = '${board.item_no}';
			var gno = 0;
			var gseq = 0;
			var depth = 0;
			var allData = {"title" : title, "writer":writer, "detail":detail, "board_no":board_no, "board_item_no": board_item_no, 
									"gno":gno, "gseq":gseq, "depth":depth}
			$.ajax({
		        type: "POST", 
		        url: "${pageContext.request.contextPath}/reply/reply-insert", 
		        data: allData,
		        success: //호출이 성공하면 호출되는 함수를 정의한다.
		        function(result){ //값을 data변수로 받아서 처리한다.
					window.location.reload(true);
		        }
		    });
		});
	});
	
	function replyCheck(session){
		console.log(typeof session);
		console.log(session.length);
		if(session.length<=0){
			$("#reply").attr("placeholder", "댓글 작성하려면 로그인 하세요 ");
			$("#reply").attr("disabled", true);
			$("#replyRegister").attr("disabled", true);
		}
	}
	
	function responseClick(btn){
		var session = '${sessionScope.member.id}';
		if(session.length<=0)
			alert("로그인해 주세요");
		else{
			var button = btn.name;
			var flag = $("#"+button).css("display")
			
			if(flag=='none')
				$("#"+button).css("display", "block");
			else
				$("#"+button).css("display", "none");
		}
	}
	
	function response(btn){
		var btnId = btn.id;
		var textId = btnId.split("b");
		var text = textId[0]+"reply";
		var title = "${board.title}"
		var writer = '${sessionScope.member.id}';
		var detail = $("#"+text).val();
		var board_no = '${board.no}';
		var board_item_no = '${board.item_no}';
		var reply_no = textId[0];
		var allData = {"title" : title, "writer":writer, "detail":detail, "board_no":board_no, "board_item_no": board_item_no, 
								"reply_no":reply_no}
		console.log(title);
		$.ajax({
	        type: "POST", 
	        url: "${pageContext.request.contextPath}/reply/reply-response-insert", 
	        data: allData,
	        success: //호출이 성공하면 호출되는 함수를 정의한다.
	        function(result){ //값을 data변수로 받아서 처리한다.
				window.location.reload(true);
	        }
	    });
	}
	
	function replyDelete(btn){
		var btnId = btn.name;
		var deleteId = btnId.split("d");

		$.ajax({
	        type: "POST", 
	        url: "${pageContext.request.contextPath}/reply/reply-delete", 
	        data: {"no":deleteId[0]},
	        success: //호출이 성공하면 호출되는 함수를 정의한다.
	        function(result){ //값을 data변수로 받아서 처리한다.
	        	if(result)
					window.location.reload(true);
	        	else
	        		alert("작성자가 아닙니다.");
	        }
	    });
	}
	
</script>

<article>
<%-- 컨테이너 영역 --%>
<h3>상세보기</h3>
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
	    	<tr>
	      		<td>
	      			<div id="detail" style="height: auto; min-height: 200px; "></div>
	      		</td>
	 		</tr>
	 		<tr>
	 			<td>조회수 : ${board.read }</td>
	 		</tr>
	 		
	  		<c:forEach items="${listReply}" var ="reply">
	      		<tr>
	      			<td>
	      				<div class="row form-inline">
							<div class="form-group area-70" style="padding-left:10px" >
								<c:forEach var="i" begin="0" end="${reply.depth}">
			      					&nbsp;&nbsp;
			      				</c:forEach>
			      				<div class="align-left">
			      				<c:if test="${reply.depth > 0 }">
			      					<img src="${pageContext.request.contextPath}/img/reply.png" width="25" height="15">
			      				</c:if>
			      				</div>
			      				<label>${reply.detail }</label>
							</div>
							<div style="padding-left: 10px">
								<h5 style="font-size: 15px">${replyNickname[reply.no]}</h5>
								<h5 style="font-size: 15px">${reply.date }</h5>
								<input type="button" name="${reply.no }" onclick="responseClick(this)" value="답글달기" style="border:none; background:white">
		      					<c:if test="${sessionScope.member.id == reply.writer || sessionScope.member.power eq '관리자' || sessionScope.member.power eq '스탭'}">
		      						<input type="button" name="${reply.no }delete" onclick="replyDelete(this)" value="삭제하기" style="border:none; background:white">
		      					</c:if>
							</div>   
						</div>
	      			</td>
	      		</tr>
	      		<tr class="form-inline" id="${reply.no }" style="display:none">
			  		<td><!-- vertical-align:middle; -->
			 			<div class="row form-inline">
			 				<div class="align-left" style="padding-right:30px; padding-left:20px">  
				 				<textarea id="${reply.no }reply" rows="5" cols="50" required></textarea>​
				 			</div>
				 			<div class="align-left">  
				 				<input type="button" onclick="response(this)" id="${reply.no }btn" class="btn" style="height:100%; padding-botton:10px" value="등록">
				 			</div>
			 			</div>	
			 		</td>
	     		</tr>  
	      	</c:forEach>
	  		<tr class="form-inline">
		  		<td><!-- vertical-align:middle; -->
		 			<div class="row form-inline">
		 				<div class="align-left" style="padding-right:30px; padding-left:20px">  
			 				<textarea id="reply" name="reply" rows="5" cols="50" required></textarea>​
			 			</div>
			 			<div class="align-left">  
			 				<input type="button" class="btn" id="replyRegister" style="height:100%; padding-botton:10px" value="등록">
			 			</div>
		 			</div>	
		 		</td>
	     	</tr>  
		</tbody>
	</table>             
	<hr/>

	<div class="align-right">
		<input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/free/free-write?item_no=${board.item_no }&head=${board.head }'" value="글쓰기">
		<c:if test="${sessionScope.member.id == board.writer }">
			<input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/free/free-revise/${board.no }/${board.item_no }'" value="수정하기">
		</c:if>
		<c:if test="${sessionScope.member.power eq '관리자' || sessionScope.member.power eq '스탭' || nickname eq sessionScope.member.nickname}">
			<input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/free/free-delete/${board.no }/${board.item_no }'" value="삭제하기">
		</c:if>
		<input type="button" class="btn" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/list?item_no=${board.item_no }';"/>
	</div>

</div>

</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
