<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/mypage.css?after" />
</head>
<body id="body">
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar">
					<div style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
						<span class="bold">나의 펫팔</span>
						<i class="fas fa-cog"></i>
					</div>					
				</div>
				<div class="profile">
					<img src="${thumb}" alt="">
					<div>
						<span id="nickname">${name}</span>
						<a href="/mypage/profile/view.do" id="viewProfile"><span>마이프로필</span></a>
					</div>
				</div>
				<div class="mypage">
					<ul>
						<li>
							<a href="/mypage/walk/list.do">
								<div>
									<i class="fas fa-paw color"></i>
									<span>나의 산책</span>
								</div>
								<div>
									<i class="fas fa-chevron-right"></i>
								</div>
							</a>
						</li>
						<li>
							<a href="/mypage/community/list.do">
								<div>
									<i class="fas fa-pen-alt color"></i>
									<span>나의 커뮤니티</span>
								</div>
								<div>
									<i class="fas fa-chevron-right"></i>
								</div>
							</a>
						</li>
						<li>
							<a href="/mypage/scrap/walk/list.do">
								<div>
									<i class="fas fa-heart color"></i>
									<span>관심목록</span>
								</div>
								<div>
									<i class="fas fa-chevron-right"></i>
								</div>
							</a>
						</li>
						<li>
							<a href="petpal.html">
								<div>
									<i class="fas fa-dog color"></i>
									<span>펫팔 관리</span>
								</div>
								<div>
									<span id="count">0</span>
									<i class="fas fa-chevron-right"></i>
								</div>
							</a>
						</li>
					</ul>
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
			</div>
			
	</body>
</html>