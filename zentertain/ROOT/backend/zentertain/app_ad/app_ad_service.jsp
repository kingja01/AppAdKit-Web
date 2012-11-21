<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"
%><%@page import="java.util.Map"
%><%@page import="java.util.HashMap"
%><%@page import="java.util.List"
%><%@page import="java.util.ArrayList"
%><%@page import="java.text.DateFormat"
%><%@page import="java.text.SimpleDateFormat"
%><%@page import="org.apache.commons.logging.Log"
%><%@page import="org.apache.commons.logging.LogFactory"
%><%@page import="com.fasterxml.jackson.core.JsonGenerator"
%><%@page import="com.fasterxml.jackson.core.JsonEncoding"
%><%@page import="com.fasterxml.jackson.databind.ObjectMapper"
%><%@page import="com.common.configuration.*"
%><%@page import="com.zentertain.appAd.controller.*"
%><%@page import="com.zentertain.appAd.persistence.*"
%><%!
	//application/json
	public static final String FORMAT_DATE = "yyyy-MM-dd HH:mm:ss";
%><%response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	Log log = LogFactory.getLog("app_ad_service.jsp");
	
	String bundleIdentifier = request.getParameter(AppAdController.PARAM_BUNDLE_IDENTIFIER) == null ? null
			: request.getParameter(AppAdController.PARAM_BUNDLE_IDENTIFIER).trim();	
	AppAdController controller = new AppAdController();					
	ObjectMapper objectMapper = new ObjectMapper();
	objectMapper.setDateFormat(new SimpleDateFormat(FORMAT_DATE));
		
	response.getWriter().append(objectMapper.writeValueAsString(controller.generateClientJsonByBundleIdentifier(bundleIdentifier)));
%>