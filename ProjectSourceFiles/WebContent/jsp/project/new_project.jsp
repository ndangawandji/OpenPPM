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
<%--
 -  Updater : Cedric Ndanga Wandji
 -  Devoteam, 22/06/2015, user story 4 : deleting of project manager field, if the user is connected via a Project manager profile.
 -  Devoteam, 22/06/2015, user story 4 : Setting a default value for the project's priority.
--%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@page import="es.sm2.openppm.utils.ValidateUtil"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="error" var="fmtError" />

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
<fmt:message key="msg.error.maximum_allowed" var="fmtTcvMax">
	<fmt:param><b><fmt:message key="tcv"/></b></fmt:param>
</fmt:message>

<c:choose>
	<c:when test="${type == typeProject}">
		<c:set var="reqPM">*</c:set>
		<c:set var="reqValidate"><%=Project.EMPLOYEEBYPROJECTMANAGER %>_name</c:set>
		<c:if test="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_PM)%>">		<!-- cnw us4, setting variables for a project manager profile to configure his new project form -->
			<c:set var="hideProjectManager">hide</c:set>
			<c:set var="nameProjectManager">${user.contact.fullName}</c:set>
			<c:set var="idProjectManager">${user.idEmployee}</c:set>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_IM) %>">
			<c:set var="hideInvestment">hide</c:set>
			<c:set var="idInvestment">${user.idEmployee}</c:set>
			<c:set var="nameInvestment">${user.contact.fullName}</c:set>
		</c:if>
		<c:set var="reqIm">*</c:set>	
		<c:set var="reqValidate"><%=Project.EMPLOYEEBYINVESTMENTMANAGER %>_name</c:set>
	</c:otherwise>
</c:choose>

<script type="text/javascript">
<!--
var projectValidator;
function createProject() {

	if (projectValidator.form()) {
		document.forms["frm_project"].submit();
	}
	return false;
}

readyMethods.add(function() {
	var dates = $('#<%=Project.PLANNEDINITDATE%>, #<%=Project.PLANNEDFINISHDATE%>').datepicker({
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		onSelect: function(selectedDate) {
			var option = this.id == "<%=Project.PLANNEDINITDATE%>" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
			if (projectValidator.numberOfInvalids() > 0) projectValidator.form();
		}
	});

	// validate the form when it is submitted
	projectValidator = $("#frm_project").validate({
		errorContainer: 'div#project-errors',
		errorLabelContainer: 'div#project-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Project.CHARTLABEL%> : {required: true },
			<%=Project.PROJECTNAME%> : {required: true },
			'${reqValidate}' : {required: true },
			<%=Project.PROGRAM%> : {required: true },
			<%=Project.PLANNEDINITDATE%> : { required: true, date : true, minDateTo: '#<%=Project.PLANNEDFINISHDATE%>' },
			<%=Project.PLANNEDFINISHDATE%> : { required: true, date : true, maxDateTo: '#<%=Project.PLANNEDINITDATE%>' },
			<%=Project.PROBABILITY %>: { range: [0,99] },
			<%=Project.PRIORITY%> : {range: [0, 99] },
			<%=Project.TCV%> : {maxlength: <%=Constants.MAX_CURRENCY%> }
		},
		messages: {
			<%=Project.CHARTLABEL%> : {required: '${fmtShortNameRequired}' },
			<%=Project.PROJECTNAME%> : {required: '${fmtProjectNameRequired}' },
			<%=Project.EMPLOYEEBYINVESTMENTMANAGER %>_name : {required: '${fmtInvestmentManagerRequired}' },
			<%=Project.EMPLOYEEBYPROJECTMANAGER %>_name : {required: '${fmtProjectManagerRequired}' },
			<%=Project.PROGRAM%> : {required: '${fmtProgramRequired}' },
			<%=Project.PLANNEDINITDATE%>: { required: '${fmtPlannedStartDateRequired}', date: '${fmtPlannedStartDateFormat}', minDateTo: '${fmtPlannedStartDateAfterFinish}' },
			<%=Project.PLANNEDFINISHDATE%>: { required: '${fmtPlannedFinishDateRequired}', date: '${fmtPlannedFinishDateFormat}', maxDateTo: '${fmtPlannedFinishDateBeforeStart}' },
			<%=Project.PROBABILITY %> : { range : '${fmtProbabilityOutOfRange}' },
			<%=Project.PRIORITY%> : { range : '${fmtPriorityOutOfRange}' },
			<%=Project.TCV%> : { maxlength : '${fmtTcvMax}' }
		}
	});
	
	$('#<%=Project.BUDGETYEAR%>').filterSelect({
		selectFilter:'program',
		emptyAll: true
	});
});
//-->
</script>
<div id="project-errors" class="ui-state-error ui-corner-all hide">
	<p>
		<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong><fmt:message key="msg.error_title"/></strong>
		&nbsp;(<b><span id="numerrors"></span></b>)
	</p>
	<ol></ol>
</div>

<form name="frm_project" id="frm_project" method="post" action="<%=ProjectServlet.REFERENCE%>">
	<input type="hidden" name="accion" value="<%=ProjectServlet.CREATE_PROJECT %>" />
	<input type=hidden name="type" value="${type }" />
	<input type="hidden" name="<%=Project.PERFORMINGORG %>" id="<%=Project.PERFORMINGORG %>" value="${user.performingorg.idPerfOrg }"/>
	<fieldset>
		<table width="100%">
		
			<tr><td colspan="5">&nbsp;</td></tr>
		
			<tr>
				<th class="left" width="25%"><fmt:message key="project.chart_label"/>&nbsp;*</th>
				<th class="left" colspan="2"><fmt:message key="project_name"/>&nbsp;*</th>
				<th class="center" width="10%"><fmt:message key="project.budget_year"/></th>
				<th class="left" width="10%"><fmt:message key="project.accounting_code"/></th>
			</tr>
			<tr>
				<td><input type="text" name="<%=Project.CHARTLABEL %>" id="<%=Project.CHARTLABEL %>" class="campo" maxlength="15" style="width: 120px;"/></td>
				<td colspan="2"><input type="text" name="<%=Project.PROJECTNAME %>" id="<%=Project.PROJECTNAME %>" class="campo" maxlength="80"/></td>
				<td class="center"><input type="text" name="<%=Project.BUDGETYEAR%>" id="<%=Project.BUDGETYEAR%>" maxlength="4" class="campo" style="width: 32px;"></td>
				<td><input type="text" name="<%=Project.ACCOUNTINGCODE %>" id="<%=Project.ACCOUNTINGCODE %>" class="campo" maxlength="20" style="width: 120px;" /></td>
			</tr>
		
			<tr><td colspan="5">&nbsp;</td></tr>
		
			<tr>
				<th class="left">
					<div class="${hideInvestment}">
						<fmt:message key="proposal.bid_manager"/>&nbsp;${reqIm}						
						<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="searchEmployeePop('<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>', $('<%=Project.PERFORMINGORG %>').val(), <%=Constants.ROLE_IM %>);"/>
					</div>
				</th>
				<th width="30%" class="left">		<!-- cnw us4 -->
					<div class="${hideProjectManager}">
						<fmt:message key="project_manager"/>&nbsp;${reqPM}
						<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="searchEmployeePop('<%=Project.EMPLOYEEBYPROJECTMANAGER %>', $('<%=Project.PERFORMINGORG %>').val(), <%=Constants.ROLE_PM %>);"/>
					</div>
					
				</th>
				<th width="25%" class="left"><fmt:message key="program"/>&nbsp;*</th>
				<th class="left" colspan="2"><fmt:message key="category"/></th>
			</tr>
			<tr>
				<td>
					<input type="hidden" id="<%=Project.EMPLOYEEBYINVESTMENTMANAGER %>" name="<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>" value="${idInvestment}"/>
					<input type="text" id="<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>_name" class="campo ${hideInvestment}" name="<%=Project.EMPLOYEEBYINVESTMENTMANAGER%>_name" value="${nameInvestment }" readonly/>
				</td>
				<td>
					<input type="hidden" id="<%=Project.EMPLOYEEBYPROJECTMANAGER %>" name="<%=Project.EMPLOYEEBYPROJECTMANAGER %>" value="${idProjectManager}"/>		<!-- cnw us4, getting id of current project manager -->
					<input type="text" id="<%=Project.EMPLOYEEBYPROJECTMANAGER %>_name" class="campo ${hideProjectManager}" name="<%=Project.EMPLOYEEBYPROJECTMANAGER %>_name" value="${nameProjectManager}" readonly/>		<!-- cnw us4 adding of ${hideProjectManager} css class -->
				</td>
				<td>
					<select name="<%=Project.PROGRAM %>" id="<%=Project.PROGRAM%>" class="campo">
						<option value='' selected><fmt:message key="select_opt" /></option>
						<c:forEach var="program" items="${programs}">
							<option class="${program.budgetYear }" value="${program.idProgram}">${program.programName}</option>
						</c:forEach>
					</select>
				</td>
				<td colspan="5">
					<select name="<%=Project.CATEGORY %>" id="<%=Project.CATEGORY%>" class="campo">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<c:forEach var="category" items="${categories}">
							<option value="${category.idCategory}">${category.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		
			<tr><td colspan="5">&nbsp;</td></tr>
		
			<tr>
				<th class="left">
					<fmt:message key="business_manager"/>					
					<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="searchEmployeePop('<%=Project.EMPLOYEEBYFUNCTIONALMANAGER%>', $('<%=Project.PERFORMINGORG %>').val(), <%=Constants.ROLE_FM %>);"/>
				</th>
				<th class="left">
					<fmt:message key="sponsor"/>					
					<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="searchEmployeePop('<%=Project.EMPLOYEEBYSPONSOR %>', $('<%=Project.PERFORMINGORG %>').val(), <%=Constants.ROLE_SPONSOR %>);"/>
				</th>
				<th class="left">
					<fmt:message key="customer"/>									
					<img class="position_right icono" src="images/AddContact.png" title="<fmt:message key="add"/>" onclick="newCustomerPopup();"/>
				</th>
				<th class="center" colspan="2"><fmt:message key="tcv"/></th>
			</tr>
		
			<tr>
				<td>
					<input type="hidden" id="<%=Project.EMPLOYEEBYFUNCTIONALMANAGER %>" name="<%=Project.EMPLOYEEBYFUNCTIONALMANAGER%>"/>
					<input type="text" id="<%=Project.EMPLOYEEBYFUNCTIONALMANAGER%>_name" class="campo" name="<%=Project.EMPLOYEEBYFUNCTIONALMANAGER%>_name" readonly/>
				</td>
				<td>
					<input type="hidden" id="<%=Project.EMPLOYEEBYSPONSOR %>" name="<%=Project.EMPLOYEEBYSPONSOR %>" />
					<input type="text" id="<%=Project.EMPLOYEEBYSPONSOR %>_name" class="campo" name="<%=Project.EMPLOYEEBYSPONSOR %>_name" readonly/>
				</td>
				<td>
					<select name="<%=Project.CUSTOMER %>" id="<%=Project.CUSTOMER %>" class="campo">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<c:forEach var="customer" items="${customers}">
							<option value="${customer.idCustomer}">${customer.name}</option>
						</c:forEach>
					</select>
				</td>
				<td class="center" colspan="2"><input type="text" name="<%=Project.TCV%>" class="campo importe" style="width: 120px;"></td>
			</tr>
			
			<tr><td colspan="5">&nbsp;</td></tr>
			
			<tr>
				<th class="left"><fmt:message key="baseline_start"/>&nbsp;*</th>
				<th class="left"><fmt:message key="baseline_finish"/>&nbsp;*</th>
				<th class="left"><fmt:message key="sac"/></th>
				<th class="center"><fmt:message key="strategic_value"/></th>
				<th class="center"><fmt:message key="proposal.win_probability"/></th>
			</tr>
			<tr>
				<td><input type="text" name="<%=Project.PLANNEDINITDATE %>" id=<%=Project.PLANNEDINITDATE %> class="campo fecha"/></td>
				<td><input type="text" name="<%=Project.PLANNEDFINISHDATE %>" id="<%=Project.PLANNEDFINISHDATE %>" class="campo fecha"/></td>
				<td class="left">
					<nobr>
						<input type="text" name="<%=Project.DURATION%>" maxlength="4" class="campo right" style="width: 32px;">d
					</nobr>
				</td>
				<td class="center">
					<nobr>
						<input type="text" name="<%=Project.PRIORITY %>" maxlength="3" class="campo right" style="width: 24px;" value="<%=Constants.PRIORITY_DEFAULT%>"/>%	<!-- cnw us4 setting default value for the project's priority -->
					</nobr>
				</td>
				<td class="center">
					<nobr>
						<c:choose>
							<c:when test="<%=ValidateUtil.isNull(Constants.PROBABILITY_DEFAULT[0]) %>">
								<input type="text" id="<%=Project.PROBABILITY %>" name="<%=Project.PROBABILITY %>" title="${msg_bac_desc}" class="campo right" style="width:24px;margin:0px 2px 0px 0px;" maxlength="3" value="${project.probability}" />%
							</c:when>
							<c:otherwise>
								<select id="<%=Project.PROBABILITY %>" name="<%=Project.PROBABILITY %>" class="campo" style="width:50px;">
									<c:forEach var="value" items="<%=Constants.PROBABILITY_DEFAULT %>">
										<option value="${value}">${value}</option>
									</c:forEach>
								</select>%
							</c:otherwise>
						</c:choose>
					</nobr>
				</td>				
			</tr>
			
			<tr><td colspan="5">&nbsp;</td></tr>
			
			<tr>
				<td colspan="5" class="right">
					<a href="#" class="boton" onClick="return createProject();"><fmt:message key="project.create" /></a>
				</td>
			</tr>
		</table>
	</fieldset>
</form>

<jsp:include page="../common/new_customer_popup.jsp" flush="true"/>
<jsp:include page="../common/search_employee_popup.jsp" flush="true" />
