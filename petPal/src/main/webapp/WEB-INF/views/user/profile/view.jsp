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
		<link rel="stylesheet" href="${path}/resources/assets/css/main.css?after" />
		<link rel="stylesheet" href="${path}/resources/assets/css/view.css?after" />
		<link rel="stylesheet" href="${path}/resources/assets/css/profile.css?after" />
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<!-- <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet"> -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
		<div id="wrapper" style="padding-top: 10px;">
    <div id="bar" style="border-bottom: none; padding-top: 2px; padding-bottom: 10px; margin-bottom: 0;">
        <div style="display: flex; align-items: center; position: relative; z-index: 4; justify-content: space-between; width: 100%;">
            <a href="javascript:void(0)" onclick="back()"><i class="fas fa-arrow-left"></i></a>
            
        </div>
    </div>
        <div style="overflow: scroll !important; width: 100%;padding-bottom: 15px; height: calc(100vh - 4.7em);">
            <div>
                <p id="title-p">강아지 정보</p>
                <div id="image">
                    <img src="${petVO.pet_photothumb}" alt="" width="100%" height="100%">
                    <div id="dog-info">
                        <p><span class="type">&nbsp;이름&nbsp;</span> : <span id="name">${petVO.pet_name}</span></p>
                        <p><span class="type">&nbsp;나이&nbsp;</span> : <span id="name">${petVO.pet_age}</span>살</p>
                        <p><span class="type">&nbsp;성별&nbsp;</span> : <span id="name">${petVO.pet_gender}</span></p>
                        <p><span class="type">&nbsp;종류&nbsp;</span> : <span id="name">${petVO.pet_breed}</span></p>
                        <p><span class="type">&nbsp;동네&nbsp;</span> : <span id="name">${petVO.si} ${petVO.gungu} ${petVO.dong}</span></p>
                    </div>
                </div>
               
            </div>
            <div id="info">
                <div class="info">
                    <span class="info-title">몸무게</span>
                    <span>${petVO.pet_weight}kg</span>
                </div>
                <div class="info">
                    <span class="info-title">중성화</span>
                    <span>${petVO.surgery}</span>
                </div>
                <div class="info">
                    <span class="info-title">좋아하는거</span>
                    <span>${petVO.likes}</span>
                </div>
                <div class="info">
                    <span class="info-title">싫어하는거</span>
                    <span>${petVO.dislikes}</span>
                </div>
                <div class="info"  style="margin: 5px 0;">
                    <p class="info-title">성격</p>
                    <ul>
                        <li><span>${petVO.character1}</span></li>
                        <c:if test="${not empty petVO.character2}">
                        <li><span>${petVO.character2}</span></li>
                        </c:if>
                        <c:if test="${not empty petVO.character3}">
                        <li><span>${petVO.character3}</span></li>
                        </c:if>
                    </ul>
                </div>
                <div class="info highlight">
                    <span class="info-title">특이사항</span>
                    <p style="width: 250px; line-height: 1.3;" id="tip">${petVO.tip}</p>
                </div>
            </div>
            <div>
                <p id="title-p" style="margin-top: 15px;">집사 정보</p>     
            </div>
            <div id="info" style="border-bottom: none;">
                <div class="info">
                    <span class="info-title">닉네임</span>
                    <span>${userVO.user_name}</span>
                </div>
                <div class="info">
                    <span class="info-title">나이</span>
                    <span id="o_age">${userVO.user_birth}</span><span>살</span>
                </div>
                <div class="info">
                    <span class="info-title">성별</span>
                    <span id="o_age">${userVO.user_gender}</span>
                </div>
                <div class="info">
                    <span class="info-title">산책 요일</span>
                    <ul>
                    	<c:forTokens items="${userVO.walk_day}" delims="," var = "item">
                        	<li><span>${item}</span></li>
                    	</c:forTokens>
                    </ul>
                </div>
                <div class="info" style="margin: 5px 0;;">
                    <span class="info-title">산책 시간</span>
                        <span id="mn">${userVO.walk_time}</span><span>&nbsp;</span>
                        <span id="time">${userVO.walk_hour}</span><span>시</span>
                        <c:if test="${userVO.walk_minute ne 0}">
                        	<span id="minute">${userVO.walk_minute}</span><span>분</span>
                        </c:if>
                </div>
                <div class="info highlight">
                    <p class="info-title">산책 장소</p>
                    <ul style="display: flex; flex-direction: column; width: auto;">
                        <li><span>${userVO.walk_place1}</span></li>
                         <c:if test="${not empty userVO.walk_place2}">
                        <li><span>${userVO.walk_place2}</span></li>
                        </c:if>
                    </ul>
                </div>
                <div class="info" style="align-items: flex-start !important; margin-top: 8px;">
                    <span class="info-title">산책 스타일</span>
                    <p style="width: 250px; line-height: 1.3; padding-top: 5px" id="style">${userVO.walk_style}</p>
                </div>
            </div>
        </div>
    </div>
    <!-- Nav -->
    <nav id="nav" class="nav">
        <div class="btn-box">
            <a href="profile.html" id="viewProfile">펫팔하기</a>                
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
	<script type="text/javascript">
	function back(){
		window.history.back();
	}
	</script>
</html>