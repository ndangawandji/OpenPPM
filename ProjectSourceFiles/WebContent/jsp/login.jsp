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
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="<%=Constants.DEF_LOCALE %>" scope="request"/>
<html>

<fmt:message key="error" var="fmt_error" />

<head>
<title><fmt:message key="title_two"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%-- Include All JS and CSS --%>
<jsp:include page="common/head_includes.jsp" flush="true">
	<jsp:param value="false" name="compresJS"/>
</jsp:include>

<script type="text/javascript">
<!--
var profileSelected = false;

readyMethods.add(function() {
	$("input.boton").button();
	$('#j_username').focus();
});
//-->
</script>
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
				<p>
					<c:choose>
						<c:when test="${error }"><fmt:message key="msg.error_login.message"/></c:when>
						<c:otherwise>${error }</c:otherwise>
					</c:choose>
				</p>
			</div>
			
			<%--***********************************  CONTENIDO  **********************************--%>
			
			<c:if test="${notLogin eq null }">
				<form name="frm_login" id="frm_login" method="post" action="<%=response.encodeURL("j_security_check") %>">
					<fieldset id="login_module" style="width:30%; margin: 0 auto">
						<legend><fmt:message key="login"/></legend>
						<table align="center" width="100%">
							<tr><td>&nbsp;</td></tr>
							<tr>
								<th width="35%" class="left"><fmt:message key="user"/>&nbsp;*</th>
								<td width="65%">
									<input type="text" name="j_username" id="j_username" class="campo" value="" />
								</td>
							</tr>
							<tr>
								<th class="left"><fmt:message key="pass"/>&nbsp;*</th>
								<td>
									<input type="password" name="j_password" id="j_password" class="campo" value="" />
								</td>
							</tr>
							<tr><td>&nbsp;</td></tr>
							<tr>
								<td colspan="2" align="center">
									<input type="submit" class="boton" value="<fmt:message key="login"/>" style="width:auto !important" />
								</td>
							</tr>
						</table>
					</fieldset>
				</form>
			</c:if>
			<%--**********************************************************************************--%>
			
		</div>
		<div style="background-image: url(images/fondo_pagina.gif); margin: 20px auto 0;">
			<jsp:include page="common/footer.jsp" flush="true" />
		</div>
	</div>
	
	<jsp:include page="common/about_popup.jsp" flush="true" />
	
</body>
</html>
</compress:html>
