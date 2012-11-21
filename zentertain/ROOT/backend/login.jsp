<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page	
	import="org.apache.commons.logging.Log"%><%@page
	import="org.apache.commons.logging.LogFactory"%><%@page
	import="com.common.configuration.*"%><%@page
	import="com.zentertain.user.controller.*"%><%@
	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%	
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	Log log = LogFactory.getLog("/backend/login.jsp");

	try {
		UserController controller = new UserController();
		if("true".equals(request.getParameter("logout"))) {
			UserController.logout(session);
		} 
		if("login".equals(request.getParameter("action"))) {			
			String loginResult = controller.login(request);
			if("SUCCESS".equals(loginResult)) {
				response.sendRedirect("./zentertain/user/user_list.jsp");	
			} else if("ERROR_RAND".equals(loginResult)) {
				request.setAttribute("ERROR_RAND","ERROR_RAND");
			} else if("ERROR_NO_ENTITY".equals(loginResult)) {
				request.setAttribute("ERROR_NO_ENTITY","ERROR_NO_ENTITY");
			}
		}
	} catch(Exception e) {
		log.error(e);
	}
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Administrator login</title>
		<!-- CSS -->
		<link href="_common/css/transdmin.css" rel="stylesheet"
			type="text/css" media="screen" />
		<!--[if IE 6]><link rel="stylesheet" type="text/css" media="screen" href="_common/css/ie6.css" /><![endif]-->
		<!--[if IE 7]><link rel="stylesheet" type="text/css" media="screen" href="_common/css/ie7.css" /><![endif]-->
		
		<!-- JavaScripts-->
		<script type="text/javascript" src="_common/js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="_common/js/jNice.js"></script>
		<c:choose>
			<c:when test="${!empty ERROR_RAND}">
				<script type="text/javascript">
					$(document).ready(function() {
						alert("验证码错误，请重新登陆。");
					});
				</script>
			</c:when>
			<c:when test="${!empty ERROR_NO_USER}">
				<script type="text/javascript">
					$(document).ready(function() {
						alert("用户名密码有误，请重新登陆。");
					});
				</script>
			</c:when>
		</c:choose>
		<style type="text/css">
			.login_i {padding: 50px;background: url(_common/img/login_bg.jpg) 0 50px no-repeat;margin: auto;width: 420px;height: 394px;height: 424px\9;overflow: hidden;}			
			.login_head {padding: 23px 0 50px 30px;font: bold 14px/ 18px arial, simsun;color: #666;}			
			.login_i p {width: 290px;}
			.login_i .login_item {padding: 6px 0 8px 40px; font-family: simsun;}			
			.login_i .login_item2 {padding: 6px 0 8px 88px;font-family: simsun;}			
			.login_i .login_item3 {padding: 75px 0 0 3px;font-family: arial, simsun;color: #999;}
			.login_i .login_item input, .login_i .login_item img { vertical-align: text-bottom;}			
		</style>
	</head>
	<body>
		<div id="wrapper">
			<div class="login_i">
				<p class="login_head">
					APP管理登陆					
				</p>
				<form name="myform" method="post" class="jNice">
					<input type="hidden" name="action" value="login" />
					<p class="login_item">
						用户名：
						<input type="text" name="userName" />
					</p>
					<p class="login_item">
						密&nbsp;&nbsp;码：
						<input type="password" name="password" />
					</p>
					<p class="login_item">
						验证码：
						<input type="text" name="rand" size="6" maxlength="4" />
						<img border="0" src="_common/page/rand.jsp" />
					</p>
					<p class="login_item2">
						<input type="submit" name="submit" value="提交" />
					</p>
					<p class="login_item3">
						Zentertain Application 管理系统
					</p>
				</form>
			</div>
			<!--footer begin-->
			<jsp:include flush="false" page="_common/page/footer.jsp" />
			<!--footer end-->
		</div>
	</body>
</html>



