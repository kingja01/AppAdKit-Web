<%@ page language="java" contentType="text/html; charset=UTF-8"
%><%@page import="org.apache.commons.logging.Log"
%><%@page import="org.apache.commons.logging.LogFactory"
%><%@page import="com.common.configuration.*"
%><%@page import="com.zentertain.app.controller.*"
%><%response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	Log log = LogFactory.getLog("app_controller.jsp");
	
	String action = request.getParameter(ZentertainConfiguration.PARAM_ACTION) == null ? null
			: request.getParameter(ZentertainConfiguration.PARAM_ACTION).trim();
	
	try {
		AppController controller = new AppController();
		if (ZentertainConfiguration.ACTION_INSERT.equals(action)) {
			response.getWriter().append(controller.insert(request).toJSONString());
		} else if (ZentertainConfiguration.ACTION_UPDATE.equals(action)) {			
			response.getWriter().append(controller.update(request).toJSONString());
		} else if (ZentertainConfiguration.ACTION_DELETE.equals(action)) {
			response.getWriter().append(controller.delete(request).toJSONString());
		} else {
			response.getWriter().append("{\"status\":\"false\",\"errorList\":\"" + ZentertainConfiguration.ERROR_UNKNOWN + "\"}");
		}
	} catch(Exception e) {
		log.error(e);
		response.getWriter().append("{\"status\":\"false\",\"errorList\":\"" + ZentertainConfiguration.ERROR_UNKNOWN + "\"}");
	}%>