<%------------------------------------------------------------------------------
 -  Copyright (C) 2009-2012 SM2 BALEARES
 -  This program is free software: you can redistribute it and/or modify
 -  it under the terms of the GNU General Public License as published by
 -  the Free Software Foundation, either version 3 of the License, or
 -  (at your option) any later version.
 -  
 -  This program is distributed in the hope that it will be useful,
 -  but WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 -  See the GNU General Public License for more details.
 -  
 -  You should have received a copy of the GNU General Public License
 -  along with this program. If not, see http://www.gnu.org/licenses/.
 - 
 -  For more information, please contact SM2 BALEARES.
 -  Mail: info@open-ppm.org
 -  Web: http://www.talaia-openppm.es/
 - 
 -  Authors : Javier Hernandez Castillo, Daniel Casas Lopez
------------------------------------------------------------------------------%>
<%@page import="es.sm2.openppm.common.Settings"%>
<%@taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<compress:html
	enabled="<%= Settings.PERFORMANCE_COMPRESS_HTML%>"
	compressJavaScript="false"
	removeComments="true">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://granule.com/tags" prefix="g" %>

<%@page import="es.sm2.openppm.utils.ValidateUtil"%>
<%@page import="es.sm2.openppm.servlets.UtilServlet"%>
<%@page import="es.sm2.openppm.servlets.MyAccountServlet"%>
<%@page import="es.sm2.openppm.servlets.LoginServlet"%>
<%@page import="es.sm2.openppm.servlets.HomeServlet"%>
<%@page import="es.sm2.openppm.model.Employee"%>
<%@page import="es.sm2.openppm.logic.SecurityLogic"%>
<%@page import="es.sm2.openppm.exceptions.LogicException"%>

<%@page import="es.sm2.openppm.model.Contact"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<c:choose>
	<c:when test="${locale ne null and not empty locale  }">
		<fmt:setLocale value="${locale}" scope="request"/>
	</c:when>
	<c:otherwise>
		<fmt:setLocale value="<%=Constants.DEF_LOCALE %>" scope="request"/>
	</c:otherwise>
</c:choose>

<c:set var="status_initiating" scope="request"><%=Constants.STATUS_INITIATING %></c:set>
<c:set var="status_planning" scope="request"><%=Constants.STATUS_PLANNING %></c:set>
<c:set var="status_control" scope="request"><%=Constants.STATUS_CONTROL %></c:set>
<c:set var="status_closed" scope="request"><%=Constants.STATUS_CLOSED %></c:set>

<c:set var="close_classname" scope="request"><%=Settings.PROJECT_CLOSE_CLASSNAME %></c:set>

<c:set var="typeProject" scope="request"><%=Constants.TYPE_PROJECT %></c:set>
<c:set var="typeInvestment" scope="request"><%=Constants.TYPE_INVESTMENT %></c:set>

<c:set var="role_pmo" scope="request"><%=Constants.ROLE_PMO %></c:set>
<c:set var="role_pgm_manager" scope="request"><%=Constants.ROLE_PROGM %></c:set>
<c:set var="role_fun_manager" scope="request"><%=Constants.ROLE_FM %></c:set>
<c:set var="role_inv_manager" scope="request"><%=Constants.ROLE_IM %></c:set>
<c:set var="role_prj_manager" scope="request"><%=Constants.ROLE_PM %></c:set>
<c:set var="role_res_manager" scope="request"><%=Constants.ROLE_RM %></c:set>
<c:set var="role_sponsor" scope="request"><%=Constants.ROLE_SPONSOR %></c:set>
<c:set var="role_resource" scope="request"><%=Constants.ROLE_RESOURCE %></c:set>
<c:set var="role_porf_manager" scope="request"><%=Constants.ROLE_PORFM %></c:set>

<c:set var="pluginRedmine" scope="request"><%=Constants.PLUGIN_REDMINE %></c:set>
<c:set var="pluginMSProject" scope="request"><%=Constants.PLUGIN_MSPROJECT %></c:set>
<c:set var="pluginSheet" scope="request"><%=Constants.PLUGIN_SHEET %></c:set>

<c:if test="${rootActivity ne null }">
	<c:set var="valPlanInitDate" scope="request"><fmt:formatDate value="${rootActivity.planInitDate}" pattern="${datePattern}" /></c:set>
	<c:set var="valPlanEndDate" scope="request"><fmt:formatDate value="${rootActivity.planEndDate}" pattern="${datePattern}" /></c:set>
	<c:set var="valActInitDate" scope="request"><fmt:formatDate value="${rootActivity.actualInitDate}" pattern="${datePattern}" /></c:set>
	<c:set var="valActEndDate" scope="request"><fmt:formatDate value="${rootActivity.actualEndDate}" pattern="${datePattern}" /></c:set>
	<input type="hidden" id="valPlanInitDate" value="${valPlanInitDate }"/>
	<input type="hidden" id="valPlanEndDate" value="${valPlanEndDate }"/>
	<input type="hidden" id="valActInitDate" value="${valActInitDate }"/>
	<input type="hidden" id="valActEndDate" value="${valActEndDate }"/>
</c:if>

<html>
	<head>
		<title><fmt:message key="title_two"/></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<%-- Include All JS and CSS --%>
		<jsp:include page="common/head_includes.jsp" flush="true">
			<jsp:param value="true" name="compresJS"/>
		</jsp:include>
		<%
		Employee user = SecurityLogic.validateLoggedUser(request);
		
			Integer idProfile = -1;
			if (user != null && user.getResourceprofiles() != null) {
				idProfile = user.getResourceprofiles().getIdProfile();
			}	
			
			String formulario = null;
			if (request.getParameter("nextForm") != null) {
				formulario = request.getParameter("nextForm") + ".jsp";
			}
		%>
	</head>
	<body>
		<div id="page-timeout">
			<fmt:message key="session_will_expire_in" /><input type="text" id="session-time-expire" readonly="readonly" style="border:0px" /><fmt:message key="minutes" />
			<a href="#" class="boton" onClick="return enlargeSesion();"><fmt:message key="extend-session" /></a>
		</div>
		<form name="form_change_rol" method="post" action="<%=HomeServlet.REFERENCE%>">
			<input name="accion" type="hidden" value="<%=HomeServlet.SELECT_ROL%>"/>
		</form>
		<div style="width: 1000px; margin: 0 auto; background-image: url('images/fondo_pagina2.gif');" class="left">
			
			<div style="width: 100%; height: 115px; background-image: url('images/cabecera.jpg');">
				<table width="100%" border="0" cellspacing="5" cellpadding="0">
					<tr>
						<td class="login_info left" style="padding-left:13px;">
							<c:if test="${user != null }">
								<a href="javascript:docsAndManualsPopup();"><fmt:message key="docs_and_manuals" /></a>
							</c:if>
						</td>
						<td align="right" width="30%" class="login_info">&nbsp;</td>
					</tr>
					<tr>
						<td class="login_info left" style="padding-left:13px;">
							<c:if test="${user != null }">
			                	<fmt:message key="profile" />: <%=user.getResourceprofiles().getProfileName() %>${user.performingorg eq null?"":" - "}${user.performingorg eq null?"":user.performingorg.name}&nbsp;|&nbsp;<a href="javascript:selectRol();"><fmt:message key="msg.info.switch"/></a>
			                </c:if>
						</td>
						<td align="right" width="30%" class="login_info">
							<c:if test="${user != null }">
								<a href="<%=MyAccountServlet.REFERENCE%>" style="padding-right: 5px;"><fmt:message key="user" />: <%=user.getContact().getFullName() %></a>|
								<a href="login?a=<%=LoginServlet.LOGOFF%>" style="padding-left: 5px;"><fmt:message key="logoff"/></a>
			                </c:if>
			            </td>
					</tr>
				</table>
			</div>
			<%--***********************************  MENU  **********************************--%>
			<c:if test="${user != null }">
				<c:choose>
					<c:when test="<%=Settings.PERFORMANCE_COMPRESS_JS %>">
						<g:compress>
							<jsp:include page="common/menu.jsp" flush="true">
								<jsp:param name="idProfile" value="<%=idProfile %>" />
							</jsp:include>
						</g:compress>
					</c:when>
					<c:otherwise>
						<jsp:include page="common/menu.jsp" flush="true">
							<jsp:param name="idProfile" value="<%=idProfile %>" />
						</jsp:include>
					</c:otherwise>
				</c:choose>
			</c:if>
			<%--*****************************************************************************--%>
			
			<div class="left" style="width: 92%; margin: 0 auto; margin-top:10px;">
				<div class="tit_pagina" style="padding:5px 5px 20px;">${title }</div>
				<c:if test="${user != null }">
					<c:choose>
						<c:when test="<%=Settings.PERFORMANCE_COMPRESS_JS %>">
							<g:compress>
								<jsp:include page="common/messages.jsp" flush="true" />
							</g:compress>
						</c:when>
						<c:otherwise>
							<jsp:include page="common/messages.jsp" flush="true" />
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="<%=!ValidateUtil.isNull(formulario)%>">
					<%--***********************************  CONTENIDO  **********************************--%>
					<c:choose>
						<c:when test="<%=Settings.PERFORMANCE_COMPRESS_JS %>">
							<g:compress>
								<jsp:include page="<%=formulario%>" flush="true" />
							</g:compress>
						</c:when>
						<c:otherwise>
							<jsp:include page="<%=formulario%>" flush="true" />
						</c:otherwise>
					</c:choose>
					<%--**********************************************************************************--%>
				</c:if>
			</div>
			<div>&nbsp;</div>
		</div>
		<c:choose>
			<c:when test="<%=Settings.PERFORMANCE_COMPRESS_JS %>">
				<g:compress>
					<jsp:include page="common/footer.jsp" flush="true" />
					<jsp:include page="common/about_popup.jsp" flush="true" />
					<c:if test="${user != null }">
						<jsp:include page="common/docs_and_manuals_popup.jsp" flush="true" />
					</c:if>
				</g:compress>
			</c:when>
			<c:otherwise>
				<jsp:include page="common/footer.jsp" flush="true" />
				<jsp:include page="common/about_popup.jsp" flush="true" />
				<c:if test="${user != null }">
					<jsp:include page="common/docs_and_manuals_popup.jsp" flush="true" />
				</c:if>
			</c:otherwise>
		</c:choose>
	</body>
</html>
</compress:html>
