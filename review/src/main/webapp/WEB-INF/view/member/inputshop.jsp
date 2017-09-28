<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
		<div  align = "center">
		<div>
			<h2>상품 등록</h2>
		</div>
		<div>
			<h5>※포인트에는 반드시 숫자만 입력하고 이미지는 80x100을 권장</h5>
		</div>
    	<form action="shopinput" method="post" enctype="multipart/form-data">
            <div>
                <label for="title"">상품 이름</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div>
                <label for="file" >상품 이미지</label>
                <input type="file" id="file" name="file" required>
            </div>
             <div>
                <label for="point" >포인트</label>
                <input type="text" id="point" name="point" required>
            </div>
            <div>
                <input type="submit" class="input-btn" value="업로드">
                <input type="button" class="input-btn" value="홈으로" onclick="location.href='home'">
            </div>    
            </form>
       	</div> 
</article>

<%@ include file="/WEB-INF/view/template/footer.jsp" %>  