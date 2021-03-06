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
 -  Updater : Cedric Ndanga Wandji
 -  Devoteam 09/06/2015 user story 40 : adding new column for the activity initial workload input.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.model.Projectactivity"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtStartDateRequired">
	<fmt:param><b><fmt:message key="activity.start"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtFinishDateRequired">
	<fmt:param><b><fmt:message key="activity.finish"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtStartDateFormat">
	<fmt:param><b><fmt:message key="activity.start"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtFinishDateFormat">
	<fmt:param><b><fmt:message key="activity.finish"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_after_date" var="fmtStartDateAfterFinish">
	<fmt:param><b><fmt:message key="activity.start"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.finish"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtFinishDateBeforeStart">
	<fmt:param><b><fmt:message key="activity.finish"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.start"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var validatorActivity;
function saveActivity() {

	if (validatorActivity.form()) {
		loadingPopup();
		var f =  document.forms["frm_activity"];
		f.scrollTop.value = $(document).scrollTop();
		f.submit();
	}
}

function closeActivity() {

	$('div#activity-popup').dialog('close');
}


readyMethods.add(function() {

	$('div#activity-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 500, 
		minWidth: 500, 
		resizable: false,
		open: function(event, ui) { validatorActivity.resetForm(); }
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
			init_date: { required: true, date : true, minDateTo: '#act_end_date' },
			end_date: { required: true, date : true, maxDateTo: '#act_init_date' },
			wbs_dictionary: { maxlength: 300 }
		},
		messages: {
			init_date: { required: '${fmtStartDateRequired}', date : '${fmtStartDateFormat}', minDateTo: '${fmtStartDateAfterFinish}' },
			end_date: { required: '${fmtFinishDateRequired}', date : '${fmtFinishDateFormat}', maxDateTo: '${fmtFinishDateBeforeStart}' }
		}
	});	
});
//-->
</script>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<script type="text/javascript">
	<!--
	readyMethods.add(function() {		
		var activityDates = $('#act_init_date, #act_end_date').datepicker({
			dateFormat: '${datePickerPattern}',
			firstDay: 1,
			showOn: 'button',
			buttonImage: 'images/calendario.png',
			buttonImageOnly: true,
			changeMonth: true,
			minDate: $('#proj_iniDate').html(),
			onSelect: function(selectedDate) {
				var option = this.id == "act_init_date" ? "minDate" : "maxDate";
				var instance = $(this).data("datepicker");
				var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
				activityDates.not(this).datepicker("option", option, date);
				if (validatorActivity.numberOfInvalids() > 0) validatorActivity.form();
			}
		});
	
	});
	//-->
	</script>
</c:if>

<div id="activity-popup" class="popup">

	<div id="activity-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="activity-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_activity" id="frm_activity" method="POST" action="<%=ProjectPlanServlet.REFERENCE%>">
		<input type="hidden" name="idactivity" value="" />
		<input type="hidden" name="accion" value="<%=ProjectPlanServlet.SAVE_ACTIVITY %>" />
		<input type="hidden" name="id" value="${project.idProject }" />
		<input type="hidden" name="scrollTop" value="" />
		
		<fieldset>
			<legend><fmt:message key="edit_activity" /></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th colspan="4" class="left"><fmt:message key="activity.name" /></th>					<!-- cnw us40 changing colspan attribute. Before 3 after 4  -->
				</tr>
				<tr>
					<td colspan="4"><input type="text" name="name" class="campo" readonly="readonly" /></td><!-- cnw us40 changing colspan attribute. Before 3 after 4  -->
				</tr>
				<tr>
					<th class="left" width="30"><fmt:message key="activity.start" />&nbsp;*</th>
					<th class="left" width="30%"><fmt:message key="activity.finish" />&nbsp;*</th>
					<th class="left" width="15%"><fmt:message key="activity.init_workload" /></th>			<!-- cnw us40 adding initial workload column label -->
					<th class="left" width="25%">
						<!--<fmt:message key="planned_value" />-->
					</th>
				</tr>
				<tr>
					<td><input type="text" name="init_date" id="act_init_date" class="campo fecha" /></td>
					<td><input type="text" name="end_date" id="act_end_date" class="campo fecha" /></td>
					<td><input type="text" name="init_workload" id="init_workload" class="campo fecha"></td>			<!-- cnw us40 adding initial workload input -->
					<td><input type="hidden" name="<%=Projectactivity.PV %>" class="campo importe" /></td>
				</tr>
				<tr><th class="left" colspan="4"><fmt:message key="activity.description" /></th></tr>
				<tr>
					<td colspan="4">
						<textarea name="wbs_dictionary" id="wbs_dictionary" class="campo" style="width:98%;"></textarea>
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<c:if test="${tl:hasPermission(user,project.status,tab)}">
    			<input type="submit" class="boton" onclick="saveActivity(); return false;" value="<fmt:message key="save" />" />
			</c:if>
			<a href="javascript:closeActivity();" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
