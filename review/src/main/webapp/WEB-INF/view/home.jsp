<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<h1>어서오세요~!</h1>
<img src="http://placehold.it/800x400">
</article>

<aside>
	<div id="loginbar">
		ID : <input type="text" placeholder="id">
		<br><br>
		PW : <input type="password" placeholder="password"><input type="submit" value="login">
		<br><br>
		<input type="checkbox"><small>로그인유지여부
		</small>
		<small><a href="#">회원가입</a></small>
		<small><a href="#">ID/PW 찾기</a></small>
	</div>
	<div>
		추천&랭킹
		<div id="recommandbar">
		<h2>추천</h2>
		오늘의 추천 영화<br>
		<img src="http://placehold.it/80x40">
		<br><br>
		오늘의 추천 도서<br>
		<img src="http://placehold.it/80x40">
		<br><br>
		</div>
		<div id="rankbar">
			<h2>랭킹</h2>
			랭킹이미지?<br>
			<img src="http://placehold.it/300x200">
			<br><br>
		</div>
	</div>
</aside>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
