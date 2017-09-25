<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<style>
#emotionSelector, #weatherSelector {
	 position:absolute;
	 display:none;
	 background-color:#b0c4de;
	 border:solid 2px #d0d0d0;
	 width:200px;
	 height:150px;
	 padding:10px;
}
</style>

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
		
		var item_no = '${item_no}';
		$("#item_no").val(item_no);
		
		var head = '${head}';
		$("#head").val(head);
		
		$("#preview").on("click", function(){
 			var msg = valid(form);
 			var text = tagRemove(form.ir1.value);

			if(msg!=null)
				alert(msg);
			else{
				window.open("", "preview", "width=750, height=800");
				form.action="book-preview";
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
				form.action="book-write";
				form.submit();
			}
		});
		
		//-- 버튼 클릭시 버튼을 클릭한 위치 근처에 레이어 생성 --//
		$("#icon").on("click", function(e) {
		 var divTop = e.clientY + 10; //상단 좌표
		 var divLeft = e.clientX + 10; //좌측 좌표
		 $('#emotionSelector').css({
		     "top": divTop
		     ,"left": divLeft
		     , "position": "absolute"
		 }).show();
		});
		
		//-- 버튼 클릭시 버튼을 클릭한 위치 근처에 레이어 생성 --//
		$("#weather").on("click", function(e) {
		 var divTop = e.clientY + 10; //상단 좌표
		 var divLeft = e.clientX + 10; //좌측 좌표
		 $('#weatherSelector').css({
		     "top": divTop
		     ,"left": divLeft
		     , "position": "absolute"
		 }).show();
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
		if(form.head.value==null)
			msg = "장르를 선택하세요";
		if(form.item_no.value==null)
			msg = "카테고리를 선택하세요";
		if(form.tag.value!=null){
			var number = 0;
		    var tags = form.tag.value.split( ',' );
		    for (var i in tags ) {
		   		number++;
		    }
		    if(number>5)
		    	console.log("태그는 5개까지 입력해주세요");
		}
		
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

	function emoClick(img){
		console.log(img.name);
		var emoLabel = document.querySelector("#emoLabel");
		var emotionSelector = document.querySelector("#emotionSelector");
		emoLabel.innerHTML = "<input type='hidden'  name='emotion' value='"+img.name+"'>"+img.name;
		emotionSelector.style.display = "none";
	}
	function weaClick(img){
		console.log(img.name);
		var weaLabel = document.querySelector("#weaLabel");
		var weatherSelector = document.querySelector("#weatherSelector");
		weaLabel.innerHTML = "<input type='hidden'  name='weather' value='"+img.name+"'>"+img.name;
		weatherSelector.style.display = "none";
	}
	function emoDel(){
		var emoLabel = document.querySelector("#emoLabel");
		emoLabel.innerHTML = "";
		emotionSelector.style.display = "none";
	}
	function weaDel(){
		var weaLabel = document.querySelector("#weaLabel");
		weaLabel.innerHTML = "";
		weatherSelector.style.display = "none";
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
			<select name="item_no" class="user-input" id="item_no" required>  
	        	<option value="-1" >선택</option>
	        	<option id="item_no_notice" value = "0">공지</option>
	      		<option value = "1">국내도서</option> 
	        	<option value = "2">해외도서</option> 
	   		</select> 
	    </div>
		<select name="head" class="user-input" id="head" required>  
			<option value="-1" >장르</option>
			<option id="head_notice" value = "0">공지</option>
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
		<div class="form-group area-20">
			<input type="button" name="icon" id="icon" value="감정 이모티콘 넣기">
		</div>
		<div class="form-group mx-sm-3">
			<input type="button"  name="weather" id="weather" value="날씨 이모티콘 넣기">
		</div>
	</div>
	<label id="emoLabel"></label>&nbsp;&nbsp;<label id=weaLabel></label>
	
	<!-- 감정 이모티콘 레이어  -->
	<div id="emotionSelector">
	        <div style="position:absolute;top:5px;right:5px">
	        <span onClick="javascript:document.getElementById('emotionSelector').style.display='none'" style="cursor:pointer;font-size:1.5em" title="닫기">X</span>
	        </div> 
	        <img class="icon" id="love" name="love" src="<c:url value="/img/icon_love.PNG"/>"  onclick="emoClick(this)" width="40" height="30">
	        <img class="icon" id="good" name="good" src="<c:url value="/img/icon_good.PNG"/>" onclick="emoClick(this)" width="40" height="30">
	        <img class="icon" id="sogood" name="sogood" src="<c:url value="/img/icon_sogood.PNG"/>" onclick="emoClick(this)" width="40" height="30"> <br>
	        <img class="icon" id="fighting" name="fighting" src="<c:url value="/img/icon_fighting.PNG"/>" onclick="emoClick(this)" width="40" height="30">
	        <img class="icon" id="angry" name="angry" src="<c:url value="/img/icon_angry.PNG"/>" onclick="emoClick(this)" width="40" height="30"> 
	        <img class="icon" id="bad" name="bad" src="<c:url value="/img/icon_bad.PNG"/>" onclick="emoClick(this)" width="40" height="30"> <br>
	        <img class="icon" id="shock" name="shock" src="<c:url value="/img/icon_shock.PNG"/>" onclick="emoClick(this)" width="40" height="30">
	        <img class="icon" id="sobad" name="sobad" src="<c:url value="/img/icon_sobad.PNG"/>" onclick="emoClick(this)" width="40" height="30">
	        <img class="icon" id="tired" name="tired" src="<c:url value="/img/icon_tired.PNG"/>" onclick="emoClick(this)" width="40" height="30">
	        <label style="margin-left: 0;" width="130" height="30" onclick="emoDel()">삭제하기</label>
	</div>
	<!-- //감정 이모티콘 레이어  -->
	
	<!-- 날씨 이모티콘 레이어  -->
	<div id="weatherSelector">
	        <div style="position:absolute;top:5px;right:5px">
	        <span onClick="javascript:document.getElementById('weatherSelector').style.display='none'" style="cursor:pointer;font-size:1.5em" title="닫기">X</span>
	        </div> 
	        <img class="icon" id="sunny" name="sunny" src="<c:url value="/img/sunny.PNG"/>"  onclick="weaClick(this)" width="40" height="30">
	        <img class="icon" id="sunny_cloudy" name="sunny_cloudy" src="<c:url value="/img/sunny_cloudy.PNG"/>" onclick="weaClick(this)" width="40" height="30">
	        <img class="icon" id="rainy" name="rainy" src="<c:url value="/img/rainy.PNG"/>" onclick="weaClick(this)" width="40" height="30"> <br>
	        <img class="icon" id="cloudy" name="cloudy" src="<c:url value="/img/cloudy.PNG"/>" onclick="weaClick(this)" width="40" height="30">
	        <img class="icon" id="night" name="night" src="<c:url value="/img/night.PNG"/>" onclick="weaClick(this)" width="40" height="30">
	        <img class="icon" id="heavy_rain" name="heavy_rain" src="<c:url value="/img/heavy_rain.PNG"/>" onclick="weaClick(this)" width="40" height="30"> <br>
	        <img class="icon" id="thunder" name="thunder" src="<c:url value="/img/thunder.PNG"/>" onclick="weaClick(this)" width="40" height="30">
	        <img class="icon" id="packed_weather" name="packed_weather" src="<c:url value="/img/packed_weather.PNG"/>" onclick="weaClick(this)" width="40" height="30">
	        <img class="icon" id="snowy" name="snowy" src="<c:url value="/img/snowy.PNG"/>" onclick="weaClick(this)" width="40" height="30">
	        <label style="margin-left: 0;" width="130" height="30" onclick="weaDel()">삭제하기</label>
	</div>
	<!-- //날씨 이모티콘 레이어  -->
	
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
	       	sSkinURI: "/review/smarteditors/SmartEditor2Skin.html",
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

	<div class="row form-inline">
		<div class="form-group area-10">
			<label>태그</label>
		</div>
		<input id="tag" type="text" name="tag" style="width:400px" placeholder="태그는 쉼표로 구분하며, 5개까지 입력할 수 있습니다">
	</div>
		
	<div class="align-right">
		<input type="button" class="btn" style="margin: 10px" value="글쓰기" id="register" onclick="submitContents(this)" />
		<input type="button" class="btn" style="margin: 10px" id="preview" value="미리보기" onclick="submitContents(this)"/>		
		<input type="button" class="btn" style="margin: 10px" value="목록보기" onclick="location.href='list?item_no=${item_no}'"/>	
	</div>
	
</form>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
