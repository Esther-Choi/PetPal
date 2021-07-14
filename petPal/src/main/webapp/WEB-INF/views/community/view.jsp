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
		<link rel="stylesheet" href="${path}/resources/assets/css/main.css?after" />
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		<noscript><link rel="stylesheet" href="${path}/resources/assets/css/noscript.css" /></noscript>
	</head>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<body id="body">
	<input type="hidden" value="${check}" id="check">
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar" style="background-color: white;">
					<div style="display: flex; align-items: center; position: relative; z-index: 4;">
						<a href="javascript:void(0)" onclick="back()"><i class="fas fa-arrow-left"></i></a>
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
						<a href="javascript:void(0)" onclick="writeCom()"><i class="far fa-comment"></i>댓글 <span id="com-cnt"></span></a>
					</div>
					<ul id="comments">
					</ul>	
				</div>
				<!-- Nav -->
				
				<form id="nav" name="frm" method="get" style="width: 100%; margin: 0 10px;">
					<input type="hidden" id="board_num" name="board_num" value="${comVO.num}">
					<input type="text" id="input" name="content" placeholder="따뜻한 댓글을 입력해주세요 :D">
					<a href="javascript:void(0)" id="sendBtn"><i class="fas fa-arrow-right"></i></a>
				</form>
				
			</div>
		
		<!-- Scripts -->
			<script src="${path}/resources/assets/js/jquery.min.js"></script>
			<script src="${path}/resources/assets/js/browser.min.js"></script>
			<script src="${path}/resources/assets/js/breakpoints.min.js"></script>
			<script src="${path}/resources/assets/js/util.js"></script>
			<script src="${path}/resources/assets/js/main.js"></script>
			
	</body>
	<script>
	
	$(document).ready(function(){
		var check = $("#check").val();
		
		if(check == 1){
			
		}
	});
	
	function back(){
		window.history.back();
	}

	
	$(function(){
		getCommentList();
	});

		$("#input").on("change keyup paste", function(){
			if($("#input").val() == ""){
				$("#sendBtn").hide();
			}else {
				$("#sendBtn").css("display", "flex");
			}
		})
		
		$("#sendBtn").on("click", function(){
			$.ajax({
				type: 'GET',
				url: "/com/insertComment.do",
				data: $("#nav").serialize(),
				success : function(data){
					if(data == "success"){
						$("#input").val("");
						getCommentList();
					}
				},
				error : function(){
					console.log("error")
					alert("댓글 작성 실패. 잠시 후 다시 시도해 주세요")
				}
			});
		});
		
		
		function getCommentList(){
			var boardNo = $("#board_num").val();
			$.ajax({
				type: 'GET',
				url: "/com/getCommentList.do",
				data: {"boardNo" : boardNo},
				dataType : "json",
				success : function(data){
					var html = "";
					var cnt = data.length;
					
					if(data.length > 0){
						for (var i = 0; i < data.length; i++) {
							html += "<li id='profile'>";
							html += "<img src='"+data[i].photo+"' alt=''>";
							html += "<div id='info'>"
							html += "<p id='nickname'>"+data[i].user_name+"</p>";
							html += "<ul>";
							html += "<li><span id='com-address'>"+data[i].address+"</span></li>";
							html += "<li><span>&#183;</span></li>";
							html += "<li><span id='com-date'>"+data[i].date+"</span></li>";
							html += "</ul>";
							html += "<p id='comment'>"+data[i].content+"</p>"
							html += "</div>";
							html += "</li>";
						}
						}else{
							html += "<div id='nocom'>";
							html += "<i class='fas fa-comment-dots'></i>";
							html += "<p>아직 댓글이 없어요.</p>";
							html += "<span>가장 먼저 댓글을 남겨보세요.</span>";
						}
						$("#com-cnt").html(cnt);
						$("#comments").html(html);
					},
				error : function(){
					console.log("error")
					alert("댓글 로딩 실패. 잠시 후 다시 시도해 주세요")
				}
			});
		};

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