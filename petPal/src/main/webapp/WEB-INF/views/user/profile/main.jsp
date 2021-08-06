<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/assets/css/mypage.css?after" />
<link rel="stylesheet" href="${path}/resources/assets/css/profile.css?after" />
<link rel="stylesheet" href="${path}/resources/assets/css/view.css?after" />
</head>
<script type="text/javascript">
	$.fnFollow = function(follow_id){
		
		var check = 0;
		if ($("#follow").attr("class") == "follow") {
			check = 1;
		} else {
			check = 0;
		}
		$.ajax({
			type : 'POST',
			url : "/user/follow.do",
			data : {"follow_id":follow_id, "check":check},
			success : function(data) {
				if (data == "success") {
					if ($("#follow").attr("class") == "follow") {
						$("#follow").attr("class", "unfollow");
						$("#follow").text("언펫팔하기")
					} else {
						$("#follow").attr("class", "follow");
						$("#follow").text("펫팔하기")
					}
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
		<!-- <div id="bg"></div> -->
		<!-- Wrapper-->
			<div id="wrapper">	
				<div id="bar" style="background-color: white; text-align: center;">
					<div style="display: flex; align-items: center; position: relative; z-index: 4; width: 100%;">
						<a href="javascript:history.back();"><i class="fas fa-arrow-left"></i></a>
                        <div class="title" style="width: 90%; font-size: 0.9em; color: black;">
                            <span>프로필</span>
                        </div>
					</div>					
				</div>
				<div class="profile">
					<img src="${thumb}" alt="">
					<div>
						<span id="nickname">${name}</span>
						<a href="/user/profile/view.do?user_id=${user_id}" id="viewProfile"><span>프로필 보기</span></a>
					</div>
				</div>
				<div class="mypage">
					<ul>
						<li>
							<a href="/user/walk/list.do?user_id=${user_id}">
								<div>
									<i class="fas fa-paw color"></i>
									<span>산책</span>
								</div>
								<div>
									<i class="fas fa-chevron-right"></i>
								</div>
							</a>
						</li>
						<li>
							<a href="/user/community/list.do?user_id=${user_id}">
								<div>
									<i class="fas fa-pen-alt color"></i>
									<span>커뮤니티</span>
								</div>
								<div>
									<i class="fas fa-chevron-right"></i>
								</div>
							</a>
						</li>
					</ul>
				</div>
			<!-- Nav -->
		    <nav id="nav" class="nav">
		        <div class="btn-box">
		        	<c:choose>
		        		<c:when test="${check eq true}">
			            	<a href="javascript:void(0)" onclick="$.fnFollow('${user_id}')" id="follow" class="unfollow">언펫팔하기</a>                
		        		</c:when>
		        		<c:otherwise>
		        			<a href="javascript:void(0)" onclick="$.fnFollow('${user_id}')" id="follow" class="follow">펫팔하기</a>                
		        		</c:otherwise>
		        	</c:choose>
		        </div>
		        <div class="btn-box">
		            <a href="" id="chat">채팅하기</a>
		        </div>
		    </nav>
			</div>
	</body>
</html>