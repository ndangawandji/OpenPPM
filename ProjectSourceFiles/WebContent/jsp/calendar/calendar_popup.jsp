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

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.CalendarServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="maintenance.error_msg_a" var="fmtNameRequired">
	<fmt:param><b><fmt:message key="calendar.name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtStartRequired">
	<fmt:param><b><fmt:message key="calendar.start"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtFinishRequired">
	<fmt:param><b><fmt:message key="calendar.finish"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtStartDateFormat">
	<fmt:param><b><fmt:message key="calendar.start"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtFinishDateFormat">
	<fmt:param><b><fmt:message key="calendar.finish"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtStartDateAfterFinish">
	<fmt:param><b><fmt:message key="calendar.start"/></b></fmt:param>
	<fmt:param><b><fmt:message key="calendar.finish"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtFinishDateBeforeStart">
	<fmt:param><b><fmt:message key="calendar.finish"/></b></fmt:param>
	<fmt:param><b><fmt:message key="calendar.start"/></b></fmt:param>
</fmt:message>

<fmt:message key="maintenance.error_msg_a" var="msg_error_init_date">
	<fmt:param><fmt:message key="msg.error.valid_date_init"/></fmt:param>
</fmt:message>

<fmt:message key="maintenance.error_msg_a" var="msg_error_end_date">
	<fmt:param><fmt:message key="msg.error.valid_date_end"/></fmt:param>
</fmt:message>

<fmt:message key="maintenance.error_msg_a" var="msg_error_calendar_name">
	<fmt:param><fmt:message key="calendar.name"/></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var validatorCalendar;

function saveDateCalendar() {

	if (validatorCalendar.form()) {

		var f = document.forms["frm_calendar_popup"];
		
		var params = {
			accion: "<%=CalendarServlet.JX_SAVE_CALENDAR_EXCEPTION %>",
			idCalendarBase: $("#idCalendarBase").val(),
			name: f.calendar_name.value,
			startDate: f.calendar_start.value,
			endDate: f.calendar_end.value
		};
		
		calendarAjax.call(params, function(data) {

			exceptionsTable.fnAddDataAndSelect( [
             	        data.idCalendarBaseException,
             	     	data.description,
             	     	data.startDate,
             	     	data.finishDate,
             	     	'<img onclick="deleteException(this, '+data.idCalendarBaseException+')" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">'
             		] );

			$("#calendar-popup").dialog("close");
		});	
	}
}

readyMethods.add(function() {
	$('div#calendar-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 500, 
		minWidth: 500, 
		resizable: false,
		open: function(event, ui) { validatorCalendar.resetForm(); }
	});

	var dates = $('#calendar_start, #calendar_end').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "calendar_start" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
			if (validatorCalendar.numberOfInvalids() > 0) validatorCalendar.form();
		}
	});
	validatorCalendar = $("#frm_calendar_popup").validate({
		errorContainer: 'div#calendar-errors',
		errorLabelContainer: 'div#calendar-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#calendar-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			calendar_name: { required: true },
			calendar_start: { required: true, date: true, minDateTo: '#calendar_end' },
			calendar_end: { required: true, date: true, maxDateTo: '#calendar_start' }
		},
		messages: {
			calendar_name: { required: '${fmtNameRequired}' },
			calendar_start: { required: '${fmtStartRequired}', date: '${fmtStartDateFormat}', minDateTo: '${fmtStartDateAfterFinish}' },
			calendar_end: { required: '${fmtFinishRequired}', date: '${fmtFinishDateFormat}', maxDateTo: '${fmtFinishDateBeforeStart}' }
		}
	});
});
//-->
</script>

<div id="calendar-popup" class="popup">

	<div id="calendar-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="calendar-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_calendar_popup" id="frm_calendar_popup" action="calendar" method="post">
		<fieldset>
			<legend id="legend_calendar"></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="40%"><fmt:message key="calendar.name"/>&nbsp;*</th>
					<th class="left" width="30%"><fmt:message key="calendar.start"/>&nbsp;*</th>
					<th class="left" width="30%"><fmt:message key="calendar.finish"/>&nbsp;*</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="calendar_name" class="campo" />
					</td>
					<td>
						<input type="text" name="calendar_start" id="calendar_start" class="campo fecha" />
					</td>
					<td>
						<input type="text" name="calendar_end" id="calendar_end" class="campo fecha" />
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
			<a href="javascript:saveDateCalendar();" class="boton" id="pop_exception"><fmt:message key="save" /></a>
			<a href="javascript:saveWorkWeek();" class="boton" id="pop_workweek"><fmt:message key="save" /></a>
    	</div>
    </form>
</div>
