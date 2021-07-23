<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/view.css?after" />
</head>
<script>
	$(document).ready(function() {
		var check = $("#check").val();

		if (check == 1) {
			$(".like").css("color", "rgb(255, 179, 102)");
		} else {
			$(".like").css("color", "#737373");
		}
	});


	$.fnLike = function(num) {
		var check = 0;
		if ($(".like").css("color") == "rgb(255, 179, 102)") {
			check = 0;
		} else {
			check = 1;
		}
		$.ajax({
			type : 'GET',
			url : "/walk/likeWalk.do?num=" + num + "&check=" + check,
			success : function(data) {
				if (data == "success") {
					if ($(".like").css("color") == "rgb(255, 179, 102)") {
						$(".like").css("color", "#737373");
					} else {
						$(".like").css("color", "rgb(255, 179, 102)");
					}
				}
			},
			error : function() {
				console.log("error")
				alert("좋아요 실패. 잠시 후 다시 시도해 주세요")

			}
		});

	}
	
	$.fnForm = function(num) {
		$("#frm").attr("method", "get");
		$("#frm").attr("action", "/walk/form.do?"+num);
		$("#frm").submit();
	}
	
	$.fnDeleteCheck = function(num){
		var check = confirm("게시글을 정말 삭제하시겠어요?");
		if(check){
			location.href = '/walk/delete.do?num='+num;
		}
	}
</script>
<body>
	<%@ include file="/WEB-INF/views/template/top.jsp"%>

	<input type="hidden" value="${check}" id="check">
	<form id="frm" name="frm">
		<input type="hidden" value="${walkVO.num}">
<%-- 		<input type="hidden" value="${walkVO.title}">
		<input type="hidden" value="${walkVO.location}">
		<input type="hidden" value="${walkVO.date}">
		<input type="hidden" value="${walkVO.walk_time}">
		<input type="hidden" value="${walkVO.walk_hour}">
		<input type="hidden" value="${walkVO.walk_minute}">
		<input type="hidden" value="${walkVO.content}"> --%>
	</form>
	<div id="wrapper" style="padding-top: 10px;">
		<div id="bar"
			style="border-bottom: none; padding-top: 2px; padding-bottom: 10px; margin-bottom: 0;">
			<div
				style="display: flex; align-items: center; position: relative; z-index: 4; justify-content: space-between; width: 100%;">
				<a href="/walk/list.do"><i
					class="fas fa-arrow-left"></i></a>
				<div
				style="width: 50px; display: flex; justify-content:flex-end; align-content: center;  align-items: center;">
				<c:if test="${walkVO.user_id eq user_id}">
					<a href="/walk/form.do?num=${walkVO.num}" style="margin-right: 25px"><i class="far fa-edit"></i></a>
					<a href="javascript:void(0)" onclick="$.fnDeleteCheck('${walkVO.num}')"><i class="far fa-trash-alt"></i></a>
				</c:if>
				</div>
			</div>
		</div>
		<div
			style="overflow: scroll !important; width: 100%; height: calc(100vh - 90px); padding-bottom: 15px;">

			<div id="content">
				<p id="title">${walkVO.title}</p>
				<ul>
					<li><i class="fas fa-check"></i>&nbsp;<span> 종류 : </span><span
						id="type">${walkVO.breed}</span></li>
					<li><i class="fas fa-check"></i>&nbsp;<span> 나이 : </span><span
						id="age">${walkVO.age}살</span></li>
					<li><i class="fas fa-check"></i>&nbsp;<span> 장소 : </span><span
						id="place">${walkVO.location}</span></li>
					<li><i class="fas fa-check"></i>&nbsp;<span> 날짜 : </span><span
						id="date">${walkVO.date}</span></li>
					<li><i class="fas fa-check"></i>&nbsp;<span> 시간 : </span><span
						id="time"> ${walkVO.walk_time} ${walkVO.walk_hour}시 <c:if
								test="${walkVO.walk_minute ne 0}">${walkVO.walk_minute}분</c:if></span></li>
				</ul>
				<p id="cont">${walkVO.content}</p>
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
			<button id="heart" onclick="$.fnLike('${walkVO.num}')">
				<i class="far fa-heart like" id="color"></i>
			</button>
			<div class="btn-box">
				<a href="/user/profile.do?user_id=${walkVO.user_id}"
					id="viewProfile">프로필 보기</a>
			</div>
			<div class="btn-box">
				<a href="" id="chat">채팅하기</a>
			</div>
		</nav>
	</div>
</body>
</html>