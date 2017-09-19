<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<article>

<div id="mywrite-wrap">
    
<table class = "table table-bordered mywrite" style="margin-left:0px;">
   
   <thead>
      <tr>
        <th id="check" width=10%><input type="checkbox" id="all"></th>
          <th>제목</th>
         <th width=10%>작성일</th>
         <th width=80px>조회수</th>
      </tr>
   </thead>
   
   <tbody>
       <c:forEach var = "list" items = "${list}">
   		<tr>
   			<td id="check"><input type="checkbox" class="unit"></td>
   			<td>${list.title}</td> 
   			<td>${list.reg}</td>
   			<td>${list.read}</td>
   		</tr>
   </c:forEach>
       
   </tbody>
   
</table>

</div>
</article>
