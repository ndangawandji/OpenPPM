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
<%@page import="es.sm2.openppm.model.Documentproject"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>
<% String type = (String)request.getParameter("documentationType"); %>
<script type="text/javascript">
<!--

var projectAjax = new AjaxCall('<%=ProjectServlet.REFERENCE%>','<fmt:message key="error" />');

function saveDocumentProject<%=type%>() {
	
	projectAjax.call($("#form_document_project_${param.documentationType }").serialize(), function(data) {	
	
		document.forms["form_document_project_${param.documentationType }"].<%= Documentproject.IDDOCUMENTPROJECT%>.value = data.<%= Documentproject.IDDOCUMENTPROJECT%>;
		
		if ($('#res_document_link${param.documentationType }').val() != '') {
			$('#toggleEditLink${param.documentationType }').hide();
			$('#toggleALink${param.documentationType }').show();
		}
		
		$('#a_link${param.documentationType }')
			.text($('#res_document_link${param.documentationType }')
			.val()).attr('href',$('#res_document_link${param.documentationType }').val());
		
		if(<%=type.equals(Constants.DOCUMENT_CLOSURE)%>) {
			toClosureProject();
   		}
	});
}
function modifyLink<%=type%>() {
	$('#toggleALink${param.documentationType }').hide();
	$('#toggleEditLink${param.documentationType }').show();
}
//-->
</script>
<form name="form_document_project_${param.documentationType}" id="form_document_project_${param.documentationType }" action="<%=ProjectServlet.REFERENCE%>" method="post">
	<input type="hidden" name="accion" value="<%=ProjectServlet.JX_SAVE_DOCUMENT%>"/>
	<input type="hidden" name="<%=Documentproject.TYPE%>" value="${param.documentationType }"/>
	<input type="hidden" name="<%=Documentproject.IDDOCUMENTPROJECT%>" id="<%=Documentproject.IDDOCUMENTPROJECT%>" value="${docs.idDocumentProject }"/>
	<input type="hidden" name="<%=Documentproject.PROJECT%>" id="<%=Documentproject.PROJECT%>_${param.documentationType}" value="${project.idProject }"/>

	<fieldset style="margin-top:10px;" class="level_1">
		<c:choose>
			<c:when test="${docs == null or (docs != null and empty docs.link)}">
				<c:set var="linkDocument">style="display:none;"</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="inputDocument">style="display:none;"</c:set>
			</c:otherwise>
		</c:choose>
		<div class="hColor">${param.documentationTitle }</div>
		<div ${inputDocument } id="toggleEditLink${param.documentationType }">
			<c:if test="${tl:hasPermission(user,project.status,tab)}">
				<img style="width:16px;" class="link" src="images/approve.png" onclick="saveDocumentProject<%=type%>()" title="<fmt:message key="documentation.validate"/>"/>
			</c:if>
			<input type="text" name="<%=Documentproject.LINK %>" id="res_document_link${param.documentationType }" style="width: 380px;" maxlength="200" class="campo" value="${docs.link }" />
		</div>
		<div ${linkDocument} id="toggleALink${param.documentationType }">
			<c:if test="${tl:hasPermission(user,project.status,tab)}">
				<img style="width:16px;" class="link" src="images/modify.png" onclick="modifyLink<%=type%>()" title="<fmt:message key="documentation.edit"/>"/>
			</c:if>
			<a href="${tl:escape(docs.link) }" target="_blank" id="a_link${param.documentationType }">${tl:escape(docs.link) }</a>
		</div>
	</fieldset>
</form>
