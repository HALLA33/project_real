<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
	<title>리뷰 사이트</title>
<!-- 	<meta charset="utf-8"> -->
<!-- 	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->

	<link rel="stylesheet" type="text/css" href="<c:url value="/css/layout.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/design.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap/bootstrap.min.css" />">
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
	<script type="text/javascript" src="<c:url value="/smarteditor/js/service/HuskyEZCreator.js"/>" charset="utf-8"></script>
	<script type="text/javascript" src="<c:url value="/css/bootstrap/js/bootstrap.min.js"/>"></script>
	<script>
	$(document).ready(function(){
		$(".sub-wrap").on("click", function(){
			console.log($(this).childrens().text());
		});
	});
	</script> 
	</head>
<body>
	<%-- header (상단) --%>
	<header>
		검색 공간
		<a href="attend">attend</a>
		<a href="check">check</a>
		<a href="forget">forget</a>
		<a href="forgetpw">forgetpw</a>
		<a href="member">member</a>
		<a href="myedit">myedit</a>
		<a href="myinfo">myinfo</a>
		<a href="sign">sign</a>
		<a href="tos">tos</a>
	</header>
	<%-- body (몸) --%>
	<div id='main'>
        <nav class = "menu-wrap">
            <ul>
                <li>
                    <h1>영화</h1>
                    <ul >
                        <li class ="sub-wrap">
                        	<a href="list">국내 영화</a>
                            <ul>
                               <li><a href="#">SF/판타지</a></li>
                                <li><a href="#">드라마</a></li>
                                <li><a href="#">전쟁/모험</a></li>
                                <li><a href="#">미스터리/스릴러</a></li>
                                <li><a href="#">애니메이션</a></li>
                                <li><a href="#">코미디</a></li>
                                <li><a href="#">액션/느와르</a></li>
                                <li><a href="#">기타</a></li> 
                            </ul>
                        </li>
                        <li class ="sub-wrap"><a href="list">외국 영화</a>
                            <ul>
                                <li><a href="#">SF/판타지</a></li>
                                <li><a href="#">드라마</a></li>
                                <li><a href="#">전쟁/모험</a></li>
                                <li><a href="#">미스터리/스릴러</a></li>
                                <li><a href="#">애니메이션</a></li>
                                <li><a href="#">코미디</a></li>
                                <li><a href="#">액션/느와르</a></li>
                                <li><a href="#">기타</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul>
                <li>
                    <h1>도서</h1>
                    <ul>
                        <li class ="sub-wrap"><a href="list">국내 도서</a>
                            <ul>
                                <li><a href="#">SF/판타지/무협</a></li>
                                <li><a href="#">추리</a></li>
                                <li><a href="#">로맨스</a></li>
                                <li><a href="#">공포/스릴러</a></li>
                                <li><a href="#">역사</a></li>
                                <li><a href="#">시/에세이</a></li>
                                <li><a href="#">철학/종교</a></li>
                                <li><a href="#">과학</a></li>
                                <li><a href="#">기타</a></li>
                            </ul>
                            
                        </li>
                        <li class ="sub-wrap"><a  href="list">외국 도서</a>
                            <ul>
                                <li><a href="#">SF/판타지/무협</a></li>
                                <li><a href="#">추리</a></li>
                                <li><a href="#">로맨스</a></li>
                                <li><a href="#">공포/스릴러</a></li>
                                <li><a href="#">역사</a></li>
                                <li><a href="#">시/에세이</a></li>
                                <li><a href="#">철학/종교</a></li>
                                <li><a href="#">과학</a></li>
                                <li><a href="#">기타</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul>
                <li>
                    <h1><a href="#">공연</a></h1>
                </li>
            </ul>
            <ul>
                <li>
                    <h1><a href="#">기타</a></h1>
                </li>
            </ul>
            
        </nav>
</div>