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
	enabled="<%= es.sm2.openppm.common.Settings.PERFORMANCE_COMPRESS_HTML%>"
	compressJavaScript="false"
	removeComments="true"><%@page import="es.sm2.openppm.servlets.LoginServlet"%>
<%@page import="es.sm2.openppm.servlets.HomeServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://granule.com/tags" prefix="g" %>

<html>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:message key="error" var="fmt_error" />

<head>
<title><fmt:message key="title_two"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%-- Include All JS and CSS --%>
<jsp:include page="common/head_includes.jsp" flush="true">
	<jsp:param value="true" name="compresJS"/>
</jsp:include>

<c:choose>
	<c:when test="<%=Settings.PERFORMANCE_COMPRESS_JS %>">
		<g:compress>
			<script type="text/javascript">
			<!--
			readyMethods.add(function() {
				$("input.boton").button();
				$('#listPerfOrgs').filterSelect({'selectFilter':'listProfiles'});
			});
			//-->
			</script>
		</g:compress>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
		<!--
		readyMethods.add(function() {
			$("input.boton").button();
			$('#listPerfOrgs').filterSelect({'selectFilter':'listProfiles'});
		});
		//-->
		</script>
	</c:otherwise>
</c:choose>
</head>
<body>

	<div style="width: 1000px; height: 100%; background-image: url(images/fondo_pagina2.gif);  margin: auto;">
		<div style="height: 115px; width: 100%; background-image: url(images/cabecera.jpg);"></div>
		
		<div id="contenido" style="width: 92%; margin: 30px auto 0;">
			<c:if test="${error != null }">
				<c:set var="showError">style="display:block !important;"</c:set>
			</c:if>
			<div id="login-error" class="ui-state-error ui-corner-all leftPadding hide" ${showError }>
				<h4><fmt:message key="msg.error_login.title"/></h4>
				<p><fmt:message key="msg.error_login.message"/></p>
			</div>
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
			
			<%--***********************************  CONTENIDO  **********************************--%>
			
			<form name="frm_login" id="frm_login" method="post" action="<%=HomeServlet.REFERENCE%>">
				<input type="hidden" name="accion" value="<%=HomeServlet.CHOOSE_ROL%>">
				<fieldset id="choose_rol" style="width:50%; margin: 0 auto;">
					<legend><fmt:message key="msg.info.choose_profile"/></legend>
					<table align="center" width="100%">
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<th style="text-align: left;" width="50%"><fmt:message key="perf_organization"/></th>
							<th style="text-align: left;" width="50%"><fmt:message key="profile"/></th>
						</tr>
						<tr>
							<td>
								<select class="campo" style="width: 95%;" id="listPerfOrgs">
									<c:set var="isInAll">false</c:set>
									<c:forEach var="emp" items="${employees }">
										<c:if test="${emp.performingorg eq null and not isInAll}">
											<c:set var="isInAll">true</c:set>
											<option value="rolPorfolio"><fmt:message key="perf_organization.all"/></option>
										</c:if>
									</c:forEach>
									<c:forEach var="org" items="${organizactions }">
										<option value="${org.idPerfOrg }">${org.name }</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select class="campo" style="width: 90%;" name="idEmployee" id="listProfiles">
									<c:forEach var="emp" items="${employees }">
										<option class="${emp.performingorg eq null?"rolPorfolio":emp.performingorg.idPerfOrg }" value="${emp.idEmployee }">${emp.resourceprofiles.profileName }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td colspan="2" align="center">
								<input type="submit" class="boton" style="width:auto !important" value="<fmt:message key="accept"/>"/>
								<a href="login?a=<%=LoginServlet.LOGOFF%>" class="boton"><fmt:message key="logoff"/></a>
							</td>
						</tr>
					</table>
				</fieldset>
			</form>
			
			<%--**********************************************************************************--%>
			
		</div>
		<div style="background-image: url(images/fondo_pagina.gif); margin: 20px auto 0;">
			<c:choose>
				<c:when test="<%=Settings.PERFORMANCE_COMPRESS_JS %>">
					<g:compress>
						<jsp:include page="common/footer.jsp" flush="true" />
					</g:compress>
				</c:when>
				<c:otherwise>
					<jsp:include page="common/footer.jsp" flush="true" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<c:choose>
		<c:when test="<%=Settings.PERFORMANCE_COMPRESS_JS %>">
			<g:compress>
				<jsp:include page="common/about_popup.jsp" flush="true" />
			</g:compress>
		</c:when>
		<c:otherwise>
			<jsp:include page="common/about_popup.jsp" flush="true" />
		</c:otherwise>
	</c:choose>
</body>
</html>
</compress:html>
