<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="none"
%><%@page import="com.common.configuration.*"
%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@taglib prefix="zentertain" uri="http://com.zentertain/tag"
%><%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	String paramBiKeyWord = request.getParameter("paramBiKeyWord");
	String formBiKeyWord = request.getParameter("biKeyWord");
	
	if(formBiKeyWord != null) {
		request.setAttribute("biKeyWord",formBiKeyWord);
		request.setAttribute("paramBiKeyWord",java.net.URLEncoder.encode(formBiKeyWord, "utf-8"));
	} else if(paramBiKeyWord != null) {
		String biKeyWord = new String(paramBiKeyWord.getBytes("ISO-8859-1"), "utf-8");
		request.setAttribute("biKeyWord",java.net.URLDecoder.decode(biKeyWord, "utf-8"));
		request.setAttribute("paramBiKeyWord",biKeyWord);
	}
%>
<html>
<head>　　 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
　　 <title>APP管理</title>
	<!-- CSS -->
	<link href="./../../_common/css/transdmin.css" rel="stylesheet" type="text/css" media="screen" />		
	<!--[if IE 6]><link rel="stylesheet" type="text/css" media="screen" href="./../../_common/css/ie6.css" /><![endif]-->
	<!--[if IE 7]><link rel="stylesheet" type="text/css" media="screen" href="./../../_common/css/ie7.css" /><![endif]-->
	<script type="text/javascript">var g_path = '<%=request.getContextPath()%>';</script>
	<script type="text/javascript" src="./../../_common/js/jquery-1.7.1.min.js"></script>	
	<!-- JavaScripts-->		
	<script type="text/javascript" src="./../../_common/js/jNice.js"></script>
	<script type="text/javascript" src="./../../_common/js/app_list.js"></script>
</head>
<body>
	<div id="wrapper">
		<!--head begin-->
		<jsp:include flush="true" page="/backend/_common/page/head.jsp">
			<jsp:param name="page" value="nav1" />
		</jsp:include>
		<!--head end-->
        
        <div id="containerHolder">
			<div id="container">
        		<div id="sidebar">
                	<ul class="sideNav">                    	
                    	<li><a href="#" class="active">APP管理</a></li>                    	
                    </ul>
                    <!-- // .sideNav -->
                </div>    
                <!-- // #sidebar -->
                
                <!-- h2 stays for breadcrumbs -->
                <h2><a href="#">APP管理</a> &raquo; <a href="#" class="active">APP列表</a></h2>
                <div id="main">
                	<form id="query" action="" method="post">
							<table class="table_head" cellpadding="0" cellspacing="0">
								<tr>
									<td><h3>APP列表</h3></td>
									<td align="right">
										Bundle Identifier&nbsp;<input type="text" name="biKeyWord" value="<c:out value="${biKeyWord}"/>" style="width:100px;">
		                            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" value="查询" class="button" onclick='javascript:$("#query").submit();'/>
		                			</td>
								</tr>
							</table>																			  				
              		</form>
					
                   	<table id="app_list_table" cellpadding="0" cellspacing="0">
                   		<tr>                   			
                   			<td nowrap="nowrap">APP名称</td>
                   			<td nowrap="nowrap">Bundle Identifier</td>
                   			<td nowrap="nowrap">Apple Id</td>                   			
                   			<td nowrap="nowrap" class="action">操作</td>
                   		</tr>
						<zentertain:AppList pageSize="10" pageLinksCount="10" biKeyWord="${biKeyWord}">
							<c:choose>
								<c:when test="${!empty zentertainAppList}">									
									<c:forEach var="zentertainApp" items="${zentertainAppList}">
										<tr id="<c:out value="${zentertainApp.id}"/>" class="odd">
											<td><c:out value="${zentertainApp.name}"/></td>
											<td><c:out value="${zentertainApp.bundleIdentifier}"/></td>
											<td><c:out value="${zentertainApp.appleId}"/></td>																						
			                                <td class="action">
                                                <a href="#info" onclick="editEntity('<c:out value="${zentertainApp.id}"/>',                                                									
                                                									'<c:out value="${zentertainApp.name}"/>',
                                                									'<c:out value="${zentertainApp.bundleIdentifier}"/>',
                                                									'<c:out value="${zentertainApp.appleId}"/>',
                 	                                                              	'<fmt:formatDate value="${zentertainApp.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>')"
                      	                                                            class="edit">修改</a>
											     <a href="#" onclick="deleteEntity('<c:out value="${zentertainApp.id}"/>','app_controller.jsp')" class="delete">删除</a>
			                                </td>
			                            </tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr><td style='text-align: center' colspan="6">该页没有记录！</td></tr>
								</c:otherwise>
							</c:choose>
						</zentertain:AppList>
					</table>
                    <!-- pagination div -->
					<div class="sabrosus">
						<script type="text/javascript">
							var currentPageNo = get_url_param('page');
							if(!currentPageNo.match(/^\d+$/)) { currentPageNo = 1; }
							var name = '<c:out value="${paramNameKeyWord}"/>';							
							var pageCount = <c:out value="${pageCount}"/>;
							jQuery(document).ready(function(){
								jQuery("#firstPage").attr("href",window.location.pathname + "?page=1&paramBiKeyWord=" + name);
								jQuery("#lastPage").attr("href",window.location.pathname + "?page="+ pageCount +"&paramBiKeyWord=" + name);
								//currentPageNo
								if(currentPageNo == 1)
									jQuery("#firstPageDiv").html("&lt;").attr("class","disabled");
								if(currentPageNo == pageCount)
									jQuery("#lastPageDiv").html("&gt;").attr("class","disabled");
							});
						</script>
						<c:if test="${pageCount > 1}">
							<span id="firstPageDiv"><a id="firstPage" href="javascript:void(0);" target="_self">&lt;</a></span>
							<c:forEach var="links" items="${pageLinks}">
								<c:choose>
									<c:when test="${links.order eq param.page}">
										<span class="current"><c:out value="${links.order}"/></span>
									</c:when>
									<c:when test="${links.order == 1 && empty param.page}">
										<span class="current"><c:out value="${links.order}"/></span>
									</c:when>
									<c:otherwise>
										<a href="${links.href}&paramBiKeyWord=${paramBiKeyWord}" id="page_link_<c:out value="${links.order}" />" target="_self"><c:out value="${links.order}"/></a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<span id="lastPageDiv"><a id="lastPage" href="javascript:void(0);" target="_self">&gt;</a></span>
						</c:if>
					</div>
					<!-- pagination div -->
					<form id="myform" name="myform" action="" class="jNice" method="post">						
						<h3>添加/修改APP</h3><a name="info"></a>
						<input type="hidden" id="action" name="action" value="insert">
						<input type="hidden" id="id" name="id">
                    	<fieldset>
                        	<p><label>APP名称(50字以内):</label><input id="name" type="text"  name="name" class="text-long"/></p>
                        	<p><label>Bundle Identifier(100字以内):</label><input id="bundleIdentifier" type="text"  name="bundleIdentifier" class="text-long"/></p>
                        	<p><label>Apple Id(50字以内):</label><input id="appleId" type="text"  name="appleId" class="text-long"/></p>                        	
                        	<p><span id="createDate">创建日期:</span></p>
                            <input id="saveOrUpdate" type="button" value="提交" class="button" onclick="submitFunction('<%=request.getContextPath()%>/backend/zentertain/app/app_controller.jsp')"/>
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