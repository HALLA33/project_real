<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<article>
<%-- 컨테이너 영역 --%>
<form name="nse" action="#" method="post">
	<div class="row">
		<h1>자유 게시판</h1>
	</div>
	<div class="row align-left">
		<div class="cell area-20">제목</div>
		<div class="cell fill align-left">
			<input type="text" name="title" class="user-input area-90">
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
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
