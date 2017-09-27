<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/template/header.jsp" %>  
<article>
<script>
window.onload = function(){
	
	var all = document.querySelector("#all");
	var unit = document.querySelectorAll(".unit");
	var item = $(".item");
	var writeno = [];

	var allcheck= function () {
		$(all).change(function () {
			
			if(this.checked){
				writeno = [];
				for (var i = 0; i < unit.length; i++) {
					unit[i].checked = this.checked;
					writeno.push($(unit[i]).val());
					console.log(writeno);
				};
			}else if(!this.checked){
				for (var i = 0; i < unit.length; i++) {
					unit[i].checked = this.checked;
					writeno = [];
					console.log(writeno);
				}
			}
		});	
	};
	
	
	//하나라도 해제되면 '전체선택' 체크박스 해제
	
	var alldischeck= function () {
		for (var i = 0; i < unit.length; i++) {
			unit[i].addEventListener("click", function() {
				if (!this.checked) {
					all.checked = false;
					writeno.splice(writeno.indexOf($(unit[i]).val()), 1);
					console.log(writeno);
				}
			});
		};
	};
		
	var change= function () {
			$(unit).change(function() {
			
			if (this.checked) {
				writeno.push($(this).val());
				console.log(writeno);
			} else if (!this.checked) {
				writeno.splice(writeno.indexOf($(this).val()), 1);
				console.log(writeno);
			}
		});
	};
    
    $("#mydelete").on("click", function () {
    	jQuery.ajaxSettings.traditional = true;
    	
    	$.ajax({
    		
    		url:"mycodelete",
    		type:"post",
    		data:{
    			"writeno" : writeno
    		},
    		success: function(){
    			alert("선택한 댓글을 삭제하였습니다");
    			location.reload();
    		}

    	});
    	
	});   
    allcheck();
	alldischeck();
	change();
    
    }
</script>
<div class="empty-row"></div>
    
    <div style = "padding: 0px 100px 10px;">
        <small><a href="myboard">작성 게시글</a></small>&nbsp;&nbsp;
        <small><a href="mycomment">작성 댓글</a></small>&nbsp;&nbsp;
        <small><a href="#" id = "mydelete">선택한 글 삭제</a></small>
    </div>

<div id="mywrite-wrap">

	<div align = "center">
		<button class="btn btn-primary modify" onclick = "location.href = 'mycomment?mode=new'">최신순</button>
		<button class="btn btn-primary modify" onclick = "location.href = 'mycomment?mode=old'">과거순</button>
	</div>

<table class = "table table-bordered mywrite" style="margin-left:0px;">
   
   <thead>
      <tr>
        <th id="check" width=10%><input type="checkbox" id="all"></th>
        <th>제목</th>
          <th>댓글</th>
         <th width=10%>작성일</th>
      </tr>
   </thead>
   
   <tbody>
   <c:forEach items="${m_co}" var="m_co">
   		<tr>
   			<td id="check"><input type="checkbox" class="unit" value = "${m_co.no}"></td>
   			<c:if test = "${m_co.board_item_no ==1 or m_co.board_item_no == 2}">
   			<td><a href = "${pageContext.request.contextPath}/book-detail?no=${m_co.board_no}&item_no=${m_co.board_item_no}">${m_co.title }</a></td>
   			</c:if>
   			<c:if test = "${m_co.board_item_no ==3 or m_co.board_item_no == 4}">
   			<td><a href = "${pageContext.request.contextPath}/movie/movie-detail?no=${m_co.board_no}&item_no=${m_co.board_item_no}">${m_co.title }</a></td>
   			</c:if>
   			<td>${m_co.detail}</td>
   			<td>${m_co.reg}</td>
   		</tr>
   </c:forEach>
       
   </tbody>
   
</table>
</div>
</article>
</body>
</html>
<%@ include file="/WEB-INF/view/template/footer.jsp" %>  