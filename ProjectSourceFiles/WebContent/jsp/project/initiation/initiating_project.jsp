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
<%@page import="es.sm2.openppm.model.Fundingsource"%>
<%@page import="es.sm2.openppm.utils.ValidateUtil"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.model.Documentproject"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.common.Settings"%>
<%@page import="es.sm2.openppm.servlets.ProjectInitServlet"%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="msg.error.no_stakeholders_approve_project" var="msg_error_stakeholders" />
<fmt:message key="accept" var="msg_accept" />
<fmt:message key="msg.error.approve_project" var="msg_approve_project" />
<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message key="tcv_desc" var="msg_tcv_desc" />
<fmt:message key="ni_desc" var="msg_ni_desc" />
<fmt:message key="bac_desc" var="msg_bac_desc" />
<fmt:message key="error" var="fmt_error" />

<fmt:message key="msg.info.execdate_before_project_initdate" var="fmt_plannedInitDate_before_project_initdate"/>
<fmt:message key="msg.error.planned_close_date_before_exec_date" var="fmt_planned_close_date_before_exec_date" />

<c:set var="is_pmo" value="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_PMO) %>" />

<c:set var="stk_internal"><%=Constants.CLASS_STAKEHOLDER_INTERNAL%></c:set>
<c:set var="stk_external"><%=Constants.CLASS_STAKEHOLDER_EXTERNAL%></c:set>
<c:set var="stk_supporter"><%=Constants.TYPE_STAKEHOLDER_SUPPORTER%></c:set>
<c:set var="stk_neutral"><%=Constants.TYPE_STAKEHOLDER_NEUTRAL%></c:set>
<c:set var="stk_opponent"><%=Constants.TYPE_STAKEHOLDER_OPPONENT%></c:set>
<c:set var="documentStorage"><%=es.sm2.openppm.common.Constants.DOCUMENT_STORAGE%></c:set>

<fmt:message var="fmt_internal" key="stakeholder.internal"/>
<fmt:message var="fmt_external" key="stakeholder.external"/>
<fmt:message var="fmt_supporter" key="stakeholder.supporter"/>
<fmt:message var="fmt_neutral" key="stakeholder.neutral"/>
<fmt:message var="fmt_opponent" key="stakeholder.opponent"/>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtShortNameRequired">
	<fmt:param><b><fmt:message key="project.chart_label"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtProjectNameRequired">
	<fmt:param><b><fmt:message key="project_name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtInvestmentManagerRequired">
	<fmt:param><b><fmt:message key="investment_manager"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtProjectManagerRequired">
	<fmt:param><b><fmt:message key="project_manager"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtProgramRequired">
	<fmt:param><b><fmt:message key="program"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtPlannedStartDateRequired">
	<fmt:param><b><fmt:message key="baseline_start"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtPlannedFinishDateRequired">
	<fmt:param><b><fmt:message key="baseline_finish"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtPlannedStartDateFormat">
	<fmt:param><b><fmt:message key="baseline_start"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtPlannedFinishDateFormat">
	<fmt:param><b><fmt:message key="baseline_finish"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtPlannedStartDateAfterFinish">
	<fmt:param><b><fmt:message key="baseline_start"/></b></fmt:param>
	<fmt:param><b><fmt:message key="baseline_finish"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtPlannedFinishDateBeforeStart">
	<fmt:param><b><fmt:message key="baseline_finish"/></b></fmt:param>
	<fmt:param><b><fmt:message key="baseline_start"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.out_of_range" var="fmtPriorityOutOfRange">
	<fmt:param><b><fmt:message key="project.priority"/></b></fmt:param>
	<fmt:param>0 - 99</fmt:param>
</fmt:message>
<fmt:message key="msg.error.out_of_range" var="fmtProbabilityOutOfRange">
	<fmt:param><b><fmt:message key="proposal.win_probability"/></b></fmt:param>
	<fmt:param>0 - 99</fmt:param>
</fmt:message>
<fmt:message key="msg.error.min_value" var="fmtSacMinValue">
	<fmt:param><b>0</b></fmt:param>
	<fmt:param><b><fmt:message key="sac"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.min_value" var="fmtEffortMinValue">
	<fmt:param><b>0</b></fmt:param>
	<fmt:param><b><fmt:message key="effort"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.maximum_allowed" var="fmtTcvMax">
	<fmt:param><b><fmt:message key="tcv"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.maximum_allowed" var="fmtBacMax">
	<fmt:param><b><fmt:message key="bac"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.maximum_allowed" var="fmtNiMax">
	<fmt:param><b><fmt:message key="project.net_value"/></b></fmt:param>
</fmt:message>

<c:choose>
	<c:when test="${type eq typeInvestment}">
		<c:set var="tab" scope="request"><%=Constants.TAB_INVESTMENT%></c:set>
		<c:set var="reqIM">*</c:set>	
		<c:set var="reqValidate"><%=Project.EMPLOYEEBYINVESTMENTMANAGER %>_name</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="reqPM">*</c:set>
		<c:set var="reqValidate">projectmanager_name</c:set>
	</c:otherwise>
</c:choose>
<c:if test="${project.status ne status_initiating}">
	<c:set var="disableValidate">readonly</c:set>
</c:if>

<%-- 
Request Attributes:
	contractTypes:	List of contract types
	programs:		List of programs
	employees:		List of employees of the perforg
	companies:		List of Companies
	project:		Project to plan
	projCharter:	Project Charter of project to plan
	profiles:		List of Resourceprofiles
	perforgs:		List of Performing Organization
--%>

<script type="text/javascript">
<!--
// Rules for validate project
var validator;
var initAjax = new AjaxCall('<%=ProjectInitServlet.REFERENCE%>','<fmt:message key="error" />');
var stakeholdersTable;

function resetEmployees() {
	$('#projectmanager').val('');
	$('#projectmanager_name').val('');
	$('#functionalmanager').val('');
	$('#functionalmanager_name').val('');
	$('#sponsor').val('');
	$('#sponsor_name').val('');	
}

function searchProjectMember(name, role) {
	var perforg = $('#perforg').val();
	if (perforg != '') {
		searchEmployeePop(name, perforg, role);
	}
}

function viewDocCharter() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectInitServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectInitServlet.VIEW_CHARTER%>";
	f.submit();	
}
function saveProject(viewCharter) {
	
	if (validator.form() && validateDates()) {
		var f = document.forms["frm_project"];
		f.accion.value = '<%=ProjectInitServlet.JX_SAVE_PROJECT%>';
		
		var leadProject		 = ''; 
		var dependentProject = '';
		
		$('#idLeadProject option').each(function() { leadProject += (leadProject==''?'':',')+$(this).val(); });
		$('#idDependentProject option').each(function() { dependentProject += (dependentProject==''?'':',')+$(this).val(); });
		
		f.leadProject.value		 = leadProject;
		f.dependentProject.value = dependentProject;
		
		initAjax.call($('#frm_project').serialize(), function(data) {
			if (viewCharter) { viewDocCharter(); }
		});
	} 
}

function deleteProject(idSelect) { $(idSelect+' option:selected').remove(); }

function newContactPopup() {
	$('#new-contact-popup').dialog('open');
}

function validateDates() {

	stateValidate = false;
	
	if(!dateBefore($('#proj_initdate').html(), $('#plannedInitDate').val(), '${datePattern}') && $('#plannedInitDate').val() != "") { 
		informationSuccess("${fmt_plannedInitDate_before_project_initdate}");
	}
	if(!dateBefore($('#plannedInitDate').val(), $('#plannedFinishDate').val(), '${datePattern}')) { 
		alertUI("${fmt_error}","${fmt_planned_close_date_before_exec_date}");
	}
	else {
		stateValidate = true;
	}
	return stateValidate;
}

function confirmIniLink() {
	$('#toggleEditLinkIni').hide();
	$('#toggleALinkIni').show();
	
	$('#a_linkIni')
		.text($('#<%=Project.LINKDOC%>')
		.val()).attr('href',$('#<%=Project.LINKDOC%>').val());
}
function modifyIniLink() {

	$('#toggleALinkIni').hide();
	$('#toggleEditLinkIni').show();
}
function updateTotalCosts() {
	
	var totalsellerscosts	= toNumber($('#totalsellerscosts').text());
	totalsellerscosts		= parseFloat(totalsellerscosts == ""?0:totalsellerscosts);
	
	var totalinfrastructurecosts = toNumber($('#totalinfrastructurecosts').text());
	totalinfrastructurecosts	 = parseFloat(totalinfrastructurecosts == ""?0:totalinfrastructurecosts);
	
	var totallicensescosts 	= toNumber($('#totallicensescosts').text());
	totallicensescosts 		= parseFloat(totallicensescosts == ""?0:totallicensescosts);
	
	var totalCosts = totalsellerscosts + totallicensescosts + totalinfrastructurecosts;
	
	$("#sumCosts").val(toCurrency(totalCosts));
}

// When document is ready
readyMethods.add(function() {
	
	stakeholdersTable = $('#tb_stakeholders_master').dataTable({
		"oLanguage": datatable_language,
		"bPaginate": false,
		"aoColumns": [
			{"bVisible": false },							  
		  	{"bVisible": false },
		  	{"bVisible": false },
		  	{"bVisible": false },
		  	{"bVisible": false },
            {"sClass": "left" }, 
            {"sClass": "left" }, 
            {"sClass": "left" },
            {"sClass": "left" },
            {"bVisible": false },
            {"bVisible": false },
            {"bVisible": false },
            {"sClass": "center", "bSortable" : false },
            {"bVisible": false }
     	],
     	"aaSorting": [[13, 'asc'], [0, 'asc']]
	});

	$('#tb_stakeholders_master tbody tr').live('click', function (event) {
		fnSetSelectable(stakeholdersTable, this);
	});
	
	validator = $("#frm_project").validate({
		errorContainer: 'div#project-errors',
		errorLabelContainer: 'div#project-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Project.CHARTLABEL%>: { required: true },
			projectname: { required: true },
			'${reqValidate}' : { required: true },
			program: { required: true }, 
			<%=Project.PLANNEDINITDATE%> : { required: true, date : true, minDateTo: '#<%=Project.PLANNEDFINISHDATE%>' },
			<%=Project.PLANNEDFINISHDATE%> : { required: true, date : true, maxDateTo: '#<%=Project.PLANNEDINITDATE%>' },
			strategic_value: { range: [0,99] },
			'<%=Project.PROBABILITY %>${disableValidate}': { range: [0,99] },
			sac: { min: 0, integerPositive: true },
			effort: { min: 0 },
			successcriteria: { maxlength: 1500 },
			projectobjectives: { maxlength: 1500 },
			businessneed: { maxlength: 1500 },
			mainconstraints: { maxlength: 1500 },
			mainassumptions: { maxlength: 1500 },
			mainrisks: { maxlength: 1500 },
			tcv: { maxlength: <%=Constants.MAX_CURRENCY%> },
			bac: { maxlength: <%=Constants.MAX_CURRENCY%> },
			ni: { maxlength: <%=Constants.MAX_CURRENCY%> }
		},
		messages: {
			<%=Project.CHARTLABEL%> : {required: '${fmtShortNameRequired}' },
			projectname : {required: '${fmtProjectNameRequired}' },
			projectmanager_name : {required: '${fmtProjectManagerRequired}' },
			<%=Project.EMPLOYEEBYINVESTMENTMANAGER %>_name : {required: '${fmtInvestmentManagerRequired}' },
			program : {required: '${fmtProgramRequired}' },
			<%=Project.PLANNEDINITDATE%>: { required: '${fmtPlannedStartDateRequired}', date: '${fmtPlannedStartDateFormat}', minDateTo: '${fmtPlannedStartDateAfterFinish}' },
			<%=Project.PLANNEDFINISHDATE%>: { required: '${fmtPlannedFinishDateRequired}', date: '${fmtPlannedFinishDateFormat}', maxDateTo: '${fmtPlannedFinishDateBeforeStart}' },
			strategic_value : { range : '${fmtPriorityOutOfRange}' },
			'<%=Project.PROBABILITY %>${disableValidate}' : { range : '${fmtProbabilityOutOfRange}' },
			sac : { min : '${fmtSacMinValue}' },
			effort : { min : '${fmtEffortMinValue}' },
			tcv: { maxlength: '${fmtTcvMax}' },
			bac: { maxlength: '${fmtBacMax}' },
			ni: { maxlength: '${fmtNiMax}' }
		}
	});
	
	updateTotalCosts();
	
	$('#<%=Project.BUDGETYEAR%>').filterSelect({
		selectFilter:'program',
		emptyAll: true
	});
	$('#program').val('${project.program.idProgram}');
});
//-->
</script>
<c:if test="${project.status eq status_initiating}">
	<script>
		readyMethods.add(function() {
			var dates = $('#plannedInitDate, #plannedFinishDate').datepicker({
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				onSelect: function(selectedDate) {
					var option = this.id == "plannedInitDate" ? "minDate" : "maxDate";
					var instance = $(this).data("datepicker");
					var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
					dates.not(this).datepicker("option", option, date);
					if (validator.numberOfInvalids() > 0) validator.form();
				}
			});
		});
	</script>
</c:if>	

<c:choose>
	
	<c:when test="${type eq typeInvestment}">
		<script>
			function toInitiatingProject() {
				var f = document.forms["frm_project"];
				f.action = "<%=ProjectInitServlet.REFERENCE%>";
				f.accion.value = "";
				f.submit();
			}
		</script>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
			    <td width="6">&nbsp;</td>
		    	<td width="6" class="left_menu_sel"></td>
			    <td class="tituloPestana1" class="left"><a href="#" onclick="return toInitiatingProject();" class="texLink">&nbsp;&nbsp;<fmt:message key="initiation" />&nbsp;&nbsp;</a></td>
			    <td width="6" class="right_menu_sel"></td>
			    <td width="6">&nbsp;</td>
		   </tr>
	   </table>
	   <c:set var="status"><fmt:message key="investments.status.${project.investmentStatus}" /></c:set>
	</c:when>
	<c:otherwise>
	   <c:set var="status"><fmt:message key="project_status.${project.status}" /></c:set>
		<jsp:include page="../common/header_project.jsp">
			<jsp:param value="I" name="actual_page"/>
		</jsp:include>
	</c:otherwise>
</c:choose>

<div class="caja_formulario">
	<form name="frm_project" id="frm_project" method="post">
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="id" id="id" value="${project.idProject}" />
		<input type="hidden" name="status" value="${project.status}" />
		<input type="hidden" name="idprojectcharter" value="${projCharter.idProjectCharter}" />
		<input type="hidden" id="initdate" value="${project.initDate}" />
		<input type="hidden" name="type" value="${type}" />
		<input type="hidden" name="perforg" id="perforg" value="${project.performingorg.idPerfOrg }" />
		<input type="hidden" id="idDocument" name="idDocument" />
		
		<div id="project-errors" class="ui-state-error ui-corner-all hide">
			<p>
				<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong><fmt:message key="msg.error_title"/></strong>
				&nbsp;(<b><span id="numerrors"></span></b>)
			</p>
			<ol></ol>
		</div>
		
		<%-- PROJECT DATA --%>
		<jsp:include page="../common/info_project.jsp" flush="true" />
		<fieldset style="margin-top:5px;" class="level_1">
			<legend class="link" onclick="changeCookie('tb_basic_data')"><fmt:message key="basic_data"/></legend>
			<div class="buttons">
				<img id="tb_basic_dataBtn" onclick="changeCookie('tb_basic_data', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="tb_basic_data" style="display:none;">
				<table width="100%">
					<tr><td>&nbsp;</td></tr>
					<tr>
						<th class="left" width="25%"><fmt:message key="project.chart_label"/>*</th>
						<th class="left" colspan="3"><fmt:message key="project_name" />*</th>
						<th class="center" width="12%"><fmt:message key="project.budget_year"/></th>
						<th class="left" width="13%"><fmt:message key="project.accounting_code" /></th>
					</tr>
					<tr>
						<td><input type="text" class="campo" name="<%=Project.CHARTLABEL %>" maxlength="15" value="${project.chartLabel }" style="width: 120px;" /></td>
						<td colspan="3">
							<c:choose>
								<c:when test="<%= SecurityUtil.isUserInRole(request, Constants.ROLE_PMO) %>">
									<input type="text" name="projectname" class="campo" value="${project.projectName}" maxlength="80"/>
								</c:when>
								<c:when test="${project.status ne status_initiating and project.status ne status_planning}">
									<input type="text" name="projectname" value="${project.projectName}" maxlength="80" readonly/>
								</c:when>
								<c:otherwise>
									<input type="text" name="projectname" class="campo" value="${project.projectName}" maxlength="80"/>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="center"><input type="text" id="<%=Project.BUDGETYEAR%>" name="<%=Project.BUDGETYEAR%>" value="${project.budgetYear }" maxlength="4" class="campo" style="width: 32px;"></td>
						<td><input type="text" name="<%=Project.ACCOUNTINGCODE %>" id="<%=Project.ACCOUNTINGCODE %>" class="campo" maxlength="20" value="${project.accountingCode}" style="width: 120px;" /></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<th class="left">
							<fmt:message key="proposal.bid_manager"/>${reqIM}
							<c:if test="${tl:hasPermission(user,project.status,tab)}">				
								<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="searchEmployeePop('<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>', $('<%=Project.PERFORMINGORG %>').val(), <%=Constants.ROLE_IM %>);" />
							</c:if>
						</th>
						<th class="left" width="25%">
							<fmt:message key="project_manager" />${reqPM}
							<c:if test="${tl:hasPermission(user,project.status,tab)}">					
								<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="return searchProjectMember('projectmanager', <%=Constants.ROLE_PM %>);"/>
							</c:if>
						</th>
						<th class="left" colspan="2"><fmt:message key="program" />&nbsp;*</th>
						<th colspan="2"><fmt:message key="category"/></th>
					</tr>
					<tr>
						<td>
							<input type="hidden" id="<%=Project.EMPLOYEEBYINVESTMENTMANAGER %>" name="<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>" value="${project.employeeByInvestmentManager.idEmployee }"/>
							<input type="text" id="<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>_name" class="campo" name="<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>_name" value="${project.employeeByInvestmentManager.contact.fullName }" readonly/>
						</td>
						<td>
							<input type="hidden" id="projectmanager" name="projectmanager" value="${project.employeeByProjectManager.idEmployee }"/>
							<input type="text" id="projectmanager_name" class="campo" name="projectmanager_name" value="<c:out value="${project.employeeByProjectManager.contact.fullName }" />" readonly/>
						</td>
						<td colspan="2">
							<c:choose>
								<c:when test="${(project.status eq status_initiating or project.status eq status_planning) and tl:hasPermission(user,project.status,tab)}">
									<select name="program" id="program" class="campo">
										<option value='' selected><fmt:message key="select_opt" /></option>
										<c:forEach var="program" items="${programs}">
											<option class="${program.budgetYear }" value="${program.idProgram}" 
												${project.program.idProgram == program.idProgram ? "selected" : ""}>
												${program.programName}
											</option>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="program" id="program" value="${project.program.idProgram}"/>
									<span>${project.program.programName}</span>
								</c:otherwise>
							</c:choose>
						</td>
						<td colspan="2">
							<select name="<%=Project.CATEGORY %>" id="<%=Project.CATEGORY %>" class="campo">
								<option value=""><fmt:message key="select_opt"/></option>
								<c:forEach var="category" items="${categories}">
									<option value="${category.idCategory}"
										${project.category.idCategory == category.idCategory ? "selected" : ""}>${category.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<th class="left">
							<fmt:message key="business_manager" />
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="return searchProjectMember('functionalmanager', <%=Constants.ROLE_FM %>);" />
							</c:if>
						</th>
						<th class="left">
							<fmt:message key="sponsor" />
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="return searchProjectMember('sponsor', <%=Constants.ROLE_SPONSOR %>);" />
							</c:if>
						</th>
						<th class="left" colspan="2"><fmt:message key="customer" />
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img class="position_right icono"  title="<fmt:message key="add"/>" src="images/AddContact.png" onclick="return newCustomerPopup();"/>
							</c:if>
						</th>
						<th class="center"><fmt:message key="tcv" /></th>
						<th class="center"><fmt:message key="bac" /></th>
					</tr>
					<tr>
						<td>
							<input type="hidden" id="functionalmanager" name="functionalmanager" value="${project.employeeByFunctionalManager.idEmployee }"/>
							<input type="text" class="campo" id="functionalmanager_name" name="functionalmanager_name" value="<c:out value="${project.employeeByFunctionalManager.contact.fullName }" />" readonly/>
						</td>
						<td>
							<input type="hidden" id="sponsor" name="sponsor" value="${project.employeeBySponsor.idEmployee }"/>
							<input type="text" class="campo" id="sponsor_name" name="sponsor_name" value="<c:out value="${project.employeeBySponsor.contact.fullName }" />" readonly/>
						</td>
						<td colspan="2">
							<c:choose>
								<c:when test="${project.status ne status_closed}">
									<select name="customer" id="customer" class="campo">
										<option value="" selected><fmt:message key="select_opt"/></option>
										<c:forEach var="customer" items="${customers}">
											<option value="${customer.idCustomer}"
												${project.customer.idCustomer == customer.idCustomer ? "selected" : ""}>
												${customer.name}
												</option>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="customer" id="customer" value="${project.customer.idCustomer}"/>
									<input type="text" value="${project.customer.name}"/>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="center">
							<c:choose>
								<c:when test="<%= SecurityUtil.isUserInRole(request, Constants.ROLE_PMO) %>">
									<input type="text" id="tcv" name="tcv" title="${msg_tcv_desc}" class="campo importe" style="width:85px;margin:0px 2px 0px 0px;" value="${project.tcv}" />
								</c:when>
								<c:when test="${project.status ne status_initiating and project.status ne status_planning}">
									<input type="text" id="tcv" name="tcv" title="${msg_tcv_desc}" class="importe" style="width:85px;margin:0px 2px 0px 0px;" value="${project.tcv}" readonly/>
								</c:when>
								<c:otherwise>
									<input type="text" id="tcv" name="tcv" title="${msg_tcv_desc}" class="campo importe" style="width:85px;margin:0px 2px 0px 0px;" value="${project.tcv}" />
								</c:otherwise>
							</c:choose>						
						</td>
						<td class="center"><input type="text" id="bac" name="bac" title="${msg_bac_desc}" class="campo importe" style="width:85px;margin:0px 2px 0px 0px;" value="${project.bac}" /></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<th class="left"><fmt:message key="baseline_start" />&nbsp;*</th>
						<th class="left"><fmt:message key="baseline_finish" />&nbsp;*</th>
						<th class="left"><fmt:message key="sac" /></th>
						<th class="center"><fmt:message key="strategic_value"/></th>
						<th class="center"><fmt:message key="proposal.win_probability"/></th>
						<th class="center">
							<c:choose>
								<c:when test="<%=Settings.SHOW_EXTERNAL_COSTS_FIELD %>">
									<fmt:message key="external_costs"/>
								</c:when>
								<c:otherwise>
									&nbsp;
								</c:otherwise>
							</c:choose>	
						</th>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${project.status ne status_initiating}">
								<td><fmt:formatDate value="${project.plannedInitDate}" pattern="${datePattern}" /></td>
								<td><fmt:formatDate value="${project.plannedFinishDate}" pattern="${datePattern}" /></td>
								<input type="hidden" name="plannedInitDate" id="plannedInitDate" 
									value="<fmt:formatDate value="${project.plannedInitDate}" pattern="${datePattern}" />"
								/>
								<input type="hidden" name="plannedFinishDate" id="plannedFinishDate"
									value="<fmt:formatDate value="${project.plannedFinishDate}" pattern="${datePattern}" />"
								/>
							</c:when>
							<c:otherwise>
								<td>
									<input type="text" name="plannedInitDate" id="plannedInitDate" class="campo fecha"
										value="<fmt:formatDate value="${project.plannedInitDate}" pattern="${datePattern}" />"
									/>
								</td>
								<td>
									<input type="text" name="plannedFinishDate" id="plannedFinishDate" class="campo fecha" 
										value="<fmt:formatDate value="${project.plannedFinishDate}" pattern="${datePattern}" />"
									/>
								</td>
							</c:otherwise>
						</c:choose>
						<td>
							<nobr>
								<input type="text" name="sac" id="sac" class="campo" style="width:40px;margin:0px 2px 0px 5px;" value="${project.duration}"/>d
							</nobr>
						</td>
						<td class="center">
							<nobr>
								<input type="text" name="strategic_value" maxlength="3" style="width: 24px;" class="campo right" value="${project.priority}"/>%
							</nobr>
						</td>
						<td class="center">
							<nobr>
								<c:choose>
									<c:when test="<%=ValidateUtil.isNull(Constants.PROBABILITY_DEFAULT[0]) %>">
										<input type="text" id="<%=Project.PROBABILITY %>" name="<%=Project.PROBABILITY %>" title="${msg_bac_desc}" class="campo right" style="width:24px;margin:0px 2px 0px 0px;" maxlength="3" value="${project.probability}" ${disableValidate }/>%
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${project.status eq status_initiating}">
												<select id="<%=Project.PROBABILITY %>" name="<%=Project.PROBABILITY %>" class="campo" style="width:50px;" ${disableValidate }>
													<c:forEach var="value" items="<%=Constants.PROBABILITY_DEFAULT %>">
														<option value="${value}" ${value eq project.probability?"selected":""}>${value }</option>
													</c:forEach>
												</select>%
											</c:when>
											<c:otherwise>
												<input type="text" id="<%=Project.PROBABILITY %>" name="<%=Project.PROBABILITY %>" title="${msg_bac_desc}" class="campo right" style="width:24px;margin:0px 2px 0px 0px;" maxlength="3" value="${project.probability}" readonly />%	
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</nobr>
						</td>
						<td>
							<c:choose>
								<c:when test="<%=Settings.SHOW_EXTERNAL_COSTS_FIELD %>">
									<input type="text" id="sumCosts" value="" class="right" readonly />
								</c:when>
								<c:otherwise>
									<input type="text" id="sumCosts" value="" class="right" readonly style="visibility: hidden;" />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<th><fmt:message key="contract_type" /></th>
						<th><fmt:message key="geography"/></th>
						<th colspan="4">&nbsp;</th>											
					</tr>
					<tr>
						<td>
							<select name="contracttype" class="campo">
								<option value='' selected><fmt:message key="select_opt" /></option>
								<c:forEach var="contractType" items="${contractTypes}">
									<option value="${contractType.idContractType}"
										${project.contracttype.idContractType == contractType.idContractType ? "selected" : ""}>
										${contractType.description}
									</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<select name="<%=Project.GEOGRAPHY %>" class="campo">
								<option value=''><fmt:message key="select_opt" /></option>
								<c:forEach var="geography" items="${geographies}">
									<option value="${geography.idGeography}"
											${project.geography.idGeography == geography.idGeography ? "selected" : ""}>
										${geography.name}</option>
								</c:forEach>
							</select>
						</td>
						<td class="center" colspan="2">
							<nobr>
								<input name="<%=Project.ISGEOSELLING %>" style="width:20px;" value="true" type="checkbox" ${project.isGeoSelling ? "checked" : ""}/>
								<fmt:message key="proposal.requires_travelling" />
							</nobr>
						</td>
						<td colspan="2" class="center">
							<nobr>
								<input name="internalProject" style="width:20px;" id="internalProject" value="true" type="checkbox" ${project.internalProject ? "checked" : ""}/>
								<fmt:message key="project.internal_project" />
							</nobr>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<th colspan="2"><fmt:message key="document_link"/></th>
						<th colspan="4"><fmt:message key="funding_source"/></th>
					</tr>
					<tr>
						<td colspan="2">
							<c:choose>
								<c:when test="${project.linkDoc == null or empty project.linkDoc}">
									<c:set var="linkDocument">style="display:none;"</c:set>
								</c:when>
								<c:otherwise>
									<c:set var="inputDocument">style="display:none;"</c:set>
								</c:otherwise>
							</c:choose>
							<div ${inputDocument } id="toggleEditLinkIni">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img style="width:16px;" src="images/approve.png" onclick="confirmIniLink()"/>
								</c:if>
								<input type="text" name="<%=Project.LINKDOC%>" id="<%=Project.LINKDOC%>" style="width: 375px; *width: 365px !important;" maxlength="200" class="campo" value="${project.linkDoc}" />
							</div>
							<div ${linkDocument} id="toggleALinkIni">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img style="width:16px;" src="images/modify.png" onclick="modifyIniLink()"/>
								</c:if>
								<a href="${project.linkDoc}" target="_blank" id="a_linkIni">${project.linkDoc}</a>
							</div>
						</td>
						<td colspan="4">
							<select class="campo" name="<%=Fundingsource.IDFUNDINGSOURCE%>">
								<option value=''><fmt:message key="select_opt" /></option>
								<c:forEach var="fundingsource" items="${fundingsources}">
									<option value="${fundingsource.idFundingSource}"
											${project.fundingsource.idFundingSource == fundingsource.idFundingSource ? "selected" : ""}>
										${fundingsource.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<th colspan="2">
							<fmt:message key="projects.lead"/>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img class="position_right icono" style="padding-right: 20px;" title="<fmt:message key="delete"/>" src="images/delete.jpg" onclick="deleteProject('#idLeadProject');"/>
								<img class="position_right icono"  title="<fmt:message key="add"/>" src="images/add_proj.png" onclick="openSearchProject('#idLeadProject');"/>
							</c:if>
						</th>
						<th colspan="4">
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img class="position_right icono" style="padding-right: 20px; *margin-top: 0 !important;" title="<fmt:message key="delete"/>" src="images/delete.jpg" onclick="deleteProject('#idDependentProject');"/>
								<img class="position_right icono" style="margin-top: 0 !important;" title="<fmt:message key="add"/>" src="images/add_proj.png" onclick="openSearchProject('#idDependentProject');"/>
							</c:if>
							<fmt:message key="projects.dependent"/>
						</th>
					</tr>
					<tr>
						<td colspan="2">
							<input type="hidden" name="leadProject"/>
							<select class="campo" multiple style="height: 100px;" id="idLeadProject">
								<c:forEach var="lead" items="${project.projectassociationsForDependent}">
									<option value="${lead.projectByLead.idProject}">${lead.projectByLead.projectName}</option>
								</c:forEach>
							</select>
						</td>
						<td colspan="4">
							<input type="hidden" name="dependentProject"/>
							<select class="campo" multiple style="height: 100px;" id="idDependentProject">
								<c:forEach var="dependent" items="${project.projectassociationsForLead}">
									<option value="${dependent.projectByDependent.idProject}">${dependent.projectByDependent.projectName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<c:if test="${tl:hasPermission(user,project.status,tab)}">
					<div align="right" style="margin-top:10px;">
						<a href="javascript: saveProject();" class="boton"><fmt:message key="save" /></a>
					</div>
				</c:if>
			</div>			
		</fieldset>
		
		<%-- STAKEHOLDERS --%>
		<div style="">&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('tb_stakeholders')"><fmt:message key="stakeholders"/></legend>
			<div class="buttons">
				<img id="tb_stakeholdersBtn" onclick="changeCookie('tb_stakeholders', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="tb_stakeholders" style="display:none;">
				<table id="tb_stakeholders_master" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%">&nbsp;</th>							
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="42%"><fmt:message key="stakeholder.name" /></th>
							<th width="25%"><fmt:message key="stakeholder.rol" /></th>
							<th width="15%"><fmt:message key="stakeholder.classification" /></th>
							<th width="10%"><fmt:message key="stakeholder.type" /></th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="8%">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img onclick="newStakeholder()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
								</c:if>
							</th>
							<th width="0%">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stakeholder" items="${stakeholders}">
							<tr>
								<td>${stakeholder.idStakeholder}</td>								
								<td>${tl:escape(stakeholder.requirements)}</td>
								<td>${tl:escape(stakeholder.expectations)}</td>
								<td>${tl:escape(stakeholder.influence)}</td>
								<td>${tl:escape(stakeholder.mgtStrategy)}</td>
								<td>${tl:escape(stakeholder.contactName)}</td>
								<td>${tl:escape(stakeholder.projectRole)}</td>
								<td>
									<c:choose>
										<c:when test="${stakeholder.classification eq stk_internal}">
											${fmt_internal}
										</c:when>
										<c:when test="${stakeholder.classification eq stk_external}">
											${fmt_external}
										</c:when>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${stakeholder.type eq stk_supporter}">
											${fmt_supporter}
										</c:when>
										<c:when test="${stakeholder.type eq stk_neutral}">
											${fmt_neutral}
										</c:when>
										<c:when test="${stakeholder.type eq stk_opponent}">
											${fmt_opponent}
										</c:when>
									</c:choose>
								</td>
								<td>${stakeholder.classification}</td>
								<td>${stakeholder.type}</td>
								<td>${stakeholder.department}</td>
								<td>
									<img onclick="viewStakeholder(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
									<c:if test="${tl:hasPermission(user,project.status,tab)}">
										&nbsp;&nbsp;&nbsp;
										<img onclick="deleteStakeholder(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
									</c:if>
								</td>
								<td>${stakeholder.orderToShow}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</fieldset>
		
		<%-- PROJECT CHARTER --%>
		<div style="">&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('tb_project_charter')"><fmt:message key="project_charter"/></legend>
			<div class="buttons">
				<img id="tb_project_charterBtn" onclick="changeCookie('tb_project_charter', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="tb_project_charter" style="display:none;">
				<div align="right" style="margin-top:10px; margin-right: 10px;">
					<a class="boton" href="javascript:${tl:hasPermission(user,project.status,tab)?"saveProject(true)":"viewDocCharter()"};"><fmt:message key="generate_project_charter" /></a>
				</div>
				<table width="100%">
					<tr>
						<th class="left"><fmt:message key="project_charter.project_description" /></th>
						<th class="left"><fmt:message key="project_charter.project_objectives" /></th>
					</tr>
					<tr>
						<td class="center">
							<textarea name="successcriteria" class="campo show_scroll" rows="8" style="width:90%;">${projCharter.sucessCriteria}</textarea>
						</td>
						<td class="center">
							<textarea name="projectobjectives" id="projectobjectives" class="campo show_scroll" rows="8" style="width:90%;">${projCharter.projectObjectives}</textarea>
						</td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="project_charter.business_need" /></th>
						<th class="left"><fmt:message key="project_charter.main_constraints" /></th>
					</tr>
					<tr>
						<td class="center">
							<textarea name="businessneed" id="businessneed" class="campo show_scroll" rows="5" style="width:90%;">${projCharter.businessNeed}</textarea>
						</td>
						<td class="center">
							<textarea name="mainconstraints" class="campo show_scroll" rows="5" style="width:90%;">${projCharter.mainConstraints}</textarea>
						</td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="project_charter.main_risks" /></th>
						<th class="left"><fmt:message key="project_charter.main_assumptions" /></th>
					</tr>
					<tr>
						<td class="center">
							<textarea name="mainrisks" class="campo show_scroll" rows="5" style="width:90%;">${projCharter.mainRisks}</textarea>
						</td>
						<td class="center">
							<textarea name="mainassumptions" class="campo show_scroll" rows="5" style="width:90%;">${projCharter.mainAssumptions}</textarea>							
						</td>
					</tr>
				</table>
					
				<jsp:include page="projectcharter_costs.inc.jsp" flush="true" />

				<table width="100%">
					<tr>
						<th width="50%">&nbsp;</th>
						<th width="30%" align="right"><fmt:message key="internal_effort" /></th>
						<th width="20%" align="right"><fmt:message key="project.net_value" /></th>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right">
							<input type="text" name="effort" id="effort" class="campo right" maxlength="5" style="width:40px;margin:0px 2px 0px 5px;" value="${project.effort}" />h							
						</td>
						<td align="right">
							<input type="text" name="ni" title="${msg_ni_desc}" class="campo importe" style="width:85px;margin:0px 2px 0px 0px;" value="${project.netIncome}"/>
						</td>
					</tr>
				</table>
			</div>
		</fieldset>
	</form>
	
	<div style="">&nbsp;</div>
	
	<fmt:message var="documentationTitle" key="documentation.initiating"/>
	<jsp:include page="../common/project_documentation_${documentStorage}.jsp">
		<jsp:param name="documentationType" value="<%=Constants.DOCUMENT_INITIATING %>"/>
		<jsp:param name="documentationTitle" value="${documentationTitle }"/>
	</jsp:include>
		
	<c:if test="${tl:hasPermission(user,project.status,tab)}">
		<div align="right" style="margin-top:10px;">
			<a href="javascript: saveProject();" class="boton"><fmt:message key="save" /></a>
		</div>	
		<script type="text/javascript">
			readyMethods.add(function() {
				$("#tb_stakeholders_master tbody").sortable({
					cursor: "move",	
				   	update: function() {
				   		
				   		var ids = '';
				   		$("#tb_stakeholders_master tbody tr").each(function() {
				   			
				   			var stakeholder = stakeholdersTable.fnGetData(this);
				   			if (ids == '') { ids += stakeholder[0]; }
				   			else { ids += ','+stakeholder[0]; }
				   		});
				   		
				    	var params = {	    			
			    			accion: '<%=ProjectInitServlet.JX_UPDATE_STAKEHOLDER_ORDER%>',
			    			idProject: '${project.idProject}',
			    			ids : ids
			    		};
				    	initAjax.call(params);
				    }
				});
			});
		</script>		
	</c:if>	
</div>

<jsp:include page="edit_stakeholder.jsp" flush="true" />

<c:if test="${tl:hasPermission(user,project.status,tab)}">

	<jsp:include page="../../common/search_employee_popup.jsp" flush="true" />
	<jsp:include page="../../common/search_contact_popup.jsp" flush="true" />
	<jsp:include page="../../common/new_customer_popup.jsp" flush="true"/>
	<jsp:include page="../common/search_projects_popup.jsp" flush="true"/>
	
	<%--  Icludes if "projectcharter_costs.inc.jsp is included --%>
	<jsp:include page="edit_sellercost.jsp" flush="true" />
	<jsp:include page="edit_infrastructurecost.jsp" flush="true" />
	<jsp:include page="edit_licensecost.jsp" flush="true" />
	<jsp:include page="edit_workingcost.jsp" flush="true" />
</c:if>
