<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/petpal.css?after" />
</head>
<script>
		
		$.fnFollow = function(follow_id){
			
			var check = 0;
			$.ajax({
				type : 'POST',
				url : "/user/follow.do",
				data : {"follow_id":follow_id, "check":check},
				success : function(data) {
					if (data == "success") {
						location.href = location.href;
					}
				},
				error : function() {
					console.log("error")
					alert("펫팔 실패. 잠시 후 다시 시도해 주세요")

				}
			});
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
                            <span>펫팔관리</span>
                        </div>
					</div>					
				</div>
					<c:choose>
						<c:when test="${not empty list}">
						<div id="pet-list" style="height: calc(100vh - 4.4em)">
							<ul class="listToChange">
							<c:forEach items="${list}" var="user">
								<li class="scrolling">
								<div class="profile">
									<a href="/user/profile/main.do?user_id=${user.user_id}">
									<div class="profile-div">
										<img src="${user.pet_photothumb}" alt="">
										<div class="name">
											<span id="petname">${user.pet_name}</span>							
											<span id="nickname">${user.user_name}</span>							
										</div>
									</div>
								</a>
									<div>
										<div class="a-div">
											<a href="javascript:void(0)" onclick="$.fnFollow('${user.user_id}')">언펫팔</a>
										</div>
									</div>
								</div>
								</li>
							</c:forEach>
							</ul>
						</div>
						</c:when>
						<c:otherwise>
							<div id="nolist">
								<p>아직 펫팔이 없어요.</p>
							</div> 
						</c:otherwise>
					</c:choose>
			</div>
	</body>
</html>