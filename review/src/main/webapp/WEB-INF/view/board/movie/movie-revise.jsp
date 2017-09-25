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
		
		var item_no = '${board.item_no}';
		$("#item_no").val(item_no);
		
		$("#preview").on("click", function(){
			var msg = valid(form);
			var text = tagRemove(form.ir1.value);
	
			if(msg!=null)
				alert(msg);
			else{
				var openWin = window.open("about:blank", "preview", "width=750, height=800");
				form.action="${pageContext.request.contextPath}/movie/movie-preview";
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
				form.action="${pageContext.request.contextPath}/movie/movie-revise/${board.no}/${board.item_no}";
				form.submit();
			}
		});
	});
	
	function valid(form){
		var msg = null;
		var text = tagRemove(form.ir1.value, 1);
		
		if(text=='')
			msg = "내용을 입력하세요";
		if(form.movie_title.value=='')
			msg = "영화를 검색하세요";
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
<h3>영화 게시판</h3>
<form action="${pageContext.request.contextPath}/movie/movie-revise?no=${board.no}" method="post" name="form">
	<input type="hidden" name="writer" value="${sessionScope.member.id }">
	<div class="row form-inline">
		<div class="form-group area-20">
			<label>카테고리</label>
		</div>
	   	<div class="form-group mx-sm-3">
	   		<select name="item_no" id="item_no" class="user-input" id="item_no">
	   			<option value="-1">선택</option>
	   			<option id="item_no_notice" value = "0">공지</option>
				<option value = "3">국내영화</option>
				<option value = "4">해외영화</option>  
	   		</select> 
	    </div>
		<select name="head" id="head" class="user-input" id="head">  
			<option value="-1">장르</option>
			<option id="head_notice" value = "0">공지</option>
			<option value = "101" >SF/판타지</option>  
			<option value = "102" >드라마</option>  
			<option value = "103" >전쟁/모험</option> 
			<option value = "104" >미스터리/스릴러</option>
			<option value = "105" >애니메이션</option>
			<option value = "106" >코미디</option> 
			<option value = "107" >액션/느와르</option>
			<option value = "199" >기타</option> 
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
			<label>영화 검색</label>
		</div>
		<div class="form-group mx-sm-3">
			<input id="movie_name" class="user-input margin" type="text" placeholder="검색할 영화 제목을 작성하세요">
		</div>
		<!-- location.href='bookList/keyword='+${book_name} -->
		<input type="button" onclick="moviename()" value="검색">
			
		<script type="text/javascript">
			function moviename(){
				var movie_name = $("#movie_name").val();
	            var openWin = window.open("movie/movieList?keyword="+movie_name, "영화 찾기", "width=750, height=800");
			}
		</script>
	</div>

	<div class="row form-inline">
		<div class="form-group area-20" >
			<c:choose>
				<c:when test="${book.image==null }">
					<img id="image" src="${pageContext.request.contextPath}/img/noImage.PNG" width="120" height="120">
				</c:when>
				<c:otherwise>
					<img id="image" src="${book.image }">
				</c:otherwise>
			</c:choose>
		</div>
		<div style="padding-left: 10px">
			<h5 id="movie_title" style="font-size: 15px; width: 500px" >${movie.title }</h5>
			<h5 id="director" style="font-size: 15px">${movie.director}</h5>
			<c:choose>
				<c:when test="${movie.actor==null  }">
					<h5 id="actor" style="font-size: 15px">출연배우</h5>
				</c:when>
				<c:otherwise>
					<h5 id="actor" style="font-size: 15px">${movie.actor }</h5>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${movie.pubDate==null  }">
					<h5 id="pubDate" style="font-size: 15px">제작년도</h5>
				</c:when>
				<c:otherwise>
					<h5 id="pubDate" style="font-size: 15px">${movie.pubDate }</h5>
				</c:otherwise>
			</c:choose>
		</div>   
	</div>

	<input type="hidden" class="movie_title" name="movie_title" value="${movie.title }">
	<input type="hidden" class="image" name="image" value="${movie.image }">
	<input type="hidden" class="director" name="director" value="${movie.director }">
	<input type="hidden" class="actor" name="actor" value="${movie.actor }">
	<input type="hidden" class="pubDate" name="pubDate" value="${movie.pubDate }">
   
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
