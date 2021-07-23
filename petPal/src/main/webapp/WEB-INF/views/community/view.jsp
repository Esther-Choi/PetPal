<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
</head>
<style>
.active {
	color: rgb(255, 179, 102);
}
</style>
<script>
	
	
	$(document).ready(function(){
		var check = $("#check2").val();
		
		if(check == 1){
			$(".scrap").css("color", "rgb(255, 179, 102)");
		}else {
			$(".scrap").css("color", "#737373");
		}
		
		$("#input").on("change keyup paste", function(){
			if($("#input").val() == ""){
				$("#sendBtn").hide();
			}else {
				$("#sendBtn").css("display", "flex");
			}
		})
	});

	
		$(function(){
			getCommentList();
		});

		
		
		$.fnSendComment = function(){
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
		};
		
		
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



		function writeCom(){
			$("input").focus();
		}
		
		 $.fnLike = function(e) {
			var i = $(e).children("i");
			var span = $(e).children("span");
			var color = span.attr("class");
			var num = $(e).attr("num");

			var check = 0;
			if (color == "active") {
				check = 0;
			} else {
				check = 1;
			}
			$.ajax({
				type : 'GET',
				url : "/com/likeCom.do?num=" + num + "&check=" + check,
				success : function(data) {
					if (data == "success") {
						if (color == "active") {
							i.attr("class", "far fa-heart like");
							span.attr("class", "");
						} else {
							i.attr("class", "far fa-heart like active");
							span.attr("class", "active");

						}
					}
				},
				error : function() {
					console.log("error")
					alert("좋아요 실패. 잠시 후 다시 시도해 주세요")

				}
			});

		}
		
		function scrap(num){
    		var check = 0;
    		if($(".scrap").css("color") == "rgb(255, 179, 102)"){
				check = 0;
			}else {
				check = 1;
			}
    		$.ajax({
    			type: 'GET',
    			url : "/com/scrapCom.do?num="+num+"&check="+check,
    			success : function(data){
    				if(data == "success"){
    					if($(".scrap").css("color") == "rgb(255, 179, 102)"){
    						$(".scrap").css("color", "#737373");
    					}else {
    						$(".scrap").css("color", "rgb(255, 179, 102)");
    					}
    				}
    			},
    			error : function(){
    				console.log("error")
					alert("좋아요 실패. 잠시 후 다시 시도해 주세요")
				
    			}
    		});
    		
		}
		
		$.fnDeleteCheck = function(num){
			var check = confirm("게시글을 정말 삭제하시겠어요?");
			if(check){
				location.href = '/com/delete.do?num='+num;
			}
		}
		
	</script>
<body id="body">
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<input type="hidden" value="${check}" id="check">
	<input type="hidden" value="${check2}" id="check2">
	<!-- <div id="bg"></div> -->
	<!-- Wrapper-->
	<div id="wrapper">
		<div id="bar" style="background-color: white;">
			<div
				style="display: flex; align-items: center; position: relative; z-index: 4;">
				<a href="/com/list.do"><i class="fas fa-arrow-left"></i></a>
			</div>
			<div
				style="width: 50px; display: flex; justify-content:flex-end; align-content: center;  align-items: center;">
				<c:if test="${comVO.user_id eq user_id}">
					<a href="/com/form.do?num=${comVO.num}" style="margin-right: 25px; padding-bottom: 3px"><i class="far fa-edit"></i></a>
					<a href="javascript:void(0)" onclick="$.fnDeleteCheck('${comVO.num}')"><i class="far fa-trash-alt"></i></a>
				</c:if>
				<c:if test="${comVO.user_id ne user_id}">
					<a href="javascript:void(0)" onclick="scrap('${comVO.num}')"
						id="save"><i class="far fa-heart scrap"
						style="font-size: 18px;"></i></a>
				</c:if>
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
				<c:choose>
					<c:when test="${comVO.likecheck eq 1}">
						<a href="javascript:void(0)" num="${comVO.num}" class="like" onclick="$.fnLike(this)"><i
							class="far fa-heart like active"></i><span class="active"
							id="like-text">좋아요</span></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0)" num="${comVO.num}" class="like" onclick="$.fnLike(this)"><i
							class="far fa-heart like"></i><span id="like-text">좋아요</span></a>
					</c:otherwise>
				</c:choose>
				<a href="javascript:void(0)" onclick="writeCom()"><i
					class="far fa-comment"></i>댓글 <span id="com-cnt"></span></a>
			</div>
			<ul id="comments">
			</ul>
		</div>
		<!-- Nav -->

		<form id="nav" name="frm" method="get"
			style="width: 100%; margin: 0 10px;">
			<input type="hidden" id="board_num" name="board_num"
				value="${comVO.num}"> <input type="text" id="input"
				name="content" placeholder="따뜻한 댓글을 입력해주세요 :D"> <a
				href="javascript:void(0)" id="sendBtn" onclick = "$.fnSendComment()"><i
				class="fas fa-arrow-right"></i></a>
		</form>

	</div>
</html>