<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
		<title>Pet Pal</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
		<link rel="stylesheet" href="${path}/resources/assets/css/join.css" />
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<!-- <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet"> -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
    <div id="wrapper">
        <div id="top">
            <p>회원가입</p>
            <a href="main.html"><i class="fas fa-times"></i></a>
        </div>
        <form id="frm" name="frm" method="post" action="/user/join02.do">
        
        <div id="input">
            <p id="info">집사 정보</p>
            <div id="id-box">
                <input id="id" name="user_id" type="text" placeholder="아이디">
                <a href=""><span>중복확인</span> </a>
            </div>
            <input name="user_pw" type="text" placeholder="비밀번호">
            <input type="text" placeholder="비밀번호 확인">
            <div id="id-box">
                <input id="id" type="text" placeholder="닉네임">
                <a href=""><span>중복확인</span> </a>
            </div>
            <div id="birth-box">
                <span id="birth-span">생년</br>월일</span>
                <input name="user_birth" type="date" placeholder="dd">
            </div>
            <div id="gender-box">
                <span>성별</span>
                <div>
                    <button type="button" id="gender" onclick="selectGender(this)" value="여자">여자</button>
                    <button type="button" onclick="selectGender(this)" value="남자">남자</button>
                </div>
            </div>
            <div id="day-box">
                <span id="day-span">산책</br>요일</span>
                <div>
                    <button type="button" class="day" onclick="selectDay(this)" value="월">월</button>
                    <button type="button" onclick="selectDay(this)" value="화">화</button>
                    <button type="button" onclick="selectDay(this)" value="수">수</button>
                    <button type="button" onclick="selectDay(this)" value="목">목</button>
                    <button type="button" onclick="selectDay(this)" value="금">금</button>
                    <button type="button" onclick="selectDay(this)" value="토">토</button>
                    <button type="button" onclick="selectDay(this)" value="일">일</button>
                </div>
            </div>
            <div id="time-box">
                <span id="birth-span">산책시간</span>
                <!-- <select name="day" id="">
                    <option value="오전">오전</option>
                    <option value="오후">오후</option>
                </select> -->
                <div>
                    <button type="button" id="ma" onclick="selectMA(this)" value="오전">오전</button>
                    <button type="button" onclick="selectMA(this)" value="오후">오후</button>
                </div>
                <select name="walk_hour" id="hr">
                    <option value="">시</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select>
                <span style="font-size: 0.8em;">&nbsp;: &nbsp;</span>
                <select name="walk_minute" id="mn">
                    <option value="분">분</option>
                    <option value="morning">00</option>
                    <option value="afternoon">30</option>
                    
                </select>
            </div>
            <div id="place-box">
                <span id="place-span">산책</br>장소</span>
                <div>
                    <input name="walk_place1" type="text" placeholder="자주 가는 산책장소를 작성해주세요">
                    <input name="walk_place2" type="text" placeholder="자주 가는 산책장소를 작성해주세요">
                </div>
            </div>
            <div id="style-box">
                <span>산책 스타일</span>
                <textarea name="walk_style" id="style" placeholder="평소 산책 스타일을 적어주세요!"></textarea>
            </div>
            </form>
            <div id="submit-btn">
                <a href="javascript:void(0)" onclick="submit()" ><span>다음</span></a>
            </div>
        </div>
        
        
    </div>

    <!-- Scripts -->
			<script src="${path}/resources/assets/js/jquery.min.js"></script>
			<script src="${path}/resources/assets/js/browser.min.js"></script>
			<script src="${path}/resources/assets/js/breakpoints.min.js"></script>
			<script src="${path}/resources/assets/js/util.js"></script>
			<script src="${path}/resources/assets/js/main.js"></script>
</body>
<script>   

	function submit(){
		frm.submit();
	}

    function selectGender(e){
        $("#gender").attr("id", "");
        $(e).attr("id", "gender");
    }

    function selectDay(e) {
        if($(e).attr("class") == "day"){
            console.log($(".day").length);
            if($(".day").length == 1){
                alert("최소 한개는 선택해야합니다.")
            }else {
                $(e).attr("class", "");
            }
            
        }else {
            $(e).attr("class", "day");
            
        }
    }

    function selectMA(e) {

        $("#ma").attr("id", "");
        $(e).attr("id", "ma");
    }


</script>
</html>