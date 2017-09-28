<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<article id="home_article">
	<%-- 컨테이너 영역 --%>
	<!-- 공지 -->
	<div class="main-page">
		<div style="margin-right: 0px, font-size: 5px">
			<h1>공지글~!</h1>
			<a href="${pageContext.request.contextPath}/list?item_no=0">전체보기</a>
			<table>
				<c:forEach items="${home_notice}" var="notice">
					<tr>
						<td><a href="<c:url value="book-detail?no=${notice.no }&item_no=${notice.item_no }" />"
									style="font-size: 13px; width: 600px; margin-top: 10px"
									id="block">${notice.title}</a></td>
						<td>${notice.writer}</td>
						<td>${notice.reg}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<!-- 도서 -->
	<div class="main-page">
		<div class="main-left" style="margin-right: 0px, font-size: 5px">
			<h1>도서(국내)~!</h1>
			<a href="${pageContext.request.contextPath}/list?item_no=1">전체보기(국내)</a>
			<table>
				<c:forEach items="${home_book_inner}" var="bi">
					<tr>
						<td><a href="${pageContext.request.contextPath}/list?item_no=${bi.item_no }&head=${bi.head }">${bi.b_head}</a></td>
						<td><a href="<c:url value="book-detail?no=${bi.no }&item_no=${bi.item_no }" />"
									style="font-size: 13px; width: 600px; margin-top: 10px"
									id="block">${bi.title}</a></td>
						<td>${bi.writer}</td>
						<td>${bi.reg}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="main-page">
			<h1>도서(국외)~!</h1>
			<a href="${pageContext.request.contextPath}/list?item_no=2">전체보기(국외)</a>
			<table>
				<c:forEach items="${home_book_outter}" var="bo">
					<tr>
						<td><a href="${pageContext.request.contextPath}/list?item_no=${bo.item_no }&head=${bo.head }">${bo.b_head}</a></td>
						<td><a href="<c:url value="book-detail?no=${bo.no }&item_no=${bo.item_no }" />"
									style="font-size: 13px; width: 600px; margin-top: 10px"
									id="block">${bo.title}</a></td>
						<td>${bo.writer}</td>
						<td>${bo.reg}</td>
					</tr>
				</c:forEach>
			</table>
		</div>

	</div>
	
	<!-- 영화 -->
	<div class="main-page">
		<div class="main-left" style="margin-right: 0px, font-size: 5px">
			<h1>영화(국내)~!</h1>
			<a href="${pageContext.request.contextPath}/list?item_no=3">전체보기(국내)</a>
			<table>
				<c:forEach items="${home_movie_inner}" var="mi">
					<tr>
						<td><a href="${pageContext.request.contextPath}/list?item_no=${mi.item_no }&head=${mi.head }">${mi.b_head}</a></td>
						<td><a href="<c:url value="movie/movie-detail?no=${mi.no }&item_no=${mi.item_no }" />"
									style="font-size: 13px; width: 600px; margin-top: 10px"
									id="block">${mi.title}</a></td>
						<td>${mi.writer}</td>
						<td>${mi.reg}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="main-right" style="margin-right: 0px, font-size: 5px">
			<h1>영화(국외)~!</h1>
			<a href="${pageContext.request.contextPath}/list?item_no=4">전체보기(국외)</a>
			<table>
				<c:forEach items="${home_movie_outter}" var="mo">
					<tr>
						<td><a href="${pageContext.request.contextPath}/list?item_no=${mo.item_no }&head=${mo.head }">${mo.b_head}</a></td>
						<td><a href="<c:url value="movie/movie-detail?no=${mo.no }&item_no=${mo.item_no }" />"
									style="font-size: 13px; width: 600px; margin-top: 10px"
									id="block">${mo.title}</a></td>
						<td>${mo.writer}</td>
						<td>${mo.reg}</td>
					</tr>
				</c:forEach>
			</table>
		</div>

	</div>
</article>

<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp"%>
