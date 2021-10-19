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
<%@page import="es.sm2.openppm.model.Workingcosts"%>
<%@page import="es.sm2.openppm.servlets.ProjectInitServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.utils.ValidateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:message key="update" var="msg_update" />
<fmt:message key="add" var="msg_add" />
<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message key="msg.confirm_delete" var="msg_delete_workingcost">
	<fmt:param><fmt:message key="workingcost"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_delete_workingcost">
	<fmt:param><fmt:message key="workingcost"/></fmt:param>
</fmt:message>

<c:if test="${project.status ne status_closed}">
	<c:set var="deleteWorkingCost"><img onclick="deleteWorkingCost(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg"></c:set>
</c:if>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtRealEffortRequired">
	<fmt:param><b><fmt:message key="workingcosts.actual_hours"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var wc_validator;
var initAjax = new AjaxCall('<%=ProjectInitServlet.REFERENCE%>','<fmt:message key="error" />');

function viewWorkingCost(element) {
	
	wc_validator.resetForm();
	var workingcost = workingCostsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_workingcost"];

	// Recover workingcost info
	f.wc_id.value			= workingcost[0];
	f.wc_resource.value		= unEscape(workingcost[1]);
	f.<%=Workingcosts.RESOURCEDEPARTMENT %>.value	= unEscape(workingcost[2]);
	f.wc_effort.value 		= workingcost[3];
	f.wc_real_effort.value 	= workingcost[4];
	f.wc_rate.value 		= workingcost[5];		
	f.<%=Workingcosts.Q1%>.value = workingcost[6];
	f.<%=Workingcosts.Q2%>.value = workingcost[7];
	f.<%=Workingcosts.Q3%>.value = workingcost[8];
	f.<%=Workingcosts.Q4%>.value = workingcost[9];
		
	$('#btn_saveworkingcost').button("option", "label", '${msg_update}');
	
	$('#workingcost-popup').dialog('open');
}

function resetWorkingCost() {
	var f = document.forms["frm_workingcost"];
	f.wc_id.value = '';
	f.reset();
}

function saveWorkingCost() {
	if (wc_validator.form()) {
		var f = document.forms["frm_workingcost"];

		var wc_id = f.wc_id.value;
		
		var params = {
			accion: "<%=ProjectInitServlet.JX_SAVE_WORKINGCOST%>", 
			id: document.forms["frm_project"].id.value, // Project ID
			wc_id: f.wc_id.value,
			wc_resource: f.wc_resource.value,
			wc_department: f.<%=Workingcosts.RESOURCEDEPARTMENT %>.value, 
			wc_effort: f.wc_effort.value,
			wc_real_effort: f.wc_real_effort.value == '' ? 0 : f.wc_real_effort.value,
			wc_rate: f.wc_rate.value,	
			<%=Workingcosts.Q1%>: f.<%=Workingcosts.Q1%>.value, 
			<%=Workingcosts.Q2%>: f.<%=Workingcosts.Q2%>.value, 
			<%=Workingcosts.Q3%>: f.<%=Workingcosts.Q3%>.value, 
			<%=Workingcosts.Q4%>: f.<%=Workingcosts.Q4%>.value 
		};
		
		initAjax.call(params, function (data) {
			var idWorkingCost = data.id;

			var dataRow = [
		        idWorkingCost,
		       	escape(f.wc_resource.value),
		        escape(f.<%=Workingcosts.RESOURCEDEPARTMENT %>.value),
		     	f.wc_effort.value,    
		     	f.wc_real_effort.value,
		     	f.wc_rate.value,		
				f.<%=Workingcosts.Q1%>.value,
				f.<%=Workingcosts.Q2%>.value,
				f.<%=Workingcosts.Q3%>.value,
				f.<%=Workingcosts.Q4%>.value,
				'<img onclick="viewWorkingCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'
    		];
			
			var anSelected = fnGetSelected(workingCostsTable);
			var aPos = workingCostsTable.fnGetPosition(anSelected[0]);
			workingCostsTable.fnUpdate(dataRow, aPos, 0);
			$('#workingcost-popup').dialog('close');
			
		});
	} 
}

function closeWorkingCostDetail() {
	wc_validator.resetForm();
	resetWorkingCost();
	$('#workingcost-popup').dialog('close');
}

readyMethods.add(function() {
	
	//Validate required fields
	wc_validator = $("#frm_workingcost").validate({
		errorContainer: 'div#workingcost-errors',
		errorLabelContainer: 'div#workingcost-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#workingcost_numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {			
			wc_real_effort: "required"
		},
		messages: {			
			wc_real_effort: { required: '${fmtRealEffortRequired}'}
		}
	});
	
	$('#workingcost-popup').dialog({ 
		autoOpen: false, 
		modal: true, 
		width: 500, 
		resizable: false,
		open: function(event, ui) { wc_validator.resetForm(); }
	});
});
//-->
</script>

<div id="workingcost-popup" class="popup">
	<div id="workingcost-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="workingcost_numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	<form name="frm_workingcost" id="frm_workingcost" >
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="wc_id" id="wc_id" />
		<input type="hidden" name="wc_rate" />
		<input type="hidden" name="<%=Workingcosts.Q1%>" />
		<input type="hidden" name="<%=Workingcosts.Q2%>" />
		<input type="hidden" name="<%=Workingcosts.Q3%>" />
		<input type="hidden" name="<%=Workingcosts.Q4%>" />
				
		<fieldset>
			<legend><fmt:message key="direct_cost"/></legend>
			<table width="100%" cellpadding="2" cellspacing="1" align="center">
				<tr>
					<th class="left" width="80%" colspan="4"><fmt:message key="workingcosts.resource" />&nbsp;</th>
					<th class="left" width="20%"><fmt:message key="workingcosts.planned_hours" />&nbsp;</th>
				</tr>
				<tr>
					<td colspan="4"><input type="text" id="wc_resource" name="wc_resource" class="campo" maxlength="50" disabled /></td>
					<td><input type="text" id="wc_effort" name="wc_effort" class="campo" maxlength="5" style="text-align: right;" disabled /></td>
				</tr>
				<tr>
					<th class="left" colspan="4"><fmt:message key="workingcosts.department" /></th>
					<th class="left"><fmt:message key="workingcosts.actual_hours" />&nbsp;*</th>
				</tr>
				<tr>
					<td colspan="4">
						<c:choose>
							<c:when test="<%=ValidateUtil.isNull(Settings.WORKING_COST_DEPARTMENTS[0]) %>">
								<input type="text" id="<%=Workingcosts.RESOURCEDEPARTMENT %>" name="<%=Workingcosts.RESOURCEDEPARTMENT %>" class="campo" maxlength="50" disabled />
							</c:when>
							<c:otherwise>							
								<select id="<%=Workingcosts.RESOURCEDEPARTMENT %>" name="<%=Workingcosts.RESOURCEDEPARTMENT %>" class="campo" disabled>
									<c:forEach var="value" items="<%=Settings.WORKING_COST_DEPARTMENTS %>">
										<option value="${value}">${value }</option>
									</c:forEach>
								</select>
							</c:otherwise>
					</c:choose>
					</td>
					<td><input type="text" name="wc_real_effort" class="campo" maxlength="5" style="text-align: right;" /></td>								
				</tr>				
			</table>
		</fieldset>
		<div class="popButtons">
			<c:if test="${project.status ne status_closed}">
				<input type="submit" class="boton" onclick="saveWorkingCost(); return false;" value="<fmt:message key="update" />" />
			</c:if>
			<a href="javascript:closeWorkingCostDetail();" class="boton" id="btn_closeworkingcost"><fmt:message key="close" /></a>
		</div>
	</form>
</div>
