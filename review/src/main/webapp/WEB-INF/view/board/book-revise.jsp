<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	$(document).ready(function(){
		var power = '${sessionScope.member.power}';
		if(power=='관리자'){
			$("#item_no_notice").show();
			$("#head_notice").show();
		}
		else{
			$("#item_no_notice").hide();
			$("#head_notice").hide();
		}
		
		var head = '${board.head}';
		$("#head").val(head);
		
		$("#preview").on("click", function(){
			var msg = valid(form);
			var text = tagRemove(form.ir1.value);
	
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
			var text = tagRemove(form.ir1.value);
			
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
		var text = tagRemove(form.ir1.value, 1);
		
		if(text=='')
			msg = "내용을 입력하세요";
		if(form.book_title.value=='')
			msg = "책을 검색하세요";
		if(form.title.value=='')
			msg = "제목을 입력하세요";
		if(form.head.value==-1)
			msg = "장르를 선택하세요";
		if(form.item_no.value==-1)
			msg = "카테고리를 선택하세요";

		return msg;
	}
	
	function tagRemove(text, flag){
		var detail = text_replace(text);
		
		return detail;
			
		function text_replace(text){
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
	   			<option value="-1">선택</option>
	   			<option id="item_no_notice" value = "0">공지</option>
				<option value = "1">국내도서</option>
				<option value = "2" selected>해외도서</option>  
	   		</select> 
	    </div>
		<select name="head" id="head" class="user-input" id="right">  
			<option value="-1">장르</option>
			<option id="head_notice" value = "0">공지</option>
			<option value = "1" >SF/판타지/무협</option>  
			<option value = "2" >추리</option>  
			<option value = "3" >로맨스</option> 
			<option value = "4" >공포/스릴러</option>
			<option value = "5" >역사</option>
			<option value = "6" >시/에세이</option> 
			<option value = "7" >철학/종교</option>
			<option value = "8" >과학</option> 
			<option value = "99" >기타</option> 
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
	       	sSkinURI: "/review_re/smarteditors/SmartEditor2Skin.html",
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
		
	// textArea에 이미지 첨부
    	function pasteHTML(filename){
    		console.log(filename);
    		
    		var sHTML = '<img src="${pageContext.request.contextPath}/image/'+filename+'">';
    	    oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
    	}
    	
	</script>
	
	<div class="row form-inline">
		<div class="form-group area-10">
			<label>태그</label>
		</div>
		<input id="tag" type="text" name="tag" style="width:400px" placeholder="태그는 쉼표로 구분하며, 5개까지 입력할 수 있습니다" value="${board.tag }">
	</div>
	
	<div class="align-right">
		<input type="button" class="btn" style="margin: 10px" value="글쓰기" id="register" onclick="submitContents(this)" />
		<input type="button" class="btn" style="margin: 10px" value="미리보기" id="preview" onclick="submitContents(this)"/>		
		<input type="button" class="btn" style="margin: 10px" value="목록보기" onclick="location.href='list?item_no=${item_no}'"/>	
	</div>
	
</form>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
