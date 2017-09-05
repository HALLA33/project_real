<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/design.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.min.css" />">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<title>도서 찾기</title> 

<script type="text/javascript">
	function add_book(image,title,author,publisher,pubdate){
		title = text_replace(title);
		
		window.opener.location.href="book-write?image="+image+"&title="+title+"&author="+author+"&publisher="+publisher+"&pubdate="+pubdate;
		opener.document.getElementById("book_name").value= title;	
		
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
	    <form action="bookList" style="margin-left: 40px; margin-top: 10px">
	   		<input type="text" name="keyword" id="search_book_name" value="${keyword}">
	    	<input type="submit" value="검색">
	 	</form>

		<ul id="list-ul">
			<c:forEach items="${bookList}" var ="b">	 
				<li style="border:1px solid #bcbcbc; padding: 10px; width:650px;">
					<div class="row form-inline">
						<div class="form-group area-20" >
							<img id="b_image" src="${b.image}">
						</div>
						<div style="padding-left: 10px;">
							<h5 style="font-size:14px; width: 500px">${b.title }</h5>
							<h5 style="font-size:14px">${b.author }</h5>
							<h5 style="font-size:14px">${b.publisher }</h5>
							<h5 style="font-size:14px">${b.pubdate }</h5>
							<button type="button" onclick="add_book('${b.image}','${b.title}','${b.author}','${b.publisher}','${b.pubdate}')" id="block" style="width:50px; height:30px">넣기</button>
					 	</div>
					</div>
				</li>
			</c:forEach>
	     </ul>
</body>
</html>
