<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	// 아이디 중복확인 여부와 패스워드 확인 결과를 저장할 전역변수 선언
	var checkIdResult = false, checkRetypePassResult = false; 
	var checkPassResult = false;

	function checkPass(pass){
		
		var spanElem = document.getElementById("checkPassResult");
		var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
		var engUpperRegex = /[A-Z]/;
		var engLowerRegex = /[a-z]/;
		var numRegex = /[0-9]/;
		var specRegex = /[!@#$%]/;
		
		var count = 0;
		
// 		var regex = /^[A-Za-z0-9!@#$%]{8,16}$/;
	
		if(lengthRegex.exec(pass)){
			
			if(engUpperRegex.exec(pass)) count++;
			if(engLowerRegex.exec(pass)) count++;
			if(numRegex.exec(pass)) count++;
			if(specRegex.exec(pass)) count++;
			
			switch (count){
			case 4 :
				
				spanElem.innerHTML = "보안 강도 : 우수"
		 		spanElem.style.color = "GREEN";
		 		checkPassResult = true;
			
				break;
				
			case 3 :
				
				spanElem.innerHTML = "보안 강도 : 보통"
		 		spanElem.style.color = "YELLOW";
		 		checkPassResult = true;
		 		
				break;
				
			case 2 : 
				
				spanElem.innerHTML = "보안 강도 : 위험"
			 	spanElem.style.color = "ORANGE";
			 	checkPassResult = true;
			 		
			 	break;
			
			default:
				
				spanElem.innerHTML = "사용 불가능한 패스워드!"
			 	spanElem.style.color = "RED";
			 	checkPassResult = false;
			 		
				break;
			}
			
// 			spanElem.innerHTML = "사용 가능한 패스워드!"
// 			spanElem.style.color = "GREEN";
// // 			document.fr.pass.focus();
// 			checkPassResult = true;
	
		} else {
				spanElem.innerHTML = "8 ~ 16자리 영문자,숫자,특수문자 필수!"
				spanElem.style.color = "RED";
				checkPassResult = false;
		
			
		}
	
	}
	
	function checkRetypePass(pass2) {
		/*
		함수에서 pass 와 pass2 의 항목 비교하여 일치하면 "패스워드 일치"(초록색) 표시하고
		아니면 "패스워드 불일치"(빨간색) 표시
		=> 패스워드 일치 시 checkRetypePassResult 를 true, 아니면 false 로 변경
		*/
		var pass = document.fr.pass.value;
		var spanElem = document.getElementById("checkRetypePassResult");
		
		if(pass == pass2) {
			spanElem.innerHTML = "패스워드 일치";
			spanElem.style.color = "GREEN";
			checkRetypePassResult = true;
			
		} else {
			spanElem.innerHTML = "패스워드 불일치";
			spanElem.style.color = "RED";
			checkRetypePassResult = false;
		}
		
		
	}
	
	function openCheckIdWindow() {
		window.open("check_id.jsp","","width=400,height=250");
	}
	
	function checkSubmit() {
		// 아이디 중복 확인 작업을 통해 아이디를 입력받았고(checkIdResult == true),
		// 패스워드 확인을 통해 두 패스워드가 동일하면(checkRetypePassResult == true) 이면
		// true 리턴, 아니면 false 리턴
		// => 아아디 중복 확인 작업과 패스워드 비교 작업 시 성공 여부를 저장할 변수 필요
		//    (이 변수는 다른 메서드에서도 접근해야하므로 함수 외부에 전역변수로 선언해야함)
		if(checkIdResult == false) { // 아이디 중복확인을 수행하지 않았을 경우
			// alert() 함수를 통해 "중복 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
			alert("아이디 중복확인 필수!");
			document.fr.id.focus();
			return false; // 현재 함수 종료
		} else if(checkRetypePassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
			// alert() 함수를 통해 "패스워드 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
			alert("패스워드 확인 필수!");
			document.fr.pass2.focus();
			return false; // 현재 함수 종료
		} else if(checkPassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
			// alert() 함수를 통해 "패스워드 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
			alert("패스워드 확인 필수!");
			document.fr.pass2.focus();
			return false; // 현재 함수 종료
		}
	}
	</script>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
// 	                if(data.userSelectedType === 'R'){
// 	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
// 	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
// 	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
// 	                        extraAddr += data.bname;
// 	                    }
// 	                    // 건물명이 있고, 공동주택일 경우 추가한다.
// 	                    if(data.buildingName !== '' && data.apartment === 'Y'){
// 	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
// 	                    }
// 	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
// 	                    if(extraAddr !== ''){
// 	                        extraAddr = ' (' + extraAddr + ')';
// 	                    }
// 	                    // 조합된 참고항목을 해당 필드에 넣는다.
// 	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
// 	                } else {
// 	                    document.getElementById("sample6_extraAddress").value = '';
// 	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>
	
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkSubmit()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" required="required" readonly="readonly" placeholder = "중복체크 버튼 클릭">
		  			<input type="button" value="dup. check" class="dup" id="btn" onclick="openCheckIdWindow()"><br>
		  			<!-- 버튼 클릭 시 새 창 띄우기(크기 : 350 * 200, 파일 : check_id.jsp) -->
		  			
		  			<label>Password</label>
		  			<input type="password" name="pass" id="pass" required="required"  placeholder ="영문, 숫자, 특수문자 8~16글자" onkeyup="checkPass(this.value)">			
		  			<span id="checkPassResult"></span><br>
		  			
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" required="required" onkeyup="checkRetypePass(this.value)">
		  			<span id="checkRetypePassResult"><!-- 패스워드 일치 여부 표시 영역 --></span><br>
		  			<!-- pass2 항목에 텍스트 입력할 때마다 자바스크립트의 checkRetypePass() 함수 호출 -->
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" required="required"><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			
<!-- 		  			<label>Post code</label> -->
<!-- 		  			<input type="text" name="post_code" id="sample6_postcode" readonly="readonly"  placeholder="검색 버튼 클릭"> -->
<!-- 		  			<input type="button" value="search" class="dup" onclick="sample6_execDaumPostcode()" ><br> -->
<!-- 						<input type="text" id="sample6_postcode" placeholder="우편번호"> -->
<!-- 						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br> -->
		  			<label>Address</label>
<!-- 						<input type="text" id="sample6_address" placeholder="주소"><br> -->
<!-- 						<input type="text" id="sample6_detailAddress" placeholder="상세주소"> -->

		  			<input type="text" name="address" id="sample6_address"> <br>
<!-- 		  			<input type="text" name="address2" id="sample6_detailAddress" placeholder="상세주소 입력"> <br> -->
<!-- 					<input type="text" id="sample6_extraAddress" placeholder="참고항목"> <br> -->
		  			
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" ><br>
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" ><br>
		  		</fieldset>

		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


