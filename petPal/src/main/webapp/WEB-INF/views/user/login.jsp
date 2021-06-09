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

        #wrapper {
            /* display: flex;
            justify-content: space-between; */
        }

        a {
            text-decoration: none;
        }

        #top {
            border-bottom: solid 1px #f2f2f2;
            width: 100%;
            text-align: center;
            font-size: 1.1em;
            padding: 0.6em 0;
            color: black;
        }

        .fa-times {
            position: absolute;
            right: 1em;
            top: 1em;
            font-size: 1.1em;
            color: #737373;
        }

        #input {
            width: 100%;
            text-align: center;
            margin-top: 2.5em;
        }

        #input input {
            height: 4em;
            margin-bottom: 0.7em;
            width: 95%;
            border: solid 1.8px #bfbfbf;
            padding: 0 0.8em;
            border-radius: 5px;
            font-size: 0.8em;
            color: black;
        }

        #input input::placeholder {
            color: #bfbfbf;
        }

        /* #input input:focus {
            outline: solid 1px powderblue !important;
            border-radius: 5px;
        } */

        #buttons {
            display: flex;
            flex-direction: column;
            justify-content: center;
            width: 100%;
            align-items: center;
        }
        
        #buttons a {
            text-decoration: none;
            font-size: 0.8em;
            width: 95%;
            text-align: center;
            padding: 0.8em 0;
            margin-bottom: 10px;
        }
        
        #login {
            background-color: #ffa64d;
            color: white;
            border-radius: 5px;
        }

        #kakao {
            background-color: #FEE500;
            color: 	#000000;
            border-radius: 5px;
        }

        .fa-comment{
            margin-right: 1em;
            color: 	#000000;
        }

        #sub-menu a{
            color: #bfbfbf;
            font-size: 0.7em;
            padding: 0 1em;
            
        }

        #findpw {
            border-right: solid 1px #e6e6e6;
            border-left: solid 1px #e6e6e6;
        }
      

    </style>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
    <div id="wrapper">
        <div id="top">
            <p>로그인</p>
            <a href="/user/main.do"><i class="fas fa-times"></i></a>
        </div>
        <form name="frm" action="/user/loginOk.do" method="POST">
        <div id="input">
            <input type="text" placeholder="아이디" name="user_id">
            <input type="text" placeholder="비밀번호" name="user_pw">
        </div>
        </form>
        <div id="buttons">
            <a href="javascript:void(0)" onclick="submit()" id="login">로그인</a>
        </div>
        <!--<div id="buttons">
            <a href="" id="kakao"><i class="fas fa-comment"></i>카카오 계정으로 로그인</a>
        </div>  -->
        <div id="sub-menu">
            <a href="">아이디 찾기</a>
            <a href="" id="findpw">비밀번호 찾기</a>
            <a href="/user/join01.do">회원가입</a>
        </div>
    </div>

    <!-- Scripts -->
			<script src="${path}/resources/assets/js/jquery.min.js"></script>
			<script src="${path}/resources/assets/js/browser.min.js"></script>
			<script src="${path}/resources/assets/js/breakpoints.min.js"></script>
			<script src="${path}/resources/assets/js/util.js"></script>
			<script src="${path}/resources/assets/js/main.js"></script>
</body>
<script>

	submit = function(){
		
		if($("input[name='user_id']").val() == "" || $("input[name='user_pw']").val() == ""){
			alert("아이디와 비밀번호 모두 입력해주세요");
			return false;
		}
		
		frm.submit();
	};

	var msg = '${msg}';
	var url = '${url}';
	if(msg != ""){
		
		alert(msg)
		document.location.href = url;
	}
</script>
</html>