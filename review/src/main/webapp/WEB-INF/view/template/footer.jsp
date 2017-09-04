<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <aside>
		<div id="loginbar">
		<c:if test="${sessionScope.member eq null}">
		<form action="login" method="post">
			ID : <input type="text" placeholder="id" name = "id">
			<br><br>
			PW : <input type="password" placeholder="password" name = "pw">
			<input type="submit" value="login">
			<br><br>
			<input type="checkbox"><small>로그인유지여부			
		</form>		
			<small><a href="#">회원가입</a></small>
			<small><a href="#">ID/PW 찾기</a></small>
		</c:if>
		<c:if test = "${sessionScope.member ne null }">
			닉네임 : ${sessionScope.member.nickname }&#40;${sessionScope.member.id}&#41;<br>
			포인트 : ${sessionScope.member.point }<br>
			<input type="button" value="로그아웃" onclick="location.href='logout'"> 
		</c:if>
			</small>
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
	</div>
	
	<footer>
		footer
	</footer>
</body>
</html>