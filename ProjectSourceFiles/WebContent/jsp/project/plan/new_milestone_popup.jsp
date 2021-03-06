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
<%@page import="es.sm2.openppm.model.Milestones"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<fmt:message var="msg_milestone_sign" key="milestone.report_type.milestone_sign" />
<fmt:message var="msg_no_report" key="milestone.report_type.no_report" />
<fmt:message key="error" var="fmt_error" />
<fmt:message key="msg.error.date_outside_project" var="fmt_error_range_date" >
	<fmt:param><fmt:message key="milestone"/></fmt:param>
</fmt:message>

<fmt:message key="maintenance.error_msg_a" var="fmtActivityRequired">
	<fmt:param><b><fmt:message key="activity.name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtDueDateRequired">
	<fmt:param><b><fmt:message key="milestone.due_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.info.must_be_digit" var="fmtDaysDigit">
	<fmt:param><b><fmt:message key="milestone.days_before_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtDueDateFormat">
	<fmt:param><b><fmt:message key="milestone.due_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_after_date" var="fmtMilestoneDateAfterFinish">
	<fmt:param><b><fmt:message key="milestone.due_date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_end_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtMilestoneDateBeforeStart">
	<fmt:param><b><fmt:message key="milestone.due_date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_init_date"/></b></fmt:param>
</fmt:message>
<c:if test="${project.status ne status_closed}">
	<c:set var="deleteMilestone"><img onclick="deleteMilestone(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg"></c:set>
</c:if>

<script type="text/javascript">
<!--
var validatorMilestone;
function saveMilestone() {
	var f = document.forms["frm_milestone"];

	if (validatorMilestone.form()) {
		
		f.report_sign.value = ($('#sign').is(':checked')?"Y":"N");
		
		planAjax.call($('#frm_milestone').serialize(),function(data) {
			
			var checked = (data.milestone.report_type=="Y"?"checked":"");
			var checkedNotify = (f.<%=Milestones.NOTIFY%>.checked?"checked":"");
			
			var dataRow = [
			        data.milestone.id,
			        data.activity.id,
			        escape(data.activity.name),
			        escape(data.milestone.description),
			        data.milestone.planned,						        
			        '<input type="checkbox" disabled="disabled" ' + checked + '/>',
			        '<input type="checkbox" disabled="disabled" ' + checkedNotify + '/>',
			        data.milestone.report_type,
			        escape(data.milestone.label),
			        '<img onclick="viewMilestone(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'+
			        '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
			        '${deleteMilestone}',
			        f.<%=Milestones.NOTIFY%>.checked+"",
			        f.<%=Milestones.NOTIFYDAYS%>.value,
			        escape($('#<%=Milestones.NOTIFICATIONTEXT%>').text())
				];
			if (f.milestone_id.value == '') { milestonesTable.fnAddDataAndSelect(dataRow); }
			else { milestonesTable.fnUpdateAndSelect(dataRow); }

			f.reset();
			$('#milestone-popup').dialog('close');
		});
	} 
}

function closeMilestone() {
	$('div#milestone-popup').dialog('close');
}

function updateActivityDates(id) {
	
	var data = (typeof id === 'undefined'?
			activitiesTable.fnFindData($("#milestone_activity").val(),1)
			:activitiesTable.fnFindData(id,1));
	
	if (data != null) {
		$("#planned_date").datepicker("option", "minDate", data[3]);
		$("#planned_date").datepicker("option", "maxDate", data[4]);
		$("#plannedDateMin").val(data[3]);
		$("#plannedDateMax").val(data[4]);
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
	//Validate required fields
	validatorMilestone = $("#frm_milestone").validate({
		errorContainer: 'div#milestone-errors',
		errorLabelContainer: 'div#milestone-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#milestone-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			activity: {required: true },			
			planned_date: { required: true, date: true, minDateTo: '#plannedDateMax', maxDateTo: '#plannedDateMin'},
			<%=Milestones.NOTIFICATIONTEXT %>: { maxlength: 200 },
			<%=Milestones.NOTIFYDAYS %>: { digits: true },
			description: { maxlength: 200 }
		},
		messages: {
			activity: {required: '${fmtActivityRequired}' },		
			planned_date: {
				required: '${fmtDueDateRequired}',
				date: '${fmtDueDateFormat}',
				minDateTo : function() { return '${fmtMilestoneDateAfterFinish} ('+$('#plannedDateMax').val()+')';},
				maxDateTo : function() { return '${fmtMilestoneDateBeforeStart} ('+$('#plannedDateMin').val()+')'; }
			},
			<%=Milestones.NOTIFYDAYS %>: { digits: '${fmtDaysDigit}' }
		}
	});
	
	$("#milestone_activity").bind("change",function() { updateActivityDates($(this).val()); });
	
	$("#<%=Milestones.NOTIFY %>").bind("change",function() {
		if ($(this).is(':checked')) {
			$(".notification").show();
			$("#<%=Milestones.NOTIFYDAYS %>").attr('disabled','');
		}
		else {
			$(".notification").hide();
			$("#<%=Milestones.NOTIFYDAYS %>").attr('disabled','disabled');
		}
	});
});
//-->
</script>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<script type="text/javascript">
	<!--
		readyMethods.add(function() {
			var dates = $('#planned_date').datepicker({
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

</c:if>

<div id="milestone-popup" class="popup">
	
	<div id="milestone-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="milestone-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	
	<form name="frm_milestone" id="frm_milestone" action="<%=ProjectPlanServlet.REFERENCE%>" >
		<input type="hidden" name="accion" value="<%=ProjectPlanServlet.JX_SAVE_MILESTONE%>"/>
		<input type="hidden" name="milestone_id" id="milestone_id"/>
		<input type="hidden" name="report_sign"/>
		<input type="hidden" name="<%=Project.IDPROJECT%>" value="${project.idProject }"/>
		<input type="hidden" id="plannedDateMin"/>
		<input type="hidden" id="plannedDateMax"/>
		
		<input type="hidden" name="label" class="campo" maxlength="30" />
		
		<fieldset>
			<legend><fmt:message key="milestone"/></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>					
					<th class="left" width="60%"><fmt:message key="activity.name"/>&nbsp;*</th>
					<th class="center" width="40%"><fmt:message key="milestone.due_date"/>*</th>
				</tr>
				<tr>					
					<td>
						<select name="activity" id="milestone_activity" class="campo">
							<c:forEach var="activity" items="${activities}">
								<option value="${activity.idActivity}">${tl:escape(activity.activityName)}</option>
							</c:forEach>
						</select>
					</td>
					<td class="center" ><input type="text" name="planned_date" id="planned_date" class="campo fecha" /></td>
				</tr>
				<tr>
					<th class="left">&nbsp;</th>
					<th class="center"><fmt:message key="milestone.show_milestone_sign"/></th>										
				</tr>
				<tr>
					<td>
						<input type="checkbox" name="<%=Milestones.NOTIFY %>" id="<%=Milestones.NOTIFY %>"  style="width: 16px;"/>
						&nbsp;<fmt:message key="milestone.notify"/>&nbsp;
						<input type="text" name="<%=Milestones.NOTIFYDAYS %>" id="<%=Milestones.NOTIFYDAYS %>" value="1" class="campo" style="width: 16px;" maxlength="2"/>
						&nbsp;<fmt:message key="milestone.days_before_date"/>
					</td>
					<td><input type="checkbox" name="report_type" id="sign" /></td>															
				</tr>
				<tr class="notification">
					<th colspan="2" class="left"><fmt:message key="milestone.notification_text"/></th>
				</tr>
				<tr class="notification">
					<td colspan="2">
						<textarea name="<%=Milestones.NOTIFICATIONTEXT %>" id="<%=Milestones.NOTIFICATIONTEXT %>" class="campo" style="width:98%;"></textarea>
					</td>
				</tr>
				<tr>
					<th colspan="2" class="left"><fmt:message key="milestone.desc"/></th>
				</tr>
				<tr>
					<td colspan="2">
						<textarea name="description" id="milestoneDesc" class="campo" style="width:98%;"></textarea>
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<c:if test="${tl:hasPermission(user,project.status,tab)}">
    			<input type="submit" class="boton" onclick="saveMilestone(); return false;" value="<fmt:message key="save" />" />
			</c:if>
			<a href="javascript:closeMilestone();" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
