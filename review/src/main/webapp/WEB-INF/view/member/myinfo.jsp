<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div class="empty-row"></div>
    <div align="center">
        <h1>내 정보</h1>
    </div>
    <div class="empty-row"></div>
<table class = "table-striped info">
   <tbody>
       <tr>
         <td>아이디</td>
         <td>hong123</td>
      </tr>
       
       <tr>
         <td>비밀번호</td>
         <td>*****</td>
      </tr>
      
      <tr>
         <td>닉네임</td>
         <td>닉</td>
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
         <td>010-0000-0000</td>
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
 <div class="empty-row"></div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
