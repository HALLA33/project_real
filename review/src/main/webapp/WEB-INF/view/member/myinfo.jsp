<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<form action="check" method="get">
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
         <td>${sessionScope.member.id }</td>
      </tr>
       
<!--        <tr> -->
<!--          <td>비밀번호</td> -->
<!--          <td>*****</td> -->
<!--       </tr> -->
      
      <tr>
         <td>닉네임</td>
         <td>${sessionScope.member.nickname }</td>
      </tr>
       
       <tr>
         <td>메일</td>
         <td>${sessionScope.member.email }</td>
      </tr>
       
       <tr>
         <td>이름</td>
         <td>${sessionScope.member.name }</td>
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
         <td>${sessionScope.member.phone }</td>
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
            <button type="button" onclick="location.href = 'check?mode=edit'" class = "btn btn-primary">정보 수정</button>
        </div>
    </form>
     <div class="empty-row"></div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
