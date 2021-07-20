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
		<form id="view-cont" name="frm" action="/walk/insertWalk.do"
			method="post">
			<div id="profile">
				<input name="title" type="text" placeholder="글 제목">
			</div>
			<div id="profile">
				<input name="location" type="text"
					placeholder="산책 장소 (간단하게 장소명을 적어주세요)">
			</div>
			<div id="profile">
				<input name="date" type="date" name="date" id="date"
					style="width: 50%; margin-right: 20px;"> <select
					name="walk_time" id="day">
					<option value="오전">오전</option>
					<option value="오후">오후</option>
				</select> <select name="walk_hour" id="hr">
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
				</select> <span> : &nbsp;</span> <select name="walk_minute" id="mn">
					<option value="">분</option>
					<option value="00">00</option>
					<option value="30">30</option>

				</select>
			</div>
			<textarea name="content" id="" cols="30"
				placeholder="이번 산책에 대해 설명해주세요!"></textarea>
		</form>

	</div>
</body>

</html>