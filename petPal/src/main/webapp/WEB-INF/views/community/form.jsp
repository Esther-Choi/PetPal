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
		
		if($("#num").val() == ""){
			$("form[name=frm]").attr("action", "/com/insertCom.do");
		}else {
			$("form[name=frm]").attr("action", "/com/editCom.do?num="+$("#num").val());
		}
		
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
				<a href="javascript:void(0)" onclick="$.fnBack()">닫기</a>
			</div>
			<span style="color: black; font-size: 0.9em;">커뮤니티 글쓰기</span>
			<div>
				<a href="javascript:void(0)" onclick="$.fnSubmit()">완료</a>
			</div>
		</div>
			<input type="hidden" name="num" id="num" value="${comVO.num}">
		<form id="view-cont" name="frm" method="post">
			<div
				style="display: flex; align-items: center; border-bottom: solid 1px #e6e6e6;">
				<select name="type" id="category">
					<option value="">게시글의 주제를 선택해주세요.</option>
					<option value="질문있어요" ${comVO.type eq '질문있어요' ? "selected='selected'":""}>질문있어요!</option>
					<option value="펫팁 공유해요" ${comVO.type eq '펫팁 공유해요' ? "selected='selected'":""}>펫팁 공유해요</option>
					<option value="펫 찾아주세요" ${comVO.type eq '펫 찾아주세요' ? "selected='selected'":""}>펫 찾아주세요</option>
					<option value="펫용품 추천" ${comVO.type eq '펫용품 추천' ? "selected='selected'":""}>펫용품 추천</option>
				</select><i class="fas fa-chevron-down"></i>
			</div>
			<textarea name="content" id="" cols="30"
				placeholder="펫 관련된 질문이나 이야기를 해보세요.">${comVO.content}</textarea>
		</form>
		<!-- Nav -->
		<nav id="nav">
			<input type="file" id="file" name="file">
		</nav>
	</div>
</body>
</html>