<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    function scrollMove(seq){
        var offset = $("#ilch" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
    }
</script>

<article>
<div class="container" id="ilch1">
		<h3>2개 일치</h3>
		<br>
		
		<c:forEach items="${recomTwo}" var ="two">
         <div class="row form-inline" style="height:90px" id="testing">
            <div class="form-group area-20" style="border: 1px darkseagreen ;">
            	<c:if test="${two.item_no==1 or two.item_no==2 }">
            		<img style="width:80px; height:100px" src="${book[two.search_no].image }">
            	</c:if>
                <c:if test="${two.item_no==3 or two.item_no==4 }">
            		<img style="width:80px; height:100px" src="${movie[two.search_no].image }">
            	</c:if>
             </div>
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<c:if test="${two.item_no==1 or two.item_no==2 }">
                		<a href="<c:url value="book-detail?no=${two.no }&item_no=${two.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${book[two.search_no].title}</a>
                	</c:if>
                   <c:if test="${two.item_no==3 or two.item_no==4 }">
                		<a href="<c:url value="/movie/movie-detail?no=${two.no }&item_no=${two.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${movie[two.search_no].title}</a>
                	</c:if>
                  </div>
                  <div class="align-left">
                      <h5 style="font-size: 13px">${nickname[two.no]}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${two.reg}</h5>
                  </div>
                  <div id="detail"></div>
                <h5 id="detail" style="font-size: 13px;">${two.detail}</h5>
               <div class="align-left">
                      <h5 style="font-size: 13px">${two.b_item_no}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${two.b_head}</h5>
                  </div>
              </div>
         </div>
      <hr/>
       </c:forEach>
       <br><br>
       <hr>
</div>
<div class="container" id="ilch2">
		<h3>감정 일치</h3>
		<br>
		
		<c:forEach items="${recomEmo}" var ="emo">
         <div class="row form-inline" style="height:90px" id="testing">
            <div class="form-group area-20" style="border: 1px darkseagreen ;">
            	<c:if test="${emo.item_no==1 or emo.item_no==2 }">
            		<img style="width:80px; height:100px" src="${book[emo.search_no].image }">
            	</c:if>
                <c:if test="${emo.item_no==3 or emo.item_no==4 }">
            		<img style="width:80px; height:100px" src="${movie[emo.search_no].image }">
            	</c:if>
             </div>
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<c:if test="${emo.item_no==1 or emo.item_no==2 }">
                		<a href="<c:url value="book-detail?no=${emo.no }&item_no=${emo.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${book[emo.search_no].title}</a>
                	</c:if>
                   <c:if test="${emo.item_no==3 or emo.item_no==4 }">
                		<a href="<c:url value="/movie/movie-detail?no=${emo.no }&item_no=${emo.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${movie[emo.search_no].title}</a>
                	</c:if>
                  </div>
                  <div class="align-left">
                      <h5 style="font-size: 13px">${nickname[emo.no]}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${emo.reg}</h5>
                  </div>
                  <div id="detail"></div>
                <h5 id="detail" style="font-size: 13px;">${emo.detail}</h5>
               <div class="align-left">
                      <h5 style="font-size: 13px">${emo.b_item_no}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${emo.b_head}</h5>
                  </div>
              </div>
         </div>
      <hr/>
       </c:forEach>
       <br>
       <hr>
</div>
<div class="container" id="ilch3">
		<h3>날씨 일치</h3>
		<br>
		
		<c:forEach items="${recomWea}" var ="wea">
         <div class="row form-inline" style="height:90px" id="testing">
            <div class="form-group area-20" style="border: 1px darkseagreen ;">
            	<c:if test="${wea.item_no==1 or wea.item_no==2 }">
            		<img style="width:80px; height:100px" src="${book[wea.search_no].image }">
            	</c:if>
                <c:if test="${wea.item_no==3 or wea.item_no==4 }">
            		<img style="width:80px; height:100px" src="${movie[wea.search_no].image }">
            	</c:if>
             </div>
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<c:if test="${wea.item_no==1 or wea.item_no==2 }">
                		<a href="<c:url value="book-detail?no=${wea.no }&item_no=${wea.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${book[wea.search_no].title}</a>
                	</c:if>
                   <c:if test="${wea.item_no==3 or wea.item_no==4 }">
                		<a href="<c:url value="/movie/movie-detail?no=${wea.no }&item_no=${wea.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${movie[wea.search_no].title}</a>
                	</c:if>
                  </div>
                  <div class="align-left">
                      <h5 style="font-size: 13px">${nickname[wea.no]}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${wea.reg}</h5>
                  </div>
                  <div id="detail"></div>
                <h5 id="detail" style="font-size: 13px;">${wea.detail}</h5>
               <div class="align-left">
                      <h5 style="font-size: 13px">${wea.b_item_no}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${wea.b_head}</h5>
                  </div>
              </div>
         </div>
      <hr/>
       </c:forEach>
       
       <div id="scrolldiv" style="position: fixed; bottom: 55%; right: 70px;">
 		<i title="up" class="xi-view-stream xi-2x" onclick="scrollMove('1')"></i>
 	</div>
 	
 	<div id="scrolldiv" style="position: fixed; bottom:50%; right: 70px;">
 		<i title="down" class="xi-emoticon-smiley-o xi-2x" onclick="scrollMove('2')"></i>
 	</div>
 	
 	<div id="scrolldiv" style="position: fixed; bottom: 45%; right: 70px;">
 		<i title="down" class="xi-sun-o xi-2x" onclick="scrollMove('3')"></i>
 	</div>
 	
</div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
