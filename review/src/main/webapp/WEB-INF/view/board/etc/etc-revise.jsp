<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		}
		else{
			$("#item_no_notice").hide();
		}
		
		var icon = '${board.emotion}'
		var weather = '${board.weather}'
		iconSetting(icon, weather);
			
		var item_no = '${board.item_no}';
		$("#item_no").val(item_no);
		
		$("#preview").on("click", function(){
			var msg = valid(form);
			var text = tagRemove(form.ir1.value);
	
			if(msg!=null)
				alert(msg);
			else{
				var openWin = window.open("about:blank", "preview", "width=750, height=800");
				form.action="${pageContext.request.contextPath}/etc/etc-preview";
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
				form.action="${pageContext.request.contextPath}/etc/etc-revise/${board.no}/${board.item_no}";
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
		var text = tagRemove(form.ir1.value, 1);
		
		if(text=='')
			msg = "내용을 입력하세요";
		if(form.title.value=='')
			msg = "제목을 입력하세요";
		if(form.item_no.value==-1)
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
	
	function tagRemove(text, flag){
		var detail = text_replace(text);
		
		return detail;
			
		function text_replace(text){
			text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");

			return text;
		}
		
	}
	
	function iconSetting(icon, weather){
		if(icon!='없음'){
			$("#emoLabel").css("display", "block");
		    $("#emoDiv").css("border", "1px solid #b0c4de");
		    $("#emoDiv").css("border-radius", "10px")
		    $("#emoDiv").css("margin-bottom", "10px")
		    $("#emoLabel").css("padding-left", "30px")
		    var extention = "icon_" + icon + ".PNG";
		    var imgTag = '<img src="${pageContext.request.contextPath}/img/'+extention+'" style="width:40px; height:40px">'; 
			emoLabel.innerHTML = "<input type='hidden'  name='emotion' value='"+icon+"'>"+ imgTag;
		}
		if(weather!='없음'){
			$("#weaLabel").css("display", "block");
			$("#weaDiv").css("border", "1px solid #b0c4de");
			$("#weaDiv").css("border-radius", "10px")
			$("#weaDiv").css("margin-bottom", "10px")
			$("#weaDiv").css("margin-left", "10px")
			$("#weaLabel").css("padding-left", "30px")
			var extention = weather + ".PNG";
		    var imgTag = '<img src="${pageContext.request.contextPath}/img/'+extention+'" style="width:40px; height:40px">'; 
			weaLabel.innerHTML = "<input type='hidden'  name='weather' value='"+weather+"'>"+imgTag;
		}
	}
	
	function emoClick(img){
		console.log(img.name);
		var emoLabel = document.querySelector("#emoLabel");
		var emotionSelector = document.querySelector("#emotionSelector");
	    $("#emoLabel").css("display", "block");
	    $("#emoDiv").css("border", "1px solid #b0c4de");
	    $("#emoDiv").css("border-radius", "10px")
	    $("#emoDiv").css("margin-bottom", "10px")
	    $("#emoLabel").css("padding-left", "30px")
	    var extention = "icon_" + img.name + ".PNG";
	    var imgTag = '<img src="${pageContext.request.contextPath}/img/'+extention+'" style="width:40px; height:40px">'; 
		emoLabel.innerHTML = "<input type='hidden'  name='emotion' value='"+img.name+"'>"+ imgTag;
		emotionSelector.style.display = "none";
	}
	function weaClick(img){
		console.log(img.name);
		var weaLabel = document.querySelector("#weaLabel");
		var weatherSelector = document.querySelector("#weatherSelector");
		$("#weaLabel").css("display", "block");
		$("#weaDiv").css("border", "1px solid #b0c4de");
		$("#weaDiv").css("border-radius", "10px")
		$("#weaDiv").css("margin-bottom", "10px")
		$("#weaDiv").css("margin-left", "10px")
		$("#weaLabel").css("padding-left", "30px")
		var extention = img.name + ".PNG";
	    var imgTag = '<img src="${pageContext.request.contextPath}/img/'+extention+'" style="width:40px; height:40px">'; 
		weaLabel.innerHTML = "<input type='hidden'  name='weather' value='"+img.name+"'>"+imgTag;
		weatherSelector.style.display = "none";
	}
	function emoDel(){
		var emoLabel = document.querySelector("#emoLabel");
		$("#emoLabel").css("display", "none");
		$("#emoDiv").css("border", "none");
		emoLabel.innerHTML = "";
		emotionSelector.style.display = "none";
	}
	function weaDel(){
		var weaLabel = document.querySelector("#weaLabel");
		$("#weaLabel").css("display", "none");
		$("#weaDiv").css("border", "none");
		weaLabel.innerHTML = "";
		weatherSelector.style.display = "none";
	}
</script>

<article>
<%-- 컨테이너 영역 --%>
<h3> 게시판</h3>
<form action="${pageContext.request.contextPath}/etc/etc-revise?no=${board.no}" method="post" name="form">
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

	<div class="form-inline">
		<div class="form-group area-20" >
			<input type="button" class="btn" name="icon" id="icon"  value="감정 이모티콘" >
		</div>
		<div class="form-group mx-sm-3">
			<input type="button"  class="btn" name="weather" id="weather" value="날씨 이모티콘">
		</div>
	</div>
	<div class="form-inline">
		<div class="form-group area-20"  id="emoDiv">
			<label id="emoLabel" style="display:none"></label>
		</div>
		<div class="form-group area-20" id="weaDiv">
			<label id="weaLabel" style="display:none"></label>
		</div>
	</div>
		
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
   
	<textarea name="ir1" id="ir1" class="nse_content" style="width:100%; height:412px; min-width:610px; display:none;">${board.detail }</textarea>
	<script type="text/javascript">
   		var oEditors = [];
    	nhn.husky.EZCreator.createInIFrame({
	       	oAppRef: oEditors,
	       	elPlaceHolder: "ir1",
	       	sSkinURI: "/review/smarteditors/SmartEditor2Skin.html",
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
