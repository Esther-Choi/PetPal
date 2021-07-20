<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp" %>

<script type="text/javascript">

	/*
	맨 위로 이동
	*/
	$.fnGoTop = function(id) {
		$("#"+id).scrollTop(0);
	}
	
	/*
	뒤로가기
	*/
	$.fnBack = function() {
		window.history.back();
	}

</script>