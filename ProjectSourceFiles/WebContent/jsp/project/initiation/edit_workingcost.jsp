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
<fmt:message key="maintenance.error_msg_a" var="fmtResourceRequired">
	<fmt:param><b><fmt:message key="workingcosts.resource"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtEffortRequired">
	<fmt:param><b><fmt:message key="workingcosts.units"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtRateRequired">
	<fmt:param><b><fmt:message key="workingcosts.unit_rate"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.maximum_allowed" var="fmtRateMax">
	<fmt:param><b><fmt:message key="workingcosts.unit_rate"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var wc_validator;

function viewWorkingCost(element) {
	
	wc_validator.resetForm();
	var workingcost = workingCostsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_workingcost"];

	// Recover workingcost info
	f.wc_id.value			= workingcost[0];
	f.wc_resource.value		= unEscape(workingcost[1]);
	f.<%=Workingcosts.RESOURCEDEPARTMENT %>.value	= unEscape(workingcost[2]);
	f.wc_effort.value 		= workingcost[3];
	f.wc_rate.value 		= workingcost[4];
	f.wc_workcost.value 	= workingcost[5];
	
	f.effort_old.value 		= workingcost[3];
	f.cost_old.value 		= workingcost[5];
	
	f.<%=Workingcosts.Q1%>.value = workingcost[6];
	f.<%=Workingcosts.Q2%>.value = workingcost[7];
	f.<%=Workingcosts.Q3%>.value = workingcost[8];
	f.<%=Workingcosts.Q4%>.value = workingcost[9];
	f.wc_real_effort.value 		= workingcost[10];
	
	$('#btn_saveworkingcost').button("option", "label", '${msg_update}');
	
	$('#workingcost-popup').dialog('open');
}

function deleteWorkingCostConfirmated () {
	$('#dialog-confirm').dialog("close"); 

	var f = document.forms["frm_workingcost"];
	
	var params = {
		accion: "<%=ProjectInitServlet.JX_DELETE_WORKINGCOST%>", 
		id: document.forms["frm_project"].id.value, // Project ID
		wc_id: f.wc_id.value
	};
	
	initAjax.call(params, function (data) {
				
	    var aData = workingCostsTable.fnGetSelectedData();

	    var total = toNumber($('#totalworkingcosts').html());
		var oldCost = toNumber(aData[5]);

	    var newTotal = parseFloat(total) - parseFloat(oldCost);
	    
		$('#totalworkingcosts').html(toCurrency(newTotal));
		
		var totalEffort = toNumber($('#totaleffort').html());
		var oldEffort = toNumber(aData[3]);

		var newTotalEffort = parseFloat(totalEffort) - parseFloat(oldEffort);
		
	    workingCostsTable.fnDeleteSelected();
	    
		$('#totaleffort').html(newTotalEffort);
	});
}

function deleteWorkingCost(element) {
		
	var workingcost = workingCostsTable.fnGetData( element.parentNode.parentNode );
	
	$('#wc_id').val(workingcost[0]);
	
	$('#dialog-confirm-msg').html('${msg_delete_workingcost}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": deleteWorkingCostConfirmated,
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_delete_workingcost}'
	);
	$('#dialog-confirm').dialog('open');
}

function resetWorkingCost() {
	var f = document.forms["frm_workingcost"];
	f.wc_id.value = '';
	f.reset();
}

function newWorkingCost() {
	
	resetWorkingCost();
	wc_validator.resetForm();
	
	$('#btn_saveworkingcost').button("option", "label", '${msg_add}');
	$('#workingcost-popup').dialog('open');
	$('#wc_rate').val(toCurrency('<%=Settings.INTERNAL_COSTS%>'));
	
	var f = document.forms["frm_workingcost"];
	f.effort_old.value = 0;
	f.cost_old.value = 0;
	
	f.wc_resource.focus();
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
			wc_rate: f.wc_rate.value,
			wc_workcost: f.wc_workcost.value,
			<%=Workingcosts.Q1%>: f.<%=Workingcosts.Q1%>.value,
			<%=Workingcosts.Q2%>: f.<%=Workingcosts.Q2%>.value,
			<%=Workingcosts.Q3%>: f.<%=Workingcosts.Q3%>.value,
			<%=Workingcosts.Q4%>: f.<%=Workingcosts.Q4%>.value,
			wc_real_effort: f.wc_real_effort.value == '' ? 0 : f.wc_real_effort.value 
		};
		
		initAjax.call(params, function (data) {
			var idWorkingCost = data.id;

			var dataRow = [
		        idWorkingCost,
		       	escape(f.wc_resource.value),
		        escape(f.<%=Workingcosts.RESOURCEDEPARTMENT %>.value),
		     	f.wc_effort.value, 
		     	f.wc_rate.value, 
		     	f.wc_workcost.value,
		     	f.<%=Workingcosts.Q1%>.value,
		     	f.<%=Workingcosts.Q2%>.value,
		     	f.<%=Workingcosts.Q3%>.value,
		     	f.<%=Workingcosts.Q4%>.value,
		     	f.wc_real_effort.value,
				'<img onclick="viewWorkingCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'+
				'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
				'${deleteWorkingCost}'
    		];
			
			if (wc_id != '') {
				
				var anSelected = fnGetSelected(workingCostsTable);
				var aPos = workingCostsTable.fnGetPosition(anSelected[0]);
				
				workingCostsTable.fnUpdate(dataRow, aPos, 0); 
			}
			else {
				workingCostsTable.fnAddData(dataRow); 
			}
			
			var total = toNumber($('#totalworkingcosts').html());
			total = (total==""?0:total);
			
			var oldCost = toNumber(f.cost_old.value);
			var newCost = toNumber(f.wc_workcost.value);
			
			var newTotal = parseFloat(total) - parseFloat(oldCost) + parseFloat(newCost);

			$('#totalworkingcosts').html(toCurrency(newTotal));
			
			var totalEffort = toNumber($('#totaleffort').html());
			var oldEffort = toNumber(f.effort_old.value);
			var newEffort = toNumber(f.wc_effort.value);
			
			var newTotalEffort = parseFloat(totalEffort == ''?0:totalEffort) - parseFloat(oldEffort) + parseFloat(newEffort);
			
			$('#totaleffort').html(newTotalEffort);
			
			if(f.wc_id.value != "" ) {
				$('#workingcost-popup').dialog('close');
			}
			else {
				resetWorkingCost();
				$('#wc_rate').val(toCurrency('<%=Settings.INTERNAL_COSTS%>'));	
			}	
		});
	} 
}

function closeWorkingCostDetail() {
	wc_validator.resetForm();
	resetWorkingCost();
	$('#workingcost-popup').dialog('close');
}

function updateWorkCost() {
	
	var effort = $("#wc_effort").val();
	var rate = $("#wc_rate").val();
	
	if (!isDecimal(rate)) {
		rate = toNumber($("#wc_rate").val());
	}
	
	var workCost = effort * rate;
	
	$("#wc_workcost").val(toCurrency(workCost));
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
			wc_resource: "required",
			wc_effort: "required", 
			wc_rate: { required: true, maxlength: <%=Constants.MAX_CURRENCY%> }
		},
		messages: {
			wc_resource: { required: '${fmtResourceRequired}'},
			wc_effort: { required: '${fmtEffortRequired}'},
			wc_rate: { required: '${fmtRateRequired}', maxlength:'${fmtRateMax}' }
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
		<input type="hidden" name="cost_old" id="cost_old" value="0" />
		<input type="hidden" name="effort_old" id="effort_old" value="0" />
		<input type="hidden" name="wc_real_effort" value="0" />
		<fieldset>
			<legend><fmt:message key="direct_cost"/></legend>
			<table width="100%" cellpadding="2" cellspacing="1" align="center">
				<tr>
					<th class="left" width="80%" colspan="4"><fmt:message key="workingcosts.resource" />&nbsp;*</th>
					<th class="left" width="20%"><fmt:message key="workingcosts.units" />&nbsp;*</th>
				</tr>
				<tr>
					<td colspan="4"><input type="text" id="wc_resource" name="wc_resource" class="campo" maxlength="50" /></td>
					<td><input type="text" id="wc_effort" name="wc_effort" class="campo" maxlength="5" style="text-align: right;" onblur="updateWorkCost();" /></td>
				</tr>
				<tr>
					<th class="left" colspan="4"><fmt:message key="workingcosts.department" /></th>
					<th class="left"><fmt:message key="workingcosts.unit_rate" />&nbsp;*</th>
				</tr>
				<tr>
					<td colspan="4">
						<c:choose>
							<c:when test="<%=ValidateUtil.isNull(Settings.WORKING_COST_DEPARTMENTS[0]) %>">
								<input type="text" id="<%=Workingcosts.RESOURCEDEPARTMENT %>" name="<%=Workingcosts.RESOURCEDEPARTMENT %>" class="campo" maxlength="50" />
							</c:when>
							<c:otherwise>							
								<select id="<%=Workingcosts.RESOURCEDEPARTMENT %>" name="<%=Workingcosts.RESOURCEDEPARTMENT %>" class="campo">
									<c:forEach var="value" items="<%=Settings.WORKING_COST_DEPARTMENTS %>">
										<option value="${value}">${value }</option>
									</c:forEach>
								</select>
							</c:otherwise>
					</c:choose>
					</td>										
					<td><input type="text" id="wc_rate" name="wc_rate" class="campo importe" style="align:left;" onblur="updateWorkCost();" /></td>
				</tr>
				<tr>
					<c:choose>
						<c:when test="<%=Settings.SHOW_QUARTERS %>">
							<th class="center ${hideQuarters }"><fmt:message key="workingcosts.q1" /></th>
							<th class="center ${hideQuarters }"><fmt:message key="workingcosts.q2" /></th>
							<th class="center ${hideQuarters }"><fmt:message key="workingcosts.q3" /></th>
							<th class="center ${hideQuarters }"><fmt:message key="workingcosts.q4" /></th>
						</c:when>
						<c:otherwise><th colspan="4">&nbsp;</th></c:otherwise>
					</c:choose>
					<th class="left"><fmt:message key="workingcosts.cost" /></th>
				</tr>
				<tr>
					<c:if test="<%=!Settings.SHOW_QUARTERS %>"><c:set var="hideQuarters">hide</c:set></c:if>
					<td class="center">
						<input type="text" name="<%=Workingcosts.Q1 %>" class="campo center ${hideQuarters }" style="width: 45px;" maxlength="6"/>
					</td>
					<td class="center">
						<input type="text" name="<%=Workingcosts.Q2 %>" class="campo center ${hideQuarters }" style="width: 45px;" maxlength="6"/>
					</td>
					<td class="center">
						<input type="text" name="<%=Workingcosts.Q3 %>" class="campo center ${hideQuarters }" style="width: 45px;" maxlength="6"/>
					</td>
					<td class="center">
						<input type="text" name="<%=Workingcosts.Q4 %>" class="campo center ${hideQuarters }" style="width: 45px;" maxlength="6"/>
					</td>
					<td><input type="text" id="wc_workcost" name="wc_workcost" class="campo importe" disabled="" /></td>
				</tr>
			</table>
		</fieldset>
		<div class="popButtons">
			<c:if test="${project.status ne status_closed}">
				<input type="submit" class="boton" id="btn_saveworkingcost" onclick="saveWorkingCost(); return false;" value="<fmt:message key="add" />" />
			</c:if>
			<a href="javascript:closeWorkingCostDetail();" class="boton" id="btn_closeworkingcost"><fmt:message key="close" /></a>
		</div>
	</form>
</div>
