<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  
<article id="home_article">
<%-- 컨테이너 영역 --%>
<div id="caption">
	<div style="margin-right: 0px, font-size: 5px">
		<h1>공지글~!</h1>
		<a href="${pageContext.request.contextPath}/list?item_no=0">전체보기</a>
	</div>
	<c:forEach items="${home_notice}" var ="two">
         <div class="row form-inline" style="height:90px" id="testing">
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<a href="<c:url value="book-detail?no=${two.no }&item_no=${two.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${two.title}</a>
                  	<h5 style="font-size: 13px">${two.writer}</h5>
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
</div>
<div id="caption">
	<div style="margin-right: 0px, font-size: 5px">
		<h1>도서(국내)~!</h1>
		<a href="${pageContext.request.contextPath}/list?item_no=1">전체보기(국내)</a>
		<c:forEach items="${home_book_inner}" var ="bi">
         <div class="row form-inline" style="height:90px" id="testing">
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<a href="<c:url value="book-detail?no=${bi.no }&item_no=${bi.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${bi.title}</a>
                  	<h5 style="font-size: 13px">${bi.writer}</h5>
                    <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                    <h5 style="font-size: 13px">${bi.reg}</h5>
                  </div>
                  <div id="detail"></div>
                <h5 id="detail" style="font-size: 13px;">${bi.detail}</h5>
               <div class="align-left">
                      <h5 style="font-size: 13px">${bi.b_item_no}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${bi.b_head}</h5>
                  </div>
              </div>
         </div>
      <hr/>
       </c:forEach>
	</div>
	<div style="margin-right: 0px, font-size: 5px">
		<h1>도서(국외)~!</h1>
		<a href="${pageContext.request.contextPath}/list?item_no=2">전체보기(국외)</a>
		<c:forEach items="${home_book_outter}" var ="bo">
         <div class="row form-inline" style="height:90px" id="testing">
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<a href="<c:url value="book-detail?no=${bo.no }&item_no=${bo.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${bo.title}</a>
                  	<h5 style="font-size: 13px">${bo.writer}</h5>
                    <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                    <h5 style="font-size: 13px">${bo.reg}</h5>
                  </div>
                  <div id="detail"></div>
                <h5 id="detail" style="font-size: 13px;">${bo.detail}</h5>
               <div class="align-left">
                      <h5 style="font-size: 13px">${bo.b_item_no}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${bo.b_head}</h5>
                  </div>
              </div>
         </div>
      <hr/>
       </c:forEach>
	</div>
	
</div>
<div id="caption">
	<div style="margin-right: 0px, font-size: 5px">
		<h1>영화(국내)~!</h1>
		<a href="${pageContext.request.contextPath}/list?item_no=3">전체보기(국내)</a>
		<c:forEach items="${home_movie_inner}" var ="mi">
         <div class="row form-inline" style="height:90px" id="testing">
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<a href="<c:url value="movie/movie-detail?no=${mi.no }&item_no=${mi.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${mi.title}</a>
                  	<h5 style="font-size: 13px">${mi.writer}</h5>
                    <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                    <h5 style="font-size: 13px">${mi.reg}</h5>
                  </div>
                  <div id="detail"></div>
                <h5 id="detail" style="font-size: 13px;">${mi.detail}</h5>
               <div class="align-left">
                      <h5 style="font-size: 13px">${mi.b_item_no}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${mi.b_head}</h5>
                  </div>
              </div>
         </div>
      <hr/>
       </c:forEach>
	</div>
	<div style="margin-right: 0px, font-size: 5px">
		<h1>영화(국외)~!</h1>
		<a href="${pageContext.request.contextPath}/list?item_no=4">전체보기(국외)</a>
		<c:forEach items="${home_movie_outter}" var ="mo">
         <div class="row form-inline" style="height:90px" id="testing">
             <div class="area-80"> 
                <div style="padding-top:10px">
                	<a href="<c:url value="movie/movie-detail?no=${mo.no }&item_no=${mo.item_no }" />" style="font-size: 13px; width:600px; margin-top:10px " id="block" >${mo.title}</a>
                  	<h5 style="font-size: 13px">${mo.writer}</h5>
                    <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                    <h5 style="font-size: 13px">${mo.reg}</h5>
                  </div>
                  <div id="detail"></div>
                <h5 id="detail" style="font-size: 13px;">${mo.detail}</h5>
               <div class="align-left">
                      <h5 style="font-size: 13px">${mo.b_item_no}</h5>
                      <h5 style="font-size: 13px; padding-left:15px; padding-right:15px">&#124;</h5>
                     <h5 style="font-size: 13px">${mo.b_head}</h5>
                  </div>
              </div>
         </div>
      <hr/>
       </c:forEach>
	</div>
	
</div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
