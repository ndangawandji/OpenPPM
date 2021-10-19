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
<%@page import="es.sm2.openppm.servlets.ProjectRiskServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@page import="es.sm2.openppm.model.Documentproject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="documentStorage"><%=es.sm2.openppm.common.Constants.DOCUMENT_STORAGE%></c:set>

<%-- 
Request Attributes:
	project
	assumptions
	risks
	riskCategories
	issues
--%>

<jsp:include page="../common/header_project.jsp">
	<jsp:param value="R" name="actual_page"/>
</jsp:include>
<script type="text/javascript">
<!--
	var riskAjax = new AjaxCall('<%=ProjectRiskServlet.REFERENCE%>','<fmt:message key="error"/>');

	readyMethods.add(function() {
	
	});

//-->
</script>
<div class="caja_formulario">
	<form name="frm_project" id="frm_project" method="post">
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="id" id="id" value="${project.idProject}" />
		<input type="hidden" name="assumption_id" id="assumption_id" />
		<input type="hidden" name="risk_id" id="risk_id" />
		<input type="hidden" name="assumption_log_id" id="assumption_log_id" />
		<input type="hidden" name="reassessment_log_id" />		
		<input type="hidden" name="issue_id" id="issue_id" />
		<input type="hidden" id="idDocument" name="idDocument" />		
   		
		<%-- INFORMATION OF PROJECT --%>
		<jsp:include page="../common/info_project.jsp" flush="true" />
	</form>
	<jsp:include page="manage_risks.inc.jsp" flush="true" />
	<jsp:include page="manage_issues.inc.jsp"></jsp:include>
	<jsp:include page="manage_assumptions.inc.jsp" flush="true" />
	
	<div style="">&nbsp;</div>
	
	<fmt:message var="documentationTitle" key="documentation.risk"/>
	<jsp:include page="../common/project_documentation_${documentStorage}.jsp">
		<jsp:param name="documentationType" value="<%=Constants.DOCUMENT_RISK %>"/>
		<jsp:param name="documentationTitle" value="${documentationTitle }"/>
	</jsp:include>
</div>

<jsp:include page="manage_assumption_popup.jsp" flush="true" />
<jsp:include page="manage_issue_popup.jsp" flush="true" />
