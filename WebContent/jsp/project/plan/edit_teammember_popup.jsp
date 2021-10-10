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
 -  Updater : Cédric Ndanga Wandji, Xavier De Langauthier
------------------------------------------------------------------------------%>
<%--
	Updater : Cédric Ndanga Wandji
	Devoteam, 22/04/2015, userstory 13 : adding of new control for workload in days.
	Devoteam, 22/04/2015, userstory 13 : adding of javascript:convertFteInDays() to set Days throught workload
												   javascript:convertDaysInFte() to set workload throught Days
									     These 2 functions are called when workload or days inputs have focus.
									     For calling of these functions, see rows 382 and 385 in this file.
	Devoteam, 11/05/2015, userstory 13 : adding rules for the workload in days in the form.	
	Devoteam, 11/05/2015, userstory 13 : adding of global JavaScript variable maxWorksDays for the max of workload in days in a period assignment.						       
 --%>
 <%--
 	Updater : Xavier De Langauthier
 	Devoteam, 2015-04-14, user story 3 : PRe-assigned date in and date out with planned date
                           				function : cvhangeActivityDates
 --%>
<%@page import="es.sm2.openppm.model.Projectactivity"%>
<%@page import="es.sm2.openppm.model.Skill"%>
<%@page import="es.sm2.openppm.servlets.ResourceServlet"%>
<%@page import="es.sm2.openppm.model.Teammember"%>
<%@page import="es.sm2.openppm.model.Employee"%>
<%@page import="es.sm2.openppm.model.Contact"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.utils.StringPool"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="error" var="fmt_error" />
<fmt:message key="msg.error.date_before_date" var="fmt_activity_init_befire_out">
	<fmt:param><fmt:message key="activity"/>&nbsp;<fmt:message key="activity.end_date"/></fmt:param>
	<fmt:param><fmt:message key="team_member.date_out"/></fmt:param>
</fmt:message>

<fmt:message key="msg.error.date_before_date" var="fmt_activity_in_befire_end">
	<fmt:param><fmt:message key="team_member.date_in"/></fmt:param>
	<fmt:param><fmt:message key="activity"/>&nbsp;<fmt:message key="activity.init_date"/></fmt:param>
</fmt:message>

<fmt:message key="msg.error.date_before_date" var="fmt_activity_range_date">
	<fmt:param><fmt:message key="team_member.date_out"/></fmt:param>
	<fmt:param><fmt:message key="team_member.date_in"/></fmt:param>
</fmt:message>

<c:set var="rol_pmo" value="<%=Constants.ROLE_PMO %>"/>
<c:set var="rol_pm" value="<%=Constants.ROLE_PM %>"/>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtActivityRequired">
	<fmt:param><b><fmt:message key="activity"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtInDateRequired">
	<fmt:param><b><fmt:message key="team_member.date_in"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtOutDateRequired">
	<fmt:param><b><fmt:message key="team_member.date_out"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtInDateFormat">
	<fmt:param><b><fmt:message key="team_member.date_in"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.invalid_format" var="fmtOutDateFormat">
	<fmt:param><b><fmt:message key="team_member.date_out"/></b></fmt:param>
	<fmt:param>${datePattern}</fmt:param>
</fmt:message>
<fmt:message key="msg.error.out_of_range" var="fmtFteOutOfRange">
	<fmt:param><b><fmt:message key="team_member.fte"/></b></fmt:param>
	<fmt:param>1 - 100</fmt:param>
</fmt:message>
<fmt:message key="msg.error.not_working_days" var="fmtDaysNotWorkingDays">   <!--  us13  adding workload in Days-->
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtMemberInDateAfterStart">
	<fmt:param><b><fmt:message key="team_member.date_in"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_init_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_after_date" var="fmtMemberInDateBeforeFinish">
	<fmt:param><b><fmt:message key="team_member.date_in"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_end_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_before_date" var="fmtMemberOutDateAfterStart">
	<fmt:param><b><fmt:message key="team_member.date_out"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_init_date"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.date_after_date" var="fmtMemberOutDateBeforeFinish">
	<fmt:param><b><fmt:message key="team_member.date_out"/></b></fmt:param>
	<fmt:param><b><fmt:message key="activity.planned_end_date"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var resourceAjax = new AjaxCall('<%=ResourceServlet.REFERENCE%>','<fmt:message key="error" />');
var validatorMember;
var maxWorksDays;      //contains max of possible number of days in the period assignment.

function chargeBTPop() {
	$('td#skill div').bt({
		fill: '#F9FBFF',
		cssStyles: {color: '#343C4E', width: 'auto'},
		width: 250,
		padding: 10,
		cornerRadius: 5,
		spikeLength: 15,
		spikeGirth: 5,
		shadow: true,
		positions: 'left'
	});
}

function releasedResource() {
	var f = document.frm_member;
	
	var params = {
			accion: '<%=ProjectPlanServlet.JX_RELEASED_RESOURCE%>',
		idResource: f.idmember.value,
		commentsPm: $('#commentsPm').val()
	};
	planAjax.call(params, function() {
		
		var aData = teamTable.fnGetSelectedData();
		
		aData[4] = '<fmt:message key="resource.released"/>';
		
		teamTable.fnUpdateAndSelect(aData);
		
		closeTeamMember();
	});
}
function editTeamMember(element) {

	var teamMember = teamTable.fnGetData( element.parentNode.parentNode );
	
	var params = {
		accion: '<%=ResourceServlet.JX_VIEW_RESOURCE%>',
		idResource: teamMember[0]
	};
	resourceAjax.call(params, function(data) {
		
		var f = document.frm_member;
		f.reset();
		
		f.idmember.value		= teamMember[0];
		$('#tm_fullname').text(data.<%=Contact.FULLNAME%>);
		$('#skill').html(data.<%=Teammember.SKILL%>);
		f.member_fte.value		= data.<%=Teammember.FTE%>;
		f.member_days.value     = data.<%=Teammember.WORKLOAD_IN_DAYS%>;
		f.member_datein.value	= data.<%=Teammember.DATEIN%>;		
		f.employee_id.value 	= data.<%=Employee.IDEMPLOYEE%>;
		f.idActivity.value 		= data.<%=Projectactivity.IDACTIVITY%>;
		f.<%=Teammember.SELLRATE%>.value = toCurrency(data.<%=Teammember.SELLRATE%>);
		$('#<%=Contact.BUSINESSPHONE%>').text(data.<%=Contact.BUSINESSPHONE%>);
		$('#<%=Contact.MOBILEPHONE%>').text(data.<%=Contact.MOBILEPHONE%>);
		$('#<%=Contact.EMAIL%>').text(data.<%=Contact.EMAIL%>);
		$('#<%=Employee.COSTRATE%>').text(data.<%=Employee.COSTRATE%>);
		$('#idSkill').html(optionsSkills(data.skillArray));
		$('#idSkill').val(data.<%=Skill.IDSKILL%>);
		$("#commentsPm").val(data.<%=Teammember.COMMENTSPM%>);
		
		
		var commentsRm = data.<%=Teammember.COMMENTSRM%>;
		
		if (typeof commentsRm === 'undefined' || commentsRm == '' || commentsRm == null) {
			$('#commentsForRM').hide();
		}
		else {
			$('#commentsForRM').show();
			$('#commentsRm').html(commentsRm);
		}
		
		$('#btnPreassigned, #btnReleased, #btnUpdate').hide();
		
		if (data.statusVal == '<%=Constants.RESOURCE_ASSIGNED%>') {
			$('#btnReleased, #btnUpdate').show();
		}
		else if (data.statusVal == '<%=Constants.RESOURCE_PROPOSED%>' || 
				data.statusVal == '<%=Constants.RESOURCE_PRE_ASSIGNED%>') {
			$('#btnPreassigned, #btnReleased').show();
		}
		else if (data.statusVal == '<%=Constants.RESOURCE_TURNED_DOWN%>') {
			$('#btnReleased').show();
		}

		if (data.statusVal != '<%=Constants.RESOURCE_PRE_ASSIGNED%>') {
			$('#member_datein').datepicker('disable');
		}
		
		changeActivityDates();
		chargeBTPop();
		$("#member_dateout").datepicker("option", "minDate", $('#member_datein').val());		
		f.member_dateout.value	= data.<%=Teammember.DATEOUT%>;
		
		
		if (data.statusVal == '<%=Constants.RESOURCE_ASSIGNED%>') {
			$('#idActivity').attr('disabled', 'disabled');
			$('#idSkill').attr('disabled', 'disabled');
			$('#<%=Teammember.SELLRATE %>').attr('disabled', 'disabled');
			$('#member_fte').attr('disabled', 'disabled');
		}
		else {
			$('#idActivity').attr('disabled', '');
			$('#idSkill').attr('disabled', '');
			$('#<%=Teammember.SELLRATE %>').attr('disabled', '');
			$('#member_fte').attr('disabled', '');
		}
		
		showTeamMemberPopup();
	});
}

function showTeamMemberPopup() { $('#member-popup').dialog('open'); }

function preasignedResource() {
	
	if (validatorMember.form()) {
		
		var f = document.frm_member;
		
		id_member = f.idmember.value;
		
		planAjax.call({
				accion: "<%=ProjectPlanServlet.JX_SAVE_MEMBER%>",
				idActivity: f.idActivity.value,
				id: document.forms['frm_project'].id.value,
				plannedFinishDate: $('#plannedFinishDate').html(),
				member_id: f.idmember.value,
				member_fte: f.member_fte.value,
				member_datein: f.member_datein.value,
				member_dateout: f.member_dateout.value,
				employee_id: f.employee_id.value,
				<%=Teammember.SELLRATE%>: f.<%=Teammember.SELLRATE%>.value,
				idSkill: f.idSkill.value,
				commentsPm: $("#commentsPm").val(),
				member_days: f.member_days.value
			}, function (data) {
				
				var dataRow = [
					data.id,
					escape(data.contact_fullname),
					escape(data.activity),
					data.fte+'%',
					escape(data.status),
					escape(data.performing_org),
					data.date_in,
					data.date_out,
					'<img onclick="editTeamMember(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'
				];
				
				if (id_member == '') { teamTable.fnAddDataAndSelect(dataRow); }
				else { teamTable.fnUpdateAndSelect(dataRow); }
				
				f.reset();
				
				$('#member-popup').dialog('close');
		});
	}
}

function updateResource() {
	
	if (validatorMember.form()) {
		
		var f = document.frm_member;
		
		id_member = f.idmember.value;
		
		planAjax.call({
				accion: "<%=ProjectPlanServlet.JX_UPDATE_MEMBER%>",				
				id: document.forms['frm_project'].id.value,
				member_id: f.idmember.value,
				member_dateout: f.member_dateout.value
			}, function (data) {				
				var dataRow = [
					data.id,
					escape(data.contact_fullname),
					escape(data.activity),
					data.fte+'%',
					escape(data.status),
					escape(data.performing_org),
					data.date_in,
					data.date_out,
					'<img onclick="editTeamMember(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'
				];
				
				if (id_member == '') { teamTable.fnAddDataAndSelect(dataRow); }
				else { teamTable.fnUpdateAndSelect(dataRow); }
				
				f.reset();
				
				$('#member-popup').dialog('close');
		});
	}
}

function changeActivityDates() {
	var idActivity = $("#idActivity").val();
	if (idActivity == -1) {
		$("#act_planInitDate").html("");
		$("#act_planEndDate").html("");
	}
	else {
		$("#act_planInitDate").html($("#planInitDate" + idActivity).val());
		$("#act_planEndDate").html($("#planEndDate" + idActivity).val());
		if( isEmpty($("#member_datein").val()) ) {$("#member_datein").val($("#planInitDate" + idActivity).val());}  // 2015-04-14 Xdl pre assigned date
		if( isEmpty($("#member_dateout").val()) ) {$("#member_dateout").val($("#planEndDate" + idActivity).val());}  // 2015-04-14 Xdl pre assigned date
	}
}

function closeTeamMember() {
	$('div#member-popup').dialog('close');
}

function convertFteInDays() {			//Convert FTE in days
	
	var f = document.frm_member ;
	
	if(!isEmpty($("#member_fte").val())) {
		
		planAjax.call({
			accion: "<%=ProjectPlanServlet.JX_VERIFY_FTE%>",
			idActivity: f.idActivity.value,
			id: document.forms['frm_project'].id.value,
			plannedFinishDate: $('#plannedFinishDate').html(),
			member_id: f.idmember.value,
			member_fte: f.member_fte.value,
			member_datein: f.member_datein.value,
			member_dateout: f.member_dateout.value,
			employee_id: f.employee_id.value,
			<%-- <%=Teammember.SELLRATE%>: f.<%=Teammember.SELLRATE%>.value, --%>
			//idSkill: f.idSkill.value,
			//commentsPm: $("#commentsPm").val(),
			//member_days: f.member_days.value
		},function(data){
			var dataRow = data.member_days ;
			$("#member_days").val(dataRow);
			maxWorksDays = data.number_works_days ;
		});
	}
	
}

function convertDaysInFte() {			//Convert days in FTE
	
	var f= document.frm_member ;
	
	if(!isEmpty($("#member_days").val())) {
		
		planAjax.call({
			accion: "<%=ProjectPlanServlet.JX_VERIFY_DAYS%>",
			idActivity: f.idActivity.value,
			id: document.forms['frm_project'].id.value,
			plannedFinishDate: $('#plannedFinishDate').html(),
			member_id: f.idmember.value,
			//member_fte: f.member_fte.value,
			member_datein: f.member_datein.value,
			member_dateout: f.member_dateout.value,
			employee_id: f.employee_id.value,
			<%-- <%=Teammember.SELLRATE%>: f.<%=Teammember.SELLRATE%>.value, --%>
			//idSkill: f.idSkill.value,
			//commentsPm: $("#commentsPm").val(),
			member_days: f.member_days.value
		},function(data){
			maxWorksDays = data.number_works_days;
			var dataRow = data.member_fte ;
			console.log(dataRow  + " fte");
			$("#member_fte").val(dataRow);
			validatorMember.form();
		});
	}
}

readyMethods.add(function() {
	
	$("#member_days").focusout(function(){ 
		convertDaysInFte();                  //Convert days in FTE
	});
	$("#member_fte").focusout(function(){
		convertFteInDays();					//Convert FTE in days
	});
	 $("#member_days").keypress(function(event){  // Permettre validation avec touche entree
		var keyCode = event.keyCode ;
		if(keyCode == '13') {
			convertDaysInFte();
		} 
	});
	$("#member_fte").keypress(function(event){   // Permettre validation avec touche entree
		var keyCode = event.keyCode ;
		if(keyCode == '13') {
			convertFteInDays();
		}
	});
	
	/* $("#member_datein").change(function(){
		if (!isEmpty($("#member_dateout").val()) && $("#member_dateout").val().getTime() > $("#member_datein").val().getTime() && !isEmpty($("#member_fte").val())) { //En cours de dev
			convertFteInDays();
		}//En cours de dev
	}); */

	$('div#member-popup').dialog({ 
		autoOpen: false, 
		modal: true, 
		width: 500, 
		minWidth: 700, 
		resizable: false,
		open: function(event, ui) { validatorMember.resetForm(); }
	});
		
	validatorMember = $("#frm_member").validate({
		errorContainer: 'div#member-errors',
		errorLabelContainer: 'div#member-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#member-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			member_fte: { range: [1,100] },
			member_days: { required: true, nbjour: true },     //Règle sur le nombre de jours
			member_datein: {
				required: true,
				date: true,
				minDateTo: '#valPlanEndDate',
				maxDateTo: '#valPlanInitDate'
			},
			member_dateout: {
				required: true,
				date: true,
				minDateTo: '#valPlanEndDate',
				maxDateTo: '#valPlanInitDate'
			},
			idActivity: { act_cheked: true }
		},
		messages: {
			member_fte: { range: '${fmtFteOutOfRange}' },
			member_days:  { nbjour: '${fmtDaysNotWorkingDays}' }, //messages d'erreurs sur le type de jour d'assignation
			member_datein: {
				required: '${fmtInDateRequired}',
				date: '${fmtInDateFormat}',
				minDateTo: '${fmtMemberInDateBeforeFinish} (${valPlanEndDate})',
				maxDateTo: '${fmtMemberInDateAfterStart} (${valPlanInitDate})'
			},
			member_dateout: {
				required: '${fmtOutDateRequired}',
				date: '${fmtOutDateFormat}',
				minDateTo: '${fmtMemberOutDateBeforeFinish} (${valPlanEndDate})',
				maxDateTo: '${fmtMemberOutDateAfterStart} (${valPlanInitDate})'
			},
			idActivity: { act_cheked: '${fmtActivityRequired}' }
		}
	});
	
	$.validator.addMethod("act_cheked", function(value, element) {
		if(value == -1) { 
			return false;
		}
		return true;
	});
	$.validator.addMethod("nbjour", function(value, element) {  // maxWorkDays = 0 => selection d'un jour ferie ou un weekend
		if ( maxWorksDays < 1 ) {
			return false
		}
		return true;
	});

	$("#idActivity").change( function() {
		changeActivityDates();
	});
	/*
	$("#member_days").on("focusout", function(){
		convertDaysInFte();
	});
	$("#member_fte").on("focusout", function(){
		convertFteInDays();
	});
	*/

});
//-->
</script>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<script>
		readyMethods.add(function() {
			var dates = $('#member_datein, #member_dateout').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function(selectedDate) {
					if(!isEmpty($("#member_fte").val())){
						convertDaysInFte();
					}
					if (validatorMember.numberOfInvalids() > 0) validatorMember.form();
				}
			});
		});
	</script>
</c:if>

<div id="member-popup" class="popup">

	<div id="member-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="member-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_member" id="frm_member" action="<%=ProjectPlanServlet.REFERENCE%>" >
		<input type="hidden" name="idmember" value="" />
		<input type="hidden" name="employee_id" />		
		
		<fieldset>
			<legend><fmt:message key="contact"/></legend>
			<table width="100%" cellpadding="4">
				<tr>
					<th><fmt:message key="contact.fullname"/></th>
					<th width="18%"><fmt:message key="maintenance.resource.cost_rate"/></th>
					<th colspan="2"><fmt:message key="skill"/></th>
				</tr>
				<tr>
					<td class="center" id="tm_fullname"></td>
					<td class="center" id="<%=Employee.COSTRATE%>"></td>
					<td class="center" id="skill" colspan="2"></td>
				</tr>
				<tr>
					<th width="33%"><fmt:message key="maintenance.contact.business_phone"/></th>
					<th width="33%" colspan="2"><fmt:message key="maintenance.contact.mobile_phone"/></th>
					<th width="34%"><fmt:message key="maintenance.contact.email"/></th>
				</tr>
				<tr>
					<td class="center" id="<%=Contact.BUSINESSPHONE%>"></td>
					<td class="center" colspan="2" id="<%=Contact.MOBILEPHONE%>"></td>
					<td class="center" id="<%=Contact.EMAIL%>"></td>
				</tr>
			</table>
		</fieldset>
		<div>&nbsp;</div>
		<div id="commentsForRM">
			<fieldset>
				<legend><fmt:message key="comments.rm"/></legend>
				<div id="commentsRm"></div>
			</fieldset>
			<div>&nbsp;</div>
		</div>
		<fieldset>
			<legend><fmt:message key="edit_resource"/></legend>
			<table id="tb_team_pop" width="100%" border="0" cellpadding="4">
				<tr>
					<th class="center" width="40%" colspan="2"><fmt:message key="activity"/>&nbsp;*</th>
					<th class="center" width="60%" colspan="2"><fmt:message key="skill"/></th>
				</tr>
				<tr>
					<td colspan="2">
						<select id="idActivity" name="idActivity" class="campo">
							<option value="-1"><fmt:message key="select_opt"/></option>
							<c:forEach var="activity" items="${activities}">								
								<c:if test="${((not empty activity.planInitDate) and (not empty activity.planEndDate) and activity.wbsnode.isControlAccount) }">
									<option value="${activity.idActivity }">${activity.activityName }</option>
								</c:if>
							</c:forEach>
						</select>
						<c:forEach var="activity" items="${activities }">						
							<c:if test="${((not empty activity.planInitDate) and (not empty activity.planEndDate)) }">
								<input type="hidden" id="planInitDate${activity.idActivity }" 
									value="<fmt:formatDate value="${activity.planInitDate}" pattern="${datePattern}"/>" />
								<input type="hidden" id="planEndDate${activity.idActivity }" 
									value="<fmt:formatDate value="${activity.planEndDate}" pattern="${datePattern}"/>" />
							</c:if>
						</c:forEach>
					</td>
					<td colspan="2">
						<select id="idSkill" name="idSkill" class="campo">
						</select>
					</td>
				</tr>
				<tr>
					<th class="center" width="33%"><fmt:message key="activity.planned_init_date"/></th>
					<th class="center" colspan="2"><fmt:message key="activity.planned_end_date"/></th>
					<th class="center" width="34%"><fmt:message key="team_member.sell_rate"/></th>
				</tr>
				<tr>
					<td class="center" id="act_planInitDate"></td>
					<td class="center" id="act_planEndDate" colspan="2"></td>
					<td class="center">
						<input type="text" name="<%=Teammember.SELLRATE %>" id="<%=Teammember.SELLRATE %>" class="campo importe" style="width: 40px;"/>
					</td>
				</tr>
				<tr>
					<th class="center" width="15%"><fmt:message key="team_member.fte"/></th>
					<th width="15%"><fmt:message key="team_member.days"></fmt:message></th>
					<th class="center"><fmt:message key="team_member.date_in"/>&nbsp;*</th>
					<th class="center"><fmt:message key="team_member.date_out"/>&nbsp;*</th>
				</tr>
				<tr>
					<td class="center">
						<input type="text" id="member_fte" name="member_fte" class="campo right" style="width:34px !important;">
					</td>
					<td class="center">
						<input type="text" id="member_days" name="member_days" class="campo right" style="width:25px">
					</td>
					<td align="center">
						<input type="text" id="member_datein" name="member_datein" class="campo fecha" />
					</td>
					<td align="center">
						<input type="text" id="member_dateout" name="member_dateout" class="campo fecha" />
					</td>
				</tr>
				<tr>
					<th colspan="4"><fmt:message key="comments"/></th>
				</tr>
				<tr>
					<td colspan="4"><textarea style="width: 100%" class="campo" name="commentsPm" id="commentsPm"></textarea></td>
				</tr>
			</table>
    	</fieldset>
		<div class="popButtons">
			<c:if test="${tl:hasPermission(user,project.status,tab)}">
				<a href="javascript:preasignedResource();" class="boton" id="btnPreassigned"><fmt:message key="resource.preassign"/></a>
				<a href="javascript:updateResource();" class="boton" id="btnUpdate"><fmt:message key="resource.update"/></a>
				<a href="javascript:releasedResource();" class="boton" id="btnReleased"><fmt:message key="resource.release"/></a>
			</c:if>
			<a href="javascript:closeTeamMember();" class="boton"><fmt:message key="close"/></a>
		</div>
    </form>
</div>
