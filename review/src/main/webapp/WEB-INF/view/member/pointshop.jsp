<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>

<article>
	<div>
		<h1>포인트 상점</h1>
	</div>
		<div align="right">
			<button class="btn btn-primary modify"  onclick = "location.href = 'mybuylist'">구매내역</button>
			<c:if test="${sessionScope.member.power eq '관리자' }">
			<button class="btn btn-primary modify" onclick = "location.href = 'shopinput'">상품 등록</button>
			<button class="btn btn-primary modify"  onclick = "location.href = 'userbuylist'">사용자 주문내역</button>
			</c:if>
		</div>
	<div class="row form-inline" style="height: 90px" id="testing">
		<div class="form-group area-20" style="border: 1px darkseagreen;">
			<h5>이미지</h5>
		</div>
		<div class="area-40">
			<h3 style="font-size: 13px">상품 이름</h3>
		</div>
		<div class="area-20">
			<h3 style="font-size: 13px">구매 포인트</h3>
		</div>
		<div class="area-20">			
		</div>
	</div>
	<c:forEach items="${slist}" var="slist">
		<div class="row form-inline" style="height: 90px" id="testing">
			<div class="form-group area-20" style="border: 1px darkseagreen;">
				<img src="${pageContext.request.contextPath}/img2/${slist.savename}"
					style="width: 80px; height: 100px" />
			</div>
			<div class="area-40">
				<h3 style="font-size: 13px">${slist.title}</h3>
			</div>
			<div class="area-20">
				<h3 style="font-size: 13px">${slist.point}</h3>
			</div>
<%-- 			<c:if test = "${sessionScope.member.power ne '관리자' }"> --%>
			<div class="area-20">
				<button class="btn btn-primary modify buybtn" " value = "${slist.point}">구매</button>
				<input type="hidden" value="${slist.title }" id = "titles">
				<input type="hidden" value="${slist.no }" id = "itemno">
				<input type="hidden" value="${slist.savename }" id = "itemno2">
			</div>
<%-- 			</c:if> --%>
<%--  --%>
		</div>
		<hr />
	</c:forEach>
</article>
<script>
		$(document).ready(function () {
			var mypoint = "${sessionScope.member.point}";
			var bpoint = $(".buybtn");
			
			$(".buybtn").on("click", function () {
				var title = $(this).siblings('#titles').val();
				var itemno = $(this).siblings('#itemno').val();
				var itemno2 = $(this).siblings('#itemno2').val();
				console.log("아이템 구매 실행");
				console.log(title);
				console.log("포인트 : " + $(this).val());
				console.log(mypoint);
				if(mypoint - $(this).val() < 0){
					alert("보유하신 포인트가 부족합니다");
	    			return;
				}else{
					$(location).attr('href', 'buyitem?item='+title+"&point="+$(this).val()+"&itemno="+itemno+"&itemno2="+itemno2);
				}
				
			});
			
		});
</script>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>
