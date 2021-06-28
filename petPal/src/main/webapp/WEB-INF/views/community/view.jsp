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
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar" style="background-color: white;">
					<div style="display: flex; align-items: center; position: relative; z-index: 4;">
						<a href="community.html"><i class="fas fa-arrow-left"></i></a>
					</div>
					<div style="width: 20px; display: flex; justify-content: space-between;">	
						<a href="javascript:void(0)" onclick="save()" id="save"><i class="far fa-heart save" style="font-size: 18px;"></i></a>
					</div>
				</div>
				<div id="view-cont">
					<span id="com-type">${comVO.type}</span>				
					<div id="profile">
						<img src="${thumb}" alt="">
						<div id="info">
							<p id="nickname">${userVO.user_name}</p>
							<ul>
								<li><span id="address">${address}</span></li>
								<li><span>&#183;</span></li>
								<li><span id="date">${comVO.date}</span></li>
							</ul>
						</div>
					</div>
					<div id="com-content">
						<p>${comVO.content}</p>
					</div>
					<div id="sub">
						<a href="javascript:void(0)" onclick="like()" id="like"><i class="far fa-heart like"></i><span id><span id="like-text">좋아요</span></a>
						<a href="javascript:void(0)" onclick="writeCom()"><i class="far fa-comment"></i>댓글 <span id="com-cnt">2</span></a>
					</div>
					<ul id="comments">
						<li id="profile">
							<img src="images/dog2.jpeg" alt="">
							<div id="info">
								<p id="nickname">강쥐맘</p>
								<ul>
									<li><span id="com-address">용현5동</span></li>
									<li><span>&#183;</span></li>
									<li><span id="com-date">2시간 전</span></li>
								</ul>
								<p id="comment">제가 아는 강아지에요!!</p>
							</div>
						</li>
						<li id="profile">
							<img src="images/dog3.jpeg" alt="">
							<div id="info">
								<p id="nickname">모카맘</p>
								<ul>
									<li><span id="com-address">용현5동</span></li>
									<li><span>&#183;</span></li>
									<li><span id="com-date">2시간 전</span></li>
								</ul>
								<p id="comment">주인을 찾아서 정말 다행이네요ㅠ</p>
							</div>
						</li>
						
				</div>
				<!-- Nav -->
				<nav id="nav">
					<input type="text" id="input" placeholder="따뜻한 댓글을 입력해주세요 :D">
					<a href="" id="sendBtn"><i class="fas fa-arrow-right"></i></a>
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

		$("#input").on("change keyup paste", function(){
			if($("#input").val() == ""){
				$("#sendBtn").hide();
			}else {
				$("#sendBtn").css("display", "flex");
			}
		})

		function like(){
			if($(".like").css("color") == "rgb(255, 179, 102)"){
				$(".like").css("color", "#737373");
				$("#like-text").css("color", "#737373");
			}else {
				$(".like").css("color", "rgb(255, 179, 102)");
				$("#like-text").css("color", "rgb(255, 179, 102)");

			}
		}

		function save(){
			if($(".save").css("color") == "rgb(255, 179, 102)"){
				$(".save").css("color", "#737373");
			}else {
				$(".save").css("color", "rgb(255, 179, 102)");

			}
		}

		function writeCom(){
			$("input").focus();
		}
		
	</script>
</html>