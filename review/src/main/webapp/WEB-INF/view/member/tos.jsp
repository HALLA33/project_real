<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div class="area-80  center">
                    <div class="row ">
                        <h1>홈페이지 이용 약관</h1>
                    </div>
                    <div class="row ">
                        <textarea class="user-area" rows="15" cols="65"
                                  readonly>이용약관 적을 자리</textarea>
                    </div>
                    <div class="row  align-left">
                        <input type="checkbox" id="agree">
                        <label for="agree">
                            <span></span>
                            위의 약관을 확인하였습니다
                        </label>
                    </div>
                    <div class="row ">
                        <input class="input-btn" type="button" value="동의합니다">
                        <input class="input-btn-negative" type="button" value="동의하지 않습니다">
                    </div>
                </div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
