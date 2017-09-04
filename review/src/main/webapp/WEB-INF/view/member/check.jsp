<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div class="container" align = center>
    <div class="empty-row"></div>
    <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2" align = center>
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="panel-title">비밀번호 확인</div>
            </div>
            <div class="panel-body">
                <form id="login-form">
                    <div>
                        <input type="password" class="form-control" name="pw" placeholder="비밀번호">
                    </div>
                    <div>
                        <button type="submit" class="btn btn-primary" >확인</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
