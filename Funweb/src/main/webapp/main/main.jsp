<%@page import="news.NewsBean"%>
<%@page import="news.NewsDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 들어가는곳 -->
		  
		<div class="clear"></div>   
		<!-- 본문들어가는 곳 -->
		<!-- 메인 이미지 -->
		<div id="main_img"><img src="../images/main_img2.jpg"></div>
		<!-- 본문 내용 -->
		<article id="front">
		  	<div id="solution">
		  		<div id="hosting">
		  			<h3>◈너구리월드◈</h3>
					<p>너구리 월드에 오신 것을 진심으로 환영합니다.</p>
		  		</div>
		  		<div id="security"> 
		  		  	<h3>◈공연 & 이벤트◈</h3>
					<p>매 시간 마다 펼쳐지는 아름다운 공연을 감상하세요!</p>
		  		</div>
		  		<div id="payment">
		  			<h3>◈이용요금◈</h3>
					<p>- 자유이용권</p>
					<p>- 연간이용권</p>
					
		  		</div>
		  	</div>
		  	<div class="clear"></div>
		  	
			<div id="sec_news">
				<h3><span class="orange">Public</span> News</h3>
				<table>
				<%
				
				NewsBean newsBean = new NewsBean();
				NewsDAO newsDAO = new NewsDAO();
				
				ArrayList<NewsBean> newsList = newsDAO.selectRecentNewsList();
				
				for(NewsBean news : newsList){
					
					
				%>
				
				<tr onclick="location.href='../publicnews/news_content.jsp?num=<%=news.getNum() %>&page=1'">
					<td width="320" class="contxt"  ><%=news.getSubject()%></td>
					<td width="80"><%=news.getName() %></td>
					<td width="80"><%=news.getDate() %></td>
				</tr>
				<% }%>
				</table>
			</div>
		
		
		
		
			<div id="news_notice">
		  		<h3 class="brown">News &amp; Notice</h3>
				<table>
				<%
				
				BoardBean boardBean = new BoardBean();
				BoardDAO boardDAO = new BoardDAO();
				
				ArrayList<BoardBean> boardList = boardDAO.selectRecentBoardList();
				
				for(BoardBean board : boardList){
					
					
				%>
				
				<tr onclick="location.href='../center/notice_content.jsp?num=<%=board.getNum() %>&page=1'">
					<td width="320" class="contxt"  ><%=board.getSubject()%></td>
					<td width="80"><%=board.getName() %></td>
					<td width="80"><%=board.getDate() %></td>
				</tr>
				<% }%>
				</table>
		  	</div>
	  	</article>
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
<%-- 		<jsp:include page="../inc/bottom.jsp"/> --%>
		<%@ include file="../inc/bottom.jsp" %>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


