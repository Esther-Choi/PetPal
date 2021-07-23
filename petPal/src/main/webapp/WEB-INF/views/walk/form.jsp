<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/form.css" />
</head>
<script>
	
	
		$.fnSubmit = function(){
			if($("#num").val() == ""){
				$("form[name=frm]").attr("action", "/walk/insertWalk.do");
			}else {
				$("form[name=frm]").attr("action", "/walk/editWalk.do?num="+$("#num").val());
			}
			frm.submit();
		}
		
	</script>
<body id="body">
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!-- Wrapper-->
	<div id="wrapper">
		<div id="bar" style="background-color: white;">
			<div
				style="display: flex; align-items: center; position: relative; z-index: 4;">
				<a href="javascript:void(0)" onclick="$.fnBack()">닫기</a>
			</div>
			<span style="color: black; font-size: 0.9em !important;">산책
				글쓰기</span>
			<div>
				<a href="javascript:void(0)" onclick="$.fnSubmit()">완료</a>
			</div>
		</div>
		<input type="hidden" name="num" id="num" value="${walkVO.num}">
		<form id="view-cont" name="frm"
			method="post">
			<div id="profile">
				<input name="title" type="text" placeholder="글 제목" value="${walkVO.title}">
			</div>
			<div id="profile">
				<input name="location" type="text"
					placeholder="산책 장소 (간단하게 장소명을 적어주세요)" value="${walkVO.location}">
			</div>
			<div id="profile">
				<input name="date" type="date" name="date" id="date"
					style="width: 50%; margin-right: 20px;" value="${fn:substring(walkVO.date,0, 10)}"> <select
					name="walk_time" id="day">
					<option value="오전" ${walkVO.walk_time eq '오전' ? "selected='selected'":""}>오전</option>
					<option value="오후" ${walkVO.walk_time eq '오후' ? "selected='selected'":""}>오후</option>
				</select> <select name="walk_hour" id="hr">
					<option value="">시</option>
					<option value="1" ${walkVO.walk_hour eq '1' ? "selected='selected'":""}>1</option>
					<option value="2" ${walkVO.walk_hour eq '2' ? "selected='selected'":""}>2</option>
					<option value="3" ${walkVO.walk_hour eq '3' ? "selected='selected'":""}>3</option>
					<option value="4" ${walkVO.walk_hour eq '4' ? "selected='selected'":""}>4</option>
					<option value="5" ${walkVO.walk_hour eq '5' ? "selected='selected'":""}>5</option>
					<option value="6" ${walkVO.walk_hour eq '6' ? "selected='selected'":""}>6</option>
					<option value="7" ${walkVO.walk_hour eq '7' ? "selected='selected'":""}>7</option>
					<option value="8" ${walkVO.walk_hour eq '8' ? "selected='selected'":""}>8</option>
					<option value="9" ${walkVO.walk_hour eq '9' ? "selected='selected'":""}>9</option>
					<option value="10" ${walkVO.walk_hour eq '10' ? "selected='selected'":""}>10</option>
					<option value="11" ${walkVO.walk_hour eq '11' ? "selected='selected'":""}>11</option>
					<option value="12" ${walkVO.walk_hour eq '12' ? "selected='selected'":""}>12</option>
				</select> <span> : &nbsp;</span> <select name="walk_minute" id="mn">
					<option value="">분</option>
					<option value="00" ${walkVO.walk_minute eq '0' ? "selected='selected'":""}>00</option>
					<option value="30" ${walkVO.walk_minute eq '30' ? "selected='selected'":""}>30</option>

				</select>
			</div>
			<textarea name="content" id="" cols="30"
				placeholder="이번 산책에 대해 설명해주세요!">${walkVO.content}</textarea>
		</form>

	</div>
</body>

</html>