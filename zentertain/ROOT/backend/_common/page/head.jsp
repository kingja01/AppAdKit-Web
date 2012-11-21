<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%>
<script type="text/javascript">
	$(document).ready(function() {
		var highLightNav = '<c:out value="${param.page}"/>';
		$("#" + highLightNav).addClass("active");
	});
</script>
<!-- h1 tag stays for the logo, you can use the a tag for linking the index page -->
<h1><a href="#"><span></span></a></h1>
   
<!-- You can name the links with lowercase, they will be transformed to uppercase by CSS, we prefered to name them with uppercase to have the same effect with disabled stylesheet -->
<ul id="mainNav">
	<li><a id="nav0" href="./../../zentertain/user/user_list.jsp">用户管理</a></li>
	<li><a id="nav1" href="./../../zentertain/app/app_list.jsp">APP管理</a></li>
	<li><a id="nav2" href="./../../zentertain/app_ad/app_ad_list.jsp">广告管理</a></li>
	<li class="logout"><a href="./../../login.jsp?logout=true">登出</a></li>
</ul>
<!-- // #end mainNav -->