<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <aside>
		<div id="loginbar">
		<c:if test="${sessionScope.member eq null}">
		<form action="login" method="post">
			<div class="loginform-wrap">
				<table class="login_tab">
					<tr>
						<td width="100">
							<input type="text" placeholder="id" name = "id" style="width: 130">
						</td>
						<td class="login_sub" rowspan="2" width="80">
							<input type="submit" value="login">
						</td>
					</tr>
					<tr>
						<td>
							<input type="password" placeholder="password" name = "pw" style="width: 130">
						</td>
					</tr>
				</table>
			</div>
			<br><br>
			<input type="checkbox"><small>로그인 유지</small>
			<br>
			<small><a href="tos">회원가입</a></small>&nbsp;&nbsp;
			<small><a href="forget">ID/</a></small>
			<small><a href="forgetpw">PW 찾기</a></small>
		</form>		
		</c:if>
		<c:if test = "${sessionScope.member ne null }">
			닉네임 : ${sessionScope.member.nickname }&#40;${sessionScope.member.id}&#41;<br>
			포인트 : ${sessionScope.member.point }<br>
			<input type="button" value="로그아웃" onclick="location.href='logout'"> 
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
