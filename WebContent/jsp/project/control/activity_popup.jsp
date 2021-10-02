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
 -  Updater : Cédric Ndanga Wandji
 -  Devoteam 09/06/2015 user story 40 : adding new column for the activity initial workload input.
--%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.model.Projectactivity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="error" var="fmt_error" />

<%-- Message for validations --%>
<fmt:message key="msg.error.invalid_format" var="fmtActInitDateFormat">
	<fmt:param><b><fmt:message key="activity.actual_init_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtActEndDateFormat">
	<fmt:param><b><fmt:message key="activity.actual_end_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtActInitDateAfterFinish">
	<fmt:param><b><fmt:message key="activity.actual_init_date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.actual_end_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtActEndDateBeforeStart">
	<fmt:param><b><fmt:message key="activity.actual_end_date"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.actual_init_date"/></b></fmt:param>
</fmt:message>
<script type="text/javascript">
<!--
var validatorActivity;

function saveActivity() {

	if (validatorActivity.form()) {
		var f = document.forms["frm_activity"];

		f.id.value = $('#id').val();
		f.action = "<%=ProjectControlServlet.REFERENCE%>";
		f.accion.value = "<%=ProjectControlServlet.SAVE_ACTIVITY_CONTROL %>";
		loadingPopup();
		f.submit();
	}
}

readyMethods.add(function() {
	$('div#activity-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 500, 
		resizable: false,
		open: function(event, ui) { validatorActivity.resetForm(); }
	});

	var activityActDates = $('#<%=Projectactivity.ACTUALINITDATE %>, #<%=Projectactivity.ACTUALENDDATE %>').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		minDate: $('#proj_iniDate').html(),
		onSelect: function(selectedDate) {
			var option = this.id == "<%=Projectactivity.ACTUALINITDATE %>" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			activityActDates.not(this).datepicker("option", option, date);
			if (validatorActivity.numberOfInvalids() > 0) validatorActivity.form();
		}
	});
	
	//Validate required fields
	validatorActivity = $("#frm_activity").validate({
		errorContainer: 'div#activity-errors',
		errorLabelContainer: 'div#activity-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#activity-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Projectactivity.ACTUALINITDATE %>: { date: true, minDateTo: '#<%=Projectactivity.ACTUALENDDATE %>' },
			<%=Projectactivity.ACTUALENDDATE %>: { date: true, maxDateTo: '#<%=Projectactivity.ACTUALINITDATE %>' }
		},
		messages: {
			<%=Projectactivity.ACTUALINITDATE %>: {
				date: '${fmtActInitDateFormat}',
				minDateTo: '${fmtActInitDateAfterFinish}'
			},
			<%=Projectactivity.ACTUALENDDATE %>: {
				date: '${fmtActEndDateFormat}',
				maxDateTo: '${fmtActEndDateBeforeStart}'
			}
		}
	});
});
//-->
</script>

<div id="activity-popup" class="popup">

	<div id="activity-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="activity-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_activity" id="frm_activity" action="<%=ProjectControlServlet.REFERENCE%>" method="post">
		<input type="hidden" name="id" value="" />
		<input type="hidden" name="activity_id"/>
		<input type="hidden" name="accion" value="" />
		
		<fieldset>
			<legend><fmt:message key="edit_activity" /></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" colspan="4"><fmt:message key="activity.name" /></th>		<!-- cnw us40 changing colspan attribute. Before 3 after 4  -->
				</tr>
				<tr>
					<td colspan="4">															<!-- cnw us40 changing colspan attribute. Before 3 after 4 -->
						<input type="text" name="name" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th width="30%"><fmt:message key="activity.actual_init_date" /></th>
					<th width="30%"><fmt:message key="activity.actual_end_date" /></th>
					<th width="15%"><fmt:message key="activity.init_workload" /></th>			<!-- cnw us40 adding initial workload column label -->
					<th width="25%"><fmt:message key="project.status_date" />&nbsp;</th>
				</tr>
				<tr>
					<td class="center"><input type="text" id="<%=Projectactivity.ACTUALINITDATE %>" name="<%=Projectactivity.ACTUALINITDATE %>" class="campo fecha"/></td>
					<td class="center"><input type="text" id="<%=Projectactivity.ACTUALENDDATE %>" name="<%=Projectactivity.ACTUALENDDATE %>" class="campo fecha"/></td>
					<td class="center"><input type="text" id="" name="" class="campo fecha"></td>		<!-- cnw us40 adding initial workload input -->
					<td class="center <%=Project.STATUSDATE %>"><fmt:formatDate value="${project.statusDate}" pattern="${datePattern}"/></td>
				</tr>
    		</table>
    	</fieldset>
   		<div class="popButtons">
    		<input type="submit" class="boton" onclick="saveActivity(); return false;" value="<fmt:message key="save" />" />
    	</div>
    </form>
</div>
