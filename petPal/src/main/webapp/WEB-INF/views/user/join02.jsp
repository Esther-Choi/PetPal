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
        	<form name="frm" action="/user/join.do" method="post" >
        <input type="hidden" name="user_id" value="${userVO.user_id}">
        <input type="hidden" name="user_pw" value="${userVO.user_pw}">
        <input type="hidden" name="user_name" value="${userVO.user_name}">
        <input type="hidden" name="user_birth" value="${userVO.user_birth}">
        <input type="hidden" name="walk_day" value="${userVO.walk_day}">
        <input type="hidden" name="walk_time" value="${userVO.walk_time}">
        <input type="hidden" name="walk_hour" value="${userVO.walk_hour}">
        <input type="hidden" name="walk_minute" value="${userVO.walk_minute}">
        <input type="hidden" name="user_gender" value="${userVO.user_gender}">
        <input type="hidden" name="walk_place1" value="${userVO.walk_place1}">
        <input type="hidden" name="walk_place2" value="${userVO.walk_place2}">
        <input type="hidden" name="walk_style" value="${userVO.walk_style}">
            <p id="info">강아지 정보</p>
            <div id="birth-box">
                <span id="birth-span">사진</span>
                <input name="pet_photo" type="file" placeholder="">
            </div>
            <div id="birth-box">
                <span id="birth-span">이름</span>
                <input name="pet_name" type="text" placeholder="">
            </div>
            <div id="birth-box">
                <span id="birth-span">나이</span>
                <input name="pet_age" type="number" placeholder="">
            </div>
            <div id="gender-box">
                <span>성별</span>
                <div>
                    <button type="button" id="gender" onclick="selectGender(this)" value="여자">여자</button>
                    <button type="button" onclick="selectGender(this)" value="남자">남자</button>
                    <input type="hidden" name="pet_gender">
                </div>
            </div>
            <div id="birth-box">
                <span id="birth-span">종류</span>
               <select name="pet_breed" id="type" onchange="Type(this)" >
                   <option value="">종을 선택해주세요</option>
                   <option value="기타">기타</option>
                   <option value="골든 리트리버">골든 리트리버</option>
                   <option value="그레이하운드">그레이하운드</option>
                   <option value="닥스훈트">닥스훈트</option>
                   <option value="도베르만">도베르만</option>
                   <option value="래브라도 리트리버">래브라도 리트리버</option>
                   <option value="말라뮤트">말라뮤트</option>
                   <option value="말티즈">말티즈</option>
                   <option value="말티푸">말티푸</option>
                   <option value="미니핀">미니핀</option>
                   <option value="보더 콜리">보더 콜리</option>
                   <option value="불도그">불도그</option>
                   <option value="불 테리어">불 테리어</option>
                   <option value="비글">비글</option>
                   <option value="비숑 프리제">비숑 프리제</option>
                   <option value="사모예드">사모예드</option>
                   <option value="슈나우저">슈나우저</option>
                   <option value="시바견">시바견</option>
                   <option value="시베리안 허스키">시베리안 허스키</option>
                   <option value="시츄">시츄</option>
                   <option value="셰퍼드">셰퍼드</option>
                   <option value="요크셔 테리어">요크셔 테리어</option>
                   <option value="웰시코기">웰시코기</option>
                   <option value="진돗개">진돗개</option>
                   <option value="치와와">치와와</option>
                   <option value="코커스패니얼">코커스패니얼</option>
                   <option value="파피용">파피용</option>
                   <option value="퍼그">퍼그</option>
                   <option value="푸들">푸들</option>
                   <option value="포메나리안">포메나리안</option>
                   <option value="페키니즈">페키니즈</option>
               </select>
            </div>
            <div id="type-box" style="display: none;">
                <span id="space">00</span>
                <input type="text" id="type-input" placeholder="종을 직접 입력해주세요">
            </div>
            <div id="address">
                <span id="birth-span">위치</span>
                <div>
                    <input name="address" type="text" id="sample_address" readonly>
                    <button type="button" onclick="sample4_execDaumPostcode()">검색</button>
                </div>
            </div>
            <div id="time-box" class="surgery-box">
                <span id="birth-span" style="width: 45px;">중성화</span>
                <!-- <select name="day" id="">
                    <option value="YES">YES</option>
                    <option value="NO">NO</option>
                </select> -->
                <div class="surgery">
                    <button type="button" id="ma" onclick="surgery(this)" value="YES">YES</button>
                    <button type="button" onclick="surgery(this)" value="NO">NO</button>
                    <input type="hidden" name="surgery">
                </div>
                <span id="birth-span" style="width: 45px;">몸무게</span>
                <input name="pet_weight" type="number" id="weight">
                <span style="font-size: 0.8em; margin-left: 5px;">kg</span>
            </div>
            <div id="style-box">
                <span>좋아하는거</span>
                <input name="likes" type="text" placeholder="">
            </div>
            <div id="style-box">
                <span>싫어하는거</span>
                <input name="dislikes" type="text" placeholder="">
            </div>
            <div id="style-box">
                <span id="day-span">성격</span>
                <div>
                    <button type="button" class="character" onclick="Days(this)" value="순함">순함</button>
                    <button type="button" onclick="Days(this)" value="예민">예민</button>
                    <button type="button" onclick="Days(this)" value="활발">활발</button>
                    <button type="button" onclick="Days(this)" value="소심">소심</button>
                    <button type="button" onclick="Days(this)" value="인싸">인싸</button>
                    <button type="button" onclick="Days(this)" value="아싸">아싸</button>
                    <button type="button" onclick="Days(this)" value="난폭">난폭</button>
                    <input type="hidden" name="character1">
                    <input type="hidden" name="character2">
                    <input type="hidden" name="character3">
                </div>
            </div>
            <div id="style-box">
                <span>특이사항</span>
                <textarea name="tip" id="style" placeholder="내 강아지의 특이사항을 적어주세요!"></textarea>
            </div>
            <div id="submit-btn">
                <a href="javascript:void(0)" onclick="submitForm()"><span>완료</span></a>
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

	

	$(document).ready(function(){
		
		submitForm = function(){			
			

			if($("input[name='pet_name']").val() == "" || $("input[name='pet_aeg']").val() == "" || 
				 	$("input[name='pet_breed']").val() == "" || 
					$("input[name='address']").val() == "" ||
					$("input[name='pet_weight']").val() == "" ||  $("input[name='likes']").val() == "" ||
					$("input[name='dislikes']").val() == "" ||  $("input[name='tip']").val() == ""){
				alert("빈칸을 모두 입력해주세요!");
				return false;
			} 
			
			$(".character").each(function(index, item){
				$("input[name='character"+(index+1)+"']").val($(item).val());
			});
			
			
			$("input[name='pet_gender']").val($("#gender").val());
			$("input[name='surgery']").val($("#ma").val());
			
			frm.submit();
		}
	
		selectGender = function(e){
		    $("#gender").attr("id", "");
		    $(e).attr("id", "gender");
		}
		
		var cnt = 0;
		Days = function(e) {
	        if($(e).attr("class") == "character"){
	        	  if($(".character").length == 1){
		            	alert("최소 한개는 선택해야합니다.")
		            }else {
		            	
			            $(e).attr("class", "");
		            }
	            
	        }else {
	            if($(".character").length > 2){
	                alert("최대 3개까지 선택 가능합니다.")
	            }else {
	                $(e).attr("class", "character");
	            }
	            
	        }
	    }
	
	    surgery = function (e) {
	
	        $("#ma").attr("id", "");
	        $(e).attr("id", "ma");
	    }
	
	    Type = function (e){
	        if($(e).val() == "기타"){
	            $("#type-box").show();
	            $(e).attr("name", "");
	            $("#type-input").attr("name", "pet_breed")
	        }else {
	            $("#type-box").hide()
	            $(e).attr("name", "pet_breed");
	            $("#type-input").attr("name", "");
	    }
	    }
	});

	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var sido = data.sido;
                var sigungu = data.sigungu;
                var bname = data.bname

                $("#sample_address").val(sido+" "+sigungu+" "+bname);

            }
        }).open();
    }
	
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</html>