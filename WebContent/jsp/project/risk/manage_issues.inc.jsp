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
<%@page import="es.sm2.openppm.servlets.ProjectRiskServlet"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<fmt:message key="error" var="fmt_error" />
<fmt:message key="data_not_found" var="data_not_found" />

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_issue">
	<fmt:param><fmt:message key="issue"/></fmt:param>
</fmt:message>

<c:if test="${project.status ne status_closed}">								
	<c:set var="editIssue"><img onclick="return editIssue(this);" title="<fmt:message key="edit"/>" class="link" src="images/view.png"></c:set>
</c:if>

<c:set var="priorityH"><%=Constants.PRIORITY_HIGH%></c:set>
<c:set var="priorityM"><%=Constants.PRIORITY_MEDIUM%></c:set>
<c:set var="priorityL"><%=Constants.PRIORITY_LOW%></c:set>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtRaiseDateRequired">
	<fmt:param><b><fmt:message key="issue.raise_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtDueDateRequired">
	<fmt:param><b><fmt:message key="issue.due_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtassignedToRequired">
	<fmt:param><b><fmt:message key="issue.assigned_to"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtRatingRequired">
	<fmt:param><b><fmt:message key="issue.rating"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtRaiseDateFormat">
	<fmt:param><b><fmt:message key="issue.raise_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message><fmt:message key="msg.error.invalid_format" var="fmtDueDateFormat">
	<fmt:param><b><fmt:message key="issue.due_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message><fmt:message key="msg.error.invalid_format" var="fmtCloseDateFormat">
	<fmt:param><b><fmt:message key="issue.close_date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
//Cost editable?
var issuesTable;
var validatorIssue;

function editIssue(element) {
	
	var issue = issuesTable.fnGetData( element.parentNode.parentNode );

	var f = document.forms["frm_issue"];
	f.reset();
	f.issue_id.value = issue[0];
	f.priority.value = issue[2];
	f.date_logged.value = issue[1];
	f.target_date.value = issue[3];
	f.assigned_to.value = unEscape(issue[6]);		
	f.date_closed.value = issue[4];			
	
	$('#issue-popup').dialog('open');
	
	$("#resolution").text(unEscape(issue[8]));
	$("#issueDescription").text(unEscape(issue[9]));	

}

function addIssue() {
	$('#issue-popup').dialog('open');
	
	var f = document.forms["frm_issue"];
	f.reset();
	f.issue_id.value = "";
	$("#resolution").text("");
	$("#issueDescription").text("");
}

function saveIssue() {
	var f = document.forms["frm_issue"];

	if (validatorIssue.form()) {
		var idIssue = f.issue_id.value;
		
		// Save milestone by Ajax Call
		riskAjax.call({
				accion: "<%=ProjectRiskServlet.JX_SAVE_ISSUE%>",
				id: document.forms["frm_project"].id.value,
				issue_id: idIssue,
				priority: f.priority.value,
				date_logged: f.date_logged.value,
				target_date: f.target_date.value,
				assigned_to: f.assigned_to.value,
				description: f.description.value,
				resolution: f.resolution.value,
				date_closed: f.date_closed.value
			}, function (data) {

				var dataRow = [
				    data.id,
					data.date_logged,
					data.priority,
					data.target_date,
					data.date_closed,
					data.status,
					escape(data.assigned_to),
					data.priority_desc,
					escape(data.resolution),
					escape(data.description),
					'${editIssue}' + 
					'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
					'<img src="images/delete.jpg" class="link" onclick="deleteIssue(event, '+ data.id +');" />'
	            ];
					
				if (idIssue == '') { issuesTable.fnAddDataAndSelect(dataRow); }
				else { issuesTable.fnUpdateAndSelect(dataRow); }
				
				f.reset();

				$('#issue-popup').dialog('close');
		});
	} 
}

function deleteIssueConfirmed() {
	$('#dialog-confirm').dialog("close"); 
	var f = document.forms["frm_project"];
	f.accion.value = "<%=ProjectRiskServlet.DELETE_ISSUE%>";
	f.submit();
}

function deleteIssue(e, id) {
	var target = getTargetFromEvent(e);

	confirmUI('', '${msg_confirm_delete_issue}', 
			"${msg_yes}", "${msg_no}", 
			deleteIssueConfirmed);
	document.forms["frm_project"].issue_id.value = id;
}

readyMethods.add(function() {
	issuesTable = $('#tb_issues').dataTable({
		"oLanguage": datatable_language,
		"bFilter": true,
		"bInfo": true,
		"bPaginate": true,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aoColumns": [
		              { "bVisible": false },
		              { "sClass": "center", "sType": "es_date" },
		              { "bVisible": false },
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center", "sType": "es_date" },
		              { "bVisible": true },
		              { "bVisible": false },
		              { "sClass": "left" },
		              { "sClass": "left" }, 
		              { "sClass": "left" }, 
		              { "sClass": "center", "bSortable": false }
		      		]
	});	
	
	$('#tb_issues tbody tr').live('click', function (event) {
		fnSetSelectable(issuesTable, this);
	} );

	//Validate required fields
	validatorIssue = $("#frm_issue").validate({
		errorContainer: 'div#issue-errors',
		errorLabelContainer: 'div#issue-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#issue-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			date_logged: {required: true, date: true },
			target_date: {required: true, date: true },
			assigned_to: {required: true },
			priority: {required: true },
			date_closed: { date: true },
			description : { maxlength : 500 },
			resolution  : { maxlength : 500 }
		},
		messages: {
			date_logged: {required: '${fmtRaiseDateRequired}', date: '${fmtRaiseDateFormat}' },
			target_date: {required: '${fmtDueDateRequired}', date: '${fmtDueDateFormat}' },
			assigned_to: {required: '${fmtassignedToRequired}' },
			priority: {required: '${fmtRatingRequired}' },
			date_closed: { date: '${fmtCloseDateFormat}' }
		}
	});
		
	$('div#issue-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 550, 
		minWidth: 550, 
		resizable: false,
		open: function(event, ui) { validatorIssue.resetForm(); }
	});
});
//-->
</script>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<script type="text/javascript">
	<!--
		readyMethods.add(function() {
			$('#issue_date_logged').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function() {
					if (validatorIssue.numberOfInvalids() > 0) validatorIssue.form();
				}
			});

			$('#issue_target_date').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function() {
					if (validatorIssue.numberOfInvalids() > 0) validatorIssue.form();
				}
			});

			$('#issue_date_closed').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function() {
					if (validatorIssue.numberOfInvalids() > 0) validatorIssue.form();
				}
			});
		});
	//-->
	</script>
</c:if>

<div style="">&nbsp;</div>

<fieldset class="level_1">
	<legend class="link" onclick="changeCookie('field_issue_controlling')"><fmt:message key="issue_log"/></legend>
	<div class="buttons">
		<img id="field_issue_controllingBtn" onclick="changeCookie('field_issue_controlling', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="field_issue_controlling" class="hide" style="padding-top:10px;">
		<table id="tb_issues" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="8%"><fmt:message key="issue.raise_date"/></th>
					<th width="0%">&nbsp;</th>
					<th width="8%"><fmt:message key="issue.due_date"/></th>
					<th width="8%"><fmt:message key="issue.close_date"/></th>
					<th width="6%"><fmt:message key="issue.status"/></th>
					<th width="0%"><fmt:message key="issue.assigned_to"/></th>
					<th width="6%"><fmt:message key="issue.rating"/></th>
					<th width="28%"><fmt:message key="issue.resolution"/></th>
					<th width="28%"><fmt:message key="issue.description"/></th>
					<th width="8%">
						<c:if test="${project.status ne status_closed and tl:hasPermission(user,project.status,tab)}">
							<img onclick="addIssue();" title="<fmt:message key="add"/>" class="link" src="images/add.png">				
						</c:if>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="issue" items="${issues}">
					<tr>
						<td>${issue.idIssue }</td>
						<td><fmt:formatDate value="${issue.dateLogged }" pattern="${datePattern}" /></td>
						<td>${issue.priority }</td>
						<td><fmt:formatDate value="${issue.targetDate }" pattern="${datePattern}" /></td>
						<td><fmt:formatDate value="${issue.dateClosed }" pattern="${datePattern}" /></td>
						<td>
							<c:choose>
								<c:when test="${not empty issue.dateClosed }"><fmt:message key="issue_closed"/></c:when>
								<c:otherwise><fmt:message key="issue_opened" /></c:otherwise>
							</c:choose>
						</td>
						<td>${tl:escape(issue.assignedTo)}</td>
						<td>
							<c:if test="${issue.priority eq priorityH}"><fmt:message key="priority.high" /></c:if>
							<c:if test="${issue.priority eq priorityM}"><fmt:message key="priority.medium" /></c:if>
							<c:if test="${issue.priority eq priorityL}"><fmt:message key="priority.low" /></c:if>
						</td>
						<td>${tl:escape(issue.resolution)}</td>
						<td>${tl:escape(issue.description)}</td>
						<td>
							<c:if test="${project.status ne status_closed}">								
								<img onclick="editIssue(this);" title="<fmt:message key="edit"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img src="images/delete.jpg" class="link" onclick="deleteIssue(event, ${issue.idIssue});" />
							</c:if>							
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>		
	</div>
</fieldset>
