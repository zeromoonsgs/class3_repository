<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어트랙션</title>
<style type="text/css">

#digger{
padding: 0px; margin: 0px;
/* 	테두리 기준으로 너비 계산 */	
	float: right;
	clear: both;


}

#con{
padding: 0px; margin: 0px;
/* 	테두리 기준으로 너비 계산 */	
	float: right;
	clear: both;


}


</style>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>

<body><div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="main_img"><img src="../images/main_img.jpg"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">attraction</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<br>
			<h1><i>너구리월드 어트랙션 소개</i></h1>
			<h2 style= "color:navy;">- ♪ ♬ 자이언트 너구리 디거 ♪ ♬</h2><br>
	
<iframe width="700" height="600" id="digger" src="https://www.youtube.com/embed/h_KTgyLTzIE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><br>		
		
		<br>
		<br>
		<br>
		
		
		<div id="con">
		<p style="font-size: medium; color:orange;"><b>
		▶언더랜드 너구리들의 자랑 광산열차!<br><br>
		 ▷놀라운 스피드와 엄청난 스릴!<br><br>
		</b>
		</p>
		<h1>---------------------------------------------------------------------</h1><br>
				<h2 style="color: green;">*이용안내*</h2>
				
	                       <ul>
                        <li>
                              <div class="tit"><span class="icon"><img src="/common/images/guide-list-icon3.png" alt=""></span><b>탑승제한</b></div>
                              <div class="txt">
									<p class="icon_txt"><img src="/common/images/guide-board-icon1.png" alt=""><span>음주</span></p>
											<p class="icon_txt"><img src="/common/images/guide-board-icon2.png" alt=""><span>임산부</span></p>
						                    <p class="icon_txt"><img src="/common/images/guide-board-icon3.png" alt=""><span>심/혈관계 질환자</span></p>
						                    <p class="icon_txt"><img src="/common/images/guide-board-icon4.png" alt=""><span>디스크환자</span></p>
						                    </div>
                          	</li>
                          <li>
                              <div class="tit"><span class="icon"><img src="/common/images/guide-list-icon4.png" alt=""></span><b>신장제한</b></div><br>
                              <div class="txt">
		                		130cm 이상 탑승 가능                             
<!--                                   <br/> -->
<!--                                   		동반자 탑승가능 -->
</div>
                          </li>
                           <br>  
                          <li><!-- 2021-05-21 플러스 팁 위치 변경 -->
                                            <div class="tit"><span class="icon"><img src="/common/images/guide-list-icon9.png" alt=""></span><b>플러스 팁</b></div><br>
                                            <div class="txt">
                                                탑승 전 스트레칭 필수!</div>
                                        </li>
              			  </ul>
		</div>
		
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<%@ include file="../inc/bottom.jsp" %>
		<!-- 푸터 들어가는곳 -->
	</div>


</body>
</html>