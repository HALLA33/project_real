<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
$(document).ready(function(){
	window.alert("존재하지 않는 페이지입니다");
});
</script>

<div align="center">
		<br>
		<h2><a href="javascript:history.back();">뒤로가기</a></h2>
		<br>
		<img src="<c:url value="/img/err404.jpg"/>" width="900" height="550">
</div>
