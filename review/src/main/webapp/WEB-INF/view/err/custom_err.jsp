<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
$(document).ready(function(){
	var err = "${err}";
	
	if(err=="") err="잘못된 접근입니다";
	window.alert(err);
});
</script>
<style>
body{
	cursor:url('${pageContext.request.contextPath}/img/Blue Pencil 1 Normal.cur'), pointer; 
}
</style>
<body>
<div align="center">
		<br>
		<h2><a href="javascript:history.back();">뒤로가기</a></h2>
		<br>
		<img src="<c:url value="/img/wrong.png"/>" width="900" height="550">
</div>
</body>