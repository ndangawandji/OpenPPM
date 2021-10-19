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
<%@page import="es.sm2.openppm.model.Milestones"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<fmt:message var="msg_milestone_sign" key="milestone.report_type.milestone_sign" />
<fmt:message var="msg_no_report" key="milestone.report_type.no_report" />
<fmt:message key="error" var="fmt_error" />

<fmt:message key="msg.error.date_outside_project" var="fmt_error_range_date" >
	<fmt:param><fmt:message key="milestone.achieved"/></fmt:param>
</fmt:message>

<c:if test="${project.status ne status_closed}">
	<c:set var="controlMilestone"><img onclick="return controlMilestone(this);" title="<fmt:message key="edit"/>" class="link" src="images/view.png"></c:set>										
</c:if>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtArchivedDateRequired">
	<fmt:param><b><fmt:message key="milestone.actual_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtArchivedDateFormat">
	<fmt:param><b><fmt:message key="milestone.actual_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_after_date" var="fmtArchivedDateAfterFinish">
	<fmt:param><b><fmt:message key="milestone.actual_date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.actual_end_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtArchivedDateBeforeStart">
	<fmt:param><b><fmt:message key="milestone.actual_date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.actual_init_date"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var validatorMilestone;
function saveMilestone() {
	var f = document.forms["frm_milestone"];

	if (validatorMilestone.form()) {
		var idMilestone = document.forms["frm_milestone"].milestone_id.value;
		
		var params = {
			accion: "<%=ProjectControlServlet.JX_SAVE_MILESTONE %>",
			milestone_id: idMilestone,
			achieved: f.achieved.value,
			<%=Milestones.ACHIEVEDCOMMENTS %>:$("#<%=Milestones.ACHIEVEDCOMMENTS %>").val()
		};
		controlAjax.call(params, function (data) {
			var dataRow = [
				data.id,
				escape(data.activity_name),
				escape(data.description),
				data.planned,
				'<input type="checkbox" disabled="disabled" '+(data.report_type == 'Y'?'checked':'')+'/>',
				data.achieved,
				escape($('#<%=Milestones.ACHIEVEDCOMMENTS %>').val()),
				'${controlMilestone}',
				data.idActivity
					];
			milestonesTable.fnUpdateAndSelect(dataRow);
			
			f.reset();
			$('#milestone-popup').dialog('close');
		});
	} 
}
function updateActivityDates(id) {
	
	var data = activitiesTable.fnFindData(id,0);
	
	if (data != null) {
		var start	= (data[5] == ''?data[3]:data[5]);
		var finish	= (data[6] == ''?data[4]:data[6]);
		
		$("#achieved").datepicker("option", "minDate", start);
		$("#achieved").datepicker("option", "maxDate", finish);
		$("#plannedDateMin").val(start);
		$("#plannedDateMax").val(finish);
	}
	else {
		$("#planned_date").datepicker("option", "minDate", '');
		$("#planned_date").datepicker("option", "maxDate", '');
		$("#plannedDateMin").val('');
		$("#plannedDateMax").val('');
	}
} 
readyMethods.add(function() {
	$('div#milestone-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 550, 
		minWidth: 550, 
		resizable: false,
		open: function(event, ui) { validatorMilestone.resetForm(); }
	});

	validatorMilestone = $("#frm_milestone").validate({
		errorContainer: 'div#milestone-errors',
		errorLabelContainer: 'div#milestone-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#milestone-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			achieved: {required: true, date: true, minDateTo : '#plannedDateMax', maxDateTo : '#plannedDateMin' },
			<%=Milestones.ACHIEVEDCOMMENTS%> : { maxlength: 200 }
		},
		messages: {
			achieved: {
				required: '${fmtArchivedDateRequired}',
				date: '${fmtArchivedDateFormat}',
				minDateTo : function() { return '${fmtArchivedDateAfterFinish} ('+$('#plannedDateMax').val()+')';},
				maxDateTo : function() { return '${fmtArchivedDateBeforeStart} ('+$('#plannedDateMin').val()+')';}
			}
		}
	});

	var dates = $('#achieved').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function() {
			if (validatorMilestone.numberOfInvalids() > 0) validatorMilestone.form();
		}
	});

});
//-->
</script>

<div id="milestone-popup" class="popup">

	<div id="milestone-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="milestone-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_milestone" id="frm_milestone" action="<%=ProjectControlServlet.REFERENCE%>">
		<input type="hidden" id="plannedDateMin"/>
		<input type="hidden" id="plannedDateMax"/>
		<input type="hidden" name="milestone_id" />
		
		<fieldset>
			<legend><fmt:message key="milestone"/></legend>
		
			<table border="0" cellpadding="2" cellspacing="0" width="100%">
				<tr>
					<th class="left" width="25%"><fmt:message key="milestone"/></th>
					<th class="left" width="35%"><fmt:message key="activity.name"/></th>
					<th class="left" width="15%"><fmt:message key="milestone.due_date"/></th>
					<th class="left" width="25%"><fmt:message key="milestone.actual_date"/>&nbsp;*</th>
				</tr>
				<tr>
					<td><input type="text" name="milestone_desc" readonly="readonly" /></td>
					<td><input type="text" name="activity" readonly="readonly" /></td>
					<td><input type="text" name="dueDate" readonly="readonly" /></td>
					<td><input type="text" name="achieved" id="achieved" class="campo fecha" /></td>
				</tr>
				<tr>
					<th class="left" colspan="4"><fmt:message key="milestone.achievement_comments"/></th>
				</tr>
				<tr>
					<td colspan="4">
						<textarea name="<%=Milestones.ACHIEVEDCOMMENTS %>" id="<%=Milestones.ACHIEVEDCOMMENTS %>" style="width: 100%" class="campo"></textarea>
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<input type="submit" class="boton" onclick="saveMilestone(); return false;" value="<fmt:message key="save" />" />
    	</div>
    </form>
</div>
