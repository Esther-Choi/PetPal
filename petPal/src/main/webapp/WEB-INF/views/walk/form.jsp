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
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		<noscript><link rel="stylesheet" href="${path}/resources/assets/css/noscript.css" /></noscript>
	</head>
	<style>
		#bar a {
			font-size: 0.8em !important;
		}

		#profile input {
			border: none;
			width: 100%;
			background-color: white;
			margin-top: 0 !important;
			padding-bottom: 0 !important;
			padding-left: 0;
			height: 2.6em;
			font-size: 0.8em;
			color: black;
		}

		form {
			color: black;
		}

		input:focus {
			outline: none;
		}

		input::placeholder, textarea::placeholder {
			color: #d9d9d9;
		}

		form select {
			background-color: white;
			padding-right: 0;
		}

		form select:focus {
			outline: none;
			background-color: white;
		}

		form #date {
			width: 135px;
			margin-right: 10px;
		}

		form #day {
			width: 35px;
			padding-left: 5px;
			padding-top: 2px;
			margin-right: 10px;
			padding-bottom: 0;
			font-size: 0.8em;
		}

		form #hr, form #mn {
			width: 35px;
			padding-left: 5px;
			padding-top: 2px;
			padding-bottom: 0;
			font-size: 0.8em;
		}

		form #hour, form #minute {
			padding-top: 0;
			width: 40px;
			/* border: solid 1px #d9d9d9; */
			text-align: center;
		}

		form #minute {
			margin-left: 5px;
		}

		form textarea {
			height: 60%;
			resize: none;
			background-color: white;
			text-align: left;
			outline: none;
			padding-left: 0;
			color: black;
			white-space: pre-line;
			font-size: 0.8em;
		}

		form textarea:focus {
			background-color: white;
		}

		#view-cont {
			padding-top: 0;
		}

	</style>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar" style="background-color: white;">
					<div style="display: flex; align-items: center; position: relative; z-index: 4;">
						<a href="javascript:void(0)" onclick="back()">닫기</a>
					</div>
					<span style="color: black; font-size: 0.9em !important;">산책 글쓰기</span>
					<div>	
						<a href="javascript:void(0)" onclick="submit()">완료</a>
					</div>
				</div>
				<form id="view-cont" name="frm" action="/walk/insertWalk.do" method="post">
					<div id="profile">
						<input name="title" type="text" placeholder="글 제목">
					</div>
					<div id="profile">
						<input name="location" type="text" placeholder="산책 장소 (간단하게 장소명을 적어주세요)">
					</div>
					<div id="profile">
						<input name="date" type="date" name="date" id="date" style="width: 50%; margin-right: 20px;">
						<select name="walk_time" id="day">
							<option value="오전">오전</option>
							<option value="오후">오후</option>
						</select>
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
						<span> : &nbsp;</span>
						<select name="walk_minute" id="mn">
							<option value="">분</option>
							<option value="00">00</option>
							<option value="30">30</option>
							
						</select>
						<!-- <input type="text" id="hour" style="border: solid 1px #d9d9d9; height: 30px; padding-right: 0; margin-right: 10px;"><span> : </span>
						<input type="text" id="minute" style="border: solid 1px #d9d9d9; height: 30px; padding-right: 0; margin-left: 10px;"> -->
					</div>
					<textarea name="content" id="" cols="30" placeholder="이번 산책에 대해 설명해주세요!"></textarea>
					</form>
				
			</div>
		
		<!-- Scripts -->
			<script src="${path}/resources/assets/js/jquery.min.js"></script>
			<script src="${path}/resources/assets/js/browser.min.js"></script>
			<script src="${path}/resources/assets/js/breakpoints.min.js"></script>
			<script src="${path}/resources/assets/js/util.js"></script>
			<script src="${path}/resources/assets/js/main.js"></script>
			
	</body>
	<script>
	function back(){
		window.history.back();
	}
	
		submit = function(){
			frm.submit();
		}
	</script>
</html>