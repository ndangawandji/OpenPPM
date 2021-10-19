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

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="select_opt" var="msg_select_opt" />
<fmt:message key="change.priority.low" var="low" />
<fmt:message key="change.priority.normal" var="normal" />
<fmt:message key="change.priority.high" var="high" />
<fmt:message key="error" var="fmt_error" />

<%-- 
Request Attributes:
	changeTypes:	Change types List
--%>
		
<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtTypeRequired">
	<fmt:param><b><fmt:message key="change.change_type"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtPriorityRequired">
	<fmt:param><b><fmt:message key="change.priority"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtValidDateRequired">
	<fmt:param><b><fmt:message key="date"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtDescRequired">
	<fmt:param><b><fmt:message key="desc"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtWBSRequired">
	<fmt:param><b><fmt:message key="wbs_node"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtEffortRequired">
	<fmt:param><b><fmt:message key="change.estimated_effort"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtCostRequired">
	<fmt:param><b><fmt:message key="change.estimated_cost"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtResolutionRequired">
	<fmt:param><b><fmt:message key="change.resolution"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtValidDateFormat">
	<fmt:param><b><fmt:message key="date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtResolutionDateFormat">
	<fmt:param><b><fmt:message key="change.resolution_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var changeValidator;
var analyzeRequired = false;
var resolveRequired = false;

function showAnalyzeInputs() {
	$('.analyzed_inputs').show();
	analyzeRequired = true;
	return false;
}

function showResolutionInputs() {
	$('.resolution_inputs').show();
	resolveRequired = true;
	return false;
}

function analyzeChangeRequest() {
	showAnalyzeInputs();
	
	$('#btn_analyze').hide();
	return false;
}

function resolveChangeRequest() {
	showResolutionInputs();

	$('#btn_resolve').hide();
	return false;
}

function resetChangeRequest() {
	document.forms["frm_change"].reset();
	document.forms["frm_change"].change_id.value = '';
	$('.analyzed_inputs').hide();
	$('#btn_analyze').hide();
	$('.resolution_inputs').hide();
	$('#btn_resolve').hide();
	$('#originator').show();
	analyzeRequired = false;
	resolveRequired = false;
	return false;
}

function saveChangeRequest() {
	
	//Validate required fields
	if (changeValidator.form()) {
		var f = document.forms["frm_change"];

		if (resolveRequired) {
			// Resolution change refresh page
			f.action.value = '<%=ProjectControlServlet.REFERENCE%>';
			f.accion.value = "<%=ProjectControlServlet.SAVE_REQUEST_CHANGE %>";
			f.id.value = document.forms["frm_project"].id.value;
			f.change_id.value = f.change_id.value;
			f.cost.value = f.cost.value;

			f.submit();
		}
		else {

			controlAjax.call({
					accion: "<%=ProjectControlServlet.JX_SAVE_REQUEST_CHANGE %>",
					id: document.forms["frm_project"].id.value,
					change_id: f.change_id.value,
					type: f.type.value,
					priority: f.priority.value,
					date: f.date.value,
					desc: f.desc.value,
					solution: f.solution.value,
					originator: f.originator.value,
					wbsnode: f.wbsnode.value,
					effort: f.effort.value,
					cost: f.cost.value,
					impact: f.impact.value,
					resolution: $("input[name='resolution']:checked").val(),
					resolution_date: f.resolution_date.value,
					resolution_reason: f.resolution_reason.value
				}, function (data) {
						
					var dataRow = [
			               	data.id,
			               	(data.wbsnode==''?'<fmt:message key="change.open"/>':'<fmt:message key="analyze"/>'),
   					        escape(data.desc),
   					        (data.priority == 'H' ? '${high}' : (data.priority == 'L' ? '${low}' : '${normal}')),
   					        data.priority,
   					        data.date,
   					        escape(data.originator),
   					        escape(data.type_desc),
   					        data.type,
   					        escape(data.solution),
   					        data.wbsnode,
   					        (typeof data.effort === 'undefined'?'':data.effort),
   					        toCurrency(data.cost),
   					        escape(data.impact),
   					        data.resolution,
   					        data.resolution_date,
   					        escape(data.resolution_reason),
   					        '<img src="images/ico_pdf.gif" class="link" onclick="toChangePDF(' +data.id+ ');" />'+
   					        '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
   					        '<img onclick="editChangeRequestStatus(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'
       					];

					if (f.change_id.value == data.id) { changeRequestTable.fnUpdateAndSelect(dataRow); }
					else { changeRequestTable.fnAddDataAndSelect(dataRow); }
					
				    resetChangeRequest();
					
					$('#change-popup').dialog('close');
			});
		}
	}
}

function closeChangeRequest() {
	$('div#change-popup').dialog('close');
}
readyMethods.add(function() {
	$('div#change-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 600,
		resizable: false,
		open: function(event, ui) { changeValidator.resetForm(); }
	});

	resetChangeRequest();
	
	$('select#sel_originator').change(function(){
		var f = document.forms["frm_change"];
		if (this.value == -1) {
			$("#originator").show();
			$("#originator").attr('value','');
		}
		else {
			$("#originator").hide();
			$("#originator").attr('value', this.value);
		}
	});

	changeValidator = $("#frm_change").validate({
		errorContainer: 'div#change-errors',
		errorLabelContainer: 'div#change-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#change-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			type: {"required": true},
			priority: {"required": true},
			date: { required: true, date: true },
			desc: { required: true, maxlength:500 },
			wbsnode: {"analyzeRequired": true},
			effort: {"analyzeRequired": true, min: 0},
			cost: {"analyzeRequired": true},
			resolution: {"resolveRequired": true},
			resolution_reason: { maxlength:500 },
			impact: { maxlength:500 },
			solution: { maxlength:500 },
			resolution_date: { date: true }
		},
		messages: {
			type: { required: '${fmtTypeRequired}' },
			priority: { required: '${fmtPriorityRequired}' },
			date: {
				required: '${fmtValidDateRequired}',
				date: '${fmtValidDateFormat}'
			},
			desc: { required: '${fmtDescRequired}' },
			wbsnode: {"analyzeRequired": '${fmtWBSRequired}'},
			effort: {"analyzeRequired": '${fmtEffortRequired}' },
			cost: {"analyzeRequired": '${fmtCostRequired}'},
			resolution: {"resolveRequired": '${fmtResolutionRequired}'},
			resolution_date: { date: '${fmtResolutionDateFormat}' }
		}
	});

	$.validator.addMethod("analyzeRequired", function(value, element) {
		if (analyzeRequired) {
			return !this.optional(element);
		}
		return true;
	});

	$.validator.addMethod("resolveRequired", function(value, element) {
		if (resolveRequired) {
			return !this.optional(element);
		}
		return true;
	});

});
//-->
</script>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<script type="text/javascript">
	<!--
		readyMethods.add(function() {
			$('#change_request_date').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function() {
					if (changeValidator.numberOfInvalids() > 0) changeValidator.form();
				}
			});

			$('#resolution_date').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function() {
					if (changeValidator.numberOfInvalids() > 0) changeValidator.form();
				}
			});			
		});
	//-->
	</script>
</c:if>

<div id="change-popup" class="popup">
	<div id="change-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="change-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	<form name="frm_change" id="frm_change" action="<%=ProjectControlServlet.REFERENCE%>" method="post">
		<input type="hidden" name="id" />
		<input type="hidden" name="change_id" />
		<input type="hidden" name="accion" />
		<fieldset>
			<legend><fmt:message key="create_change_request" /></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="45%"><fmt:message key="change.change_type" />&nbsp;*</th>
					<th class="left" width="25%"><fmt:message key="change.priority" />&nbsp;*</th>
					<th class="left" width="30%"><fmt:message key="change.date" />&nbsp;*</th>
				</tr>
				<tr>
					<td>
						<select name="type" class="campo">
							<option value='' selected><fmt:message key="select_opt"/></option>
							<c:forEach var="type" items="${changeTypes}">
								<option value="${type.idChangeType}">${type.description}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<select name="priority" class="campo">
							<option value="H"><fmt:message key="change.priority.high"/></option>
							<option value="N" selected><fmt:message key="change.priority.normal"/></option>
							<option value="L"><fmt:message key="change.priority.low"/></option>
						</select>
					</td>
					<td><input type="text" id="change_request_date" name="date" class="campo fecha" /></td>
				</tr>
				<tr>
					<th class="left" colspan="3"><fmt:message key="change.desc"/>&nbsp;*</th>
				</tr>
				<tr>
					<td colspan="3">
						<textarea name="desc" class="campo" style="width: 100%;" rows="5"></textarea>
					</td>
				</tr>
				<tr>
					<th class="left" colspan="3"><fmt:message key="change.recommended_solution"/></th>
				</tr>
				<tr>
					<td colspan="3">
						<textarea name="solution" class="campo" style="width: 100%;" rows="5"></textarea>
					</td>
				</tr>
				<tr>
					<th class="left" colspan="3"><fmt:message key="change.originator"/></th>
				</tr>
				<tr>
					<td>
						<select class="campo" id="sel_originator">
							<option value='-1'><fmt:message key="other"/></option>
							<c:forEach var="stk" items="${project.stakeholders}">
								<option value="${stk.contactName}">${stk.contactName}</option>
							</c:forEach>
						</select>
					</td>
					<td colspan="2">
						<input type="text" name="originator" id="originator" class="campo" maxlength="50" />
					</td>
				</tr>
				<tr class="analyzed_inputs">
					<th class="left"><fmt:message key="wbs.ca_long"/>&nbsp;*</th>
					<th class="left"><fmt:message key="change.estimated_effort"/>&nbsp;*</th>
					<th class="left"><fmt:message key="change.estimated_cost"/>&nbsp;*</th>
				</tr>
				<tr class="analyzed_inputs">
					<td>
						<select name="wbsnode" id="wbsnode" class="campo">
							<option value='' selected><fmt:message key="select_opt"/></option>
							<c:forEach var="node" items="${wbsnodes}">
								<option value="${node.idWbsnode}">${node.name}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<input type="text" name="effort" id="effort" class="campo" />
					</td>
					<td>
						<input type="text" name="cost" id="cost" class="campo importe" />
					</td>
				</tr>
				<tr class="analyzed_inputs">
					<th colspan="3" class="left"><fmt:message key="change.impact_desc"/></th>
				</tr>
				<tr class="analyzed_inputs">
					<td colspan="3">
						<textarea name="impact" class="campo" style="width: 100%;" rows="5"></textarea>
					</td>
				</tr>
				<tr class="resolution_inputs">
					<th class="left"><fmt:message key="change.resolution"/>&nbsp;*</th>
					<th colspan="2" class="left"><fmt:message key="change.resolution_date"/>&nbsp;*</th>
				</tr>
				<tr class="resolution_inputs">
					<td>
						<input type="radio" name="resolution" value="Y" style="width:20px" /><fmt:message key="yes" />&nbsp;&nbsp;
						<input type="radio" name="resolution" value="N" style="width:20px" /><fmt:message key="no" />
					</td>
					<td colspan="2">
						<input type="text" name="resolution_date" id="resolution_date" class="campo fecha" />
					</td>
				</tr>
				<tr class="resolution_inputs">
					<th colspan="3" class="left"><fmt:message key="comments"/></th>
				</tr>
				<tr class="resolution_inputs">
					<td colspan="3">
						<textarea name="resolution_reason" class="campo" style="width: 100%;" rows="5"></textarea>
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
			<c:if test="${tl:hasPermission(user,project.status,tab)}">
				<span id="btn_analyze"><a href="#" class="boton" onClick="return analyzeChangeRequest();"><fmt:message key="analyze" /></a></span>
				<span id="btn_resolve"><a href="#" class="boton" onClick="return resolveChangeRequest();"><fmt:message key="change.solve" /></a></span>
				<input type="submit" class="boton" onclick="saveChangeRequest(); return false;" value="<fmt:message key="save" />" />
			</c:if>
			<a href="javascript:closeChangeRequest();" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
