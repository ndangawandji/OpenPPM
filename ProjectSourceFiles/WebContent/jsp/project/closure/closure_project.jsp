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
<%@page import="es.sm2.openppm.servlets.ProjectClosureServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="documentStorage"><%=es.sm2.openppm.common.Constants.DOCUMENT_STORAGE%></c:set>

<script type="text/javascript">
<!--
var closureAjax = new AjaxCall('<%=ProjectClosureServlet.REFERENCE%>','<fmt:message key="error" />');

function generateProjectClose() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectClosureServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectClosureServlet.VIEW_CLOSE%>";
	f.submit();
}

function saveClosure() {
	var f = document.forms["frm_project"];	
	
	var params = {
		accion: '<%=ProjectClosureServlet.JX_SAVE_CLOSURE%>', 
		id: f.id.value, // Project ID
		results: f.projectResults.value,
		goal: f.goalAchievement.value,
		lessons: f.lessonsLearned.value
	};
		
	closureAjax.call(params);	
}

//-->
</script>

<jsp:include page="../common/header_project.jsp">
	<jsp:param value="CL" name="actual_page"/>
</jsp:include>

<div class="caja_formulario">
	<form name="frm_project" id="frm_project" method="post" accept-charset="UTF-8">
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="id" id="id" value="${project.idProject}" />
		<input type="hidden" name="status" value="${project.status}" />
		<input type="hidden" id="idDocument" name="idDocument" />
		
		<%-- INFORMATION OF PROJECT --%>
		<jsp:include page="../common/info_project.jsp" flush="true" />
				
		<%-- DOCUMENT REPOSITORY --%>		
		<jsp:include page="closure_document_${documentStorage}.inc.jsp" flush="true"/>
		
		<%-- LESSONS LEARNED--%>
		<div style="">&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldLessonsLearned')"><fmt:message key="closure.lessons_learned"/></legend>
			<div class="buttons">
				<img id="fieldLessonsLearnedBtn" onclick="changeCookie('fieldLessonsLearned', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldLessonsLearned" class="hide" style="padding-top:10px;">
				<table width="100%">
					<tr>
						<th class="left"><fmt:message key="closure.lessons_learned" /></th>						
					</tr>
					<tr>
						<td class="center">
							<textarea name="lessonsLearned" class="campo show_scroll" rows="8" style="width:97%;">${closure.lessonsLearned}</textarea>
						</td>						
					</tr>
				</table>
			</div>
		</fieldset>
		
		<%-- CLOUSURE REPORT --%>
		<div style="">&nbsp;</div>
		<jsp:include page="closure_report.inc.jsp" flush="true"/>
		
	</form>
	
	<div style="">&nbsp;</div>
	
	<fmt:message var="documentationTitle" key="documentation.closure"/>
	<jsp:include page="../common/project_documentation_${documentStorage}.jsp">
		<jsp:param name="documentationType" value="<%=Constants.DOCUMENT_CLOSURE %>"/>
		<jsp:param name="documentationTitle" value="${documentationTitle }"/>
	</jsp:include>
	
	<div style="">&nbsp;</div>
		
	<c:if test="${tl:hasPermission(user,project.status,tab)}">
		<div align="right">
			<a href="javascript:saveClosure();" class="boton"><fmt:message key="save" /></a>
			<a href="javascript:openCloseProject();" class="boton ui-special"><fmt:message key="close_project" /></a>
		</div>
	</c:if>			
	
</div>

<jsp:include page="edit_workingcost_popup.jsp" flush="true"/>
<jsp:include page="edit_documentation_popup.jsp" flush="true"/>
<jsp:include page="close_project_popup.jsp" flush="true" />
