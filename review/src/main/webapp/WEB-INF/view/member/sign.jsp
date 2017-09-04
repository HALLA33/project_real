<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div class="container" align = center>
    <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2" align = center>
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="panel-title">가입 정보 입력</div>
            </div>
            <div class="panel-body">
                <form id="login-form" method="post">
                    <div>
                        <input type="text" class="form-control" name="id" placeholder="아이디" autofocus required>
                    </div>
                    <div>
                     <input type="password" class="form-control" name="pw" placeholder="비밀번호" autofocus required>
                    </div>
                     <div>
                     <input type="password" class="form-control" name="rpw" placeholder="비밀번호 확인" required>
                     </div>
                     <div>
                     <input type="text" class="form-control" name="name" placeholder="이름" equired>
                     </div>
                     <div>
                     <input type="text" class="form-control" name="nickname" placeholder="닉네임" required>
                     </div>
                     <div>
                     <input type="email" class="form-control" name="email" placeholder="이메일" required>
                     </div>
                        <div>
                            <select class="form-control" name="gender" required>
                                <option value="">성별</option>
                                <option value="남">남자</option>
                                <option value="여">여자</option>
                            </select>
                        </div>
                        <div>
                            <input class="form-control" type="date" name="birth" placeholder="생년월일(ex:20170101)" required>
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
                            <input class="form-control" type="text" name="phone" placeholder="전화번호(- 제외)" required>
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
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
