<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			color: #999999;
		}

		#profile input {
			border: none;
			width: 100%;
			background-color: white;
			margin-top: 0 !important;
			padding-bottom: 0 !important;
			padding-left: 0;
			height: 2.6em;
			font-size: 1em;
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
			color: black;			
			margin-top: 10px;
			height: 3.6em;
			padding-left: 0;
			font-size: 0.8em;
		}

		form select:focus {
			outline: none;
			background-color: white;
		}

		form textarea {
			height: 80%;
			resize: none;
			background-color: white;
			text-align: left;
			outline: none;
			padding-left: 0;
			color: black;
			white-space: pre-line;
			padding-top: 20px;
			font-size: 0.8em;
		}

		form textarea:focus {
			background-color: white;
		}

		#view-cont {
			padding-top: 0;
		}

		#nav {
			border-top: none;
		}

		#nav #file {
			background-color: white;
		}
	</style>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar" style="background-color: white;">
					<div style="display: flex; align-items: center; position: relative; z-index: 4;">
						<a href="community.html">닫기</a>
					</div>
					<span style="color: black; font-size: 0.9em;">커뮤니티 글쓰기</span>
					<div>	
						<a href="javascript:void(0)" onclick="submit()">완료</a>
					</div>
				</div>
				<form id="view-cont" name="frm" action="/com/insertCom.do" method="post">
					<div style="display: flex; align-items: center; border-bottom: solid 1px #e6e6e6;">
						<select name="type" id="category">
							<option value="">게시글의 주제를 선택해주세요.</option>
							<option value="질문있어요">질문있어요!</option>
							<option value="펫팁 공유해요">펫팁 공유해요</option>
							<option value="펫 찾아주세요">펫 찾아주세요</option>
							<option value="펫용품 추천">펫용품 추천</option>
						</select><i class="fas fa-chevron-down"></i>
					</div>
					<textarea name="content" id="" cols="30" placeholder="펫 관련된 질문이나 이야기를 해보세요."></textarea>
					</form>
				<!-- Nav -->
				<nav id="nav">
					<input type="file" id="file" name="file">
				</nav>
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
	</script>
</html>