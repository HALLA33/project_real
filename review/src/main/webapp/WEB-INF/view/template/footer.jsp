<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <aside>
		<div id="loginbar" style="font-family: bmjua; font-size: 13px;">
		<c:if test="${sessionScope.member eq null}">
		<form action="login" method="post">
			<div class="loginform-wrap">
				<div class="login-location">
					<table border="2" class="login-location-tab">
						<tr>
							<td><input type="text" placeholder="id" name="id" class="login-loc-text" required></td>
						</tr>
						<tr>
							<td><input type="password" placeholder="pw" name="pw" class="login-loc-text" required></td>
						</tr>
					</table>
				</div>
				<div class="login-location">
					<table border="2" class="login-location-tab">
						<tr style="height: 57px;">
							<td rowspan="2"><input type="submit" value="login" style="height: 53px;margin: 0 auto;
	width: 55px;
	height: 53px;
	background-color: dodgerblue;
	color: white; border-radius: 5px; cursor: pointer;"></td>
						</tr>
					</table>
				</div>
			</div>
			<br><br>
			<input type="checkbox" id="remember" style="margin: 20 0 10 0; cursor: pointer;">
			<label for="remember" style="font-size:13px; margin-left:0px; cursor: pointer;">로그인 유지</label>
			<br>
			<a href="tos">회원가입</a>&nbsp;&nbsp;
			<a href="forget">ID</a>&nbsp;/
			<a href="forgetpw">PW 찾기</a>
		</form>		
		</c:if>
		<c:if test = "${sessionScope.member ne null }">
			<div class="left">
				닉네임 : <a href="myinfo">${sessionScope.member.nickname }&#40;${sessionScope.member.id}&#41;</a>
			</div>
			<div class="right">
				<button class="edit-btn" onclick="location.href='myedit'">edit</button>
			</div>
			<div>
				<div class="left">
					포인트 : <a href="#" class="left">${sessionScope.member.point }</a>
				</div>
				<div class="right" style="margin-bottom: 10px;"> 
					<input type="button" value="로그아웃" onclick="location.href='logout'" style="backgborder-radius: 5px; font-size: 8px; background-color: white;">
				</div>
			</div>
			<a href="#">내가 쓴 글</a>
		</c:if>
		</div>
		<div>
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
				<img src="http://placehold.it/200x200">
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
