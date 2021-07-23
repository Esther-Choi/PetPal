<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
</head>
<style>
#sub {
	padding-top: 5px;
}

.active {
	color: rgb(255, 179, 102);
}
</style>
<script>
	var toolip = document.getElementsByClassName('toolip');
	var body = document.getElementById('body');

	$(document)
			.ready(
					function() {
						$(document).bind("touchend", function() {
							$("#bg").css("visibility", "hidden");
							$(".toolip").css("visibility", "hidden");
							// $(".toolip").slideUp();
						})

						$("#list")
								.scroll(
										function() {

											var scrollTop = $("#list")
													.scrollTop();
											var height = $("#list").height();
											var scrollHeight = $("#list").prop(
													'scrollHeight');

											if (scrollTop + height >= scrollHeight) {

												var lastnum = $(
														".scrolling:last")
														.attr("num");
												console.log(lastnum);
												// ajax를 이용해서 현재 뿌려진 게시글의 마지막 num을 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다.
												$
														.ajax({
															type : 'post',
															url : 'scrollDown.do',
															dataType : 'json', //서버로부터 되돌려받는 데이터 타입
															data : "num="
																	+ lastnum,
															success : function(
																	data) {
																var str = "";

																if (data != "") {
																	$(data)
																			.each(
																					function() {
																						str += "<li id='list-content' class='scrolling' num='"+this.num+"'>"
																								+ "<a href='/com/view.do?num="
																								+ this.num
																								+ "'>"
																								+ "<div id='content'>"
																								+ "<span id = 'com-type'>"
																								+ this.type
																								+ "</span>"
																								+ "<p id='title'>"
																								+ this.title
																								+ "</p>"
																								+ "<ul>"
																								+ "<li><span id='writer'>"
																								+ this.user_id
																								+ "</span></li>"
																								+ "<li><span>&#183;</span></li>"
																								+ "<li><span id='date'>"
																								+ this.date
																								+ "</span></li>"
																								+ "</ul>"
																								+ "</div></a>"
																								+ "<div id='sub'>"
																						if (this.likecheck == 1) {
																							+"<a href='javascript:void(0)' class='like'><i class='far fa-heart like active'></i><span class='active' id='like-text'>좋아요</span></a>"
																						} else {
																							+"<a href='javascript:void(0)' class='like'><i class='far fa-heart like'></i><span id='like-text'>좋아요</span></a>"
																						}
																						+"<a href='com_view.html'><i class='far fa-comment'></i>댓글쓰기</a>"
																								+ "</div></li>";
																					});
																	//이전까지 뿌려졌던 데이터는 비워주고, <ul>헤더에 위에 만든 str을 뿌려준다

																	$(
																			".listToChange")
																			.append(
																					str);

																}
															},
															error : function() {
																console
																		.log("Error");
															}

														});
												/* //class가 listToChange인것 중에 가장 처음인것을 찾아서 그 위치로 이동(스크롤해서 새로운 리스트를 불러오면)
												var position = $(".listToChange:first").offset(); //위치값
												
												//이동 위로 부터 position.top px 위치로 스크롤 하는 것. 그걸 500ms 동안 애니메이션이 이루어짐
												$("#list").animate({scrollTop : position.top }, 600); */
											}

										})

					})

	$.fnShow = function() {
		$("#bg").css("visibility", "visible");
		$(".toolip").css("visibility", "visible");
		// $(".toolip").slideDown();

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
</script>
<body id="body">
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<input type="hidden" value="${check}" id="check">
	<!-- <div id="bg"></div> -->
	<!-- Wrapper-->
	<div id="wrapper">
		<div id="bar" style="background-color: white;">
			<div
				style="display: flex; align-items: center; position: relative; z-index: 4;">
				<a href="javascript:void(0);" style="margin-right: 5px;"
					onclick="$.fnShow()"><span>용현5동</span></a> <i
					class="fas fa-chevron-down" style="font-size: 10px;"></i>
				<div class="toolip">
					<p id="address">용현5동</p>
					<p id="set">내 동네 설정하기</p>
				</div>
			</div>
			<div
				style="width: 90px; display: flex; justify-content: space-between;">
				<a href=""><i class="fas fa-search" style="font-size: 18px;"></i></a>
				<a href=""><i class="fas fa-sliders-h"></i></a> <a href=""><i
					class="far fa-bell"></i></a>
			</div>
		</div>
		<div id="cont-list">
			<ul class="listToChange">
				<c:forEach items="${lists}" var="comVO">
					<li id="list-content" class="scrolling"><a
						href="/com/view.do?num=${comVO.num}">
							<div id="content">
								<span id="com-type">${comVO.type}</span>
								<p id="title">${comVO.content}</p>
								<ul>
									<li><span id="writer">${comVO.user_name}</span></li>
									<li><span>&#183;</span></li>
									<li><span id="date">${comVO.date}</span></li>
								</ul>
							</div>
					</a>
						<div id="sub">
							<c:choose>
								<c:when test="${comVO.likecheck eq 1}">
									<a href="javascript:void(0)" num="${comVO.num}" class="like" onclick = "$.fnLike(this)"><i
										class="far fa-heart like active"></i><span class="active"
										id="like-text">좋아요</span></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0)" num="${comVO.num}" class="like" onclick = "$.fnLike(this)"><i
										class="far fa-heart like"></i><span id="like-text">좋아요</span></a>
								</c:otherwise>
							</c:choose>
							<a href="/com/view.do?num=${comVO.num}"><i
								class="far fa-comment"></i>댓글쓰기</a>
						</div></li>
				</c:forEach>
			</ul>
		</div>
		<a href="/com/form.do" id="write"> <i class="fas fa-pencil-alt"></i>
		</a>
		<!-- Nav -->
		<nav id="nav">
			<a href="/walk/list.do" class="icon solid"><i class="fas fa-paw"></i>
				<p>홈</p></a> <a href="javascript:void(0)" onclick="$.fnGoTop('cont-list')"
				class="icon solid" style="opacity: 1 !important;"><i
				class="fas fa-bullhorn"></i>
				<p>커뮤니티</p></a> <a href="#contact" class="icon solid""><i
				class="far fa-comment-alt"></i>
				<p>채팅</p></a> <a href="mypage.html" class="icon brands"><i
				class="far fa-user"></i>
				<p>나의 펫팔</p></a>
		</nav>
	</div>
</body>
</html>