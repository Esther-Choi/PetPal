<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/com_form.css" />
</head>
<script>
	$.fnSubmit = function() {
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
				<a href="community.html">닫기</a>
			</div>
			<span style="color: black; font-size: 0.9em;">커뮤니티 글쓰기</span>
			<div>
				<a href="javascript:void(0)" onclick="$.fnSubmit()">완료</a>
			</div>
		</div>
		<form id="view-cont" name="frm" action="/com/insertCom.do"
			method="post">
			<div
				style="display: flex; align-items: center; border-bottom: solid 1px #e6e6e6;">
				<select name="type" id="category">
					<option value="">게시글의 주제를 선택해주세요.</option>
					<option value="질문있어요">질문있어요!</option>
					<option value="펫팁 공유해요">펫팁 공유해요</option>
					<option value="펫 찾아주세요">펫 찾아주세요</option>
					<option value="펫용품 추천">펫용품 추천</option>
				</select><i class="fas fa-chevron-down"></i>
			</div>
			<textarea name="content" id="" cols="30"
				placeholder="펫 관련된 질문이나 이야기를 해보세요."></textarea>
		</form>
		<!-- Nav -->
		<nav id="nav">
			<input type="file" id="file" name="file">
		</nav>
	</div>
</body>
</html>