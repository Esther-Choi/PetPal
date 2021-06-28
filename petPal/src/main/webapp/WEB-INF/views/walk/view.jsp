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
		<link rel="stylesheet" href="${path}/resources/assets/css/view.css" />
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
	</head>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<body>
    <div id="wrapper" style="padding-top: 10px;">
    <div id="bar" style="border-bottom: none; padding-top: 2px; padding-bottom: 10px; margin-bottom: 0;">
        <div style="display: flex; align-items: center; position: relative; z-index: 4; justify-content: space-between; width: 100%;">
            <a href="javascript:void(0)" onclick="back()"><i class="fas fa-arrow-left"></i></a>
            
        </div>
        </div>
        <div style="overflow: scroll !important; width: 100%; height: calc(100vh - 90px); padding-bottom: 15px;">

            <!-- <div id="image">
                <img src="images/dog.jpeg" alt="" width="100%">
            </div> -->
            
            <div id="content">
                <p id="title">${walkVO.title}</p>
                <!-- <ul>
                    <li><span id="type">푸들</span></li>
                    <li><span>&#183;</span></li>
                    <li><span id="age">3살</span></li>
                    <li><span>&#183;</span></li>
                    <li><span id="place">호수공원</span></li>
                    <li><span>&#183;</span></li>
                    <li><span id="date">오늘</span></li>
                </ul> -->
                <ul>
                    <li><i class="fas fa-check"></i>&nbsp;<span> 종류 : </span><span id="type">${walkVO.breed}</span></li>
                    <li><i class="fas fa-check"></i>&nbsp;<span> 나이 : </span><span id="age">${walkVO.age}살</span></li>
                    <li><i class="fas fa-check"></i>&nbsp;<span> 장소 : </span><span id="place">${walkVO.location}</span></li>
                    <li><i class="fas fa-check"></i>&nbsp;<span> 날짜 : </span><span id="date">${walkVO.date}</span></li>
                    <li><i class="fas fa-check"></i>&nbsp;<span> 시간 : </span><span id="time">
                    ${walkVO.walk_time} ${walkVO.walk_hour}시 <c:if test="${walkVO.walk_minute ne 0}">${walkVO.walk_minute}분</c:if></span></li>
                </ul>
                <p id="cont">${walkVO.content}
                </p>
            </div>
            <div id="profile">
                <img src="${walkVO.thumb}" alt="">
                <div id="info">
                    <div>
                        <i class="fas fa-ghost"></i>
                        <p id="nickname">${userVO.user_name}</p>
                    </div>
                    <div>
                        <i class="fas fa-map-marker-alt"></i>
                        <p id="address">${address}</p>
                    </div>
                </div>
            </div>
        </div>
    <!-- Nav -->
    <nav id="nav" class="nav">
        <button id="heart" onclick="like()"><i class="far fa-heart like"></i></button>
            <div class="btn-box">
                <a href="profile.html" id="viewProfile">프로필 보기</a>                
            </div>
            <div class="btn-box">
                <a href="" id="chat">채팅하기</a>
            </div>
    </nav>
    </div>
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

    	function like(){
			if($(".like").css("color") == "rgb(255, 179, 102)"){
				$(".like").css("color", "#737373");
			}else {
				$(".like").css("color", "rgb(255, 179, 102)");

			}
		}
</script>
</html>