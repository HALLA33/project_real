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
			<input type="checkbox" id="remember" style="margin: 20 0 10 0; cursor: pointer;" name = "remember">
			<label for="remember" style="font-size:13px; margin-left:0px; cursor: pointer;">로그인 유지</label>
			<br>
			<a href="${pageContext.request.contextPath}/tos">회원가입</a>&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/forget">ID</a>&nbsp;/
			<a href="${pageContext.request.contextPath}/forgetpw">PW 찾기</a>
		</form>		
		</c:if>
		<c:if test = "${sessionScope.member ne null }">
			<div class="left">
				닉네임 : <a href="${pageContext.request.contextPath}/myinfo">${sessionScope.member.nickname }&#40;${sessionScope.member.id}&#41;</a>
			</div>
			<div class="right">
				<button class="edit-btn" onclick="location.href='${pageContext.request.contextPath}/myedit'">edit</button>
			</div>
			<c:if test = "${sessionScope.member.power == '관리자' }">
			<div class="right">
				<button class="edit-btn" onclick="location.href='${pageContext.request.contextPath}/member'">회원관리</button>
			</div>
			</c:if>
			<div>
				<div class="left">
					포인트 : <a href="#" class="left">${sessionScope.member.point }</a>
				</div>
				<div class="right" style="margin-bottom: 10px;"> 
					<input type="button" value="로그아웃" onclick="location.href='${pageContext.request.contextPath}/logout'" style="border-radius: 5px; font-size: 8px; background-color: white;">
				</div>
			</div>
			<a href="myboard">내가 쓴 글</a>
		</c:if>
		</div>
		<div>
			<div id="recommandbar">
			<h2>추천</h2>
			<form action="#" method="post">
			<select name="item_no" style="width:160px !important" id="margin" required>카테고리
	        	<option >선택</option>
	      		<option value = "1">국내도서</option> 
	        	<option value = "2">해외도서</option>
	        	<option value = "3">국내영화</option>
	        	<option value = "4">해외영화</option>
	        	<option value = "5">기타</option>
	   		</select><br>
	   		
	   		<select name="emotion" style="width:160px !important" id="margin" required>감정
	        	<option >선택</option>
	      		<option value = "1">love</option> 
	        	<option value = "2">good</option>
	        	<option value = "3">sogood</option>
	        	<option value = "4">fighting</option>
	        	<option value = "5">angry</option>
	        	<option value = "6">bad</option>
	        	<option value = "7">shock</option>
	        	<option value = "8">sobad</option>
	        	<option value = "9">tired</option>
	   		</select><br>
	   		
	   		<select name="wether" style="width:160px !important" id="margin" required>날씨
	        	<option >선택</option>
	      		<option value = "1">sunny</option> 
	        	<option value = "2">sunny_cloudy</option>
	        	<option value = "3">rainy</option>
	        	<option value = "4">cloudy</option>
	        	<option value = "5">night</option>
	        	<option value = "6">heavy_rain</option>
	        	<option value = "7">thunder</option>
	        	<option value = "8">packed_weather</option>
	        	<option value = "9">snowy</option>
	   		</select><br>
	   		
	   		<input type="submit" value="검색">
			<br><br>
			</form>
			</div>
			<div id="rankbar">
				<h2>랭킹</h2><br><br>
<!-- 				<img src="http://placehold.it/200x200"> -->
						<div>
							<table id="rankTable" >
								<tbody>
									<c:forEach items="${sessionScope.rankList}" var="list">
										<tr style="width:180px !important;">
											<td id=rankUnit><label id="rankLabel">${list.no}</label>&nbsp;${list.nickname }</td>
											<td style="width:60px; font-size: 12px; text-align:right">${list.point }pt</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
				<br><br>
			</div>
			<div id="rankbar">
				<h2>태그</h2><br><br>
<!-- 				<img src="http://placehold.it/200x200"> -->
						<div>
							<table id="rankTable" >
								<tbody>
									<c:forEach items="${sessionScope.tags}" var="tags">
										<tr style="width:180px !important;">
											<td id=rankUnit><a href="${pageContext.request.contextPath}/list?item_no=8&head=0&tag=${tags.tag}">#${tags.tag}</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
				<br><br>
			</div>
		</div>
	</aside>
	</div>
	
	<footer>
		footer
	</footer>
	
	<div id="scrolldiv" style="position: fixed; bottom: 60%; right: 20px;">
 		<i title="top" class="xi-arrow-top xi-2x" onclick="$( 'html, body' ).stop().animate( { scrollTop : 0 }, 500)"></i>
 	</div>
 	
 	<div id="scrolldiv" style="position: fixed; bottom: 55%; right: 20px;">
 		<i title="up" class="xi-caret-up xi-2x" onclick="$( 'html, body' ).stop().animate( { scrollTop : '-=300' } , 300)"></i>
 	</div>
 	
 	<div id="scrolldiv" style="position: fixed; bottom:50%; right: 20px;">
 		<a href="${pageContext.request.contextPath}/home"><i title="home" class="xi-home-o xi-2x"></i></a>
 	</div>
 	
 	<div id="scrolldiv" style="position: fixed; bottom: 45%; right: 20px;">
 		<i title="down" class="xi-caret-down xi-2x" onclick="$( 'html, body' ).stop().animate( { scrollTop : '+=300' } , 300)"></i>
 	</div>
 	
 	<div id="scrolldiv" style="position: fixed; bottom: 40%; right: 20px;">
 		<i title="bottom" class="xi-arrow-bottom xi-2x" onclick="$( 'html, body' ).stop().animate( { scrollTop : (document.body.scrollHeight)}, 500)"></i>
 	</div>
</body>
</html>
