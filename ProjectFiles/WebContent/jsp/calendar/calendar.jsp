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
<%@page import="es.sm2.openppm.common.Constants"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.servlets.CalendarServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="calendar.new_exception" var="newException"></fmt:message>

<fmt:message key="maintenance.error_msg_a" var="error_msg_new_calendar_name">
	<fmt:param><fmt:message key="maintenance.calendar_base.name"/></fmt:param>
</fmt:message>

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_exception">
	<fmt:param><fmt:message key="calendar.calendar_exception"/></fmt:param>
</fmt:message>

<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_exception">
	<fmt:param><fmt:message key="calendar.calendar_exception"/></fmt:param>
</fmt:message>

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_workweek">
	<fmt:param><fmt:message key="calendar.work_weeks"/></fmt:param>
</fmt:message>

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_calendar">
	<fmt:param><fmt:message key="maintenance.calendar_base"/></fmt:param>
</fmt:message>

<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_calendar">
	<fmt:param><fmt:message key="maintenance.calendar_base"/></fmt:param>
</fmt:message>

<fmt:message key="maintenance.calendar_base.new" var="new_calendar" />
<fmt:message key="maintenance.calendar_base.edit" var="edit_calendar" />
<fmt:message key="error" var="fmt_error" />
<fmt:message key="msg.info" var="fmt_information" />
<fmt:message key="msg.saved.calendar_base" var="fmt_saved" />
<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message key="msg.error.select_base_calendar" var="fmt_calendar_base"/>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtNameRequired">
	<fmt:param><b><fmt:message key="maintenance.calendar_base.name"/></b></fmt:param>
</fmt:message>

<c:set var="fromurlattribute" value="" />

<script type="text/javascript">

var validatorNewCalendar;
var exceptionsTable;
var calendarAjax = new AjaxCall('<%=CalendarServlet.REFERENCE%>','<fmt:message key="error"/>');

function newException() {

	if ($("#idCalendarBase").val() > 0){
		f = document.forms["frm_calendar_popup"];
		f.reset();

		$('#calendar_start').datepicker("option","maxDate", "");
		$('#calendar_end').datepicker("option","minDate", "");
		
		$("#legend_calendar").html("${newException}");
		$("#pop_exception").show();
		$("#pop_workweek").hide();
		$("#calendar-popup").dialog('open');
	}
	else {
		alertUI("${fmt_error}","${fmt_calendar_base}");
	}
	return false;
}

function newCalendarBase() {

	f = document.forms["frm_new_calendar_popup"];
	f.reset();
	$("#legend_calendar_popup").html("${new_calendar }");
	
	$("#new-calendar-popup").dialog('open');
	
	return false;
}

function deleteCalendarBase() {

	if ($("#idCalendarBase").val() != -1) {
		$('#dialog-confirm-msg').html('${msg_confirm_delete_calendar}');
		$('#dialog-confirm').dialog(
				'option', 
				'buttons', 
				{
					"${msg_yes}": function() {
						deleteCalendarConfirmated();
					},
					"${msg_no}": function() { 
						$('#dialog-confirm').dialog("close"); 
					}
				}
		);
		
		$('#dialog-confirm').dialog(
				'option',
				'title',
				'${msg_title_confirm_delete_calendar}'
		);
		$('#dialog-confirm').dialog('open');
	}
	return false;
}

function deleteCalendarConfirmated() {
	
	$('#dialog-confirm').dialog("close"); 
	
	var f = document.forms["frm_calendar"];
	f.accion.value = "<%=CalendarServlet.DEL_CALENDAR_BASE %>";
	f.idManten.value = $('select#idManten').val();
	f.submit();
	
	return false;
}

function saveNewCalendarBase() {

	if (validatorNewCalendar.form()) {
		var f = document.forms["frm_new_calendar_popup"];
		f.action = "<%=CalendarServlet.REFERENCE%>";
		f.accion.value =  "<%=CalendarServlet.CREATE_CALENDAR %>",
		f.submit();		
	}
}

function saveCalendarBase() {

	if ($("#idCalendarBase").val() != -1) {
		var f = document.forms["frm_calendar"];
		
		var params = {
			accion: "<%=CalendarServlet.JX_SAVE_CALENDAR %>",
			idCalendarBase: f.idCalendarBase.value,
			name: f.calendar_name.value,
			weekStart: f.week_starts.value,
			fiscalYearStart: f.fiscal_starts.value,
			startTime1: f.start_time_1.value,
			startTime2: f.start_time_2.value,
			endTime1: f.end_time_1.value,
			endTime2: f.end_time_2.value,
			hoursDay: f.hours_day.value,
			hoursWeek: f.hours_week.value,
			daysMonth: f.days_month.value
		};
		
		calendarAjax.call(params, function(data) {
			$("#idCalendarBase option[value=" + f.idCalendarBase.value + "]").text(f.calendar_name.value);
			$("#template_calendar option[value=" + f.idCalendarBase.value + "]").text(f.calendar_name.value);
			informationSuccess("${fmt_saved}");
		});
	}
	return false;
}

function loadInfo(data) {
	
	var f = document.forms["frm_calendar"];
	f.week_starts.value = (data.weekStart != null ? data.weekStart : -1);
	f.fiscal_starts.value = (data.fiscalYearStart != null ? data.fiscalYearStart : -1);
	f.start_time_1.value = (data.startTime1 != null ? data.startTime1 : -1);
	f.start_time_2.value = (data.startTime2 != null ? data.startTime2 : -1);
	f.end_time_1.value = (data.endTime1 != null ? data.endTime1 : -1);
	f.end_time_2.value = (data.endTime2 != null ? data.endTime2 : -1);
	f.hours_day.value = (data.hoursDay != null ? data.hoursDay : -1);
	f.hours_week.value = (data.hoursWeek != null ? data.hoursWeek : -1);
	f.days_month.value = (data.daysMonth != null ? data.daysMonth : -1);
	f.calendar_name.value = data.name;
	exceptionsTable.fnClearTable();
	
	for (var i = 0; i < data.calendarbaseexceptionses.length; i++) {

		info = data.calendarbaseexceptionses[i];
		
		exceptionsTable.fnAddData( [
	        info.idCalendarBaseException,
	        info.description,
	        info.startDate,
	        info.finishDate,
	        '<img onclick="deleteException(this, '+info.idCalendarBaseException+')" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">'
		] );
		
	}
}

function deleteException(element, id) {

     var parent = element.parentNode.parentNode;
     aPos = exceptionsTable.fnGetPosition( parent );
     
	$('#dialog-confirm-msg').html('${msg_confirm_delete_exception}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": function() {
					deleteExceptionConfirmated(aPos, id);
				},
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_confirm_delete_exception}'
	);
	$('#dialog-confirm').dialog('open');
	return false;
}

function deleteExceptionConfirmated(aPos, id) {
	
	var params = {
		accion: "<%=CalendarServlet.JX_DELETE_CALENDAR_EXCEPTION %>",
		idCalendarBaseException: id
	};
	
	calendarAjax.call(params, function(data) {
		exceptionsTable.fnDeleteRow(aPos);
		$('#dialog-confirm').dialog("close");
	});
	
	return false;
}

// When document is ready
readyMethods.add(function() {

	var date = $('#calendarDate').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		changeMonth: true
	});

	exceptionsTable = $('#tb_exceptions').dataTable({
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"iDisplayLength": 50,
		"bInfo": false,
		"aoColumns": [
             { "bVisible": false }, 
             { "sClass": "left", "sWidth": "50%" }, 
             { "sClass": "center", "sWidth": "22%", "sType": "es_date" },
             { "sClass": "center", "sWidth": "22%", "sType": "es_date" },
             { "sClass": "center", "sWidth": "6%", "bSortable": false }
     	]
	});
	
	$('div#new-calendar-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 500, 
		minWidth: 500, 
		resizable: false,
		open: function(event, ui) { validatorNewCalendar.resetForm(); }
	});

	validatorNewCalendar = $("#frm_new_calendar_popup").validate({
		errorContainer: 'div#new-calendar-errors',
		errorLabelContainer: 'div#new-calendar-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#new-calendar-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			new_calendar_name: { required: true }
		},
		messages: {
			new_calendar_name: { required: '${fmtNameRequired}' }
		}
	});

	$("#idCalendarBase").change(function () {

		if ($("#idCalendarBase").val() > 0) {
			
			var params = {
				accion: "<%=CalendarServlet.JX_GET_CALENDAR %>",
				idCalendarBase: $("#idCalendarBase").val()
			};
			
			calendarAjax.call(params, function(data) {
				loadInfo(data);
			});	
		}
		else {
			exceptionsTable.fnClearTable();
			
			var f = document.forms["frm_calendar"];
			f.week_starts.value = -1;
			f.fiscal_starts.value = -1;
			f.start_time_1.value = -1;
			f.start_time_2.value = -1;
			f.end_time_1.value = -1;
			f.end_time_2.value = -1;
			f.hours_day.value = -1;
			f.hours_week.value = -1;
			f.days_month.value = -1;
			f.calendar_name.value = "";
		}
	});
});
//-->
</script>

<c:if test="${calendarId ne null }">
<script>
readyMethods.add(function() { $("#idCalendarBase").trigger('change'); });
</script>
</c:if>

<form name="frm_calendar" id="frm_calendar" action="<%=CalendarServlet.REFERENCE%>" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="idManten" value="" />
	<fieldset>
		<table id="tb_calendar" width="100%" cellpadding="3" cellspacing="2">
			<tr>
				<td width="17%"></td>
				<td width="16%"></td>
				<td width="17%"></td>
				<td width="16%"></td>
				<td width="17%"></td>
				<td width="17%"></td>
			</tr>
			<tr>
			   	<th colspan="2"><fmt:message key="calendar"></fmt:message></th>
			   	<td rowspan="6" colspan="4">
			   		<table width="100%" cellpadding="3" cellspacing="2">
			   			<tr>
			   				<td align="center">
			   					<div id="calendarDate"></div>
			   				</td>
			   				<td>
			   					<table width="100%" cellpadding="3" cellspacing="2">
			   						<tr>
			   							<td width="20%"><div class="workDay"></div></td>
			   							<td width="80%"><fmt:message key="calendar.working"></fmt:message></td>
			   						</tr>
			   						<tr>
			   							<td><div class="notWorkDay"></div></td>
			   							<td><fmt:message key="calendar.non_working"></fmt:message></td>
		   							</tr>
			   						<tr>
			   							<td><div class="exceptionDay"></div></td>
			   							<td><fmt:message key="calendar.exception_day"></fmt:message></td>
			   						</tr>
			   						<tr>
			   							<td><div class="nonWorkingDay"></div></td>
			   							<td><fmt:message key="calendar.non_default_work_week"></fmt:message></td>
			   						</tr>
			   					</table>
			   				</td>
			   			</tr>
			   		</table>
			   	</td>
			</tr>
			<tr>
				<td colspan="2">
					<select class="campo" name="idCalendarBase" id="idCalendarBase">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="calendarBase" items="${listCalendars }">							
							<option value="${calendarBase.idCalendarBase }" 
								<c:if test="${calendarBase.idCalendarBase eq calendarId }">selected</c:if>
							>${calendarBase.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="#" class="boton" onClick="return newCalendarBase();"><fmt:message key="new" /></a>
					<a href="#" class="boton" onClick="return deleteCalendarBase();"><fmt:message key="delete" /></a>
				</td>
			</tr>
			<tr>
				<th class="name_calendar"><fmt:message key="maintenance.calendar_base.name"/></th>
				<td class="name_calendar">
					<input type="text" name="calendar_name" class="campo" value="${calendarName}">
				</td>
			</tr>
			<tr>
				<th><fmt:message key="calendar.week_starts"></fmt:message></th>
				<td>
					<select style class="campo" name="week_starts" id="week_starts">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<option value="1"><fmt:message key="week.monday"></fmt:message></option>
						<option value="2"><fmt:message key="week.tuesday"></fmt:message></option>
						<option value="3"><fmt:message key="week.wednesday"></fmt:message></option>
						<option value="4"><fmt:message key="week.thursday"></fmt:message></option>
						<option value="5"><fmt:message key="week.friday"></fmt:message></option>
						<option value="6"><fmt:message key="week.saturday"></fmt:message></option>
						<option value="7"><fmt:message key="week.sunday"></fmt:message></option>
					</select>
				</td>
			</tr>
			<tr>
				<th><fmt:message key="calendar.fiscal_start"></fmt:message></th>
				<td>
					<select style class="campo" name="fiscal_starts" id="fiscal_starts">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="increment" begin="1" end="12" step="1">
							<option value="${increment }"><fmt:message key="month.month_${increment }"></fmt:message></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><fmt:message key="calendar.default_start_time"></fmt:message></th>
				<td>
					<select style class="campo" name="start_time_1" id="start_time_1">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="iHour" begin="0" end="23" step="1">
							<c:choose>
								<c:when test="${iHour < 10}">
									<option value="${iHour }">0${iHour }:00</option>
									<option value="${iHour }.5">0${iHour }:30</option>
								</c:when>
								<c:otherwise>
									<option value="${iHour }">${iHour }:00</option>
									<option value="${iHour }.5">${iHour }:30</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<th><fmt:message key="calendar.default_start_time"></fmt:message></th>
				<td>
					<select style class="campo" name="start_time_2" id="start_time_2">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="iHour" begin="0" end="23" step="1">
							<c:choose>
								<c:when test="${iHour < 10}">
									<option value="${iHour }">0${iHour }:00</option>
									<option value="${iHour }.5">0${iHour }:30</option>
								</c:when>
								<c:otherwise>
									<option value="${iHour }">${iHour }:00</option>
									<option value="${iHour }.5">${iHour }:30</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<th><fmt:message key="calendar.hours_per_day"></fmt:message></th>
				<td>
					<select style class="campo" name="hours_day" id="hours_day">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="iHours" begin="1" end="16" step="1">
							<option value="${iHours }">${iHours },0 <fmt:message key="hour_min" /></option>
							<option value="${iHours }.5">${iHours },5 <fmt:message key="hour_min" /></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><fmt:message key="calendar.default_end_time"></fmt:message></th>
				<td>
					<select style class="campo" name="end_time_1" id="end_time_1">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="iHour" begin="0" end="23" step="1">
							<c:choose>
								<c:when test="${iHour < 10}">
									<option value="${iHour }">0${iHour }:00</option>
									<option value="${iHour }.5">0${iHour }:30</option>
								</c:when>
								<c:otherwise>
									<option value="${iHour }">${iHour }:00</option>
									<option value="${iHour }.5">${iHour }:30</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<th><fmt:message key="calendar.default_end_time"></fmt:message></th>
				<td>
					<select style class="campo" name="end_time_2" id="end_time_2">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						
						<c:forEach var="iHour" begin="0" end="23" step="1">
							<c:choose>
								<c:when test="${iHour < 10}">
									<option value="${iHour }">0${iHour }:00</option>
									<option value="${iHour }.5">0${iHour }:30</option>
								</c:when>
								<c:otherwise>
									<option value="${iHour }">${iHour }:00</option>
									<option value="${iHour }.5">${iHour }:30</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<th><fmt:message key="calendar.hours_per_week"></fmt:message></th>
				<td>
					<select style class="campo" name="hours_week" id="hours_week">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="hour" begin="1" end="40" step="1">
							<option value="${hour }">${hour },0 <fmt:message key="hour_min" /></option>
							<option value="${hour }.5">${hour },5 <fmt:message key="hour_min" /></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
				<th><fmt:message key="calendar.days_per_month"></fmt:message></th>
				<td>
					<select style class="campo" name="days_month" id="days_month">
						<option value="-1"><fmt:message key="select_opt"></fmt:message></option>
						<c:forEach var="day" begin="1" end="31" step="1">
							<option value="${day }">${day } <fmt:message key="week.day_min" /></option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<div style="">&nbsp;</div>	
		<fieldset>
			<legend class="link" onclick="changeCookie('fieldCalendarBaseException')"><fmt:message key="calendar.exceptions"/></legend>
			<div class="buttons">
				<img id="fieldCalendarBaseExceptionBtn" onclick="changeCookie('fieldCalendarBaseException', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldCalendarBaseException" class="hide" style="padding-top:10px;">
				<table id="tb_exceptions" class="tabledata" cellspacing="1" style="width:100% !important;">
					<thead>
						<tr>
							<th class="cabecera_tabla">&nbsp;</th>
							<th class="cabecera_tabla"><fmt:message key="calendar.name"/></th>
							<th class="cabecera_tabla"><fmt:message key="calendar.start"/></th>
							<th class="cabecera_tabla"><fmt:message key="calendar.finish"/></th>
							<th class="cabecera_tabla">
								<img onclick="newException()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
							</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</fieldset>
					
		<div class="right" style="margin-top:15px;">				
			<a href="#" class="boton" onClick="return saveCalendarBase();"><fmt:message key="save" /></a>
		</div>
	</fieldset>
</form>

<div id="new-calendar-popup">
	
	<div id="new-calendar-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="new-calendar-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	
	<form name="frm_new_calendar_popup" id="frm_new_calendar_popup" method="post">
		<input type="hidden" name="idCalendarBase" value="" />
		<input type="hidden" name="accion" value="" />
		<fieldset>
			<legend id="legend_calendar_popup"></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th><fmt:message key="maintenance.calendar_base.name"></fmt:message>&nbsp;*</th>
					<th><fmt:message key="maintenance.calendar_base.template_calendar"></fmt:message></th>
				</tr>
				<tr>
					<td><input type="text" name="new_calendar_name" id="new_calendar_name" class="campo" /></td>
					<td>
						<select name="template_calendar" id="template_calendar" class="campo">
							<option value=""><fmt:message key="select_opt"></fmt:message></option>
							<c:forEach var="item" items="${listCalendars }">
								<option value="${item.idCalendarBase }">${item.name }</option>	
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="popButtons">
			<a href="#" class="boton" onClick="return saveNewCalendarBase();"><fmt:message key="save" /></a>
		</div>
	</form>
</div>

<jsp:include page="calendar_popup.jsp" flush="true" />
