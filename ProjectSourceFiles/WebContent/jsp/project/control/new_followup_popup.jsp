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
<%@page import="es.sm2.openppm.model.Projectfollowup"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

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
var newFollowupValidator;

function openCreateFollowup() {
	document.frm_new_followup.reset();
	$('div#new-followup-popup').dialog('open');
}
function createFollowup() {
	if (newFollowupValidator.form()) {
		loadingPopup();
		document.frm_new_followup.submit();
	} 
}

readyMethods.add(function() {
	$('div#new-followup-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 450, 
		resizable: false,
		open: function(event, ui) { newFollowupValidator.resetForm(); }
	});

	var dates = $('#<%=Projectfollowup.FOLLOWUPDATE %>').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function() {
			if (newFollowupValidator.numberOfInvalids() > 0) {
				newFollowupValidator.form();
			}	
		}
	});
	
	newFollowupValidator = $("#frm_new_followup").validate({
		errorContainer: 'div#new-followup-errors',
		errorLabelContainer: 'div#new-followup-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#new-followup-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Projectfollowup.FOLLOWUPDATE %>: { required: true, date: true, minDateTo: '#valPlanEndDate', maxDateTo: '#valPlanInitDate' }
		},
		messages: {
			<%=Projectfollowup.FOLLOWUPDATE %>: {
				required: '${fmtFollowupDateRequired}',
				date: '${fmtFollowupDateFormat}',
				minDateTo: '${fmtFollowupDateAfterFinish} ('+$('#valPlanEndDate').val()+')',
				maxDateTo: '${fmtFollowupDateBeforeStart} ('+$('#valPlanInitDate').val()+')'
			}
		}
	});
});
//-->
</script>

<div id="new-followup-popup" class="popup">

	<div id="new-followup-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="new-followup-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_new_followup" id="frm_new_followup" action="<%=ProjectControlServlet.REFERENCE%>">
		<input type="hidden" name="accion" value="<%=ProjectControlServlet.NEW_FOLLOWUP%>"/>
		<input type="hidden" name="<%=Project.IDPROJECT %>" value="${project.idProject }"/>
		<fieldset>
			<legend><fmt:message key="planned_value"/></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="50%"><fmt:message key="followup.date"/>&nbsp;*</th>
					<th class="left" width="50%"><fmt:message key="planned_value.value"/></th>
				</tr>
				<tr>
					<td>
						<input type="text" id="<%=Projectfollowup.FOLLOWUPDATE %>" name="<%=Projectfollowup.FOLLOWUPDATE %>" class="campo fecha" />
					</td>
					<td>
						<input type="text" name="<%=Projectfollowup.PV %>" class="campo importe" />
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<input type="submit" class="boton" onclick="createFollowup(); return false;" value="<fmt:message key="save" />" />
    	</div>
    </form>
</div>
