<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<form name="nse" action="#" method="post">
	<div class="row">
		<h1>영화 게시판</h1>
	</div>
	<div class="row align-left">			
		<div class="cell area-20">카테고리</div>
		<div class="cell">
  			<select class="user-input" id="margin" name="item_no">  
				<option>선택</option>
				<option value = "1">국내영화</option> 
	   			<option value = "2">해외영화</option> 
			</select> 
			<select class="user-input" id="right" name="header">  
				<option>장르</option>
      			<option value = "101">SF/판타지</option> 
          		<option value = "102">드라마</option> 
       			<option value = "103">전쟁/모험</option> 
         		<option value = "104">미스터리/스릴러</option> 
            	<option value = "105">애니메이션</option> 
              	<option value = "106">코미디</option> 
              	<option value = "107">액션/느와르</option> 
             	<option value = "199">기타</option> 
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
		<div class="cell area-20" >영화검색</div>
		<input  id="margin" class="user-input" type="text" placeholder="검색할 영화 제목을 작성하세요">
		<input type="button" value="검색">
	</div>
	<div class="row align-left" id="search-wrapper">
		<div>
			<img src="http://placehold.it/120x120">
		</div>
		<div>
			<label>영화 제목</label>
			<label>감독</label>
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
	
		<div id="tag">
			<input type="text" name="tag" placeholder="태그"> 쉼표로 구분
		</div>
	
	<input type="hidden" name="writer" value="${session.nickname}">
	<input type="checkbox" name="notice" value="true">공지로 등록
	<input type="submit" value="작성완료" onclick="submitContents(this)" />
</form>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
