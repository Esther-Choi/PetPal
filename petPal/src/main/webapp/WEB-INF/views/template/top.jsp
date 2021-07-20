<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp" %>


<%
if(session.getAttribute("user_id") == null){
	%>
	<script type="text/javascript">
		location.href = "/user/main.do";
	</script>
	<% 
}%>	