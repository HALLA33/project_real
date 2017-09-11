<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<script>
	$(document).ready(function(){
		$("#preview").on("click", function(){
				var msg = valid(form);
	
			if(msg!=null)
				alert(msg);
			else{
				var openWin = window.open("about:blank", "preview", "width=750, height=800");
				form.action="${pageContext.request.contextPath}/book-preview";
				form.target="preview"
				form.submit();
			}
		});
		
		$("#register").on("click", function(){
			var msg = valid(form);
			
			if(msg!=null)
				alert(msg);
			else{
				form.action="${pageContext.request.contextPath}/book-revise/${board.no}/${board.item_no}";
				form.submit();
			}
		});
	});
	
	function valid(form){
		var msg = null;
		var text = tagRemove(form.ir1.value);
		
		if(text=='')
			msg = "내용을 입력하세요";
		if(form.book_title.value=='')
			msg = "책을 검색하세요";
		if(form.title.value=='')
			msg = "제목을 입력하세요";
		if(form.head.value==0)
			msg = "장르를 선택하세요";
		if(form.item_no.value==0)
			msg = "카테고리를 선택하세요";
	
		return msg;
	}
	
	function tagRemove(text){
		var detail = text_replace(text);
			
		return detail;
			
		function text_replace(text){
			text = text.replace(/<br\/>/ig, "\n"); 
			text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
			return text;
		}
	}
	
</script>

<article>
<%-- 컨테이너 영역 --%>
<h3>도서 게시판</h3>
<form action="${pageContext.request.contextPath}/book-revise?no=${board.no}" method="post" name="form">
	<input type="hidden" name="writer" value="${sessionScope.member.id }">
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>카테고리</label>
		</div>
	   	<div class="form-group mx-sm-3">
	   		<select name="item_no" class="user-input" id="margin">
		   		<c:choose>
		   			<c:when test="${item_no==1}">
		   				 <option>선택</option>
						 <option value = "1" selected>국내도서</option>
						 <option value = "2">해외도서</option>       
					</c:when>
					<c:when test="${item_no==2}">
						<option>선택</option>
						<option value = "1">국내도서</option>
						<option value = "2" selected>해외도서</option>  
					</c:when>
				</c:choose>		
	   		</select> 
	    </div>
		<select name="head" class="user-input" id="right">  
			<option>장르</option>
			<c:choose>
				<c:when test="${board.head==1}">
					<option value = "1" selected>SF/판타지/무협</option>       
				</c:when>
				<c:when test="${board.head==2}">
					<option value = "2" selected>추리</option>  
				</c:when>
				<c:when test="${board.head==3}">
					<option value = "3" selected>로맨스</option> 
				</c:when>
				<c:when test="${board.head==4}">
					<option value = "4" selected>공포/스릴러</option>
				</c:when>
				<c:when test="${board.head==5}">
					<option value = "5" selected>역사</option> 
				</c:when>
				<c:when test="${board.head==6}">
					<option value = "6" selected>시/에세이</option> 
				</c:when>
				<c:when test="${board.head==7}">
					<option value = "7" selected>철학/종교</option> 
				</c:when>
				<c:when test="${board.head==8}">
					<option value = "8" selected>과학</option> 
				</c:when>
				<c:when test="${board.head==99}">
					<option value = "99" selected>기타</option> 
				</c:when>
			</c:choose>	
		  </select> 
	</div>
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>제목</label>
		</div>
		<div class="form-group mx-sm-3">
			<input type="text" name="title" class="user-input area-90" value="${board.title}">
		</div>
	</div>

	<div class="row form-inline">
		<div class="form-group area-20" >
			<label>책 검색</label>
		</div>
		<div class="form-group mx-sm-3">
			<input id="book_name" class="user-input margin" type="text" placeholder="검색할 책 이름을 작성하세요">
		</div>
		<!-- location.href='bookList/keyword='+${book_name} -->
		<input type="button" onclick="bookname()" value="검색">
			
		<script type="text/javascript">
			function bookname(){
				var book_name = $("#book_name").val();
	            var openWin = window.open("bookList?keyword="+book_name, "도서 찾기", "width=750, height=800");
			}
		</script>
	</div>

	<div class="row form-inline">
		<div class="form-group area-20" >
			<c:choose>
				<c:when test="${book.image==null }">
					<img id="image" src="http://placehold.it/120x120">
				</c:when>
				<c:otherwise>
					<img id="image" src="${book.image }">
				</c:otherwise>
			</c:choose>
		</div>
		<div style="padding-left: 10px">
			<h5 id="book_title" style="font-size: 15px; width: 500px" >${book.title }</h5>
			<h5 id="author" style="font-size: 15px">${book.author}</h5>
			<c:choose>
				<c:when test="${book.publisher==null  }">
					<h5 id="publisher" style="font-size: 15px">출판사</h5>
				</c:when>
				<c:otherwise>
					<h5 id="publisher" style="font-size: 15px">${book.publisher }</h5>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${book.pubdate==null  }">
					<h5 id="pubdate" style="font-size: 15px">출판일</h5>
				</c:when>
				<c:otherwise>
					<h5 id="pubdate" style="font-size: 15px">${book.pubdate }</h5>
				</c:otherwise>
			</c:choose>
		</div>   
	</div>

	<input type="hidden" class="book_title" name="book_title" value="${book.title }">
	<input type="hidden" class="image" name="image" value="${book.image }">
	<input type="hidden" class="author" name="author" value="${book.author }">
	<input type="hidden" class="publisher" name="publisher" value="${book.publisher }">
	<input type="hidden" class="pubdate" name="pubdate" value="${book.pubdate }">
   
	<textarea name="ir1" id="ir1" class="nse_content" style="width:100%; height:412px; min-width:610px; display:none;">${board.detail }</textarea>
	<script type="text/javascript">
   		var oEditors = [];
    	nhn.husky.EZCreator.createInIFrame({
	       	oAppRef: oEditors,
	       	elPlaceHolder: "ir1",
	       	sSkinURI: "/review_re/smarteditor/SmartEditor2Skin.html",
	       	fCreator: "createSEditor2"
       	});

    	function submitContents(elClickedObj) {
   			// 에디터의 내용이 textarea에 적용됩니다.
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
        	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다. 
        	try {
   				//elClickedObj.form.submit();
       		} catch(e) {}
    		}
    	
	</script>
	<div class="align-right">
		<input type="button" class="btn" style="margin: 10px" value="글쓰기" id="register" onclick="submitContents(this)" />
		<input type="button" class="btn" style="margin: 10px" value="미리보기" id="preview" onclick="submitContents(this)"/>		
		<input type="button" class="btn" style="margin: 10px" value="목록보기" onclick="location.href='list?item_no=${item_no}'"/>	
	</div>
	
</form>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
