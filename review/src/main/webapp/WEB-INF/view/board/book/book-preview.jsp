<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/design.css" />">
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.css" />">
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.min.css" />">
		<script type="text/javascript" src="<c:url value="/smarteditor/js/service/HuskyEZCreator.js" />" charset="utf-8"></script>
		<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
		<title>미리보기</title>
		<script>
			$(document).ready(function(){
				var detail = '${board.detail}';
				$("#detail").append(detail);
					
				var img = '${book.image}'
				if(img.length==0){
					$("#image").attr("src", "${pageContext.request.contextPath}/img/noImage.PNG");
					$("#image").attr("width", "120");
					$("#image").attr("height", "120");
				}
				
				$("#close").on("click", function(){
					window.close();
				});
			});
		</script>
	</head>
	<body>
		<br>
		<h1 align="center">미리보기</h1>
		<br>
		<div class="container">
			<table class="table table-bordered" >
			 	<thead></thead>
				<tbody>
					<tr class="form-inline">
						<td class="area-20" style="border: none">제목</td>
						<td class="area-20" style="border: none">${board.title}</td>
						<td style="border: none">&#91;</td>
						<td style="border: none">${board.b_item_no }</td>
						<td style="border: none">&#124;</td>
						<td style="border: none">${board.b_head }</td>	
						<td style="border: none">&#93;</td>
					</tr>
					<tr class="form-inline">
				<td class="area-20" style="border: none">감정</td>
				<td class="area-20" style="border: none">
					<img src="${pageContext.request.contextPath}/img/icon_${board.emotion}.PNG" width="40px" height="30px"> 
				</td>
			</tr>	
			<tr class="form-inline">
				<td class="area-20" style="border: none">날씨</td>
				<td class="area-20" style="border: none">
					<img src="${pageContext.request.contextPath}/img/${board.weather}.PNG" width="40px" height="30px"> 
				</td>
			</tr>	
					<tr class="form-inline">
						<td class="area-20" style="border: none">태그</td>
						<td class="area-20" style="border: none">${board.tag}</td>
					</tr>				
					<tr>
						<td>
							<div class="row form-inline" style="border: 1px; margin:10px">
								<div class="form-group area-20" >
									<img id="image" src="${book.image }">
								</div>
								<div style="padding-left: 10px">
									<h5 style="font-size: 15px; width:500px">${book.title }</h5>
									<h5 style="font-size: 15px">${book.author }</h5>
									<h5 style="font-size: 15px">${book.publisher }</h5>
									<h5 style="font-size: 15px">${book.pubdate }</h5>
								</div>   
							</div>
			    		</td>
			      	</tr>
			    	<tr>
			      		<td>
			      			<div id="detail" style="height: auto; min-height: 200px; "></div>
			      		</td>
			 		</tr>
				</tbody>
			</table>            

			<div align="center">
				<input type="button" class="btn" id="close" value="닫기">
			</div>
	
		</div>
	</body>
</html>
