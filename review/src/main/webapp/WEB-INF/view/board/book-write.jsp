<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div class="container">
<form name="nse" action="write" method="post">
	<div class="row">
		<h1>도서 게시판</h1>
	</div>
	<div class="row align-left">			
		<div class="cell area-20">카테고리</div>
		<div class="cell">
			<select class="user-input" id="margin" name="item_no">  
				<option>선택</option>
				<option value = "1">국내도서</option> 
				<option value = "2">해외도서</option> 
			</select> 
			<select class="user-input" id="right" name="header">  
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
	</div>
	<div class="row align-left">
		<div class="cell area-20">제목</div>
		<div class="cell fill align-left">
			<input type="text" name="title" class="user-input area-90">
		</div>
	</div>
	<div class="row align-left" id="search-wrapper">
		<div class="cell area-20" >책검색</div>
		<input  id="margin" class="user-input" type="text" placeholder="검색할 책 이름을 작성하세요">
		<input type="button" value="검색">
	</div>
	<div class="row align-left" id="search-wrapper">
		<div>
			<img src="http://placehold.it/120x120">
		</div>
		<div>
			<label>책제목</label>
			<label>지은이</label>
			<label>출판사</label>
			<label>평점주기</label>
		</div>
	</div>
 
	<textarea name="ir1" id="ir1" class="nse_content" ></textarea>
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
</div>      
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
