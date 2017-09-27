<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<body>

<script> 
    window.onload = function(){
    	
    	var all = document.querySelector("#all");
		var unit = document.querySelectorAll(".unit");
		var item = $(".item");
		var writeno = [];
		var itemno = [];

		var allcheck= function () {
			$(all).change(function () {
				
				if(this.checked){
					writeno = [];
					itemno = [];
					for (var i = 0; i < unit.length; i++) {
						unit[i].checked = this.checked;
						writeno.push($(unit[i]).val());
						itemno.push($(item[i]).val());
						console.log(writeno);
						console.log(itemno);
					};
				}else if(!this.checked){
					for (var i = 0; i < unit.length; i++) {
						unit[i].checked = this.checked;
						writeno = [];
						itemno = [];
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
						itemno.splice(itemno.indexOf($(item[i]).val()), 1);
						console.log(writeno);
					}
				});
			};
		};
			
		var change= function () {
				$(unit).change(function() {
				
				if (this.checked) {
					writeno.push($(this).val());
					itemno.push($(this).siblings().val());
					console.log(writeno);
					console.log(itemno);
				} else if (!this.checked) {
					writeno.splice(writeno.indexOf($(this).val()), 1);
					itemno.splice(itemno.indexOf($(this).siblings().val()), 1);
					console.log(writeno);
					console.log(itemno);
				}
			});
		};
        
        $("#mydelete").on("click", function () {
        	jQuery.ajaxSettings.traditional = true;
        	
        	$.ajax({
        		
        		url:"mydelete",
        		type:"post",
        		data:{
        			"writeno" : writeno, "itemno" : itemno
        		},
        		success: function(){
        			alert("선택한 글을 삭제하였습니다");
        			location.reload();
        		}

        	});
        	
		});   
        allcheck();
		alldischeck();
		change();
        
        }
        
</script>
<article>

    <div class="empty-row"></div>
    
    <div style = "padding: 0px 100px 10px;">
        <small><a href="myboard">작성 게시글</a></small>&nbsp;&nbsp;
        <small><a href="mycomment">작성 댓글</a></small>&nbsp;&nbsp;
        <small><a href="#" id = "mydelete">선택한 글 삭제</a></small>
    </div>
    
    <div id="mywrite-wrap">
    
<table class = "table table-bordered mywrite" style="margin-left:0px;">
   
   <thead>
      <tr>
        <th id="check" width=10%><input type="checkbox" id="all"></th>
          <th>제목</th>
         <th width=10%>작성일</th>
         <th width=80px>조회수</th>
      </tr>
   </thead>
   
   <tbody>
   <c:forEach var = "list" items = "${lists}">
   		<tr>
   			<td id="check"><input type="checkbox" class="unit" value = "${list.no}">
   				<input type="hidden" class="item" value = "${list.item_no}">
   			</td>
   			<c:if test = "${list.item_no == 1 or list.item_no == 2}">
   			<td><a href="${pageContext.request.contextPath}/book-detail?no=${list.no}&item_no=${list.item_no}">${list.title}</a></td> 
   			</c:if>
   			<c:if test = "${list.item_no == 3 or list.item_no == 4}">
   			<td><a href="${pageContext.request.contextPath}/movie/movie-detail?no=${list.no}&item_no=${list.item_no}">${list.title}</a></td> 
   			</c:if>
   			<td>${list.reg}</td>
   			<td>${list.read}</td>
   		</tr>
   </c:forEach>
       
   </tbody>
   
</table>

</div>
</article>

</body>
<style>
    .empty-row{
        display: block;
        width:100%;
        height:50px;
    }
    .mywrite{
        width: 700px;
        margin-left: 100px;
    }
    #check{
        width: 10px;
    }
    .btn-group{
        margin-left: 10px;
        margin-bottom: 10px;
    }
</style>
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 