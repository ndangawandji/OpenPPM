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
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<fmt:message key="error" var="fmt_error" />

<c:if test="${project.status ne status_closed}">
	<c:set var="editFollowup"><img onclick="editFollowup(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png"></c:set>
	<c:set var="deleteFollowup"><img onclick="deleteFollowup(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg"></c:set>
</c:if>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtFollowupDateRequired">
	<fmt:param><b><fmt:message key="followup.date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtFollowupDateFormat">
	<fmt:param><b><fmt:message key="followup.date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_after_date" var="fmtFollowupDateAfterFinish">
	<fmt:param><b><fmt:message key="followup.date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_end_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtFollowupDateBeforeStart">
	<fmt:param><b><fmt:message key="followup.date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_init_date"/></b></fmt:param>
</fmt:message>
<script type="text/javascript">
<!--
var followupValidator;

function saveFollowup() {

	if (followupValidator.form()) {

		var f = document.frm_followup;
		
		var params = {
			accion: "<%=ProjectPlanServlet.JX_SAVE_FOLLOWUP%>",
			id: document.forms["frm_project"].id.value,
			followup_id: f.followup_id.value,
			date: f.date.value,
			pv: f.pv.value
		};
		
		planAjax.call(params,  function (data) {
					
			var dataRow = [
		        data.id,
		        data.date,
		        data.daysToDate,
		        toCurrency(data.pv),
				'${editFollowup}'+
				'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
				'${deleteFollowup}'
			];
			
			if (f.followup_id.value != data.id) { followupsTable.fnAddDataAndSelect(dataRow); }
			else { followupsTable.fnUpdateAndSelect(dataRow); }

			f.reset();
			$('#followup-popup').dialog('close');
		});
	} 
}

readyMethods.add(function() {
	$('div#followup-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 450, 
		resizable: false,
		open: function(event, ui) { followupValidator.resetForm(); }
	});

	followupValidator = $("#frm_followup").validate({
		errorContainer: 'div#followup-errors',
		errorLabelContainer: 'div#followup-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#followup-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			date: { required: true, date: true, minDateTo: '#valPlanEndDate', maxDateTo: '#valPlanInitDate' }
		},
		messages: {
			date: {
				required: '${fmtFollowupDateRequired}',
				date: '${fmtFollowupDateFormat}',
				minDateTo: '${fmtFollowupDateAfterFinish} ('+$('#valPlanEndDate').val()+')',
				maxDateTo: '${fmtFollowupDateBeforeStart} ('+$('#valPlanInitDate').val()+')'
			}
		}
	});
	
	var dates = $('#followup_date').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function() {
			if (followupValidator.numberOfInvalids() > 0) followupValidator.form();
		}
	});
});
//-->
</script>

<div id="followup-popup" class="popup">

	<div id="followup-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="followup-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_followup" id="frm_followup" action="<%=ProjectPlanServlet.REFERENCE%>">
		<input type="hidden" name="followup_id" />
		<fieldset>
			<legend><fmt:message key="planned_value"/></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="33%"><fmt:message key="followup.date"/>&nbsp;*</th>
					<th class="left" width="33%"><fmt:message key="planned_value.days_date"/></th>
					<th class="left" width="34%"><fmt:message key="planned_value.value"/></th>
				</tr>
				<tr>
					<td>
						<input type="text" name="date" id="followup_date" class="campo fecha" />
					</td>
					<td>
						<input type="text" name="daysToDate" readonly="readonly" />
					</td>
					<td>
						<input type="text" name="pv" id="followup_pv" class="campo importe" />
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<input type="submit" class="boton" onclick="saveFollowup(); return false;" value="<fmt:message key="save" />" />
    	</div>
    </form>
</div>
