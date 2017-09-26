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
		}
		else{
			$("#item_no_notice").hide();
		}
		
		var item_no = '${board.item_no}';
		$("#item_no").val(item_no);
		
		$("#preview").on("click", function(){
			var msg = valid(form);
			var text = tagRemove(form.ir1.value);
	
			if(msg!=null)
				alert(msg);
			else{
				var openWin = window.open("about:blank", "preview", "width=750, height=800");
				form.action="${pageContext.request.contextPath}/free/free-preview";
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
				form.action="${pageContext.request.contextPath}/free/free-revise/${board.no}/${board.item_no}";
				form.submit();
			}
		});
		
	});
	
	function valid(form){
		var msg = null;
		var text = tagRemove(form.ir1.value, 1);
		
		if(text=='')
			msg = "내용을 입력하세요";
		if(form.title.value=='')
			msg = "제목을 입력하세요";
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
<h3>자유 게시판</h3>
<form action="${pageContext.request.contextPath}/free/free-revise?no=${board.no}" method="post" name="form">
	<input type="hidden" name="writer" value="${sessionScope.member.id }">
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>카테고리</label>
		</div>
	   	<div class="form-group mx-sm-3">
	   		<select name="item_no" id="item_no" class="user-input" id="item_no">
	   			<option value="-1">선택</option>
	   			<option id="item_no_notice" value = "0">공지</option>
	   			<option value = "1">국내도서</option>
	   			<option value = "2">해외도서</option>
				<option value = "3">국내영화</option>
				<option value = "4">해외영화</option> 
				<option value = "5">공연</option>  
				<option value = "6">기타</option>
				<option value = "7">자유게시판</option>
	   		</select> 
	    </div>
	    <input type="hidden" id="head" name="head" value="0">
	</div>
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>제목</label>
		</div>
		<div class="form-group mx-sm-3">
			<input type="text" name="title" class="user-input area-90" value="${board.title}">
		</div>
	</div>
   
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
	
	<div class="align-right">
		<input type="button" class="btn" style="margin: 10px" value="글쓰기" id="register" onclick="submitContents(this)" />
		<input type="button" class="btn" style="margin: 10px" value="미리보기" id="preview" onclick="submitContents(this)"/>		
		<input type="button" class="btn" style="margin: 10px" value="목록보기" onclick="location.href='list?item_no=${item_no}'"/>	
	</div>
	
</form>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
