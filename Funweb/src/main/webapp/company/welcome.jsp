<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/welcome.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="../company/welcome.jsp">Welcome</a></li>
				<li><a href="#">History</a></li>
				<li><a href="#">Newsroom</a></li>
				<li><a href="#">Public Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>★ W E L C O M E</h1><br>
			<h2> ~ 환상의 나라 너구리월드 입니다 ~</h2>
			<h3> WELCOME, NEOGURIWORLD - the fantastic world ★</h3>
			<figure class="ceo">
				<img src="../images/company/neoguri.PNG" alt="너구리월드에서 사랑받는 캐릭터">
				<figcaption>너구리월드 캐릭터 neoguriworld character <br><br><br><br><br>
				</figcaption>
			</figure>
			
			<h2>너구리월드에 방문하신 방문객 여러분, 반갑습니다.</h2>
			<p style="color:navy; ">
			* <u>너구리월드에서 가족, 친구, 사랑하는 사람들과 함께 좋은 추억을 만들어 가세요.</u> * <br>
			* <i>너구리월드는 언제나 무료개방이며, 항상 방문객 여러분들을 손꼽아 기다리고 있습니다.</i> * <br>
			* 즐거움이 넘치는 곳, 환상적인 세상! <b>너구리 월드로 어서 오세요.</b> * <br>
			 </p>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<%@ include file="../inc/bottom.jsp" %>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


