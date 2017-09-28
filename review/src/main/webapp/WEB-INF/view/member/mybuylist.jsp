<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>

<article>
	<div>
		<h1>주문 내역</h1>
	</div>
	<div class="row form-inline" style="height: 90px" id="testing">
		<div class="form-group area-20" style="border: 1px darkseagreen;">
			<h5>이미지</h5>
		</div>
		<div class="area-40">
			<h3 style="font-size: 13px">상품 이름</h3>
		</div>
		<div class="area-20">
			<h3 style="font-size: 13px">발송 상태</h3>
		</div>
		<div class="area-20">
		</div>
	</div>
	<c:forEach items="${buylist}" var="buylist">
		<div class="row form-inline" style="height: 90px" id="testing">
			<div class="form-group area-20" style="border: 1px darkseagreen;">
				<img src="${pageContext.request.contextPath}/img/${buylist.item_path}"
					style="width: 80px; height: 100px" />
			</div>
			<div class="area-40">
				<h3 style="font-size: 13px">${buylist.itemname}</h3>
			</div>
			<div class="area-20">
			<c:if test ="${buylist.status eq 'false' }">
				<h3 style="font-size: 13px">발송전</h3>
			</c:if>
			<c:if test ="${buylist.status eq 'true' }">
				<h3 style="font-size: 13px">발송 중</h3>
			</c:if>
			</div>
			<div class="area-20">
			<c:if test ="${buylist.status eq 'false' }">
				<form action="deliverycencle" method="post">
				<input type = "hidden" value="${buylist.item_path}" name = "savename">
				<input type = "hidden" value="${buylist.no}" name = "no">
				<button class="btn btn-primary modify"  type = "submit">주문 취소</button>
				</form>
			</c:if>
			</div>
<%-- 			<c:if test = "${sessionScope.member.power ne '관리자' }"> --%>
<%-- 			</c:if> --%>
<%--  --%>
		</div>
		<hr />
	</c:forEach>
</article>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>
