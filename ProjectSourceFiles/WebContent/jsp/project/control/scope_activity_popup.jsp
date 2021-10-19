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
<%@page import="es.sm2.openppm.model.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="error" var="fmt_error" />

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtEVRequired">
	<fmt:param><b><fmt:message key="activity.earned_value"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.max_value" var="fmtEVMax">
	<fmt:param><b><fmt:message key="activity.earned_value"/></b></fmt:param>
	<fmt:param>&nbsp;</fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var validatorScopeActivity;

function saveScopeActivity() {

	if (validatorScopeActivity.form()) {
		
		var f = document.forms["frm_scope_activity"];

		f.id.value = $('#id').val();
		f.action = "<%=ProjectControlServlet.REFERENCE%>";
		f.accion.value = "<%=ProjectControlServlet.SAVE_SCOPE_ACTIVITY_CONTROL %>";
		loadingPopup();
		f.submit();
	}
}

function updatePOC() {
	
	var ev = $("#scope_ev").val();
	var bac = $("#scope_bac").val();
	
	if (!isDecimal(ev)) { ev = toNumber(ev); }
	if (!isDecimal(bac)) { bac = toNumber(bac); }
	
	var poc = (bac == 0?0:(ev / bac) * 100);

	$("#scope_poc").val(toCurrency(poc));
}

function updateEV() {
	
	var poc = $("#scope_poc").val();
	var bac = $("#scope_bac").val();
	
	if (!isDecimal(poc)) { poc = toNumber(poc); }
	if (!isDecimal(bac)) { bac = toNumber(bac); }
	
	var ev = (poc * bac) / 100;
	
	$("#scope_ev").val(toCurrency(ev));
}

function fmtEVMax() {
	return '${fmtEVMax}<b>'+ $("#scope_bac").val() +' </b>';
}

readyMethods.add(function() {
	
	$('div#scope-activity-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 500, 
		minWidth: 500, 
		resizable: false,
		open: function(event, ui) { validatorScopeActivity.resetForm(); }
	});

	//Validate required fields
	validatorScopeActivity = $("#frm_scope_activity").validate({
		errorContainer: 'div#scope-activity-errors',
		errorLabelContainer: 'div#scope-activity-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#scope-activity-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			ev: {
				required: true,
				maxCurrency: function() { return $("#scope_bac").val(); }
			}
		},
		messages: {
			ev: { required: '${fmtEVRequired}', maxCurrency: fmtEVMax }
		}
	});
});
//-->
</script>

<div id="scope-activity-popup" class="popup">

	<div id="scope-activity-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="scope-activity-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_scope_activity" id="frm_scope_activity" action="<%=ProjectControlServlet.REFERENCE%>" method="post">
	
		<input type="hidden" name="id" value="" />
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="activity_id" value="" />
		
		<fieldset>
			<legend><fmt:message key="edit_activity" /></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" colspan="2"><fmt:message key="activity.name" /></th>
					<th class="left"><fmt:message key="project.status_date" /></th>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="name" class="campo" readonly="readonly" /></td>
					<td class="center <%=Project.STATUSDATE %>"><fmt:formatDate value="${project.statusDate}" pattern="${datePattern}"/></td>
				</tr>
				<tr>
					<th class="left" width="40%"><fmt:message key="activity.earned_value" />&nbsp;*</th>
					<th class="left" width="35%"><fmt:message key="percent_complete" /></th>
					<th class="left" width="25%"><fmt:message key="activity.budget" /></th>
				</tr>
				<tr>
					<td>
						<input type="text" name="ev" id="scope_ev" class="campo importe" style="width:90px;" />
						<a href="javascript:updateEV();" class="boton"><fmt:message key="calculate" /></a>
					</td>
					<td>
						<input type="text" name="poc" id="scope_poc" class="campo importe" style="width:60px;" />
						<a href="javascript:updatePOC();" class="boton"><fmt:message key="calculate" /></a>
					</td>
					<td><input type="text" name="bac" id="scope_bac" class="importe" readonly="readonly" style="width:90%;" /></td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<input type="submit" class="boton" onclick="saveScopeActivity(); return false;" value="<fmt:message key="save" />" />
    	</div>
    </form>
</div>
