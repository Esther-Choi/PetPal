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
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		<noscript><link rel="stylesheet" href="${path}/resources/assets/css/noscript.css" /></noscript>
	</head>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
	<%
		if(session.getAttribute("user_id") == null){
			%>
			<script type="text/javascript">
				location.href = "/user/login.do";
			</script>
			<% 
		}%>	
	<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar">
					<div style="display: flex; align-items: center; position: relative; z-index: 4;">
						<a href="javascript:void(0);" style="margin-right: 5px;" onclick="show()"><span class="bold">용현5동</span></a>
						<i class="fas fa-chevron-down" style="font-size: 10px;"></i>
						<div class="toolip">
							<p id="address">용현5동</p>
							<p id="set">내 동네 설정하기</p>
						</div>
					</div>
					<div style="width: 90px; display: flex; justify-content: space-between;">	
						<a href=""><i class="fas fa-search" style="font-size: 18px;"></i></a>
						<a href=""><i class="fas fa-sliders-h"></i></a>
						<a href=""><i class="far fa-bell"></i></a>
					</div>
				</div>
				<div id="list">
					<ul>
					<c:forEach items="${list}" var="walkVO">
						
						<li id="list-content">
							<a href="view.html"><img src="${walkVO.thumb}" alt="">
							<div id="content">
								<span id="title">${walkVO.title}</span>
								<ul>
									<li><span>${walkVO.breed}</span></li>
									<li><span>&#183;</span></li>
									<li><span>${walkVO.age}살</span></li>
									<li><span>&#183;</span></li>
									<li><span>${walkVO.location}</span></li>
									<li><span>&#183;</span></li>
									<li><span>${walkVO.date}</span></li>
								</ul>
							</div></a>
						</li>
					</c:forEach>
								
					</ul>
				</div>
				<a href="/walk/form.do" id="write">
					<i class="fas fa-pencil-alt"></i>
				</a>
				<!-- Nav -->
				<nav id="nav">
					<a href="index.html" class="icon solid" style="opacity: 1 !important;"><i class="fas fa-paw"></i><p>홈</p></a>
					<a href="community.html" class="icon solid"><i class="fas fa-bullhorn"></i><p>커뮤니티</p></a>
					<a href="#contact" class="icon solid"><i class="far fa-comment-alt"></i><p>채팅</p></a>
					<a href="mypage.html" class="icon brands"><i class="far fa-user"></i><p>나의 펫팔</p></a>
				</nav>
			</div>
		
		<!-- Scripts -->
			<!-- <script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script> -->
			<!-- <script src="assets/js/main.js"></script> -->
			
	</body>
	<script>
		var toolip = document.getElementsByClassName('toolip');
		var body = document.getElementById('body');

		$(document).ready(function(){
			$(document).bind("touchend", function(){
				$("#bg").css("visibility", "hidden");
				$(".toolip").css("visibility", "hidden");
				// $(".toolip").slideUp();
			})
		})

		function show() {
			$("#bg").css("visibility", "visible");
			$(".toolip").css("visibility", "visible");
			// $(".toolip").slideDown();

		}
	</script>
</html>