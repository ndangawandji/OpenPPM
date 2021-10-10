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

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--
function updateTeamCalendar() {
	
	planAjax.call({
			accion:"<%=ProjectPlanServlet.JX_UPDATE_TEAM_CALENDAR%>",
			idProject:'${project.idProject}',
			since: $("#calStart").val(),
			until: $("#calFinish").val()
		},function(data) {
			$('#teamCalendarContent').html(data);
		},'html'
	);
}

readyMethods.add(function() {
	var dates = $('#calStart, #calFinish').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "calStart" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
		}
	});
});

//-->
</script>

<fieldset class="level_1">
	<legend class="link" onclick="changeCookie('fieldPlanTeamCal')"><fmt:message key="team.calendar"/></legend>
	<div class="buttons">
		<img id="fieldPlanTeamCalBtn" onclick="changeCookie('fieldPlanTeamCal', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldPlanTeamCal" class="hide" style="padding-top:10px;">
		<div>
     		<span style="margin-right:5px;">
				<fmt:message key="dates.since"/>:&nbsp;
				<input type="text" id="calStart" class="campo fecha alwaysEditable" value="${valPlanInitDate}"/>
     		</span>
        	<span style="margin-right:5px;">
				<fmt:message key="dates.until"/>:&nbsp;
				<input type="text" id="calFinish" class="campo fecha alwaysEditable" value="${valPlanEndDate}"/>
			</span>
			<a href="javascript:updateTeamCalendar();" class="boton"><fmt:message key="team.calendar.refresh" /></a>
		</div>
		<div id="teamCalendarContent"></div>
		<div style="padding-top:15px;">
			<table style="margin:0 auto; padding-top: 15px" cellpadding="4" cellspacing="4">
				<tr>
					<td><div class="workDay"></div></td>
					<td><fmt:message key="calendar.working"></fmt:message></td>
					<td><div class="notWorkDay"></div></td>
					<td><fmt:message key="calendar.non_working"></fmt:message></td>
					<td><div class="exceptionDay"></div></td>
					<td><fmt:message key="calendar.exception_day"></fmt:message></td>
					<td><div class="nonWorkingDay"></div></td>
					<td><fmt:message key="calendar.non_default_work_week"></fmt:message></td>
				</tr>
			</table>
		</div>
	</div>
</fieldset>
