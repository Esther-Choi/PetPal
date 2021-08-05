<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/mypage.css?after" />
<link rel="stylesheet" href="${path}/resources/assets/css/scrap.css?after" />
</head>
<style>
#sub {
	padding-top: 5px;
}

.activeLike {
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

						$("#cont-list")
								.scroll(
										function() {

											var scrollTop = $("#cont-list")
													.scrollTop();
											var height = $("#cont-list").height();
											var scrollHeight = $("#cont-list").prop(
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
															url : 'scrollDownMyScrap.do',
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
																								+ "&&prev='>"
																								+ "<div id='content'>"
																								+ "<span id = 'com-type'>"
																								+ this.type
																								+ "</span>"
																								+ "<p id='title'>"
																								+ this.content
																								+ "</p>"
																								+ "<ul>"
																								+ "<li><span id='writer'>"
																								+ this.user_name
																								+ "</span></li>"
																								+ "<li><span>&#183;</span></li>"
																								+ "<li><span id='date'>"
																								+ this.date
																								+ "</span></li>"
																								+ "</ul>"
																								+ "</div></a>"
																								+ "<div id='sub'>";
																						if(this.likecheck == 1) {
																							str += "<a href='javascript:void(0)' class='like'><i class='far fa-heart like activeLike'></i><span class='activeLike' id='like-text'>좋아요</span></a>"
																						} else {
																							str += "<a href='javascript:void(0)' class='like'><i class='far fa-heart like'></i><span id='like-text'>좋아요</span></a>"
																						}
																						str += "<a href='com_view.html'><i class='far fa-comment'></i>댓글쓰기</a>"
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
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper" style="padding-bottom: 0">	
				<div id="bar" style="background-color: white; text-align: center;">
					<div style="display: flex; align-items: center; position: relative; z-index: 4; width: 100%;">
						<a href="/mypage/main.do"><i class="fas fa-arrow-left"></i></a>
                        <div class="title">
                            <span>관심목록</span>
                        </div>
					</div>					
				</div>
                <div class="category-div">
                    <div>
                        <a href="/mypage/scrap/walk/list.do"><span>산책</span></a>
                    </div>
                    <div class="active-div">
                        <a href="/mypage/scrap/community/list.do"><span class="active">커뮤니티</span></a>
                    </div>
                </div>
					<c:choose>
						<c:when test="${not empty list}">
							<div id="cont-list" style="height: calc(100vh - 7.2em) !important">
								<ul>
							<c:forEach items="${list}" var="com">
								<li id="list-content" class="scrolling" num="${com.num}">
									<a href="/com/view.do?num=${com.num}&&prev=my">
										<div id="content">
											<span id="com-type">${com.type}</span>
											<p id="title">${com.content}</p>
											<ul>
												<li><span id="writer">${com.user_name}</span></li>
												<li><span>&#183;</span></li>
												<li><span id="date">${com.date}</span></li>									
											</ul>
										</div>
									</a>
									<div id="sub">
									<c:choose>
										<c:when test="${com.likecheck eq 1}">
											<a href="javascript:void(0)" num="${com.num}" class="like" onclick = "$.fnLike(this)"><i
												class="far fa-heart like activeLike"></i><span class="activeLike"
												id="like-text">좋아요</span></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0)" num="${com.num}" class="like" onclick = "$.fnLike(this)"><i
												class="far fa-heart like"></i><span id="like-text">좋아요</span></a>
										</c:otherwise>
									</c:choose>
									<a href="/com/view.do?num=${com.num}"><i
										class="far fa-comment"></i>댓글쓰기</a>
								</div>
								</li>
							</c:forEach>
							</ul>
						</div>
						</c:when>
						<c:otherwise>
							<div id="nolist" style="height: calc(100vh - 5.55em)">
								<p>아직 작성한 게시글이 없어요.</p>
							</div> 
						</c:otherwise>
					</c:choose>
			</div>
	</body>
</html>