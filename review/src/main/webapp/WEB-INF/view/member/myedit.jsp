<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div class="empty-row"></div>
    <div align="center">
        <h1>내 정보 수정</h1>
    </div>
    <div class="empty-row"></div>

    <form action="#" method="post">
    
        <table class = "table-striped info">
   <tbody>
       <tr>
         <td>아이디</td>
         <td>hong123</td>
      </tr>
       
       <tr>
         <td>비밀번호</td>
         <td><input type = "password" placeholder="*****" class = "form-control"></td>
      </tr>
       
       <tr>
         <td>비밀번호 확인</td>
         <td><input type = "password" placeholder="*****" class = "form-control"></td>
      </tr>
      
      <tr>
         <td>닉네임</td>
         <td><input type = "text" placeholder="닉" class = "form-control"></td>
      </tr>
       
       <tr>
         <td>메일</td>
         <td>mail@mail.com</td>
      </tr>
       
       <tr>
         <td>이름</td>
         <td>홍길동</td>
      </tr>
       
       <tr>
         <td>성별</td>
         <td>남</td>
      </tr>
       
       <tr>
         <td>생일</td>
         <td>1999-01-01</td>
      </tr>

       
       <tr>
         <td>전화번호</td>
         <td><input type = "tel" placeholder="010-0000-0000" class = "form-control"></td>
      </tr>
       
       <tr>
         <td>등급</td>
         <td>일반</td>
      </tr>
       
       <tr>
         <td>포인트</td>
         <td>5000</td>
      </tr>
       
       <tr>
         <td>가입일</td>
         <td>2017/08/30</td>
      </tr>
       
       <tr>
         <td>최종방문일</td>
         <td></td>
      </tr>
       
       <tr>
         <td>방문수</td>
         <td>1</td>
      </tr>
       
       <tr>
         <td>게시글수</td>
         <td>0</td>
      </tr>
       
       <tr>
         <td>댓글수</td>
         <td>0</td>
      </tr>
       
   </tbody>
       </table>
        <div align="center">
            <button type = "button" class = "btn btn-default">취소</button>
            <button type = "button" class = "btn btn-primary">수정완료</button>
        </div>
    </form>
     <div class="empty-row"></div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
