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
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
    <style>

        #wrapper {
            display: flex;
            justify-content: space-between;
        }
        
        #welcomeMsg {
            color: black;
            font-size: 50px;
            margin-top: 50px;
            margin-bottom: 30px;
        }

        img {
            width: 300px;
        }

        #buttons {
            display: flex;
            flex-direction: column;
            justify-content: center;
            width: 100%;
            align-items: center;
        }
        
        #buttons a {
            text-decoration: none;
            font-size: 1em;
            width: 95%;
            text-align: center;
            padding: 20px 0;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        
        #join {
            background-color: #ffa64d;
            color: white;
        }

        #login {
            border: solid 1px #ffa64d;
            color: #ffa64d;
        }

        #div {
            text-align: center;
            height: 70vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

    </style>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
    <div id="wrapper">
        <div id="div">
            <p id="welcomeMsg">웰컴 투 펫팔</p>
            <img src="/resources/images/logo.png" alt="">
        </div>
        <div id="buttons">
            <a href="/user/join01.do" id="join">펫팔 가입하기</a>
            <a href="/user/login.do" id="login">로그인하기</a>
        </div>
    </div>

    <!-- Scripts -->
			<script src="${path}/resources/assets/js/jquery.min.js"></script>
			<script src="${path}/resources/assets/js/browser.min.js"></script>
			<script src="${path}/resources/assets/js/breakpoints.min.js"></script>
			<script src="${path}/resources/assets/js/util.js"></script>
			<script src="${path}/resources/assets/js/main.js"></script>
</body>
</html>