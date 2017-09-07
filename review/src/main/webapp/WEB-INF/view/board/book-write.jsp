<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<h3>도서 게시판</h3>
<form action="<c:url value="book-write" />" method="post">
	<input type="hidden" name="writer" value="${sessionScope.member.nickname }">
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>카테고리</label>
		</div>
	   	<div class="form-group mx-sm-3">
			<select name="item_no" class="user-input" id="margin">  
	        	<option>선택</option>
	      		<option value = "1">국내도서</option> 
	        	<option value = "2">해외도서</option> 
	   		</select> 
	    </div>
		<select name="head" class="user-input" id="right">  
			<option>장르</option>
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
			<input type="text" name="title" class="user-input area-90">
		</div>
	</div>

	<div class="row form-inline">
		<div class="form-group area-20" >
			<label>책 검색</label>
		</div>
			<div class="form-group mx-sm-3">
				<input id="book_name" class="user-input margin" type="text" value="${name}" placeholder="검색할 책 이름을 작성하세요">
			</div>
			<!-- location.href='bookList/keyword='+${book_name} -->
			<input type="button" onclick="bookname()" value="검색">
			
			<script type="text/javascript">
				function bookname(){
					var book_name = document.getElementById("book_name").value;
	                var openWin = window.open("bookList?keyword="+book_name, "도서 찾기", "width=750, height=800");
				}
			</script>
	</div>

	<div class="row form-inline">
		<div class="form-group area-20" >
			<img id="p_image" src="${search_book.image}">
		</div>
		<div style="padding-left: 10px">
			<h5  style="font-size: 15px">${search_book.title }</h5>
			<h5  style="font-size: 15px">${search_book.author }</h5>
			<h5  style="font-size: 15px">${search_book.publisher }</h5>
			<h5  style="font-size: 15px">${search_book.pubdate }</h5>
		</div>   
	</div>
   <input type="hidden" name="p_image" value="${search_book.image}">
   <input type="hidden" name="p_title" value="${search_book.title }">
   <input type="hidden" name="p_author" value="${search_book.author }">
   <input type="hidden" name="p_publisher" value="${search_book.publisher }">
   <input type="hidden" name="p_pubdate" value="${search_book.pubdate }">
   
	<textarea name="ir1" id="ir1" class="nse_content" style="width:100%; height:412px; min-width:610px; display:none;"></textarea>
	<script type="text/javascript">
   		var oEditors = [];
    	nhn.husky.EZCreator.createInIFrame({
	       	oAppRef: oEditors,
	       	elPlaceHolder: "ir1",
	       	sSkinURI: "/review/smarteditor/SmartEditor2Skin.html",
	       	fCreator: "createSEditor2"
       	});

    	function submitContents(elClickedObj) {
   			// 에디터의 내용이 textarea에 적용됩니다.
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
        	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다. 
  			try {
   				elClickedObj.form.submit();
       		} catch(e) {}
    		}
	</script>
	<input type="submit" value="전송" onclick="submitContents(this)" />
</form>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
