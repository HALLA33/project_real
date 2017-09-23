<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>

<script>
	window.onload = function() {
		var all = document.querySelector("#all");
		var unit = document.querySelectorAll(".unit");
		var unitval = [];
		 
		var allcheck= function () {
			$(all).change(function () {
				
				if(this.checked){
					unitval = [];
					for (var i = 0; i < unit.length; i++) {
						unit[i].checked = this.checked;
						unitval.push($(unit[i]).val());
						console.log(unitval);
					};
				}else if(!this.checked){
					for (var i = 0; i < unit.length; i++) {
						unit[i].checked = this.checked;
						unitval = [];
						console.log(unitval);
					}
				}
			});	
		};
		
		
		//하나라도 해제되면 '전체선택' 체크박스 해제
		
		var alldischeck= function () {
			for (var i = 0; i < unit.length; i++) {
				unit[i].addEventListener("click", function() {
					if (!this.checked) {
						all.checked = false;
						unitval.splice(unitval.indexOf($(unit[i]).val()), 1);
						console.log(unitval);
					}
				});
			};
		};
			
		var change= function () {
				$(unit).change(function() {
				
				if (this.checked) {
					unitval.push($(this).val());
					console.log(unitval);
				} else if (!this.checked) {
					unitval.splice(unitval.indexOf($(this).val()), 1);
					console.log(unitval);
				}
			});
		};

		document.querySelector(".modify").addEventListener("click", function() {
			//회원 등급 변경
			
			jQuery.ajaxSettings.traditional = true;

			$.ajax({
				url : "chengepower",
				type : "post",
				data : {
					"userid" : unitval, "power" : $("#select").val()
				},
				success : function() {
					alert("등급 변경 완료!");
					location.reload();
				}

			});

		});
		document.querySelector(".force").addEventListener("click", function() {
			//강제 탈퇴
			
			jQuery.ajaxSettings.traditional = true;
			
			$.ajax({
				url : "unsign",
				type : "post",
				data : {
					"userid" : unitval
					},
				success : function() {
					alert("강제 탈퇴 완료");
					location.reload();
				}

			});
			

		});
		allcheck();
		alldischeck();
		change();
	};
</script>

<article>
<div id = "realmain">

	<%-- 컨테이너 영역 --%>
	<div class="empty-row"></div>
	<div align="center">
		<h1>회원 목록</h1>
	</div>

	<div style="padding: 50px 100px 10px;">


		<form class="bs-example bs-example-form" role="form" action="member"
			method="get">
			<div class="row">

				<div class="col-lg-6">
					<div class="input-group">
						<label class="search"> 회원 검색&nbsp;&nbsp;&nbsp; </label> <select
							class="" name="smode">
							<option value="0">아이디</option>
							<option value="1">닉네임</option>
						</select> <input type="search" style="width: 200px;" placeholder="검색어" name = "key" class="form-control"> <span
							class="input-group-btn">
							<button class="btn btn-default" type="submit">검색</button>
						</span>

					</div>
					<!-- /input-group -->
				</div>
				<!-- /.col-lg-6 -->

			</div>
			<!-- /.row -->
		</form>

	</div>
	<div class="empty-row"></div>
	<div align="center">
	<label>선택한 회원을&nbsp;</label> 
		<select class="" id ="select">
			<option value="normal">일반회원</option>
			<option value="staff">스탭</option>
		</select> <label>&nbsp;(으)로&nbsp;</label>
		<button class="btn btn-primary modify">변경</button>
		<button class="btn btn-danger force">강제탈퇴</button>
	</div>


	<table class="table-hover member">

		<thead>
			<tr>
				<th><input type="checkbox" id="all"></th>
				<th>번호</th>
				<th>닉네임(아이디)</th>
				<th>메일주소</th>
				<th>이름</th>
				<th>성별</th>
				<th>생일</th>
				<th>등급</th>
				<th>포인트</th>
				<th>가입일</th>
				<th>최종방문일</th>
				<th>방문수</th>
				<th>게시글수</th>
				<th>댓글수</th>
				<th>계정상태</th>
			</tr>
		</thead>
		<tbody>
			<!-- forcech 준비 구간 -->
			<c:forEach var="list" items="${list}">
				<tr>
					<td><input type="checkbox" class="unit" value="${list.id}"></td>
					<td>${list.no}</td>
					<td>${list.nickname}(${list.id})</td>
					<td>${list.email}</td>
					<td>${list.name}</td>
					<td>${list.gender}</td>
					<td>${list.birth}</td>
					<td>${list.power}</td>
					<td>${list.point}</td>
					<td>${list.reg}</td>
					<td>${list.lastvisit}</td>
					<td>${list.visitnumber}</td>
					<td>${list.writenumber}</td>
					<td>${list.replynumber}</td>
					<td>${list.enabled}</td>
				</tr>
			</c:forEach>
			<!-- forcech 준비 구간 -->
		</tbody>

	</table>

	<%-- 페이지 이동 숫자 버튼 --%>
	<br>
	<br>
	<c:if test="${startBlock > 1}">
		<a href="${url}&page=${startBlock-1}">[이전]</a>
	</c:if>

	<%-- 번호 출력(startBlock ~ endBlock) --%>
	<c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
		<c:choose>
			<c:when test="${i == pageNo}">${i}</c:when>
			<c:otherwise>
				<a href="${url}&page=${i}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<c:if test="${endBlock < blockTotal}">
		<a href="${url}&page=${endBlock+1}">[다음]</a>
	</c:if>
	<br>
	<br>
</div>
</article>

<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>
