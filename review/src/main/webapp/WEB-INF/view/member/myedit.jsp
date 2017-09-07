<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<style>
	.font-red{
		color : red;
	}
</style>
<script>
	$(document).ready(function () {
		var id = $("#id").text();
		var pwinput = $("input[name=pw]");
		var rpwinput = $("input[name=rpw]");
		var nickinput = $("input[name=nickname]");
		pwinput.on("keyup", function () {
			console.log(pwinput.val());
			var pwcheck = /^[a-z0-9]{8,20}$/g;
			if(pwinput.val() == ""){
				$("#pwcheck").html("");
				pwinput.removeClass("pwregnok");
				pwinput.addClass("pwregok");
			}
			else if(!pwcheck.test(pwinput.val())){
					$("#pwcheck").html("<td colspan = '2' align = 'center' class = 'font-red'>비밀번호는 8~20자 이어야 합니다</td>");
					pwinput.removeClass("pwregok");
					pwinput.addClass("pwregnok")
				}else{	
					$("#pwcheck").html("");
					pwinput.removeClass("pwregnok");
					pwinput.addClass("pwregok");
				}
				
			});
		
		rpwinput.on("keyup", function () {
			
			if(rpwinput.val() != pwinput.val()){
				$("#rpwcheck").html("<td colspan = '2' align = 'center' class = 'font-red'>위의 비밀번호와 일치하지 않습니다</td>");
				rpwinput.removeClass("rpwok");
				rpwinput.addClass("rpwnok")
			}else{
				$("#rpwcheck").html("");
				rpwinput.removeClass("rpwnok");
				rpwinput.addClass("rpwok");
			}
			
		});
		
		$(nickinput).on("keyup", function () {
			console.log("닉네임실행댐");
			console.log(nickinput.val());
			
			var charcase = /^[A-Za-z0-9]*[A-Za-z0-9]/g;
			var charcase2 = /^[가-힣]*[가-힣0-9]/g;
			
			var nickcheck1 = /^[A-Za-z0-9]{2,20}$/g;
			var nickcheck2 = /^[가-힣0-9]{1,10}$/g;
			
			if(charcase.test(nickinput.val())){
				if(!nickcheck1.test(nickinput.val())){
					$("#nickreg").html("<td colspan = '2' align = 'center' class = 'font-red'>영어 및 숫자 닉네임은 2~20자 이어야합니다</td>");
					nickinput.removeClass("nickok");
					nickinput.addClass("nicknok");
					$("#nickcheck").html("");
				}else{
					$("#nickreg").html("");
					nickinput.removeClass("nicknok");
					nickinput.addClass("nickok");
			}
		}else if(charcase2.test(nickinput.val())){
				if(!nickcheck2.test(nickinput.val())){
					$("#nickreg").html("<td colspan = '2' align = 'center' class = 'font-red'>한글 닉네임은 완성된 한글 또는 숫자 1자~10자 이어야합니다</td>");
					nickinput.removeClass("nickok");
					nickinput.addClass("nicknok");
					$("#nickcheck").html("");
				}else{
					$("#nickreg").html("");
					nickinput.removeClass("nicknok");
					nickinput.addClass("nickok");
			}
			}else{
				$("#nickreg").html("<td colspan = '2' align = 'center' class = 'font-red'>올바르지 않은 유형입니다</td>");
				nickinput.removeClass("nickok");
				nickinput.addClass("nicknok");
				$("#nickcheck").html("");
			}	
			
			if(nickinput.hasClass("nickok")){
		$.ajax({
			url:"nickcheck2",
			type:"post",
			data:{nick:nickinput.val(), id:id},
			dataType:"text",
			success:function(){
				console.log("정상실행댐");
				$("#nickcheck").html("<td colspan = '2' align = 'center'>사용 가능한 닉네임 입니다</td>");
				nickinput.removeClass("nicknok");
				nickinput.addClass("nickok");
			},
			error:function(){
				console.log("비정상실행댐");
				$("#nickcheck").html("<td colspan = '2' align = 'center' class = 'font-red'>이미 존재하는 닉네임 입니다</td>");
				nickinput.removeClass("nickok");
				nickinput.addClass("nicknok");
			}
		});
				
			}
			
	});
		
		$("form").on("submit", function(){
			 
			
    		if($(nickinput).hasClass("nicknok") || $(pwinput).hasClass("pwregnok")
    				|| $(rpwinput).hasClass("rpwnok")){
    			alert("중복확인을 하지않으셨거나 올바르지않은 유형을 입력하셨습니다");
    			event.preventDefault();
    			return;
    		} 
		}); 
		
		
	});
</script>
<article>
<%-- 컨테이너 영역 --%>
<div class="empty-row"></div>
    <div align="center">
        <h1>내 정보 수정</h1>
    </div>
    <div class="empty-row"></div>

    <form action="myedit" method="post">
    <input type="hidden" name = "id" value="${sessionScope.member.id }">
    
        <table class = "table-striped info">
   <tbody>
	   <tr>
         <td>아이디</td>
         <td id = "id">${sessionScope.member.id }</td>
      </tr>
       
<!--        <tr> -->
<!--          <td>비밀번호</td> -->
<!--          <td>*****</td> -->
<!--       </tr> -->
      
      <tr>
         <td>비밀번호</td>
         <td><input type = "password" placeholder="*****" class = "form-control" name = "pw" ></td>
      </tr>
      <tr id = "pwcheck"></tr>
       <tr>
         <td>비밀번호 확인</td>
         <td><input type = "password" placeholder="*****" class = "form-control" name = "rpw"></td>
      </tr>
      <tr id = "rpwcheck"></tr>
      <tr>
         <td>닉네임</td>
         <td><input type = "text" value = "${sessionScope.member.nickname }" class = "form-control" name = "nickname""></td>
      </tr>
      <tr id = "nickreg"></tr>
       <tr id = "nickcheck"></tr> 
       <tr>
         <td>메일</td>
         <td>${sessionScope.member.email }</td>
      </tr>
       
       <tr>
         <td>성별</td>
         <td>${sessionScope.member.gender }</td>
      </tr>
       
       <tr>
         <td>생일</td>
         <td>${sessionScope.member.birth }</td>
      </tr>
      
       <tr>
         <td>전화번호</td>
         <td><input type = "tel" value = "${sessionScope.member.phone }" class = "form-control" name = "phone"></td>
      </tr>
       
       <tr>
         <td>등급</td>
         <td>${sessionScope.member.power }</td>
      </tr>
       
       <tr>
         <td>포인트</td>
         <td>${sessionScope.member.point }</td>
      </tr>
       
       <tr>
         <td>가입일</td>
         <td>${sessionScope.member.reg }</td>
      </tr>
       
       <tr>
         <td>최종방문일</td>
         <td>${sessionScope.member.lastvisit }</td>
      </tr>
       
       <tr>
         <td>방문수</td>
         <td>${sessionScope.member.visitnumber }</td>
      </tr>
       
       <tr>
         <td>게시글수</td>
         <td>${sessionScope.member.writenumber }</td>
      </tr>
       
       <tr>
         <td>댓글수</td>
         <td>${sessionScope.member.replynumber }</td>
      </tr>

       
   </tbody>
       </table>
        <div align="center">
            <button type = "button" class = "btn btn-default">취소</button>
            <button class = "btn btn-primary">수정완료</button>
        </div>
    </form>
     <div class="empty-row"></div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
