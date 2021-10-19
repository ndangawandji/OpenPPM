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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>
<%@page import="es.sm2.openppm.servlets.UtilServlet"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<c:choose>
	<c:when test="${locale == null}">
		<c:set var="tempLocale" value="<%=Constants.DEF_LOCALE %>"/>
	</c:when>
	<c:otherwise>
		<c:set var="tempLocale" value="${locale }"/>
	</c:otherwise>
</c:choose>

<fmt:setLocale value="${tempLocale}" scope="request"/>

<script type="text/javascript">
<!--
function docsAndManualsPopup() {
	$('#docs-and-manuals-popup').dialog('open');
}

function descargar(docId) { 
	var f = document.frm_archivo;
	f.action = "<%=UtilServlet.REFERENCE%>";
	f.accion.value = "<%=UtilServlet.SHOW_DOCUMENTATION%>";
	f.docId.value = docId;
	f.submit();
}

readyMethods.add(function() {
	$('div#docs-and-manuals-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 300, 
		minWidth: 300, 
		resizable: false
	});
	
	$('div#docs-and-manuals-popup').dialog('option', 'title', '<fmt:message key="docs_and_manuals" />');
});
//-->
</script>

<form id="frm_archivo" name="frm_archivo" method="post">	
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="docId" value="" />	
</form>

<div id="docs-and-manuals-popup" class="popup">
	
	<ul>
		<li class="texLink"><a class="texLink" href="./docs/OpenPPM_Help_Intro.pdf" target="_blank">Introduction to OpenPPM</a></li>
		
		<c:forEach var="doc" items="${documentationList}">
			<li class="texLink"><a class="texLink" style="cursor: pointer;" onclick="descargar(${doc.idDocumentation})">${doc.namePopup}</a></li>
		</c:forEach>		
	</ul>
</div>
