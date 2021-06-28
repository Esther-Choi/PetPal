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
		<link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		<noscript><link rel="stylesheet" href="${path}/resources/assets/css/noscript.css" /></noscript>
	</head>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js'></script>
	<body id="body">
	<%
		System.out.println(session.getAttribute("user_id"));
		if(session.getAttribute("user_id") == null){
			%>
			<script type="text/javascript">
				location.href = "/user/main.do";
			</script>
			<% 
		}%>	
	<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar">
					<div style="display: flex; align-items: center; position: relative; z-index: 4;">
						<a href="javascript:void(0);" style="margin-right: 5px;" onclick="show()"><span class="bold">용현5동</span></a>
						<i class="fas fa-chevron-down" style="font-size: 10px;"></i>
						<div class="toolip">
							<p id="address">용현5동</p>
							<p id="set">내 동네 설정하기</p>
						</div>
					</div>
					<div style="width: 90px; display: flex; justify-content: space-between;">	
						<a href=""><i class="fas fa-search" style="font-size: 18px;"></i></a>
						<a href=""><i class="fas fa-sliders-h"></i></a>
						<a href=""><i class="far fa-bell"></i></a>
					</div>
				</div>
				<div id="list">
					<ul class="listToChange">
					<c:forEach items="${list}" var="walkVO">
						<li id="list-content" class="scrolling" num = "${walkVO.num}">
							<a href="/walk/view.do?num=${walkVO.num}"><img src="${walkVO.thumb}" alt="">
							<div id="content">
								<span id="title">${walkVO.title}</span>
								<ul>
									<li><span>${walkVO.breed}</span></li>
									<li><span>&#183;</span></li>
									<li><span>${walkVO.age}살</span></li>
									<li><span>&#183;</span></li>
									<li><span>${walkVO.date}</span></li>
								</ul>
								<span id="location">${walkVO.location}</span>
							</div></a>
						</li>
					</c:forEach>
								
					</ul>
				</div>
				<a href="/walk/form.do" id="write">
					<i class="fas fa-pencil-alt"></i>
				</a>
				<!-- Nav -->
				<nav id="nav">
					<a href="javascript:void(0)" onclick="goTop()" class="icon solid" style="opacity: 1 !important;"><i class="fas fa-paw"></i><p>홈</p></a>
					<a href="/com/list.do" class="icon solid"><i class="fas fa-bullhorn"></i><p>커뮤니티</p></a>
					<a href="#contact" class="icon solid"><i class="far fa-comment-alt"></i><p>채팅</p></a>
					<a href="mypage.html" class="icon brands"><i class="far fa-user"></i><p>나의 펫팔</p></a>
				</nav>
			</div>
		
		<!--<script type="text/javascript" src="${path}/resources/assets/js/jquery-ui.min.js"></script>-->
			<!--<script src="${path}/resources/assets/js/jquery.min.js"></script>-->
			<script src="${path}/resources/assets/js/browser.min.js"></script>
			<script src="${path}/resources/assets/js/breakpoints.min.js"></script>
			<script src="${path}/resources/assets/js/util.js"></script>
			<script src="${path}/resources/assets/js/main.js"></script>
			
	</body>
	<script>
		var toolip = document.getElementsByClassName('toolip');
		var body = document.getElementById('body');
		
		function goTop(){
			$("#list").scrollTop(0);
		}

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
					console.log(lastnum);
					// ajax를 이용해서 현재 뿌려진 게시글의 마지막 num을 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다.
					$.ajax({
						type : 'post',
						url : 'scrollDown.do',
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
			
			//이전 스크롤 좌표
			/*var lastScrollTop = 0;
			
			$("#list").scroll(function() {
				//현재 스크롤 좌표
				var currentScrollTop = $("#list").scrollTop();
				
				//만약 현재 위치 - 이전 위치가 0 보다 크다면, 즉 다운스크롤 했다면
				if(currentScrollTop - lastScrollTop > 0){
					
					if($("#list").scrollTop() >= ($(document).height() - $(window).height())){
						
						var lastnum = $(".scrolling:last").attr("num");
						console.log(lastnum);
						// ajax를 이용해서 현재 뿌려진 게시글의 마지막 num을 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다.
						$.ajax({
							type : 'post',
							url : 'scrollDown.do',
							contentType : 'application/json',
							headers : {
								"Context-Type" : "application/json",
								"X-HTTP-Method-Override" : "POST"
							},
							dataType : 'json', //서버로부터 되돌려받는 데이터 타입
							data : JSON.stringify({ // 서버로 보낼 데이터
								num : lastnum
							}),
							success : function(data){
								var str = "";
								
								if(data != ""){
									$(data).each(
											function(){
												console.log(this);
												str += "<li id='list-content' class='scrolling' num='"+this.num+"'>"
													+	"<a href='/walk/view.do'><img scr='"+this.thumb+"'>"
													+	"<div id='content'>"
													+	"<span id = 'title'>"+this.title+"</span>"
													+	"<ul>"
													+	"<li><span>"+this.breed+"</span></li>"
													+	"<li><span>&#183;</span></li>"
													+	"<li><span>"+this.age+"</span></li>"
													+	"<li><span>&#183;</span></li>"
													+	"<li><span>"+this.date+"</span></li>"
													+	"<ul>"
													+	"<span id='location'>"+this.location+"</span>"
													+	"</div></a></li>";
									});
									//이전까지 뿌려졌던 데이터는 비워주고, <ul>헤더에 위에 만든 str을 뿌려준다
									$(".listToChange").empty();
									$(".listToChange").append(str);
										
								}
							},
							error :function(){
								console.log("Erroe");
							} 
								
						});
						//class가 listToChange인것 중에 가장 처음인것을 찾아서 그 위치로 이동(스크롤해서 새로운 리스트를 불러오면)
						var position = $(".listToChange:first").offset(); //위치값
						
						//이동 위로 부터 position.top px 위치로 스크롤 하는 것. 그걸 500ms 동안 애니메이션이 이루어짐
						$("#list").animate({scrollTop : position.top }, 600);
					}
				}else {
					//만약 현재 위치 - 이전 위치가 0 보다 크다면, 즉 다운스크롤 했다면
					if($("#list").scrollTop() <= 0){
							
							var firstnum = $(".scrolling:first").attr("num");
							console.log(lastnum);
							// ajax를 이용해서 현재 뿌려진 게시글의 마지막 num을 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다.
							$.ajax({
								type : 'post',
								url : 'scrollUp.do',
								contentType : 'application/json',
								headers : {
									"Context-Type" : "application/json",
									"X-HTTP-Method-Override" : "POST"
								},
								dataType : 'json', //서버로부터 되돌려받는 데이터 타입
								data : JSON.stringify({ // 서버로 보낼 데이터
									num : firstnum
								}),
								success : function(data){
									var str = "";
									
									if(data != ""){
										$(data).each(
												function(){
													console.log(this);
													str += "<li id='list-content' class='scrolling' num='"+this.num+"'>"
														+	"<a href='/walk/view.do'><img scr='"+this.thumb+"'>"
														+	"<div id='content'>"
														+	"<span id = 'title'>"+this.title+"</span>"
														+	"<ul>"
														+	"<li><span>"+this.breed+"</span></li>"
														+	"<li><span>&#183;</span></li>"
														+	"<li><span>"+this.age+"</span></li>"
														+	"<li><span>&#183;</span></li>"
														+	"<li><span>"+this.date+"</span></li>"
														+	"<ul>"
														+	"<span id='location'>"+this.location+"</span>"
														+	"</div></a></li>";
										});
										//이전까지 뿌려졌던 데이터는 비워주고, <ul>헤더에 위에 만든 str을 뿌려준다
										$(".listToChange").empty();
										$(".listToChange").append(str);
											
									}
								},
								error :function(){
									console.log("Erroe");
								} 
									
							});
							//class가 listToChange인것 중에 가장 처음인것을 찾아서 그 위치로 이동(스크롤해서 새로운 리스트를 불러오면)
							var position = ($(document).height() - $(window).height()) -10; //위치값
							
							//이동 위로 부터 position.top px 위치로 스크롤 하는 것. 그걸 500ms 동안 애니메이션이 이루어짐
							$("#list").animate({scrollTop : position }, 600);
					}
				}
				
			});   */
			
		})

		function show() {
			$("#bg").css("visibility", "visible");
			$(".toolip").css("visibility", "visible");
			// $(".toolip").slideDown();
			
		}
		
		
	</script>
</html>









