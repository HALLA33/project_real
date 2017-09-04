<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%-- header.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/header.jsp" %>  

<article>
<%-- 컨테이너 영역 --%>
<div>
            <div>
                <ul>
                <li>출석부</li>
                </ul>
                <div>
                    <span class="left">
                        <input class="date-btn" type="button" value="2017년 8월 30일 20시 20분 20초">
                    </span>
                    <span class="right">
                        <input class="none-btn" type="button" value="<<이전달">
                        <input class="date-btn" type="button" value="이번달">
                        <input class="none-btn" type="button" value="다음달>>">
                    </span>
                </div>
                <table border="1" class="c-table">
                    <tr>
                        <th>출석점수</th>
                        <th>??</th>
                        <th>개근점수</th>
                        <th>자세히보기(drop)</th>
                        <th>랭킹점수</th>
                        <th>자세히보기(drop)</th>
                        <th>출석권한</th>
                        <th>??</th>
                    </tr>
                    <tr>
                        <th>출석시간</th>
                        <th>00:00:00 ~ 24:00:00</th>
                        <th>진행상태</th>
                        <th>??</th>
                        <th>출석여부</th>
                        <th>??</th>
                        <th><a href="#">개근분류</a></th>
                        <th>
                            <div class="menu-wrap">
                                <a href="#">자세히보기▼</a>
                                <ul>
                                    <li>
                                        <table>
                                            <tr>
                                                <td>개근분류</td>
                                            </tr>
                                            <tr>
                                                <td>주 月 年<br><font color="red">최근만 표시</font></td>
                                            </tr>
                                        </table>
                                    </li>
                                </ul>
                            </div>
                        </th>
                    </tr>
                </table>
                <table>
                    <tr align="center">
                        <td><span>1<br><input type="checkbox"/></span></td>
                        <td>
                            <span>2</span><br><input type="checkbox"/>
                        </td>
                        <td>
                            ....
                        </td>
                        <td>
                            <span>30</span><br><input type="checkbox"/>
                        </td>
                        <td>
                            <span>31</span><br><input type="checkbox"/>
                        </td>
                    </tr>
                </table>
                <div>
                    <span class="left">
                        <img src="http://placehold.it/15x15">결석 
                        <img src="http://placehold.it/15x15">출석 
                        <img src="http://placehold.it/15x15">미출석</span>
                    <span class="right"> ** 이전달은 가입일까지 열람이 가능합니다.</span>
                </div>
                <div class="login-view">
                    로그인을 하지 않았습니다
                </div>
            </div>
            <table border="0" id="line">
                <tr>
                    <td>순위</td>
                    <td>출석시간</td>
                    <td style="width: 50%">인사말</td>
                    <td>별명</td>
                    <td>포인트</td>
                    <td>개근</td>
                    <td>총 출석일</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>21:01:31</td>
                    <td>좋은 하루 되세요~!!</td>
                    <td>야랄랄라</td>
                    <td>230</td>
                    <td>25 일째</td>
                    <td>30 일</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>21:00:01</td>
                    <td>좋은 하루 되세요~!!</td>
                    <td>저세상</td>
                    <td>77</td>
                    <td>13 일째</td>
                    <td>13 일</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>20:59:51</td>
                    <td>좋은 하루 되세요~!!</td>
                    <td>dulie</td>
                    <td>30</td>
                    <td>3 일째</td>
                    <td>10 일</td>
                </tr>
            </table>
            <div class="row">
                 <div class="paging-wrap">
                     <div class="paging-unit"><a href="#">&lt;</a></div>
                     <div class="paging-unit active"><a href="#">1</a></div>
                     <div class="paging-unit"><a href="#">2</a></div>
                     <div class="paging-unit"><a href="#">3</a></div>
                     <div class="paging-unit"><a href="#">4</a></div>
                     <div class="paging-unit"><a href="#">5</a></div>
                     <div class="paging-unit"><a href="#">6</a></div>
                     <div class="paging-unit"><a href="#">7</a></div>
                     <div class="paging-unit"><a href="#">8</a></div>
                     <div class="paging-unit"><a href="#">9</a></div>
                     <div class="paging-unit"><a href="#">10</a></div>
                     <div class="paging-unit"><a href="#">&gt;</a></div>
                 </div>
             </div>
        </div>
</article>
      
<%-- footer.jsp를 불러와서 배치하는 코드 --%>
<%@ include file="/WEB-INF/view/template/footer.jsp" %> 
