<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<script> 
    window.onload = function(){
        var all = document.querySelector("#all");
        var unit = document.querySelectorAll(".unit");
        
        //'전체선택' 체크하면 전체 체크
        all.addEventListener("click", function(){
            for(var i=0; i<unit.length; i++){
                unit[i].checked = this.checked;
            };
        });
        
        //하나라도 해제되면 '전체선택' 체크박스 해제
        for(var i=0; i<unit.length; i++){
                    unit[i].addEventListener("click", function(){
                        if(!this.checked){
                            all.checked = false;
                        }
                    });
        };
        
    };
</script>

<article>
    <div class="empty-row"></div>
    
    <div style = "padding: 0px 100px 10px;">
        <small style="font-weight: bold"><a href="#">작성 게시글</a></small>&nbsp;&nbsp;
        <small><a href="#">작성 댓글</a></small>&nbsp;&nbsp;
        <small><a href="#">선택한 글 삭제</a></small>
    </div>

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
       <tr>
        <td id="check"><input type="checkbox" class="unit"></td>
           <td>안녕안녕</td>
         <td>2017/08/30</td>
          <td>0</td>
      </tr>
       
      <tr>
          <td id="check"><input type="checkbox" class="unit"></td>
          <td>ㅎㅇ</td>
         <td>2017/08/30</td>
          <td>0</td>
      </tr>
      
      <tr>
          <td id="check"><input type="checkbox" class="unit"></td>
          <td>ㅋㅋㅋ</td>
         <td>2017/08/30</td>
          <td>0</td>
      </tr>
       
   </tbody>
   
</table>
</article>
<style>
    .empty-row{
        display: block;
        width:100%;
        height:50px;
    }
    .mywrite{
        width: 700px;
        margin-left: 100px;
    }
    #check{
        width: 10px;
    }
    .btn-group{
        margin-left: 10px;
        margin-bottom: 10px;
    }
</style>
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
