<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<script>
	$(document).ready(function(){	
		var power = '${sessionScope.member.power}';
		if(power=='관리자'){
			$("#item_no_notice").show();
		}
		else{
			$("#item_no_notice").hide();
		}
		
		var item_no = '${item_no}';
		$("#item_no").val(item_no);
		
		$("#preview").on("click", function(){
 			var msg = valid(form);
 			var text = tagRemove(form.ir1.value);

			if(msg!=null)
				alert(msg);
			else{
				window.open("", "preview", "width=750, height=800");
				form.action="free-preview";
 				form.target="preview";
				form.submit();
			}
		});
		
		$("#register").on("click", function(){
			var msg = valid(form);
			var text = tagRemove(form.ir1.value);

			if(msg!=null)
				alert(msg);
			else{
				form.action="free-write";
				form.submit();
			}
		});
		
	});
	
	function valid(form){
		var msg = null;
		var text = tagRemove(form.ir1.value);
		
		if(text=='')
			msg = "내용을 입력하세요";
		if(form.title.value=='')
			msg = "제목을 입력하세요";
		if(form.item_no.value==null)
			msg = "카테고리를 선택하세요";
		
		return msg;
	}
	
	function tagRemove(text){
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
<form method="post" name="form">
	<input type="hidden" name="writer" value="${sessionScope.member.id }">
	<input type="hidden" name="head" value="0">
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>카테고리</label>
		</div>
	   	<div class="form-group mx-sm-3">
			<select name="item_no" class="user-input" id="item_no" required>  
	        	<option value="-1" >선택</option>
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
	</div>
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>제목</label>
		</div>
		<div class="form-group mx-sm-3">
			<input type="text" name="title" class="user-input area-90" required>
		</div>
	</div>
   
	<textarea name="ir1" id="ir1" class="nse_content" style="width:100%; height:412px; min-width:610px; display:none;" required></textarea>
	<script type="text/javascript">
   		var oEditors = [];
    	nhn.husky.EZCreator.createInIFrame({
	       	oAppRef: oEditors,
	       	elPlaceHolder: "ir1",
	       	sSkinURI: "/review_re/smarteditors/SmartEditor2Skin.html",
	       	bUseToolbar: true,
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
    	function pasteHTML(filename, width, height){
    		console.log(filename);
    		console.log(parseInt(width));
    		console.log(parseInt(height));
    		var sHTML;
    		
    		if(width>=500){
    			console.log("이상")
    			sHTML = '<img src="${pageContext.request.contextPath}/image/'+filename+'" style="width:700px">';
    		}
    		else{
    			console.log("이하")
    			sHTML = '<img src="${pageContext.request.contextPath}/image/'+filename+'">';
    		}
    	    oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
    	}
    	
	</script>
		
	<div class="align-right">
		<input type="button" class="btn" style="margin: 10px" value="글쓰기" id="register" onclick="submitContents(this)" />
		<input type="button" class="btn" style="margin: 10px" id="preview" value="미리보기" onclick="submitContents(this)"/>		
		<input type="button" class="btn" style="margin: 10px" value="목록보기" onclick="location.href='${pageContext.request.contextPath}list?item_no=${item_no}'"/>	
	</div>
	
	<input type="hidden" value="none" name="search_title">
	<input type="hidden" value="none" name="search_artist">
	
</form>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
