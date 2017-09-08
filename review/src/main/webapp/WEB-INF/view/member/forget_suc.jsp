<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<article>
	<div align = "center">
		당신의 ID는 ${id}입니다
	</div>
	<div align = "center">
       <button type="button" class="btn btn-primary"  onclick="location.href = 'forgetpw'">PW찾기</button>
    </div>
</article>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 