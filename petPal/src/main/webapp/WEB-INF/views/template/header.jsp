<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/tagLibrary.jsp" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<title>Pet Pal</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />


<link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<noscript><link rel="stylesheet" href="${path}/resources/assets/css/noscript.css" /></noscript>


<%-- JS --%>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js'></script>
<script src="${path}/resources/assets/js/browser.min.js"></script>
<script src="${path}/resources/assets/js/breakpoints.min.js"></script>
<script src="${path}/resources/assets/js/util.js"></script>
<script src="${path}/resources/assets/js/main.js"></script>
	
<%@ include file="/WEB-INF/views/common/function.jsp" %>