<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/mypage.css?after" />
</head>
<script>
		var toolip = document.getElementsByClassName('toolip');
		var body = document.getElementById('body');
		
		$(document).ready(function(){
			$(document).bind("touchend", function(){
				$("#bg").css("visibility", "hidden");
				$(".toolip").css("visibility", "hidden");
				// $(".toolip").slideUp();
			})
			
			$("#list").scroll(function(){
			
				var scrollTop = $("#list").scrollTop();
				var height = $("#list").height();
				var scrollHeight = $("#list").prop('scrollHeight');
				
				if(scrollTop + height >= scrollHeight){
				
					var lastnum = $(".scrolling:last").attr("num");
					// ajax를 이용해서 현재 뿌려진 게시글의 마지막 num을 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다.
					$.ajax({
						type : 'post',
						url : 'scrollDownMyWalk.do',
						dataType : 'json', //서버로부터 되돌려받는 데이터 타입
						data : "num="+ lastnum,
						success : function(data){
							var str = "";
							
							if(data != ""){
								$(data).each(
										function(){
											str += "<li id='list-content' class='scrolling' num='"+this.num+"'>"
												+	"<a href='/walk/view.do?num="+this.num+"'><img src='"+this.thumb+"' alt=''>"
												+	"<div id='content'>"
												+	"<span id = 'title'>"+this.title+"</span>"
												+	"<ul>"
												+	"<li><span>"+this.breed+"</span></li>"
												+	"<li><span>&#183;</span></li>"
												+	"<li><span>"+this.age+"살</span></li>"
												+	"<li><span>&#183;</span></li>"
												+	"<li><span>"+this.date+"</span></li>"
												+	"</ul>"
												+	"<span id='location'>"+this.location+"</span>"
												+	"</div></a></li>";
								});
								//이전까지 뿌려졌던 데이터는 비워주고, <ul>헤더에 위에 만든 str을 뿌려준다
								
								$(".listToChange").append(str);
									
							}
						},
						error :function(){
							console.log("Erroe");
						} 
							
					});
					/* //class가 listToChange인것 중에 가장 처음인것을 찾아서 그 위치로 이동(스크롤해서 새로운 리스트를 불러오면)
					var position = $(".listToChange:first").offset(); //위치값
					
					//이동 위로 부터 position.top px 위치로 스크롤 하는 것. 그걸 500ms 동안 애니메이션이 이루어짐
					$("#list").animate({scrollTop : position.top }, 600); */
				}
				
								
			})
			
			
		})

		function show() {
			$("#bg").css("visibility", "visible");
			$(".toolip").css("visibility", "visible");
			// $(".toolip").slideDown();
			
		}
		
		
	</script>
<body id="body">
<%@ include file="/WEB-INF/views/template/top.jsp"%>
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar" style="background-color: white; text-align: center;">
					<div style="display: flex; align-items: center; position: relative; z-index: 4; width: 100%;">
						<a href="/mypage/main.do"><i class="fas fa-arrow-left"></i></a>
                        <div class="title" style="width: 90%; font-size: 0.9em; color: black;">
                            <span>나의 산책</span>
                        </div>
					</div>					
				</div>
					<c:choose>
						<c:when test="${not empty list}">
						<div id="list">
							<ul class="listToChange">
							<c:forEach items="${list}" var="walk">
								<li id="list-content" class="scrolling" num="${walk.num}">
									<a href="/walk/view.do?num=${walk.num}&&prev=my"><img src="${walk.thumb}" alt="">
									<div id="content">
										<span id="title">${walk.title}</span>
										<ul>
											<li><span>${walk.breed}</span></li>
											<li><span>&#183;</span></li>
											<li><span>${walk.age}살</span></li>
											<li><span>&#183;</span></li>
											<li><span>${walk.date}</span></li>
										</ul>
										<span id="location">${walk.location}</span>
									</div></a>
								</li>
							</c:forEach>
							</ul>
						</div>
						</c:when>
						<c:otherwise>
							<div id="nolist">
								<p>아직 작성한 게시글이 없어요.</p>
							</div> 
						</c:otherwise>
					</c:choose>
			</div>
			<!-- Nav -->
			<nav id="nav">
				<a href="/walk/list.do" onclick="$.fnGoTop('list')" class="icon solid"
					><i class="fas fa-paw"></i>
				<p>홈</p></a> <a href="/com/list.do" class="icon solid"><i
					class="fas fa-bullhorn"></i>
				<p>커뮤니티</p></a> <a href="#contact" class="icon solid"><i
					class="far fa-comment-alt"></i>
				<p>채팅</p></a> <a href="/mypage/main.do" class="icon brands" style="opacity: 1 !important;"><i
					class="far fa-user"></i>
				<p>나의 펫팔</p></a>
			</nav>
	</body>
</html>