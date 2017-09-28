<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<article>
<form action="check" method="get">
<%-- 컨테이너 영역 --%>
<div class="empty-row"></div>
    <div align="center">
        <h1>회원 정보</h1>
    </div>
    <div class="empty-row"></div>
<table class = "table-striped info">
   <tbody>
   	 <c:forEach items="${u_list}" var ="u_list">
       <tr>
         <td>아이디</td>
         <td>${u_list.id}</td>
      </tr>
       
<!--        <tr> -->
<!--          <td>비밀번호</td> -->
<!--          <td>*****</td> -->
<!--       </tr> -->
      
      <tr>
         <td>닉네임</td>
         <td>${u_list.nickname}</td>
      </tr>
       
       <tr>
         <td>메일</td>
         <td>${u_list.email}</td>
      </tr>
       
       <tr>
         <td>이름</td>
         <td>${u_list.name}</td>
      </tr>
       
       <tr>
         <td>성별</td>
         <td>${u_list.gender}</td>
      </tr>
       
       <tr>
         <td>생일</td>
         <td>${u_list.birth}</td>
      </tr>

       
       <tr>
         <td>전화번호</td>
         <td>${u_list.phone}</td>
      </tr>
       
       <tr>
         <td>등급</td>
         <td>${u_list.power}</td>
      </tr>
      
      <tr>
         <td>총포인트</td>
         <td>${u_list.totalpoint}</td>
      </tr>
       
       <tr>
         <td>포인트</td>
         <td>${u_list.point}</td>
      </tr>
       
       <tr>
         <td>가입일</td>
         <td>${u_list.reg}</td>
      </tr>
       
       <tr>
         <td>최종방문일</td>
         <td>${u_list.lastvisit}</td>
      </tr>
       
       <tr>
         <td>방문수</td>
         <td>${u_list.visitnumber}</td>
      </tr>
       
       <tr>
         <td>게시글수</td>
         <td>${u_list.writenumber}</td>
      </tr>
       
       <tr>
         <td>댓글수</td>
         <td>${u_list.replynumber}</td>
      </tr>
       </c:forEach>
   </tbody>
       </table>
        <div align="center">
            <button type="button" onclick="location.href = 'check?mode=edit'" class = "btn btn-primary">정보 수정</button>
              <button type="button" onclick="location.href = 'check?mode=unsign'" class = "btn btn-primary" id = "unsign">회원 탈퇴</button>
        </div>
    </form>
     <div class="empty-row"></div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
