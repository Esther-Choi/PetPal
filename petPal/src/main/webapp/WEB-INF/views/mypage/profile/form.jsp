<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/join.css?after" />
</head>
<script>   

	var idCheck = false;
	var nameCheck = false;
	
	$("input[name='user_id']").change(function(){
		idCheck = false;
	});
	
	$("input[name='user_name']").change(function(){
		nameCheck = false;
	});
	
	$.fnCheckId = function(){
		
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
	
	$.fnCheckDate = function(e){
		
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
	
	$.fnCheckNickname = function(){
		
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
	

	$.fnSubmit = function(){
		
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
		
		
		$("input[name='pet_gender']").val($("#pet_gender").val());
		$("input[name='surgery']").val($("#surgery").val());
		
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
			
		
		var dayArr = new Array();
		$(".day").each(function(index, item){
			dayArr.push($(item).val());
		});
		
		
		$("input[name='user_gender']").val($("#gender").val());
		$("input[name='walk_day']").val(dayArr);
		$("input[name='walk_time']").val($("#ma").val());
		
		frm.submit();
	};
		

    $.fnSelectGender = function(e){
        $("#gender").attr("id", "");
        $(e).attr("id", "gender");
    }

    $.fnSelectDay = function(e) {
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

    $.fnSelectMA = function(e) {

        $("#ma").attr("id", "");
        $(e).attr("id", "ma");
    }
    
    $.fnSelectPetGender = function(e){
	    $("#pet_gender").attr("id", "");
	    $(e).attr("id", "pet_gender");
	}
	
	var cnt = 0;
	
	$.fnDays = function(e) {
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

    $.fnSurgery = function (e) {

        $("#surgery").attr("id", "");
        $(e).attr("id", "surgery");
    }

    $.fnType = function (e){
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

    
    $(document).ready(function(){
		
		 $("#upload").change(function(){
	            if(this.files 
	            && this.files[0]){
	                var reader = new FileReader;
	                reader.onload = function(data){
	                    $("#file-img img").attr("src", data.target.result);
	                    $("#file-img img").show();
	                }
	                reader.readAsDataURL(this.files[0]);
	            }
	        });
    });
    
  //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var sido = data.sido;
                var sigungu = data.sigungu;
                var bname = data.bname
                
                $("input[name='si']").val(sido);
                $("input[name='gungu']").val(sigungu);
                $("input[name='dong']").val(bname);

                $("#sample_address").val(sido+" "+sigungu+" "+bname);

            }
        }).open();
    }


</script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<body id="body">
	<div id="wrapper">
		<div id="top">
			<p>정보수정</p>
			<a href="/user/main.do"><i class="fas fa-times"></i></a>
		</div>

		<div id="input">
			<form name="frm" action="/mypage/profile/edit.do" method="post"
				enctype="multipart/form-data">
				<%-- <input type="hidden" name="user_id" value="${userVO.user_id}">
				<input type="hidden" name="user_pw" value="${userVO.user_pw}">
				<input type="hidden" name="user_name" value="${userVO.user_name}">
				<input type="hidden" name="user_birth" value="${userVO.user_birth}">
				<input type="hidden" name="walk_day" value="${userVO.walk_day}">
				<input type="hidden" name="walk_time" value="${userVO.walk_time}">
				<input type="hidden" name="walk_hour" value="${userVO.walk_hour}">
				<input type="hidden" name="walk_minute"
					value="${userVO.walk_minute}"> <input type="hidden"
					name="user_gender" value="${userVO.user_gender}"> <input
					type="hidden" name="walk_place1" value="${userVO.walk_place1}">
				<input type="hidden" name="walk_place2"
					value="${userVO.walk_place2}"> <input type="hidden"
					name="walk_style" value="${userVO.walk_style}"> --%>
				<p id="info">강아지 정보</p>
				<div id="file-div">
					<div class="file-upload">
						<label for="upload" class="file-upload__label"><i
							class="fas fa-camera"></i></label> <input id="upload"
							class="file-upload__input" type="file" name="file" value="">
					</div>
					<div id="file-img">
						<img src="${petVO.pet_photothumb}" width="48em" height="48em" alt="" style="">
						<!-- <button id="remove" style="display: none;">x</button> -->
					</div>
				</div>
				<div id="birth-box">
					<span id="birth-span">이름</span> <input name="pet_name" type="text"
						placeholder="" value="${petVO.pet_name}">
				</div>
				<div id="birth-box">
					<span id="birth-span">나이</span> <input name="pet_age" type="number"
						placeholder="" value="${petVO.pet_age}">
				</div>
				<div id="gender-box">
					<span>성별</span>
					<div>
						<button type="button" onclick="$.fnSelectPetGender(this)" ${petVO.pet_gender eq '여자' ? "id='pet_gender'":""}
							value="여자">여자</button>
						<button type="button" onclick="$.fnSelectPetGender(this)" value="남자" ${petVO.pet_gender eq '남자' ? "id='pet_gender'":""}>남자</button>
						<input type="hidden" name="pet_gender" value="남자">
					</div>
				</div>
				<div id="birth-box">
					<span id="birth-span">종류</span> <select name="pet_breed" id="type"
						onchange="$.fnType(this)">
						<option value="">종을 선택해주세요</option>
						<option value="기타" ${petVO.pet_breed eq '기타' ? "selected='selected'":""}>기타</option>
						<option value="골든 리트리버" ${petVO.pet_breed eq '골든 리트리버' ? "selected='selected'":""}>골든 리트리버</option>
						<option value="그레이하운드" ${petVO.pet_breed eq '그레이하운드' ? "selected='selected'":""}>그레이하운드</option>
						<option value="닥스훈트" ${petVO.pet_breed eq '닥스훈트' ? "selected='selected'":""}>닥스훈트</option>
						<option value="도베르만" ${petVO.pet_breed eq '도베르만' ? "selected='selected'":""}>도베르만</option>
						<option value="래브라도 리트리버" ${petVO.pet_breed eq '래브라도 리트리버' ? "selected='selected'":""}>래브라도 리트리버</option>
						<option value="말라뮤트" ${petVO.pet_breed eq '말라뮤트' ? "selected='selected'":""}>말라뮤트</option>
						<option value="말티즈" ${petVO.pet_breed eq '말티즈' ? "selected='selected'":""}>말티즈</option>
						<option value="말티푸" ${petVO.pet_breed eq '말티푸' ? "selected='selected'":""}>말티푸</option>
						<option value="미니핀" ${petVO.pet_breed eq '미니핀' ? "selected='selected'":""}>미니핀</option>
						<option value="보더 콜리" ${petVO.pet_breed eq '보더 콜리' ? "selected='selected'":""}>보더 콜리</option>
						<option value="불도그" ${petVO.pet_breed eq '불도그' ? "selected='selected'":""}>불도그</option>
						<option value="불 테리어" ${petVO.pet_breed eq '불 테리어' ? "selected='selected'":""}>불 테리어</option>
						<option value="비글" ${petVO.pet_breed eq '비글' ? "selected='selected'":""}>비글</option>
						<option value="비숑 프리제" ${petVO.pet_breed eq '비숑 프리제' ? "selected='selected'":""}>비숑 프리제</option>
						<option value="사모예드" ${petVO.pet_breed eq '사모예드' ? "selected='selected'":""}>사모예드</option>
						<option value="슈나우저" ${petVO.pet_breed eq '슈나우저' ? "selected='selected'":""}>슈나우저</option>
						<option value="시바견" ${petVO.pet_breed eq '시바견' ? "selected='selected'":""}>시바견</option>
						<option value="시베리안 허스키" ${petVO.pet_breed eq '시베리안 허스키' ? "selected='selected'":""}>시베리안 허스키</option>
						<option value="시츄" ${petVO.pet_breed eq '시츄' ? "selected='selected'":""}>시츄</option>
						<option value="셰퍼드" ${petVO.pet_breed eq '셰퍼드' ? "selected='selected'":""}>셰퍼드</option>
						<option value="요크셔 테리어" ${petVO.pet_breed eq '요크셔 테리어' ? "selected='selected'":""}>요크셔 테리어</option>
						<option value="웰시코기" ${petVO.pet_breed eq '웰시코기' ? "selected='selected'":""}>웰시코기</option>
						<option value="진돗개" ${petVO.pet_breed eq '진돗개' ? "selected='selected'":""}>진돗개</option>
						<option value="치와와" ${petVO.pet_breed eq '치와와' ? "selected='selected'":""}>치와와</option>
						<option value="코커스패니얼" ${petVO.pet_breed eq '코커스패니얼' ? "selected='selected'":""}>코커스패니얼</option>
						<option value="파피용" ${petVO.pet_breed eq '파피용' ? "selected='selected'":""}>파피용</option>
						<option value="퍼그" ${petVO.pet_breed eq '퍼그' ? "selected='selected'":""}>퍼그</option>
						<option value="푸들" ${petVO.pet_breed eq '푸들' ? "selected='selected'":""}>푸들</option>
						<option value="포메나리안" ${petVO.pet_breed eq '포메나리안' ? "selected='selected'":""}>포메나리안</option>
						<option value="페키니즈" ${petVO.pet_breed eq '페키니즈' ? "selected='selected'":""}>페키니즈</option>
					</select>
				</div>
				<div id="type-box" style="display: none;">
					<span id="space">00</span> <input type="text" id="type-input"
						placeholder="종을 직접 입력해주세요">
				</div>
				<div id="address">
					<span id="birth-span">위치</span>
					<div>
						<input name="address" type="text" id="sample_address" value="${petVO.address}" readonly>
						<button type="button" onclick="sample4_execDaumPostcode()">검색</button>
						<input type="hidden" name="si" value="${petVO.si}"> <input type="hidden"
							name="gungu" value="${petVO.gungu}"> <input type="hidden" name="dong" value="${petVO.dong}">
					</div>
				</div>
				<div id="time-box" class="surgery-box">
					<span id="birth-span" style="width: 45px;">중성화</span>
					<!-- <select name="day" id="">
                    <option value="YES">YES</option>
                    <option value="NO">NO</option>
                </select> -->
					<div class="surgery">
						<button type="button" id=surgery onclick="$.fnSurgery(this)"
							value="YES" ${petVO.surgery eq 'YES' ? "id='surgery'":""}>YES</button>
						<button type="button" onclick="$.fnSurgery(this)" value="NO" ${petVO.surgery eq 'NO' ? "id='surgery'":""}>NO</button>
						<input type="hidden" name="surgery" value="YES">
					</div>
					<span id="birth-span" style="width: 45px;">몸무게</span> <input
						name="pet_weight" type="number" id="weight" value="${petVO.pet_weight}"> <span
						style="font-size: 0.8em; margin-left: 5px;">kg</span>
				</div>
				<div id="style-box">
					<span>좋아하는거</span> <input name="likes" type="text" placeholder="" value="${petVO.likes}">
				</div>
				<div id="style-box">
					<span>싫어하는거</span> <input name="dislikes" type="text"
						placeholder="" value="${petVO.dislikes}">
				</div>
				<div id="style-box">
					<span id="day-span">성격</span>
					<div>
						<button type="button" onclick="$.fnDays(this)" value="순함" ${petVO.character1 eq '순함' || petVO.character2 eq '순함' || petVO.character3 eq '순함' ? "class='character'":""}>순함</button>
						<button type="button" onclick="$.fnDays(this)" value="예민" ${petVO.character1 eq '예민' || petVO.character2 eq '예민' || petVO.character3 eq '예민' ? "class='character'":""}>예민</button>
						<button type="button" onclick="$.fnDays(this)" value="활발" ${petVO.character1 eq '활발' || petVO.character2 eq '활발' || petVO.character3 eq '활발' ? "class='character'":""}>활발</button>
						<button type="button" onclick="$.fnDays(this)" value="소심" ${petVO.character1 eq '소심' || petVO.character2 eq '소심' || petVO.character3 eq '소심' ? "class='character'":""}">소심</button>
						<button type="button" onclick="$.fnDays(this)" value="인싸" ${petVO.character1 eq '인싸' || petVO.character2 eq '인싸' || petVO.character3 eq '인싸' ? "class='character'":""}>인싸</button>
						<button type="button" onclick="$.fnDays(this)" value="아싸" ${petVO.character1 eq '아싸' || petVO.character2 eq '아싸' || petVO.character3 eq '아싸' ? "class='character'":""}>아싸</button>
						<button type="button" onclick="$.fnDays(this)" value="난폭" ${petVO.character1 eq '난폭' || petVO.character2 eq '난폭' || petVO.character3 eq '난폭' ? "class='character'":""}>난폭</button>
						<input type="hidden" name="character1"> <input
							type="hidden" name="character2"> <input type="hidden"
							name="character3">
					</div>
				</div>
				<div id="style-box">
					<span>특이사항</span>
					<textarea name="tip" id="style" placeholder="내 강아지의 특이사항을 적어주세요!">${petVO.tip}</textarea>
				</div>
			
		<div id="input" style="margin-top: 30px">
			
				<p id="info">집사 정보</p>
				<div id="birth-box">
					<span id="birth-span">생년</br>월일
					</span> <input name="user_birth" type="date" placeholder="dd"
						onchange="$.fnCheckDate(this)" value ="${fn:substring(userVO.user_birth,0, 10)}">
				</div>
				<div id="gender-box">
					<span>성별</span>
					<div>
						<button type="button" onclick="$.fnSelectGender(this)"
							value="여자" ${userVO.user_gender eq '여자' ? "id='gender'":""}>여자</button>
						<button type="button" onclick="$.fnSelectGender(this)" value="남자" value="여자" ${userVO.user_gender eq '남자' ? "id='gender'":""}>남자</button>
						<input type="hidden" name="user_gender">
					</div>
				</div>
				<div id="day-box">
					<span id="day-span">산책</br>요일
					</span>
					<div>
							<button type="button" class="day" onclick="$.fnSelectDay(this)"
								value="월">월</button>
							<button type="button" onclick="$.fnSelectDay(this)" value="화">화</button>
							<button type="button" onclick="$.fnSelectDay(this)" value="수">수</button>
							<button type="button" onclick="$.fnSelectDay(this)" value="목">목</button>
							<button type="button" onclick="$.fnSelectDay(this)" value="금">금</button>
							<button type="button" onclick="$.fnSelectDay(this)" value="토">토</button>
							<button type="button" onclick="$.fnSelectDay(this)" value="일">일</button>
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
						<button type="button" onclick="$.fnSelectMA(this)"
							value="오전" ${userVO.walk_time eq '오전' ? "id='ma'":""}>오전</button>
						<button type="button" onclick="$.fnSelectMA(this)" value="오후" ${userVO.walk_time eq '오후' ? "id='ma'":""}>오후</button>
						<input type="hidden" name="walk_time">
					</div>
					<select name="walk_hour" id="hr">
						<option value="">시</option>
						<option value="1" ${userVO.walk_hour eq '1' ? "selected='selected'":""}>1</option>
						<option value="2" ${userVO.walk_hour eq '2' ? "selected='selected'":""}>2</option>
						<option value="3" ${userVO.walk_hour eq '3' ? "selected='selected'":""}>3</option>
						<option value="4" ${userVO.walk_hour eq '4' ? "selected='selected'":""}>4</option>
						<option value="5" ${userVO.walk_hour eq '5' ? "selected='selected'":""}>5</option>
						<option value="6" ${userVO.walk_hour eq '6' ? "selected='selected'":""}>6</option>
						<option value="7" ${userVO.walk_hour eq '7' ? "selected='selected'":""}>7</option>
						<option value="8" ${userVO.walk_hour eq '8' ? "selected='selected'":""}>8</option>
						<option value="9" ${userVO.walk_hour eq '9' ? "selected='selected'":""}>9</option>
						<option value="10" ${userVO.walk_hour eq '10' ? "selected='selected'":""}>10</option>
						<option value="11" ${userVO.walk_hour eq '11' ? "selected='selected'":""}>11</option>
						<option value="12" ${userVO.walk_hour eq '12' ? "selected='selected'":""}>12</option>
					</select> <span style="font-size: 0.8em;">&nbsp;: &nbsp;</span> <select
						name="walk_minute" id="mn">
						<option value="">분</option>
						<option value="00" ${userVO.walk_minute eq '0' ? "selected='selected'":""}>00</option>
						<option value="30" ${userVO.walk_minute eq '30' ? "selected='selected'":""}>30</option>

					</select>
				</div>
				<div id="place-box">
					<span id="place-span">산책</br>장소
					</span>
					<div>
						<input name="walk_place1" type="text"
							placeholder="자주 가는 산책장소를 작성해주세요" value="${userVO.walk_place1}"> <input
							name="walk_place2" type="text" placeholder="자주 가는 산책장소를 작성해주세요" value="${userVO.walk_place2}">
					</div>
				</div>
				<div id="style-box">
					<span>산책 스타일</span>
					<textarea name="walk_style" id="style"
						placeholder="평소 산책 스타일을 적어주세요!">${userVO.walk_style}</textarea>
				</div>
				<div id="submit-btn">
					<a href="javascript:void(0)" onclick="$.fnSubmit()" style="width: 100% !important"><span>완료</span></a>
				</div>
		</div>
	</form>
</div>
</div>
</body>
</html>