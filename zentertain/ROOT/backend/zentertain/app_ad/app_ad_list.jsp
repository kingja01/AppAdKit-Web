<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="none"
%><%@page import="java.util.List"
%><%@page import="com.common.configuration.*"
%><%@page import="com.zentertain.app.controller.AppController"
%><%@page import="com.zentertain.app.persistence.App"
%><%@page import="com.zentertain.appAd.controller.AppAdController"
%><%@page import="com.zentertain.appAd.persistence.AppAd"
%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
		
	String bundleIdentifierQuery = request.getParameter("bundleIdentifierQuery");
	AppController controller = new AppController();
	List<App> zentertainAppList = controller.findAllOrderByBundleIdentifier();
	
	
	pageContext.setAttribute("zentertainAppList", zentertainAppList);
	if(bundleIdentifierQuery != null && bundleIdentifierQuery.trim().length() != 0) {
		AppAdController appAdcontroller = new AppAdController();
		List<AppAd> zentertainAppAdList = appAdcontroller.findByBundleIdentifier(bundleIdentifierQuery);
		pageContext.setAttribute("zentertainAppAdList", zentertainAppAdList);
		App selectedApp = controller.findUniqueAppByBundleIdentifier(bundleIdentifierQuery);		
		pageContext.setAttribute("selectedApp", selectedApp);
	}
%>
<html>
<head>　　 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
　　 <title>广告管理</title>
	<!-- CSS -->
	<link href="./../../_common/css/transdmin.css" rel="stylesheet" type="text/css" media="screen" />
	<!--[if IE 6]><link rel="stylesheet" type="text/css" media="screen" href="./../../_common/css/ie6.css" /><![endif]-->
	<!--[if IE 7]><link rel="stylesheet" type="text/css" media="screen" href="./../../_common/css/ie7.css" /><![endif]-->
	<script type="text/javascript">var g_path = '<%=request.getContextPath()%>';</script>
	<script type="text/javascript" src="./../../_common/js/jquery-1.7.1.min.js"></script>	
	<!-- JavaScripts-->		
	<script type="text/javascript" src="./../../_common/js/jNice.js"></script>
	<script type="text/javascript" src="./../../_common/js/app_ad_list.js"></script>	
	<script type="text/javascript">
		var bundleIdentifierQuery = '<c:out value="${selectedApp.bundleIdentifier}"/>'; 		
		$(document).ready(function() {
			if(bundleIdentifierQuery != "") {
				$("#bundleIdentifierQuery option").each(function(){					
					if($(this).val() == bundleIdentifierQuery){
						$(this).attr("selected","selected");
					}
				});
			}
		});				
	</script>
</head>
<body>
	<div id="wrapper">
		<!--head begin-->
		<jsp:include flush="true" page="/backend/_common/page/head.jsp">
			<jsp:param name="page" value="nav2" />
		</jsp:include>
		<!--head end-->
        
        <div id="containerHolder">
			<div id="container">
        		<div id="sidebar">
                	<ul class="sideNav">                    	
                    	<li><a href="#" class="active">广告管理</a></li>                    	
                    </ul>
                    <!-- // .sideNav -->
                </div>    
                <!-- // #sidebar -->
                
                <!-- h2 stays for breadcrumbs -->
                <h2><a href="#">广告管理</a> &raquo; <a href="#" class="active">广告列表</a></h2>
                <div id="main">
                	<form id="query" action="" method="post">
							<table class="table_head" cellpadding="0" cellspacing="0">
								<tr>
									<td><h3>广告列表</h3></td>
									<td align="right">
		                				<font color="red">*请先选择APP，再进行广告操作&nbsp;</font>
		                				<select id="bundleIdentifierQuery" name="bundleIdentifierQuery" style="width:200px;" onchange="javascript:$('#query').submit();">
		                        			<option value="">请选择</option>
		                        			<c:if test="${!empty zentertainAppList}">									
												<c:forEach var="zentertainApp" items="${zentertainAppList}">
													<option value="<c:out value="${zentertainApp.bundleIdentifier}"/>"><c:out value="${zentertainApp.bundleIdentifier}"/></option>								                            
												</c:forEach>
											</c:if>
		                            	</select>		                            	
		                			</td>
								</tr>
							</table>
              		</form>
					
                   	<table id="app_ad_list_table" cellpadding="0" cellspacing="0">
                   		<tr>
                   			<td nowrap="nowrap">App Name</td>
                   			<td nowrap="nowrap">Apple Id</td>
                   			<td nowrap="nowrap">Device Type</td>
                   			<td nowrap="nowrap">Show Type</td>
                   			<td nowrap="nowrap" class="action">操作</td>
                   		</tr>
						
						<c:choose>
							<c:when test="${!empty zentertainAppAdList}">									
								<c:forEach var="zentertainAppAd" items="${zentertainAppAdList}">
									<tr id="<c:out value="${zentertainAppAd.id}"/>" class="odd">
										<td><c:out value="${zentertainAppAd.appName}"/></td>
										<td><c:out value="${zentertainAppAd.appleId}"/></td>
										<td>
											<c:choose>
												<c:when test="${zentertainAppAd.deviceType == '0'}">UIUserInterfaceIdiomPhone</c:when>
												<c:when test="${zentertainAppAd.deviceType == '1'}">UIUserInterfaceIdiomPad</c:when>
												<c:otherwise>Universal</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${zentertainAppAd.showType == 'UIAlertView'}">Show alert view first.</c:when>
												<c:when test="${zentertainAppAd.showType == 'UIWebView'}">Show web view directly.</c:when>
											</c:choose>
										</td>
		                                <td class="action">		                                
											<a href="#info" onclick="editEntity('<c:out value="${zentertainAppAd.id}"/>',
                                               									'<c:out value="${zentertainAppAd.alertId}"/>',
                                               									'<c:out value="${zentertainAppAd.appleId}"/>',
                                               									'<c:out value="${zentertainAppAd.appName}"/>',
                                               									'<c:out value="${zentertainAppAd.appAlertTitle}"/>',
                                               									'<c:out value="${zentertainAppAd.appAlertDescription}"/>',
                                               									'<c:out value="${zentertainAppAd.appAlertButtonText}"/>',
                                               									'<c:out value="${zentertainAppAd.deviceType}"/>',
                                               									'<c:out value="${zentertainAppAd.showType}"/>',
                                               									'<c:out value="${zentertainAppAd.actionType}"/>',
                                               									'<c:out value="${zentertainAppAd.actionInfo1}"/>',
                                               									'<c:out value="${zentertainAppAd.messageTitle}"/>',
                                               									'<c:out value="${zentertainAppAd.messageBody}"/>',
                                               									'<c:out value="${zentertainAppAd.buttonYesText}"/>',
                                               									'<c:out value="${zentertainAppAd.buttonNoText}"/>',
                                               									'<c:out value="${zentertainAppAd.showAgain}"/>',
                                               									'<c:out value="${zentertainAppAd.forcePush}"/>',
                	                                                            '<fmt:formatDate value="${zentertainAppAd.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>',
                	                                                            '<fmt:formatDate value="${zentertainAppAd.modifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>')"
                     	                                                        class="edit">修改</a>
                     	                    <a href="#" onclick="resetAlertId('<c:out value="${zentertainAppAd.id}"/>','app_ad_controller.jsp')" class="delete">重置</a>
										    <a href="#" onclick="deleteEntity('<c:out value="${zentertainAppAd.id}"/>','app_ad_controller.jsp')" class="delete">删除</a>
		                                </td>
		                            </tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr><td style='text-align: center' colspan="5">该页没有记录！</td></tr>
							</c:otherwise>
						</c:choose>						
					</table>

					<form id="myform" name="myform" action="" class="jNice" method="post">
						<h3>添加/修改此APP的广告</h3><a name="info"></a>
						<input type="hidden" id="action" name="action" value="insert">
						<input type="hidden" id="id" name="id">
						<input type="hidden" id="bundleIdentifier" name="bundleIdentifier" value="<c:out value="${selectedApp.bundleIdentifier}"/>">
                    	<fieldset>
                        	<p>BundleIdentifier:&nbsp;&nbsp;<c:out value="${selectedApp.bundleIdentifier}"/></p>
                        	<p><span id="alertId">Alert Id:</span></p>
                        	<p><label>Apple Id:</label><input id="appleId" type="text"  name="appleId" class="text-long"/></p>
                        	<p><label>App Name:</label><input id="appName" type="text"  name="appName" class="text-long"/></p>                        	
                        	<p><label>App Alert Title:</label><input id="appAlertTitle" type="text"  name="appAlertTitle" class="text-long"/></p>
                            <p><label>App Alert Description:</label><input id="appAlertDescription" type="text"  name="appAlertDescription" class="text-long"/></p>
                            <p><label>App Alert Button Text:</label><input id="appAlertButtonText" type="text"  name="appAlertButtonText" class="text-long"/></p>
                        	<p><label>Device Type:</label>
                        		<select id="deviceType" name="deviceType" style="width:265px;">
                        			<option value="">请选择</option>
                        			<option value="0">UIUserInterfaceIdiomPhone</option>
	                            	<option value="1">UIUserInterfaceIdiomPad</option>
	                            	<option value="9">Universal</option>
                            	</select>
                            </p>
                            <p><label>Show Type:</label>
                        		<select id="showType" name="showType" style="width:265px;">
                        			<option value="">请选择</option>
                        			<option value="UIAlertView">Show alert view first.</option>
	                            	<option value="UIWebView">Show web view directly.</option>	                            	
                            	</select>
                            </p>
                            <p><label>Force Push:</label>
                        		<select id="forcePush" name="forcePush" style="width:265px;">
                        			<option value="">请选择</option>
                        			<option value="1">Yes</option>
	                            	<option value="0">No</option>	                            	
                            	</select>
                            </p>
                            <p><label>Show Again:</label>
                        		<select id="showAgain" name="showAgain" style="width:265px;">
                        			<option value="">请选择</option>
                        			<option value="1">Yes</option>
	                            	<option value="0">No</option>	                            	
                            	</select>
                            </p>
                            <p><label>Action Type:</label>
                        		<select id="actionType" name="actionType" style="width:265px;">
                        			<option value="">请选择</option>
                        			<option value="open-url">open-url</option>	                            	
                            	</select>
                            </p>
                            <p><label>Action-info-1(URL):</label><input id="actionInfo1" type="text"  name="actionInfo1" class="text-long"/></p>
                            <p><label>Message Title:</label><input id="messageTitle" type="text"  name="messageTitle" class="text-long"/></p>
                            <p><label>Message Body:</label><input id="messageBody" type="text"  name="messageBody" class="text-long"/></p>
                            <p><label>Button Yes Text:</label><input id="buttonYesText" type="text"  name="buttonYesText" class="text-long"/></p>
                            <p><label>Button No Text:</label><input id="buttonNoText" type="text"  name="buttonNoText" class="text-long"/></p>

                        	<p><span id="createDate"></span></p>
                        	<p><span id="modifyDate"></span></p>
                            <input id="saveOrUpdate" type="button" value="提交" class="button" onclick="submitFunction('<%=request.getContextPath()%>/backend/zentertain/app_ad/app_ad_controller.jsp')"/>
                        </fieldset>
                    </form>
                </div>
                <!-- // #main -->
                <div class="clear"></div>
            </div>
            <!-- // #container -->
        </div>
        <!-- // #containerHolder -->
        
        <!--footer begin-->
		<jsp:include flush="false" page="/backend/_common/page/footer.jsp" />
		<!--footer end-->
    </div>
    <!-- // #wrapper -->
    <iframe id="iframe_window" name="iframe_window" src="about:blank" scrolling="no" width="1" height="1" frameborder="0" style="display:none;"></iframe>
</body>
</html>