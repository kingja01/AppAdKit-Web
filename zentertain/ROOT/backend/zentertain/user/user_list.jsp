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
	
	String paramNameKeyWord = request.getParameter("paramNameKeyWord");
	String formNameKeyWord = request.getParameter("nameKeyWord");
	
	if(formNameKeyWord != null) {
		request.setAttribute("nameKeyWord",formNameKeyWord);
		request.setAttribute("paramNameKeyWord",java.net.URLEncoder.encode(formNameKeyWord, "utf-8"));
	} else if(paramNameKeyWord != null) {
		String nameKeyWord = new String(paramNameKeyWord.getBytes("ISO-8859-1"), "utf-8");
		request.setAttribute("nameKeyWord",java.net.URLDecoder.decode(nameKeyWord, "utf-8"));
		request.setAttribute("paramNameKeyWord",nameKeyWord);
	}
%>
<html>
<head>　　 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
　　 <title>用户管理</title>
	<!-- CSS -->
	<link href="./../../_common/css/transdmin.css" rel="stylesheet" type="text/css" media="screen" />
	<!--[if IE 6]><link rel="stylesheet" type="text/css" media="screen" href="./../../_common/css/ie6.css" /><![endif]-->
	<!--[if IE 7]><link rel="stylesheet" type="text/css" media="screen" href="./../../_common/css/ie7.css" /><![endif]-->
	<script type="text/javascript">var g_path = '<%=request.getContextPath()%>';</script>
	<script type="text/javascript" src="./../../_common/js/jquery-1.7.1.min.js"></script>
	<!-- JavaScripts-->
	<script type="text/javascript" src="./../../_common/js/jNice.js"></script>
	<script type="text/javascript" src="./../../_common/js/user_list.js"></script>
</head>
<body>
	<div id="wrapper">
		<!--head begin-->
		<jsp:include flush="true" page="/backend/_common/page/head.jsp">
			<jsp:param name="page" value="nav0" />
		</jsp:include>
		<!--head end-->
        
        <div id="containerHolder">
			<div id="container">
        		<div id="sidebar">
                	<ul class="sideNav">                    	
                    	<li><a href="#" class="active">用户管理</a></li>                    	
                    </ul>
                    <!-- // .sideNav -->
                </div>    
                <!-- // #sidebar -->
                
                <!-- h2 stays for breadcrumbs -->
                <h2><a href="#">用户管理</a> &raquo; <a href="#" class="active">用户列表</a></h2>
                <div id="main">
                	<form id="query" action="" method="post">
							<table class="table_head" cellpadding="0" cellspacing="0">
								<tr>
									<td><h3>用户列表</h3></td>
									<td align="right">
										用户名/姓名&nbsp;<input type="text" id="nameKeyWord" name="nameKeyWord" value="<c:out value="${nameKeyWord}"/>" style="width:100px;">
		                            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" value="查询" class="button" onclick='javascript:$("#query").submit();'/>																	
		                			</td>
								</tr>
							</table>																			  				
              		</form>
					
                   	<table id="user_list_table" cellpadding="0" cellspacing="0">
                   		<tr>
                   			<td nowrap="nowrap">用户名</td>
                   			<td nowrap="nowrap">姓名</td>
                   			<td nowrap="nowrap">类型</td>
                   			<td nowrap="nowrap">创建日期</td>                   			
                   			<td nowrap="nowrap" class="action">操作</td>
                   		</tr>
						<zentertain:UserList pageSize="10" pageLinksCount="10" nameKeyWord="${nameKeyWord}">
							<c:choose>
								<c:when test="${!empty zentertainUserList}">									
									<c:forEach var="zentertainUser" items="${zentertainUserList}">										
										<tr id="<c:out value="${zentertainUser.id}"/>" class="odd">
											<td><c:out value="${zentertainUser.userName}"/></td>
											<td><c:out value="${zentertainUser.name}"/></td>
											<td>
												<c:choose>	
													<c:when test="${zentertainUser.type == '1'}">
														管理员
													</c:when>
													<c:otherwise>
														普通用户
													</c:otherwise>										
												</c:choose>												
											</td>
											<td><fmt:formatDate value="${zentertainUser.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/><br></td>											
			                                <td class="action">
			                                	<c:if test="${loginUser.type == '1'}">
				                                	<a href="#info" onclick="editEntity('<c:out value="${zentertainUser.id}"/>',                                                									
	                                                									'<c:out value="${zentertainUser.userName}"/>',
	                                                									'<c:out value="${zentertainUser.name}"/>',
	                                                									'<c:out value="${zentertainUser.type}"/>',
	                 	                                                              	'<fmt:formatDate value="${zentertainUser.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>')"
	                      	                                                            class="edit">修改</a>
												     <a href="#" onclick="deleteEntity('<c:out value="${zentertainUser.id}"/>','user_controller.jsp')" class="delete">删除</a>
			                                	</c:if>                                                
			                                </td>
			                            </tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr><td style='text-align: center' colspan="5">该页没有记录！</td></tr>
								</c:otherwise>
							</c:choose>
						</zentertain:UserList>
					</table>
                    <!-- pagination div -->
					<div class="sabrosus">
						<script type="text/javascript">
							var currentPageNo = get_url_param('page');
							if(!currentPageNo.match(/^\d+$/)) { currentPageNo = 1; }
							var name = '<c:out value="${paramNameKeyWord}"/>';							
							var pageCount = <c:out value="${pageCount}"/>;
							jQuery(document).ready(function(){
								jQuery("#firstPage").attr("href",window.location.pathname + "?page=1&paramNameKeyWord=" + name);
								jQuery("#lastPage").attr("href",window.location.pathname + "?page="+ pageCount +"&paramNameKeyWord=" + name);
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
										<a href="${links.href}&paramNameKeyWord=${paramNameKeyWord}" id="page_link_<c:out value="${links.order}" />" target="_self"><c:out value="${links.order}"/></a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<span id="lastPageDiv"><a id="lastPage" href="javascript:void(0);" target="_self">&gt;</a></span>
						</c:if>
					</div>
					<!-- pagination div -->
					<form id="myform" name="myform" action="" class="jNice" method="post">						
						<h3>添加/修改用户</h3><a name="info"></a>
						<input type="hidden" id="action" name="action" value="insert">
						<input type="hidden" id="id" name="id">
                    	<fieldset>
                        	<p><label>用户名(50字以内):</label><input id="userName" type="text"  name="userName" class="text-long"/></p>
                        	<p><label>密码(50字以内):</label><input id="password" type="text"  name="password" class="text-long"/></p>
                        	<p><label>姓名(50字以内):</label><input id="name" type="text"  name="name" class="text-long"/></p>
                        	<p><span id="type"></span></p>
                        	<p><span id="createDate"></span></p>
                            <input id="saveOrUpdate" type="button" value="提交" class="button" onclick="submitFunction('<%=request.getContextPath()%>/backend/zentertain/user/user_controller.jsp')"/>
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