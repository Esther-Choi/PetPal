<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            <a href="/user/main.do"><i class="fas fa-times"></i></a>
        </div>
        
        <div id="input">
        <form id="frm" name="frm" method="post" action="/user/join02.do">
            <p id="info">집사 정보</p>
            <div id="id-box">
                <input id="id" name="user_id" type="text" placeholder="아이디">
                <a href="javascript:void(0)" onclick="fnCheckId()"><span>중복확인</span> </a>
            </div>
            <input name="user_pw" type="password" placeholder="비밀번호" style="margin-bottom: 0;">
            <p style="font-size: 0.6em; text-align: left; width: 95%; margin: 0 auto;margin-bottom: 5px;">영문 숫자 포함 8자리 이상 15자리 이내</p>
            <input id="pwcheck" type="password" placeholder="비밀번호 확인">
            <div id="id-box">
                <input name="user_name" id="id" type="text" placeholder="닉네임">
                <a href="javascript:void(0)" onclick="fnCheckNickname()"><span>중복확인</span> </a>
            </div>
            <div id="birth-box">
                <span id="birth-span">생년</br>월일</span>
                <input name="user_birth" type="date" placeholder="dd" onchange="fnCheckDate(this)">
            </div>
            <div id="gender-box">
                <span>성별</span>
                <div>
                    <button type="button" id="gender" onclick="selectGender(this)" value="여자">여자</button>
                    <button type="button" onclick="selectGender(this)" value="남자">남자</button>
                    <input type="hidden" name="user_gender">
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
                    <input type="hidden" name="walk_day">
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
                    <input type="hidden" name="walk_time">
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
                    <option value="">분</option>
                    <option value="00">00</option>
                    <option value="30">30</option>
                    
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
            <div id="submit-btn">
                <a href="javascript:void(0)" onclick="submit()" ><span>다음</span></a>
            </div>
            </form>
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

	var idCheck = false;
	var nameCheck = false;
	
	$("input[name='user_id']").change(function(){
		idCheck = false;
	});
	
	$("input[name='user_name']").change(function(){
		nameCheck = false;
	});
	
	fnCheckId = function(){
		
		var id = $("input[name='user_id']").val();
		
		if(id == ""){
			alert("아이디를 입력해 주세요");
		}else {
			
			$.ajax({
				type : "POST",
				data : "user_id="+id,
				url : "checkId.do",
				success : function(msg){
					if(msg == "yes"){
						
						alert("사용 가능한 아이디 입니다.");
						idCheck = true;
					}else {
						alert("사용 불가능한 아이디 입니다.");
						$("input[name='user_id']").val("");
					}
				},
				error : function(){
					alert("오류가 발생했습니다. 다시 시도해 주세요.")
				}
			});
		}
		
	};
	
	fnCheckDate = function(e){
		
		var date = new Date(); 
		var year = date.getFullYear(); 
		var month = new String(date.getMonth()+1); 
		var day = new String(date.getDate()); 

		// 한자리수일 경우 0을 채워준다. 
		if(month.length == 1){ 
		  month = "0" + month; 
		} 
		if(day.length == 1){ 
		  day = "0" + day; 
		} 

		var now = year + "-" + month + "-" + day;
		
		if($(e).val() > now){
			alert("날짜를 다시 확인해주세요");
			$(e).val("");
		}
	};
	
	fnCheckNickname = function(){
		
		var name = $("input[name='user_name']").val();
		
		if(name == ""){
			alert("닉네임을 입력해 주세요");
		}else {
			
			$.ajax({
				type : "POST",
				data : "user_name="+name,
				url : "checkNickname.do",
				success : function(msg){
					if(msg == "yes"){
						
						alert("사용 가능한 닉네임 입니다.");
						nameCheck = true;
					}else {
						alert("사용 불가능한 닉네임 입니다.");
						$("input[name='user_name']").val("");
					}
				},
				error : function(){
					alert("오류가 발생했습니다. 다시 시도해 주세요.")
				}
			});
		}
		
	};
	

	function submit(){
		
		if($("input[name='user_id']").val() == "" || $("input[name='user_pw']").val() == "" || 
				$("#pwcheck").val() == "" || $("input[name='user_name']").val() == "" || 
				$("input[name='walk_hour']").val() == "" || $("input[name='walk_minute']").val() == "" || 
				 $("input[name='walk_style']").val() == "" || $("input[name='user_name']").val() == "" || 
				 $("input[name='userbirth']").val() == ""){
			alert("빈칸을 모두 입력해주세요!");
			return false;
		} else if($("input[name='walk_place1']").val() == "" && $("input[name='walk_place2']").val() == ""){
			alert("최소 한개의 산책장소를 입력해주세요")
			return false;
		}
			
		
		if(!idCheck){
			alert("아이디 중복확인을 해주세요");
			return false;
		}
		
		if($("input[name='user_pw']").val() != $("#pwcheck").val()){
			alert("비밀번호가 일치하지 않습니다.")
			return false;
		}
		
		if(!nameCheck){
			alert("닉네임 중복확인을 해주세요");
			return false;
		}
		
		var pw = $("input[name='user_pw']").val();
		 var num = pw.search(/[0-9]/g);
		 var eng = pw.search(/[a-z]/ig);

		 if(pw.length < 8 || pw.length > 15){
			  alert("비밀번호는 8자리 ~ 15자리 이내로 입력해주세요.");
			  return false;
		 }else if(pw.search(/\s/) != -1){
			  alert("비밀번호는 공백 없이 입력해주세요.");
			  return false;
		 }else if(num < 0 || eng < 0){
			  alert("비밀번호에 영문,숫자를 혼합하여 입력해주세요.");
			  return false;
		 }
			
		
		var dayArr = new Array();
		$(".day").each(function(index, item){
			dayArr.push($(item).val());
		});
		
		
		$("input[name='user_gender']").val($("#gender").val());
		$("input[name='walk_day']").val(dayArr);
		$("input[name='walk_time']").val($("#ma").val());
		
		frm.submit();
	}

    function selectGender(e){
        $("#gender").attr("id", "");
        $(e).attr("id", "gender");
    }

    function selectDay(e) {
        if($(e).attr("class") == "day"){
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