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
<%@page import="es.sm2.openppm.servlets.UtilServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectClosureServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectProcurementServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectInitServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectRiskServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet"%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>

<fmt:setLocale value="${locale}" scope="request"/>

<%
	String actual_page = request.getParameter("actual_page"); 
// Puede acceder a las paginas?
Project project = (Project) request.getAttribute("project");
boolean I = (project != null && (project.getStatus() == Constants.STATUS_INITIATING));
boolean P = (project != null && (project.getStatus() == Constants.STATUS_INITIATING || project.getStatus() == Constants.STATUS_PLANNING || project.getStatus() == Constants.STATUS_CONTROL || project.getStatus() == Constants.STATUS_CLOSED));
boolean C = (project != null && (project.getStatus() == Constants.STATUS_CONTROL || project.getStatus() == Constants.STATUS_CLOSED));
%>

<script type="text/javascript">
<!--

var projectAjax = new AjaxCall('<%=ProjectServlet.REFERENCE%>','<fmt:message key="error"/>');

function toInitiatingProject() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectInitServlet.REFERENCE%>";
	f.accion.value = "";
	loadingPopup();
	f.submit();

	return false;
}

function toRiskManagementProject() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectRiskServlet.REFERENCE%>";
	f.accion.value = "";
	loadingPopup();
	f.submit();

	return false;
}

function toPlanning1Project() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectPlanServlet.REFERENCE%>";
	f.accion.value = "";
	loadingPopup();
	f.submit();

	return false;
}

function toControlProject() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectControlServlet.REFERENCE%>";
	f.accion.value = "";
	loadingPopup();
	f.submit();

	return false;
}

function toClosureProject() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectClosureServlet.REFERENCE%>";
	f.accion.value = "";
	loadingPopup();
	f.submit();

	return false;
}

function toProcurementProject() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectProcurementServlet.REFERENCE%>";
	f.accion.value = "";
	loadingPopup();
	f.submit();

	return false;
}

function toTracking() {
	var f = document.forms["frm_project"];
	f.action = "tracking";
	f.accion.value = "";
	loadingPopup();
	f.submit();

	return false;
}
//-->
</script>

<c:if test="${project.status eq status_closed}">
	<div id="msg_project_closed" style="margin-bottom: 10px; padding: 0pt 0.7em;" class="ui-state-highlight ui-corner-all"> 
		<p>
			<span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-info"></span>
			<strong><fmt:message key="msg.info"/>: </strong>
		</p>
		<p>
			<fmt:message key="msg.project_closed_info" />&nbsp;
			<c:if test="<%=SecurityUtil.hasPermission(request, UtilServlet.JX_CHANGE_CLOSED_TO_CONTROL) %>">
				<fmt:message key="msg.info.change_something"/>,&nbsp;
				<a class="boton" href="javascript:changeState();"><fmt:message key="msg.info.click_here"/></a>
			</c:if>
		</p>
	</div>
	<c:if test="<%=SecurityUtil.hasPermission(request, UtilServlet.JX_CHANGE_CLOSED_TO_CONTROL) %>">
		<script>
		function changeState() {
			
			var params = {
				accion:'<%=UtilServlet.JX_CHANGE_CLOSED_TO_CONTROL%>',
				idProject:'${project.idProject}'
			};
			utilAjax.call(params,function(data){
				loadingPopup();
				var f = document.frm_project;
				f.action = "";
				f.accion.value = "";
				f.submit();
			});
		}
		</script>
	</c:if>
</c:if>

<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<%if ("I".equals(actual_page)) { %>
			<c:set var="tab" scope="request"><%=Constants.TAB_INITIATION %></c:set>
		    <td width="6">&nbsp;</td>
	    	<td width="6" class="left_menu_sel"></td>
		    <td class="tituloPestana1" class="left"><a href="#" onclick="return toInitiatingProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="initiation" />&nbsp;&nbsp;</a></td>
		    <td width="6" class="right_menu_sel"></td>
		    <td width="6">&nbsp;</td>
        <%} else { %>
	        <td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana"><a href="#" onclick="return toInitiatingProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="initiation" />&nbsp;&nbsp;</a></td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} %>
        
        <%if ("P1".equals(actual_page)) { %>
        	<c:set var="tab" scope="request"><%=Constants.TAB_PLAN %></c:set>
	        <td width="6">&nbsp;</td>
	    	<td width="6" class="left_menu_sel"></td>
		    <td class="tituloPestana1" class="left"><a href="#" onclick="return toPlanning1Project();" class="texLink">&nbsp;&nbsp;<fmt:message key="plan" />&nbsp;&nbsp;</a></td>
		    <td width="6" class="right_menu_sel"></td>
		    <td width="6">&nbsp;</td>
		<%} else if (!P) { %>
			<td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana">&nbsp;&nbsp;<span class="texLinkDisabled"><fmt:message key="plan" /></span>&nbsp;&nbsp;</td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
	    <%} else { %>
	        <td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana"><a href="#" onclick="return toPlanning1Project();" class="texLink">&nbsp;&nbsp;<fmt:message key="plan" />&nbsp;&nbsp;</a></td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} %>
        
        <%if ("R".equals(actual_page)) { %>
        	<c:set var="tab" scope="request"><%=Constants.TAB_RISK %></c:set>
		    <td width="6">&nbsp;</td>
	    	<td width="6" class="left_menu_sel"></td>
		    <td class="tituloPestana1" class="left"><a href="#" onclick="return toRiskManagementProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="risk" />&nbsp;&nbsp;</a></td>
		    <td width="6" class="right_menu_sel"></td>
		    <td width="6">&nbsp;</td>
        <%} else { %>
	        <td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana"><a href="#" onclick="return toRiskManagementProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="risk" />&nbsp;&nbsp;</a></td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} %>
        
        <%if ("C".equals(actual_page)) { %>
        	<c:set var="tab" scope="request"><%=Constants.TAB_CONTROL %></c:set>
	    	<td width="6">&nbsp;</td>
	    	<td width="6" class="left_menu_sel"></td>
		    <td class="tituloPestana1" class="left"><a href="#" onclick="return toControlProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="project_status.control" />&nbsp;&nbsp;</a></td>
		    <td width="6" class="right_menu_sel"></td>
		    <td width="6">&nbsp;</td>
		<%} else if (!C) { %>
			<td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana">&nbsp;&nbsp;<span class="texLinkDisabled"><fmt:message key="project_status.control" /></span>&nbsp;&nbsp;</td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} else { %>
	        <td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana"><a href="#" onclick="return toControlProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="project_status.control" />&nbsp;&nbsp;</a></td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} %>
        
        <%if ("PR".equals(actual_page)) { %>
        	<c:set var="tab" scope="request"><%=Constants.TAB_PROCURAMENT %></c:set>
	    	<td width="6">&nbsp;</td>
	    	<td width="6" class="left_menu_sel"></td>
		    <td class="tituloPestana1" class="left"><a href="#" onclick="return toProcurementProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="project_status.procurement" />&nbsp;&nbsp;</a></td>
		    <td width="6" class="right_menu_sel"></td>
		    <td width="6">&nbsp;</td>	
		<%} else if (I) { %>
			<td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana">&nbsp;&nbsp;<span class="texLinkDisabled"><fmt:message key="project_status.procurement" /></span>&nbsp;&nbsp;</td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} else { %>
	        <td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana"><a href="#" onclick="return toProcurementProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="project_status.procurement" />&nbsp;&nbsp;</a></td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} %>
        
        <%if ("CL".equals(actual_page)) { %>
        	<c:set var="tab" scope="request"><%=Constants.TAB_CLOSURE %></c:set>
	    	<td width="6">&nbsp;</td>
	    	<td width="6" class="left_menu_sel"></td>
		    <td class="tituloPestana1" class="left"><a href="#" onclick="return toClosureProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="closure" />&nbsp;&nbsp;</a></td>
		    <td width="6" class="right_menu_sel"></td>
		    <td width="6">&nbsp;</td>
		<%} else if (!C) { %>
			<td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana">&nbsp;&nbsp;<span class="texLinkDisabled"><fmt:message key="closure" /></span>&nbsp;&nbsp;</td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} else { %>
	        <td width="6">&nbsp;</td>
	        <td width="6" class="left_menu"></td>
	        <td class="tituloPestana"><a href="#" onclick="return toClosureProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="closure" />&nbsp;&nbsp;</a></td>
	        <td width="6" class="right_menu"></td>
	        <td width="6">&nbsp;</td>
        <%} %>
        <!-- 
        <%if (!SecurityUtil.isUserInRole(request, Constants.ROLE_PMO)) { %>
	        <%if ("C3".equals(actual_page)) { %>
		    	<td width="6">&nbsp;</td>
		    	<td width="6" class="left_menu_sel"></td>
			    <td class="tituloPestana1" class="left"><a href="#" onclick="return toTracking();" class="texLink">&nbsp;&nbsp;<fmt:message key="tracking" />&nbsp;&nbsp;</a></td>
			    <td width="6" class="right_menu_sel"></td>
			    <td width="6">&nbsp;</td>
			<%} else if (!C) { %>
				<td width="6">&nbsp;</td>
		        <td width="6" class="left_menu"></td>
		        <td class="tituloPestana">&nbsp;&nbsp;<span class="texLinkDisabled"><fmt:message key="tracking" /></span>&nbsp;&nbsp;</td>
		        <td width="6" class="right_menu"></td>
		        <td width="6">&nbsp;</td>
	        <%} else { %>
		        <td width="6">&nbsp;</td>
		        <td width="6" class="left_menu"></td>
		        <td class="tituloPestana"><a href="#" onclick="return toTracking();" class="texLink">&nbsp;&nbsp;<fmt:message key="tracking" />&nbsp;&nbsp;</a></td>
		        <td width="6" class="right_menu"></td>
		        <td width="6">&nbsp;</td>
	        <%} %>
 		<%} %>
 		 -->       
    </tr>
</table>
