<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<style>
.font-red {
	color: red;
}
</style>
<script>
	$(document).ready(function() {
		var idinput = $("#ids");
		var nickinput = $("#nicks");
		var pwinput = $("input[name=pw]");
		var rpwinput = $("input[name=rpw]");
		
		$(idinput).on("keyup", function () {
			var idcheck = /^[a-z0-9]{6,20}$/g;
			
			if(!idcheck.test(idinput.val())){
				$("#idreg").html("<h5 class = 'font-red'>아이디는 영어 및 숫자로 6자이상 20자 이하여야합니다</h5>");
				$("#idcheck").attr("disabled", true);
				$("#check").html("");
			}else{
				$("#idreg").html("");
				$("#idcheck").attr("disabled", false);
			}	
		});
		pwinput.on("keyup", function () {
		var pwcheck = /^[a-z0-9]{8,20}$/g;
			
			if(!pwcheck.test(pwinput.val())){
				$("#pwreg").html("<h5 class = 'font-red'>비밀번호는 영어 및 숫자로 8자이상 20자 이하여야합니다</h5>");
				pwinput.removeClass("pwregok");
				pwinput.addClass("pwregnok")
			}else{
				$("#pwreg").html("");
				pwinput.removeClass("pwregnok");
				pwinput.addClass("pwregok");
			}
		});
		rpwinput.on("keyup", function () {
				if(rpwinput.val() != pwinput.val()){
					$("#rpw").html("<h5 class = 'font-red'>위의 비밀번호와 일치하지 않습니다</h5>");
					rpwinput.removeClass("rpwok");
					rpwinput.addClass("rpwnok");
				}else{
					$("#rpw").html("");
					rpwinput.removeClass("rpwnok");
					rpwinput.addClass("rpwok")
				}
			});
		
		nickinput.on("keyup", function () {
			
			var charcase = /^[A-Za-z0-9]*[A-Za-z0-9]/g;
			var charcase2 = /^[가-힣]*[가-힣]/g;
			
			var nickcheck1 = /^[A-Za-z0-9]{2,20}$/g;
			var nickcheck2 = /^[가-힣0-9]{1,10}$/g;
			
			if(charcase.test(nickinput.val())){
				if(!nickcheck1.test(nickinput.val())){
					$("#nickreg").html("<h5 class = 'font-red'>영어 및 숫자 닉네임은 2~20자 이어야합니다</h5>");
					nickinput.removeClass("nickok");
					nickinput.addClass("nicknok");
					$("#nickcheck").attr("disabled", true);
					$("#check2").html("");
				}else{
					$("#nickreg").html("");
					nickinput.removeClass("nicknok");
					nickinput.addClass("nickok");
					$("#nickcheck").attr("disabled", false);
			}
		}else if(charcase2.test(nickinput.val())){
				if(!nickcheck2.test(nickinput.val())){
					$("#nickreg").html("<h5 class = 'font-red'>한글 닉네임은 완성된 한글 1자~10자 이어야합니다</h5>");
					nickinput.removeClass("nickok");
					nickinput.addClass("nicknok");
					$("#nickcheck").attr("disabled", true);
					$("#check2").html("");
				}else{
					$("#nickreg").html("");
					nickinput.removeClass("nicknok");
					nickinput.addClass("nickok");
					$("#nickcheck").attr("disabled", false);
			}
			}else{
				$("#nickreg").html("<h5 class = 'font-red'>올바르지 않은 유형입니다</h5>");
				nickinput.removeClass("nickok");
				nickinput.addClass("nicknok");
				$("#nickcheck").attr("disabled", true);
				$("#check2").html("");
			}	
		});
		$("form").on("submit", function(){
			 
    		console.log("서브밋 실행")
			
    		if($("#ids").hasClass("idnok") || $("#nicks").hasClass("nicknok") || $(pwinput).hasClass("pwregnok")
    				|| $(rpwinput).hasClass("rpwnok")){
    			alert("중복확인을 하지않으셨거나 올바르지않은 유형을 입력하셨습니다");
    			event.preventDefault();
    			return;
    		} 
		}); 

		$("#idcheck").click(function () {
				console.log("실행댐");
				console.log(idinput.val());
			$.ajax({
				url:"idcheck",
				type:"post",
				data:{id:idinput.val()},
				dataType:"text",
				success:function(){
					console.log("정상실행댐");
					$("#check").html("<h5>사용가능한 아이디입니다</h5>");
					idinput.removeClass("idnok");
					idinput.addClass("idok");
				},
				error:function(){
					console.log("비정상실행댐");
					$("#check").html("<h5 class = 'font-red'>이미 존재하는 아이디 입니다</h5>");
					idinput.removeClass("idok");
					idinput.addClass("idnok");
				}
				
			});
		});
		
		$("#nickcheck").click(function () {
			console.log("닉네임실행댐");
			console.log(nickinput.val());
		$.ajax({
			url:"nickcheck",
			type:"post",
			data:{nick:nickinput.val()},
			dataType:"text",
			success:function(){
				console.log("정상실행댐");
				$("#check2").html("<h5>사용가능한 닉네임 입니다</h5>");
				nickinput.removeClass("nicknok");
				nickinput.addClass("nickok");
			},
			error:function(){
				console.log("비정상실행댐");
				$("#check2").html("<h5 class = 'font-red'>이미 존재하는 닉네임 입니다</h5>");
				nickinput.removeClass("nickok");
				nickinput.addClass("nicknok");
			}
			
		});
	});
		
		
});
</script>
<article>
	<%-- 컨테이너 영역 --%>
	<div class="container" align=center>
		<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2"
			align=center>
			<div class="panel panel-success">
				<div class="panel-heading">
					<div class="panel-title">가입 정보 입력</div>
				</div>
				<div class="panel-body">
					<form id="login-form" method="post">
						<div>
							<input type="text" class="form-control idnok" name="id"
								placeholder="아이디" autofocus required id="ids">
							<div id="idreg"></div>
							<span></span>
							<button type="button" class="btn btn-primary" id="idcheck"
								disabled="disabled">중복 확인</button>
							<label id="check"></label>
						</div>
						<div>
							<input type="password" class="form-control" name="pw"
								placeholder="비밀번호" autofocus required>
							<div id="pwreg"></div>
						</div>
						<div>
							<input type="password" class="form-control" name="rpw"
								placeholder="비밀번호 확인" required>
							<div id="rpw"></div>
						</div>
						<div>
							<input type="text" class="form-control" name="name"
								placeholder="이름" equired>
						</div>
						<div>
							<input type="text" class="form-control nicknok" name="nickname"
								placeholder="닉네임" required id="nicks">
							<div id="nickreg"></div>
							<span></span>
							<button type="button" class="btn btn-primary" id="nickcheck"
								disabled="disabled">중복 확인</button>
							<label id="check2"></label>
						</div>
						<div>
							<input type="email" class="form-control" name="email"
								placeholder="이메일" required>
						</div>
						<div>
							<select class="form-control" name="gender" required>
								<option value="">성별</option>
								<option value="남">남자</option>
								<option value="여">여자</option>
							</select>
						</div>
						<div>
							<input class="form-control" type="date" name="birth"
								placeholder="생년월일(ex:20170101)" required>
						</div>
						<div>
							<select class="form-control" name="telecom" required>
								<option value="">통신사</option>
								<option>SKT</option>
								<option>KT</option>
								<option>LGT</option>
							</select>

						</div>
						<div>
							<input class="form-control" type="text" name="phone"
								placeholder="전화번호(- 제외)" required>
						</div>
						<div>
							<input class="btn btn-primary" type="submit" value="가입하기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</article>

<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>
