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
				form.action="book-preview";
				form.target="preview"
				form.submit();
			}
		});
		
		$("#register").on("click", function(){
			var msg = valid(form);
			
			if(msg!=null)
				alert(msg);
			else{
				form.action="book-write";
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
<form method="post" name="form">
	<input type="hidden" name="writer" value="${sessionScope.member.id }">
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>카테고리</label>
		</div>
	   	<div class="form-group mx-sm-3">
			<select name="item_no" class="user-input" id="margin" required>  
	        	<option value = "0">선택</option>
	      		<option value = "1">국내도서</option> 
	        	<option value = "2">해외도서</option> 
	   		</select> 
	    </div>
		<select name="head" class="user-input" id="right" required>  
			<option value = "0">장르</option>
		   	<option value = "1">SF/판타지/무협</option> 
		    <option value = "2">추리</option> 
		    <option value = "3">로맨스</option> 
		    <option value = "4">공포/스릴러</option> 
		    <option value = "5">역사</option> 
		   	<option value = "6">시/에세이</option> 
		    <option value = "7">철학/종교</option> 
		    <option value = "8">과학</option> 
		    <option value = "99">기타</option> 
		  </select> 
	</div>
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>제목</label>
		</div>
		<div class="form-group mx-sm-3">
			<input type="text" name="title" class="user-input area-90" required>
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
			<img id="image" src="http://placehold.it/120x120">
		</div>
		<div style="padding-left: 10px">
			<h5 id="book_title" style="font-size: 15px; width:500px">책제목</h5>
			<h5 id="author" style="font-size: 15px">저자</h5>
			<h5 id="publisher" style="font-size: 15px">출판사</h5>
			<h5 id="pubdate" style="font-size: 15px">출판일</h5>
		</div>   
	</div>

	<input type="hidden" class="book_title" name="book_title">
	<input type="hidden" class="image" name="image">
	<input type="hidden" class="author" name="author">
	<input type="hidden" class="publisher" name="publisher">
	<input type="hidden" class="pubdate" name="pubdate">
   
	<textarea name="ir1" id="ir1" class="nse_content" style="width:100%; height:412px; min-width:610px; display:none;" required></textarea>
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
