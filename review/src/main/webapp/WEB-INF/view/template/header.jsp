<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
   <head>
   <title>리뷰 사이트</title>
<!--    <meta charset="utf-8"> -->
<!--    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->

   <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
   <script type="text/javascript" src="<c:url value="/smarteditors/js/HuskyEZCreator.js"/>" charset="utf-8"></script>
   <script type="text/javascript" src="<c:url value="/js/bootstrap.min.js"/>"></script>
   <script>
//    $(document).ready(function(){
//       $(".menu-name > li").on("click", function(){
//          //console.log("첫번째 = "+$(this).val());
//       });
//       $(".menu-name > li > ul > li").on("click", function(){
//          console.log("카테고리 = "+$(this).val());
//          console.log("소제목 = "+$(this).parent().parent().val());
//          var item_no = $(this).parent().parent().val();
//          var head = $(this).val();
//             $.ajax({
//                 url:"list",
//                 type:"post",
//                 data:{
//                    "item_no":item_no, 
//                    "head" : head,
//                 },
//                 success:function() {
//                 	log.console(head);
//                    console.log("데이터 전송 완료");
//                 }
//              });         
//       });
//    });

	//err라는 파라미터가 있다면 보여줌
   $(document).ready(function(){
	var err = "${err}";
	if(err!="") {
		window.alert(err);
	}
});
   
   </script>
   <link rel="stylesheet" type="text/css" href="<c:url value="/css/layout.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/design.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.css" />">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<style>
@font-face{
   font-family: bmdohyeon;
   src: url('${pageContext.request.contextPath}/font/BMDOHYEON_ttf.ttf')
}
@font-face{
   font-family: binggrae;
   src: url('${pageContext.request.contextPath}/font/Binggrae.ttf')
}
@font-face{
   font-family: bmjua;
   src: url('${pageContext.request.contextPath}/font/BMJUA_ttf.ttf')
}
@font-face{
   font-family: hoonwhitecatr;
   src: url('${pageContext.request.contextPath}/font/HoonWhitecatR.ttf')
}
.menu-wrap>ul>li>a {
   text-decoration: none;
   font-size: 18px;
   font-family: binggrae;
   font-weight: bold;
   color : cornflowerblue;
}
/* 메인 메뉴 스타일 */
.menu-wrap {
/*     background-color: gray; */
   width: 900px;
   margin: 0 auto;
}

.menu-wrap>ul {
   list-style: none;
   display: block;
   margin-top: 10px; 
   margin-left: -80px;
}

.menu-wrap>ul>li {
   border-radius: 5px;
   display: inline-block;
}

.menu-wrap> ul > li > ul > li > a {
   font-family: binggrae;
    display: inline-block; 
   font-weight: bold;
   text-decoration: none;
   width: 100%;
   padding:10px;
   margin:0px;
}

/* 서브메뉴 스타일 */
.menu-wrap li ul {
   position: absolute;
     display: none;  
   width: 150px;
    background: #C5DDE9;
    opacity: 0.825;
   list-style: none;
   margin-top: 10px;
    margin-left: -10px; 
   padding: 0px;
   font-size: 15px;
   border-radius: 5px;
   z-index: 1000;/*항상위로*/
}

.menu-wrap >ul>li {
   padding: 10px 5px;
}
.menu-wrap > ul > li > a{
   padding: 11px;
}

.menu-wrap li:hover {
   background-color: white;
}

.menu-wrap li:hover>ul {
   display: block;
}

#caption{
   margin:60px 50px 20px;
    color: deeppink;
/*     border:1px solid black; */
    background:rgba(100,100,100, 0.3);
    order: 1;
}

#home_article{
   background-image: url('${pageContext.request.contextPath}/img/sea_crop_left.jpg');
/*    opacity: 0.825; */
}
aside{
/*    background-color: #e4e8f1; */
/*       background: linear-gradient(#e3e7f0, #50b1d7); */
   background-image: url('${pageContext.request.contextPath}/img/sea_crop_right.jpg');
/*    opacity: 0.825; */
}

.imgHeader{
   background-image: url('${pageContext.request.contextPath}/img/pencil.jpg');
   color: white;
   align-content: center;
   margin: 0 auto;
   width: 1000px;
   height: 300px;
   border: 0;
   padding: 180 0 0 80;
}


/* login-form */
.loginform-wrap{
   width: 200px;
   height: 10px;
}
.login-location{
   display: inline-block; 
   margin-left: -7px;
}
.login-location-tab{
   border: 2;
   border-collapse: collapse; 
   border-color: lightblue;
}
.login-loc-text{
   width: 130px;
}
.left{
   margin-right: 2em;
   display: inline-block;
}
.right {
   margin-left: auto;
   display: inline-block;
}
.edit-btn{
   width: 30px; height: 20px; 
   font-size: 7px; 
   background-color: white; 
   border-radius: 5px; 
   outline: 0; 
   padding: 0px;
}

.login_tab{
   border: 1;
   border-collapse: collapse;
}
.login_sub > input{
   margin: 0 auto;
   width: 55px;
   height: 50px;
   background-color: dodgerblue;
   color: white;
}
.input-group, .form-control{
   height: 40px !important;
   margin: 0 auto !important;
}


/* menu 상단 searchbar */
.search-bar{
   margin-bottom: -20px;
}
.search-bar > button{
   width: 40px;
   height: 40px;
   background-color: lightblue;
   cursor: pointer;
}

 .searchicon{ 
   padding:2px;
 } 
.form-control, .searchicon{
   border: 2px solid lightblue;
}

#scrolldiv{
   cursor: pointer;
}

#rankbar{
   width: 200px;
}
#rankTable{
   margin: 0 auto;
   padding: 0;
   background-color: #C5DDE9;
}
#rankUnit{
   display: inline-block;
   font-size: 13px;
   text-align: left;
   width: 110px;
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
   padding: 1px;
}
#rankLabel{
   width:15px;
   background-color: red;
   text-align: center;
   font-size: 12px;
   color: white;
   margin-left:0;
   margin-bottom: 0;
   border-radius: 5px;
}

/* main-view */
.main-page{
   display: flex;
   flex-wrap: wrap;
   background-color: white; 
   padding: 10px 10px; 
   margin: 10px 10px; 
   opacity: 0.7;
   font-size: 15px;
   border-radius: 5px;
}
.main-left{
   order:2;
   width:50%;
   height:200px;
   flex-grow:1;
}
.main-right{
   order:4;
   width:50%;
   flex-grow:1;
}
.sub-left > a{
   font-size: 25px;
}
.sub-right > a{
   margin-right: 20px;
}
.head-td{
   width: 15%; 
   font-size: 12px;
}
.title-td{
   width: 40%;
}
.writer-td{
   width: 20%; 
   font-size: 12px;
}
.reg-td{
   width: 25%; 
   font-size: 10px;
}

body{
	cursor:url('${pageContext.request.contextPath}/img/Blue Pencil 1 Normal.cur'), pointer; 
}


</style>
</head>
<body>
   <%-- header (상단) --%>
   <header class="imgHeader">
      <div class="menu-wrap">
         <ul class="menu-name">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li value="3"><a href="${pageContext.request.contextPath}/list?item_no=3">국내영화</a>
               <ul>
                  <li value="101"><a href="${pageContext.request.contextPath}/list?item_no=3&head=101">SF/판타지</a></li>
                  <li value="102"><a href="${pageContext.request.contextPath}/list?item_no=3&head=102">드라마</a></li>
                  <li value="103"><a href="${pageContext.request.contextPath}/list?item_no=3&head=103">전쟁/모험</a></li>
                  <li value="104"><a href="${pageContext.request.contextPath}/list?item_no=3&head=104">미스터리/스릴러</a></li>
                  <li value="105"><a href="${pageContext.request.contextPath}/list?item_no=3&head=105">애니메이션</a></li>
                  <li value="106"><a href="${pageContext.request.contextPath}/list?item_no=3&head=106">코미디</a></li>
                  <li value="107"><a href="${pageContext.request.contextPath}/list?item_no=3&head=107">액션/느와르</a></li>
                  <li value="199"><a href="${pageContext.request.contextPath}/list?item_no=3&head=199">기타</a></li>
               </ul></li>
            <li value="4"><a href="${pageContext.request.contextPath}/list?item_no=4">해외영화</a>
               <ul>
                  <li value="101"><a href="${pageContext.request.contextPath}/list?item_no=4&head=101">SF/판타지</a></li>
                  <li value="102"><a href="${pageContext.request.contextPath}/list?item_no=4&head=102">드라마</a></li>
                  <li value="103"><a href="${pageContext.request.contextPath}/list?item_no=4&head=103">전쟁/모험</a></li>
                  <li value="104"><a href="${pageContext.request.contextPath}/list?item_no=4&head=104">미스터리/스릴러</a></li>
                  <li value="105"><a href="${pageContext.request.contextPath}/list?item_no=4&head=105">애니메이션</a></li>
                  <li value="106"><a href="${pageContext.request.contextPath}/list?item_no=4&head=106">코미디</a></li>
                  <li value="107"><a href="${pageContext.request.contextPath}/list?item_no=4&head=107">액션/느와르</a></li>
                  <li value="199"><a href="${pageContext.request.contextPath}/list?item_no=4&head=199">기타</a></li>
               </ul></li>
            <li value="1"><a href="${pageContext.request.contextPath}/list?item_no=1">국내도서</a>
               <ul>
                  <li value="1"><a href="${pageContext.request.contextPath}/list?item_no=1&head=1">SF/판타지/무협</a></li>
                  <li value="2"><a href="${pageContext.request.contextPath}/list?item_no=1&head=2">추리</a></li>
                  <li value="3"><a href="${pageContext.request.contextPath}/list?item_no=1&head=3">로맨스</a></li>
                  <li value="4"><a href="${pageContext.request.contextPath}/list?item_no=1&head=4">공포/스릴러</a></li>
                  <li value="5"><a href="${pageContext.request.contextPath}/list?item_no=1&head=5">역사</a></li>
                  <li value="6"><a href="${pageContext.request.contextPath}/list?item_no=1&head=6">시/에세이</a></li>
                  <li value="7"><a href="${pageContext.request.contextPath}/list?item_no=1&head=7">철학/종교</a></li>
                  <li value="8"><a href="${pageContext.request.contextPath}/list?item_no=1&head=8">과학</a></li>
                  <li value="99"><a href="${pageContext.request.contextPath}/list?item_no=1&head=99">기타</a></li>
               </ul></li>
            <li value="2"><a href="${pageContext.request.contextPath}/list?item_no=2">해외도서</a>
               <ul>
                  <li value="1"><a href="${pageContext.request.contextPath}/list?item_no=2&head=1">SF/판타지/무협</a></li>
                  <li value="2"><a href="${pageContext.request.contextPath}/list?item_no=2&head=2">추리</a></li>
                  <li value="3"><a href="${pageContext.request.contextPath}/list?item_no=2&head=3">로맨스</a></li>
                  <li value="4"><a href="${pageContext.request.contextPath}/list?item_no=2&head=4">공포/스릴러</a></li>
                  <li value="5"><a href="${pageContext.request.contextPath}/list?item_no=2&head=5">역사</a></li>
                  <li value="6"><a href="${pageContext.request.contextPath}/list?item_no=2&head=6">시/에세이</a></li>
                  <li value="7"><a href="${pageContext.request.contextPath}/list?item_no=2&head=7">철학/종교</a></li>
                  <li value="8"><a href="${pageContext.request.contextPath}/list?item_no=2&head=8">과학</a></li>
                  <li value="99"><a href="${pageContext.request.contextPath}/list?item_no=2&head=99">기타</a></li>
               </ul></li>
            <li><a href="${pageContext.request.contextPath}/list?item_no=6">기타</a></li>
            <li><a href="${pageContext.request.contextPath}/list?item_no=7">자유게시판</a></li>
            <li><a href="${pageContext.request.contextPath}/list?item_no=0">공지</a></li>
            <li><a href="${pageContext.request.contextPath}/attend">출석체크</a></li>
            
         </ul>
      </div>
      <div style="margin-left: 600px;">
         <form action="${pageContext.request.contextPath}/list?item_no=9">
            <div class="col-lg-6">
               <div class="input-group">
                  <input type="search" style="width: 200px;" placeholder="검색어" class="form-control" name = "word" required>
                  <span class="input-group-btn search-bar">
                     <button class="btn btn-default searchicon " type="submit"><i class="xi-search xi-2x"></i></button>
                  </span>
               </div>
            </div>
         </form>
      </div>
   </header>
   <%-- body (몸) --%>
   <div id='main'>
