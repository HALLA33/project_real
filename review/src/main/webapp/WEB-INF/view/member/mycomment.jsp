<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/template/header.jsp" %>  
<article>

<div class="empty-row"></div>
    
    <div style = "padding: 0px 100px 10px;">
        <small><a href="myboard">작성 게시글</a></small>&nbsp;&nbsp;
        <small><a href="mycomment">작성 댓글</a></small>&nbsp;&nbsp;
        <small><a href="#" id = "mydelete">선택한 글 삭제</a></small>
    </div>

<div id="mywrite-wrap">

<table class = "table table-bordered mywrite" style="margin-left:0px;">
   
   <thead>
      <tr>
        <th id="check" width=10%><input type="checkbox" id="all"></th>
          <th>댓글</th>
         <th width=10%>작성일</th>
      </tr>
   </thead>
   
   <tbody>
       <tr>
        <td id="check"><input type="checkbox" class="unit"></td>
           <td>안녕안녕</td>
         <td>2017/08/30</td>
      </tr>
       
      <tr>
          <td id="check"><input type="checkbox" class="unit"></td>
          <td>ㅎㅇ</td>
         <td>2017/08/30</td>
      </tr>
      
      <tr>
          <td id="check"><input type="checkbox" class="unit"></td>
          <td>ㅋㅋㅋ</td>
         <td>2017/08/30</td>
      </tr>
       
   </tbody>
   
</table>
</div>
</article>
</body>
</html>
<%@ include file="/WEB-INF/view/template/footer.jsp" %>  