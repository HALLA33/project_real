<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/design.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.min.css" />">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<title>영화 찾기</title> 

<script type="text/javascript">
	function add_movie(image,title,director,actor,pubDate){
		title = text_replace(title);
		director = text_replace(director);
		actor = text_replace(actor);
		pubDate = text_replace(pubDate);

		$(opener.document).find("#movie_name").val(title);
		
		var imageSize = image.length;
		if(imageSize<=0){
			$(opener.document).find("#image").attr('src',"${pageContext.request.contextPath}/img/noImage.PNG");
			$(opener.document).find("#image").attr('width',"120");
			$(opener.document).find("#image").attr('height',"120");
			$(opener.document).find(".image").val("${pageContext.request.contextPath}/img/noImage.PNG");
		}
		else{
			$(opener.document).find("#image").attr('src',image);
			$(opener.document).find(".image").val(image);
		}
		
		$(opener.document).find("#movie_title").text(title);
		$(opener.document).find("#director").text(director);
		$(opener.document).find("#actor").text(actor);
		$(opener.document).find("#pubDate").text(pubDate);
		
		$(opener.document).find(".movie_title").val(title);
		$(opener.document).find(".director").val(director);
		$(opener.document).find(".actor").val(actor);
		$(opener.document).find(".pubDate").val(pubDate);

		window.close();
	}
	
	function text_replace(text){
		text = text.replace(/<br\/>/ig, "\n"); 
		text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
		return text;
	}
</script>

</head>
<body>	
	    <form action="movieList" style="margin-left: 40px; margin-top: 10px">
	   		<input type="text" name="keyword" id="search_movie_name" value="${keyword}">
	    	<input type="submit" value="검색">
	 	</form>

		<ul id="list-ul">
			<c:forEach items="${movieList}" var ="m">	 
				<li style="border:1px solid #bcbcbc; padding: 10px; width:650px;">
					<div class="row form-inline">
						<div class="form-group area-20" >
							<c:choose>
								<c:when test="${fn:length(m.image) == 0 }">
									<img id="m_image" src="${pageContext.request.contextPath}/img/noImage.PNG" width="120" height="120">
								</c:when>
								<c:otherwise>
									<img id="m_image" src="${m.image }">
								</c:otherwise>
							</c:choose>
						</div>
						<div style="padding-left: 10px;">
							<h5 style="font-size:14px; width: 500px">${m.title }</h5>
							<h5 style="font-size:14px">${m.director }</h5>
							<h5 style="font-size:14px; width: 500px">${m.actor }</h5>
							<h5 style="font-size:14px">${m.pubDate }</h5>
							<button type="button" onclick="add_movie('${m.image}','${m.title}','${m.director}','${m.actor}','${m.pubDate}')" id="block" style="width:50px; height:30px">넣기</button>
					 	</div>
					</div>
				</li>
			</c:forEach>
	     </ul>
</body>
</html>
