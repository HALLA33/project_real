<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>

<article>
<div id = "inputad">
	<div >
		<h1>포인트 상점</h1>
	</div>
	<div class="row form-inline" style="height: 90px" id="testing" >
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
				<img src="${pageContext.request.contextPath}/img/${slist.savename}"
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
			</div>
<%-- 			</c:if> --%>
<%--  --%>
		</div>
		<hr />
	</c:forEach>
	<div align = "right">
	<c:if test="${sessionScope.member.power eq '관리자' }">
	<button class="btn btn-primary modify" onclick = "location.href = 'shopinput'">상품 등록</button>
	</c:if>
	</div>
</div>
</article>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
		$(document).ready(function () {
			var mypoint = "${sessionScope.member.point}";
			var bpoint = $(".buybtn");
			
			var address = function () {
				function sample6_execDaumPostcode() {
			        new daum.Postcode({
			            oncomplete: function(data) {
			                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			                var fullAddr = ''; // 최종 주소 변수
			                var extraAddr = ''; // 조합형 주소 변수

			                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                    fullAddr = data.roadAddress;

			                } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                    fullAddr = data.jibunAddress;
			                }

			                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
			                if(data.userSelectedType === 'R'){
			                    //법정동명이 있을 경우 추가한다.
			                    if(data.bname !== ''){
			                        extraAddr += data.bname;
			                    }
			                    // 건물명이 있을 경우 추가한다.
			                    if(data.buildingName !== ''){
			                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                    }
			                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
			                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			                }

			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
			                document.getElementById('sample6_address').value = fullAddr;

			                // 커서를 상세주소 필드로 이동한다.
			                document.getElementById('sample6_address2').focus();
			            }
			        }).open();
			    }
			}
			
			$(".buybtn").on("click", function () {
				var title = $(this).siblings('#titles').val();
				console.log("아이템 구매 실행");
				console.log(title);
				if(mypoint < $(this).val()){
					alert("보유하신 포인트가 부족합니다");
	    			return;
				}else{
					
					$.ajax({
						
						url:"buyitem",
						type:"get",
						data:{"item" : title, "point" : $(this).val()},
						dataType:"text",
						success:function(res){
							$("#inputad").html(res);
							address();
						}
						
					});
				}
				
			});
			
		});
</script>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>
