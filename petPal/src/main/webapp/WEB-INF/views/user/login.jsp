<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/login.css" />
</head>
<script>

	$.fnSubmit = function(){
		
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
<body id="body">
	<div id="wrapper">
		<div id="top">
			<p>로그인</p>
			<a href="/user/main.do"><i class="fas fa-times"></i></a>
		</div>
		<form name="frm" action="/user/loginOk.do" method="POST">
			<div id="input">
				<input type="text" placeholder="아이디" name="user_id"> <input
					type="text" placeholder="비밀번호" name="user_pw">
			</div>
		</form>
		<div id="buttons">
			<a href="javascript:void(0)" onclick="$.fnSubmit()" id="login">로그인</a>
		</div>
		<!--<div id="buttons">
            <a href="" id="kakao"><i class="fas fa-comment"></i>카카오 계정으로 로그인</a>
        </div>  -->
		<div id="sub-menu">
			<a href="">아이디 찾기</a> <a href="" id="findpw">비밀번호 찾기</a> <a
				href="/user/join01.do">회원가입</a>
		</div>
	</div>
</body>
</html>