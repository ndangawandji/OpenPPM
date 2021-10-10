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

<fmt:message key="error" var="fmt_error" />
<fmt:message key="msg.error.risk_reassessment_save" var="msg_err_risk_reassessment" />
<fmt:message key="msg.confirm.delete_log_reassessment" var="msg_confirm_delete_log_reassessment" />
<fmt:message key="data_not_found" var="data_not_found" />
<fmt:message key="select_opt" var="sel_option" />
<fmt:message key="risk.probability.trivial" var="prob_trivial" />
<fmt:message key="risk.probability.minor" var="prob_minor" />
<fmt:message key="risk.probability.moderate" var="prob_moderate" />
<fmt:message key="risk.probability.high" var="prob_high" />
<fmt:message key="risk.probability.severe" var="prob_severe" />

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_risk">
	<fmt:param><fmt:message key="risk"/></fmt:param>
</fmt:message>

<c:if test="${project.status ne status_closed}">
	<c:set var="editRisk"><img onclick="editRisk(this);" title="<fmt:message key="edit"/>" class="link" src="images/view.png">&nbsp;&nbsp;&nbsp;</c:set>
</c:if>		

<c:if test="${project.status ne status_closed and tl:hasPermission(user,project.status,tab)}">
	<c:set var="editRiskReassessment"><img onclick="editRiskReassessment(this);" title="<fmt:message key="edit"/>" class="link" src="images/view.png">&nbsp;&nbsp;&nbsp;</c:set>			
</c:if>
<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<c:set var="deleteRiskReassessment"><img src="images/delete.jpg" class="link" onclick="deleteLogReassessment(event, '+ data.id +');" /></c:set>
</c:if>
<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<c:set var="deleteRiskReassessment2"><img src="images/delete.jpg" class="link" onclick="deleteLogReassessment(event, '+ data[i].id +');" /></c:set>
</c:if>

<c:set var="closed"  value="<%=Constants.CHAR_CLOSED%>" />
<c:set var="open"  value="<%=Constants.CHAR_OPEN%>" />

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtCodeRequired">
	<fmt:param><b><fmt:message key="risk.code"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtNameRequired">
	<fmt:param><b><fmt:message key="risk.name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtRaisedDateRequired">
	<fmt:param><b><fmt:message key="risk.date_raised"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtRaisedDateFormat">
	<fmt:param><b><fmt:message key="risk.date_raised"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtChangeRequired">
	<fmt:param><b><fmt:message key="reassessment_log.change"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtLogDateRequired">
	<fmt:param><b><fmt:message key="reassessment_log.date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtLogDateFormat">
	<fmt:param><b><fmt:message key="reassessment_log.date"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var riskTable;
var validatorRisk;

function updateRiskRating(sRiskRating) {
	$('#risk_rating').removeClass('risk_high');
	$('#risk_rating').removeClass('risk_medium');
	$('#risk_rating').removeClass('risk_low');
	
	if (sRiskRating != "") {
		var riskRate = parseInt(sRiskRating);
		
		if (riskRate > 1500) {
			$('#risk_rating').addClass('risk_high');
		}
		else if (riskRate > 500) {
			$('#risk_rating').addClass('risk_medium');
		}
		else {
			$('#risk_rating').addClass('risk_low');
		}
	}
}

function addRisk() {
	var f = document.forms["frm_risk"];
	f.action = "<%=ProjectRiskServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectRiskServlet.ADD_RISK%>";
	loadingPopup();
	f.submit();
}

function saveRisk() {
	if (validatorRisk.form()) {
		var f = document.forms["frm_risk"];
		f.action = "<%=ProjectRiskServlet.REFERENCE%>";
		f.accion.value = "<%=ProjectRiskServlet.SAVE_RISK%>";
		loadingPopup();
		f.submit();
	} 
}
	
function editRisk(element) {	
	var risk = riskTable.fnGetData( element.parentNode.parentNode );
	var f = document.forms["frm_risk"];	
	f.action = "<%=ProjectRiskServlet.REFERENCE%>";	
	f.accion.value = "<%=ProjectRiskServlet.EDIT_RISK%>";	
	f.risk_id.value = risk[0];
	loadingPopup();
	f.submit();	
}

function deleteRisk(id) {
	
	document.forms["frm_project"].risk_id.value = id;
	
	confirmUI(
		'', '${msg_confirm_delete_risk}', 
		"${msg_yes}", "${msg_no}", 
		function () {
			$('#dialog-confirm').dialog("close"); 
			var f = document.forms["frm_project"];
			f.accion.value = "<%=ProjectRiskServlet.DELETE_RISK%>";
			loadingPopup();
			f.submit();	
	});
	
}

function updateRiskMaterialization() {
	if ($('#materialized:checked').length <= 0) {
		$('#risk_date_materialized').val("");
		$('#risk_date_materialized').attr('disabled', 'disabled');
		$('#risk_date_materialized').datepicker("disable");
	}
	else {
		$('#risk_date_materialized').attr('disabled', '');
		$('#risk_date_materialized').datepicker("enable");
	}
}

// Risk Reassessment log functions
//
var riskReassessmentTable;
var validatorLogReassessment;

function addRiskReassessment() {
	if (document.forms["frm_risk"].risk_id.value!= "") {
		$('#reassessment-log-popup').dialog('open');
		
		var f = document.forms["frm_reassessment_log"];
		f.reset();
		f.reassessment_log_id.value = "";
		f.reassessment_log_date.focus();
		f.reassessment_log_change.focus();
		$("#reassessment_log_change").text("");
	}
	else {
		alertUI("${fmt_error}", "${msg_err_risk_reassessment }");
	}
}

function editRiskReassessment(element) {
	var log = riskReassessmentTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_reassessment_log"];
	f.reset();
	f.reassessment_log_id.value = log[0];
	f.reassessment_log_date.value = log[1];
	$("#reassessment_log_change").text(unEscape(log[2]));
	
	$('#reassessment-log-popup').dialog('open');
	f.reassessment_log_date.focus();	
}

function saveLogReassessment() {
	var f = document.forms["frm_reassessment_log"];

	if (validatorLogReassessment.form()) {
		var idReassessmentLog = f.reassessment_log_id.value;
		
		var params = {
			accion: "<%=ProjectRiskServlet.JX_SAVE_REASSESSMENT_LOG%>",
			risk_id: document.forms["frm_risk"].risk_id.value,
			reassessment_log_id: idReassessmentLog,
			date: f.reassessment_log_date.value,
			change: f.reassessment_log_change.value
		};
		
		riskAjax.call(params, function (data) {
			var dataRow = [
	            data.id,
				data.date,
				escape(data.change),
				'${editRiskReassessment}${deleteRiskReassessment}'
			];
			if (idReassessmentLog == '') { riskReassessmentTable.fnAddDataAndSelect(dataRow); }
			else { riskReassessmentTable.fnUpdateAndSelect(dataRow); }
			f.reset();
			$('#reassessment-log-popup').dialog('close');
		});
	} 
}

function deleteLogReassessmentConfirmed() {
	$('#dialog-confirm').dialog("close");
	
	var f = document.forms["frm_project"];
	
	var params = {
		accion: "<%=ProjectRiskServlet.JX_DELETE_LOG_REASSESSMENT%>",
		reassessment_log_id: document.forms["frm_project"].reassessment_log_id.value
	};
	
	riskAjax.call(params, function (data) {		
		if (data && data.error) {
			alertUI("${fmt_error}",data.error);
		}
		else {		    
			riskReassessmentTable.fnDeleteSelected();		    
		}
	});
}

function deleteLogReassessment(e, id) {
	var target = getTargetFromEvent(e);

	confirmUI('', '${msg_confirm_delete_log_reassessment}', 
			"${msg_yes}", "${msg_no}", 
			deleteLogReassessmentConfirmed);
	document.forms["frm_project"].reassessment_log_id.value = id;
}

function refreshReassessmentLog(idRisk) {
	if (idRisk > 0) {
		var params = {
			accion: "<%=ProjectRiskServlet.JX_CONS_LOG_REASSESSMENT%>",
			risk_id: idRisk
		};
		riskAjax.call(params, function (data) {
			riskReassessmentTable.fnClearTable();
			if (data.length > 0) {
				for (var i=0; i<data.length; i++) {
					riskReassessmentTable.fnAddData([
						data[i].id,
						data[i].date,
						escape(data[i].change),
						'${editRiskReassessment}${deleteRiskReassessment2}'
      				]);
				}
			}
		});
	}
}

function updateRiskRatingSelect() {
	var prob = $('#risk_probability option:selected').val();
	var impact = $('#risk_impact option:selected').val();
	if (prob != "" && impact != "") {
		var riskRating = prob * impact;
		updateRiskRating(riskRating);
	}
}

readyMethods.add(function() {
	
	if('${showRisk}') {			
		updateRiskMaterialization();
		updateRiskRating('${risk.riskRating}');
		refreshReassessmentLog('${risk.idRisk}');
		show('risk');
	}
	
	riskTable = $('#tb_risks').dataTable({
		"oLanguage": datatable_language,
		"bFilter": true,
		"bInfo": true,
		"bPaginate": true,
		"iDisplayLength": 50,
		"bAutoWidth": false,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		"aoColumns": [
             { "bVisible": false },
             { "sClass": "center" },
             { "sClass": "center", "sType": "es_date" },		              
             { "sClass": "center", "sType": "es_date" },
             { "sClass": "center"  },
             { "sClass": "right"  },
             { "sClass": "center"  },
             { "sClass": "left", "bSortable": false },
             { "sClass": "center", "bSortable": false }
    	]
	});

	$('#tb_risks tbody tr').live('click', function (event) {
		fnSetSelectable(riskTable, this);
	} );

	riskReassessmentTable = $('#tb_reassessment_logs').dataTable( {
		"oLanguage": datatable_language,
		"bFilter": true,
		"bInfo": true,
		"bPaginate": true,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		"aoColumns": [
             { "bVisible": false },
             { "sClass": "center", "sWidth": "10%", "sType": "es_date" },
             { "sClass": "left", "sWidth": "75%" },
             { "sClass": "center", "sWidth": "10%", "bSortable": false }
    	]
	});

	$('#tb_reassessment_logs tbody tr').live('click', function (event) {
		fnSetSelectable(riskReassessmentTable, this);
	});
	
	validatorRisk = $("#frm_risk").validate({
		errorContainer: 'div#risk-errors',
		errorLabelContainer: 'div#risk-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#risk-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			risk_code: {required: true },
			risk_name: {required: true },
			date_raised: {required: true, date: true },
			description : { maxlength : 500 },
			risk_trigger: { maxlength : 500 },
			response_description: { maxlength : 500 },
			mitigation_actions: { maxlength : 500 },
			contingency_actions: { maxlength : 500 },
			residual_risk: { maxlength : 500 },
			final_comments: { maxlength : 500 }
		},
		messages: {
			risk_code: {required: '${fmtCodeRequired}'},
			risk_name: {required: '${fmtNameRequired}'},
			date_raised: {required: '${fmtRaisedDateRequired}', date: '${fmtRaisedDateFormat}'}
		}
	});	

	$('#risk_type').filterSelect({'selectFilter':'response'});
	$("#response").val('${risk.riskcategories.idRiskCategory}');


	$('#risk_probability,#risk_impact').change(function() {
		updateRiskRatingSelect();
	});

	validatorLogReassessment = $("#frm_reassessment_log").validate({
		errorContainer: 'div#reassessment-log-errors',
		errorLabelContainer: 'div#reassessment-log-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#reassessment-log-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			reassessment_log_date: {required: true, date:true },
			reassessment_log_change: {required: true, maxlength: 500 }
		},
		messages: {
			reassessment_log_date: {required: '${fmtLogDateRequired}', date: '${fmtLogDateFormat}' },
			reassessment_log_change: {required: '${fmtChangeRequired}' }
		}
	});
	
	$('div#reassessment-log-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 550, 
		minWidth: 550, 
		resizable: false,
		open: function(event, ui) { validatorLogReassessment.resetForm(); }
	});

	$('#reassessment_log_date').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function() {
			if (validatorLogReassessment.numberOfInvalids() > 0) validatorLogReassessment.form();
		}
	});
	
	$('#materialized').click(function() {
		updateRiskMaterialization();
	});	
});
//-->
</script>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<script type="text/javascript">
	<!--
	readyMethods.add(function() {
		$('#date_raised').datepicker({
			dateFormat: '${datePickerPattern}',
			firstDay: 1,
			showOn: 'button',
			buttonImage: 'images/calendario.png',
			buttonImageOnly: true,
			changeMonth: true,
			onSelect: function() {
				if (validatorRisk.numberOfInvalids() > 0) validatorRisk.form();
			}
		});
		
		$('#due_date').datepicker({
			dateFormat: '${datePickerPattern}',
			firstDay: 1,
			showOn: 'button',
			buttonImage: 'images/calendario.png',
			buttonImageOnly: true,
			changeMonth: true,
			onSelect: function() {
				if (validatorRisk.numberOfInvalids() > 0) validatorRisk.form();
			}
		});
		
		$('#risk_date_materialized').datepicker({
			dateFormat: '${datePickerPattern}',
			firstDay: 1,
			showOn: 'button',
			buttonImage: 'images/calendario.png',
			buttonImageOnly: true,
			changeMonth: true,
			onSelect: function() {
				if (validatorRisk.numberOfInvalids() > 0) validatorRisk.form();
			}
		});
	});
	//-->
	</script>
</c:if>

<fieldset class="level_1">
	<legend class="link" onclick="changeCookie('field_risk_register')"><fmt:message key="risk_register"/></legend>
	<div class="buttons">
		<img id="field_risk_registerBtn" onclick="changeCookie('field_risk_register', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="field_risk_register" class="hide" style="padding-top:10px;">
		<table id="tb_risks" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="9%"><fmt:message key="risk.code"/></th>
					<th width="10%"><fmt:message key="risk.date_raised"/></th>					
					<th width="10%"><fmt:message key="risk.due_date"/></th>
					<th width="10%"><fmt:message key="risk.status"/></th>
					<th width="10%"><fmt:message key="risk.rating"/></th>
					<th width="11%"><fmt:message key="risk.response"/></th>
					<th width="32%"><fmt:message key="risk.description"/></th>
					<th width="8%">
						<c:if test="${project.status ne status_closed and tl:hasPermission(user,project.status,tab)}">
							&nbsp;<img onclick="addRisk();" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>						
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="risk" items="${risks}">
					<tr>
						<td>${risk.idRisk }</td>
						<td>${tl:escape(risk.riskCode)}</td>
						<td><fmt:formatDate value="${risk.dateRaised }" pattern="${datePattern}"/></td>						
						<td><fmt:formatDate value="${risk.dueDate}" pattern="${datePattern}"/></td>						
						<td>
							<c:choose>
								<c:when test="${risk.status == closed}">
									<%=Constants.CLOSED%>
								</c:when>
								<c:when test="${risk.status == open}">
									<%=Constants.OPEN%>
								</c:when>
							</c:choose>
						</td>				
						<td><span style="visibility: hidden;">${risk.riskRating}</span><div style="margin: -15px auto auto; width: 25px;" 
								<c:choose>
									<c:when test="${risk.riskRating gt 1500 }">
										class="risk_high"
									</c:when>
									<c:when test="${risk.riskRating gt 500 }">
										class="risk_medium"
									</c:when>
									<c:otherwise>
										class="risk_low"
									</c:otherwise>
								</c:choose>
							>&nbsp;</div></td>		
						<td>${tl:escape(risk.riskcategories.description)}</td>						
						<td>${tl:escape(risk.description)}</td>
						<td>
							<c:if test="${project.status ne status_closed}">
								<img onclick="editRisk(this);" title="<fmt:message key="edit"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
							</c:if>			
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img src="images/delete.jpg" class="link" onclick="deleteRisk(${risk.idRisk });" />
							</c:if>									
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>	
		<div id="risk" class="hide">
			<jsp:include page="manage_risk.inc.jsp" flush="true" />
		</div>	
	</div>	
</fieldset>
