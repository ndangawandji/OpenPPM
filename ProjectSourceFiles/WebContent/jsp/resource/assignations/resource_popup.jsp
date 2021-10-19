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
<%@page import="es.sm2.openppm.model.Projectactivity"%>
<%@page import="es.sm2.openppm.model.Employee"%>
<%@page import="es.sm2.openppm.model.Skill"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.model.Contact"%>
<%@page import="es.sm2.openppm.model.Teammember"%>
<%@page import="es.sm2.openppm.servlets.ResourceServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<%-- Message for validations --%>
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

<script language="javascript" type="text/javascript" >
<!--
var validatorMember;

function viewResource(idResource) {
	
	validatorMember.resetForm();
	
	var params = {
		accion: '<%=ResourceServlet.JX_VIEW_RESOURCE%>',
		idResource: idResource
	};
	resourceAjax.call(params, function(data) {
		
		var f = document.frm_resource_pop;
		f.reset();
		f.idResource.value = idResource;
		f.idResourceProposed.value = data.<%=Employee.IDEMPLOYEE%>;
		
		$('#idSkill').html(optionsSkills(data.skillArray));
		
		f.member_fte.value		= data.<%=Teammember.FTE%>;
		f.member_datein.value	= data.<%=Teammember.DATEIN%>;
		f.member_dateout.value	= data.<%=Teammember.DATEOUT%>;
		f.<%=Teammember.FTE%>.value		= data.<%=Teammember.FTE%>;
		f.<%=Teammember.DATEIN%>.value	= data.<%=Teammember.DATEIN%>;
		f.<%=Teammember.DATEOUT%>.value	= data.<%=Teammember.DATEOUT%>;
		f.<%=Teammember.SKILL%>.value	= data.<%=Teammember.SKILL%>;
		f.idSkill.value		= data.<%=Skill.IDSKILL%>;
		f.statusTag.value	= data.statusTag;
		f.<%=Teammember.PROJECTACTIVITY%>.value = data.<%=Teammember.PROJECTACTIVITY%>;
		f.<%=Project.PROJECTNAME%>.value	= data.<%=Project.PROJECTNAME%>;
		f.<%=Project.STATUS%>.value			= data.<%=Project.STATUS%>;
		f.<%=Project.PLANNEDINITDATE%>.value	= data.<%=Project.PLANNEDINITDATE%>;
		f.<%=Project.PLANNEDFINISHDATE%>.value	= data.<%=Project.PLANNEDFINISHDATE%>;
		f.<%=Project.EMPLOYEEBYPROJECTMANAGER%>.value = data.<%=Project.EMPLOYEEBYPROJECTMANAGER%>;
		f.<%=Project.PERFORMINGORG%>.value	= data.<%=Project.PERFORMINGORG%>;
		f.<%=Project.PROGRAM%>.value		= data.<%=Project.PROGRAM%>;
		f.<%=Contact.FULLNAME%>.value		= data.<%=Contact.FULLNAME%>;
		f.proposed_fullname.value		= data.<%=Contact.FULLNAME%>;
		f.<%=Projectactivity.PLANINITDATE %>.value = data.<%=Projectactivity.PLANINITDATE %>;
		f.<%=Projectactivity.PLANENDDATE %>.value = data.<%=Projectactivity.PLANENDDATE %>;
		
		$('#commentsRm').val(data.<%=Teammember.COMMENTSRM%>);
		
		var commentsPm = data.<%=Teammember.COMMENTSPM%>;
		
		if (typeof commentsPm === 'undefined' || commentsPm == '' || commentsPm == null) {
			$('#commentsForPM').hide();
		}
		else {
			$('#commentsForPM').show();
			$('#commentsPm').html(commentsPm);
		}
		
		if (data.statusVal == '<%=Constants.RESOURCE_PRE_ASSIGNED%>') {
			$('#tableActions').show();
			$('.status').attr('checked','');
			$('#approve').attr('checked','checked');
		}
		else {
			$('#tableActions').hide();
		}
		
		changeAction();
		$('#reject_resource_popup').dialog('open');
	});
}

function closeResource() { $('#reject_resource_popup').dialog('close'); }

function changeResource(accion) {
	
	var f = document.frm_resource_pop;
	
	var params = {
		accion: accion,
		idResource: f.idResource.value,
		commentsRm: $('#commentsRm').val()
	};
	resourceAjax.call(params, function() {
		
		resourceTable.fnDraw();
		closeResource();
	});
}

function proposedResource() {
	
	if (validatorMember.form()) {
		var f = document.frm_resource_pop;
		
		var params = {
			accion: '<%=ResourceServlet.JX_PROPOPSED_RESOURCE%>',
			idResource: f.idResource.value,
			idResourceProposed: f.idResourceProposed.value,
			dateIn: f.member_datein.value,
			dateOut: f.member_dateout.value,
			fte: f.member_fte.value,
			idSkill: f.idSkill.value,
			commentsRm: $('#commentsRm').val()
		};
		resourceAjax.call(params,function() {
			resourceTable.fnDraw();
			closeResource();
		});
	}
}

function actionResource() {
	
	var value = $('.status:checked').val();
	
	if (value == 'approve') { changeResource('<%=ResourceServlet.JX_APPROVE_RESOURCE%>'); }
	else if (value == 'reject') { changeResource('<%=ResourceServlet.JX_REJECT_RESOURCE%>'); }
	else if (value == 'proposed') { proposedResource(); }
	
	return false;
}

function changeAction() {
	
	var value = $('.status:checked').val();
	
	$('#buttonAction').show();
	
	$('#commentsRm').attr('disabled','');
	
	if (value == 'approve') {
		$('#tableProposed').hide();
		$('#buttonAction').val('<fmt:message key="approve" />');
	}
	else if (value == 'reject') {
		$('#tableProposed').hide();
		$('#buttonAction').val('<fmt:message key="resource.turndown" />');
	}
	else if (value == 'proposed') {
		$('#tableProposed').show();
		$('#buttonAction').val('<fmt:message key="resource.propose" />');
	}
	else {
		$('#commentsRm').attr('disabled','disabled');
		$('#buttonAction, #tableProposed').hide();
	}
}

function returnDate(id, msg) { return msg+' ('+$(id).val()+')'; }

readyMethods.add(function () {
	
	$('div#reject_resource_popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 700, 
		resizable: false
	});
	
	validatorMember = $("#frm_resource_pop").validate({
		errorContainer: 'div#member-errors',
		errorLabelContainer: 'div#member-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#member-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			member_fte: { range: [1,100] },
			member_datein: {
				required: true,
				date: true,
				minDateTo: '#<%=Projectactivity.PLANENDDATE %>',
				maxDateTo: '#<%=Projectactivity.PLANINITDATE %>'
			},
			member_dateout: {
				required: true,
				date: true,
				minDateTo: '#<%=Projectactivity.PLANENDDATE %>',
				maxDateTo: '#<%=Projectactivity.PLANINITDATE %>'
			}
		},
		messages: {
			member_fte: { range: '${fmtFteOutOfRange}' },
			member_datein: {
				required: '${fmtInDateRequired}',
				date: '${fmtInDateFormat}',
				minDateTo: function() { return returnDate('#<%=Projectactivity.PLANENDDATE %>','${fmtMemberInDateBeforeFinish}'); },
				maxDateTo: function() { return returnDate('#<%=Projectactivity.PLANINITDATE %>','${fmtMemberInDateAfterStart}'); }
			},
			member_dateout: {
				required: '${fmtOutDateRequired}',
				date: '${fmtOutDateFormat}',
				minDateTo: function() { return returnDate('#<%=Projectactivity.PLANENDDATE %>','${fmtMemberOutDateBeforeFinish}'); },
				maxDateTo: function() { return returnDate('#<%=Projectactivity.PLANINITDATE %>','${fmtMemberOutDateAfterStart}'); }
			}
		}
	});
	
	var dates = $('#member_datein, #member_dateout').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			if (validatorMember.numberOfInvalids() > 0) validatorMember.form();
		}
	});
});
//-->
</script>


<div id="reject_resource_popup" class="popup">

	<div id="member-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="member-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	
	<form name="frm_resource_pop" id="frm_resource_pop" method="post">
		<input type="hidden" name="idResource" value="" />
		<input type="hidden" name="idResourceProposed" value="" />
		<input type="hidden" name="<%=Projectactivity.PLANINITDATE %>" id="<%=Projectactivity.PLANINITDATE %>" value="" />
		<input type="hidden" name="<%=Projectactivity.PLANENDDATE %>" id="<%=Projectactivity.PLANENDDATE %>" value="" />
		
		<fieldset>
			<legend class="link" onclick="changeIco('tbProjectData', 'legend')"><fmt:message key="basic_data"/></legend>
			<div class="buttons">
				<img id="tbProjectDataBtn" onclick="changeIco('tbProjectData', this)" class="link" src="images/ico_mas.gif">
			</div>
			<table border="0" cellpadding="2" cellspacing="1" width="100%" id="tbProjectData" class="hide">
				<tr>
					<th width="40%"><fmt:message key="project" /></th>
					<th width="20%"><fmt:message key="status" /></th>
					<th width="20%"><fmt:message key="planned_init_date" /></th>
					<th width="20%"><fmt:message key="planned_close_date" /></th>
				</tr>
				<tr>
					<td><input type="text" name="<%=Project.PROJECTNAME%>" readonly/></td>
					<td><input type="text" name="<%=Project.STATUS%>" class="center" readonly/></td>
					<td><input type="text" name="<%=Project.PLANNEDINITDATE%>" id="valPlanInitDate" class="center" readonly/></td>
					<td><input type="text" name="<%=Project.PLANNEDFINISHDATE%>" id="valPlanEndDate" class="center" readonly/></td>
				</tr>
				<tr>
					<th><fmt:message key="project_manager" /></th>
					<th colspan="2"><fmt:message key="perforg" /></th>
					<th><fmt:message key="program" /></th>
				</tr>
				<tr>
					<td><input type="text" name="<%=Project.EMPLOYEEBYPROJECTMANAGER%>" readonly/></td>
					<td colspan="2"><input type="text" name="<%=Project.PERFORMINGORG%>" readonly/></td>
					<td><input type="text" name="<%=Project.PROGRAM%>" readonly/></td>
				</tr>
    		</table>
		</fieldset>
		<div>&nbsp;</div>
		<fieldset>
			<legend><fmt:message key="resource.data"/></legend>
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th width="40%"><fmt:message key="contact.fullname" /></th>
					<th width="20%"><fmt:message key="status" /></th>
					<th width="40%" colspan="2"><fmt:message key="skill" /></th>
				</tr>
				<tr>
					<td><input type="text" name="<%=Contact.FULLNAME%>" readonly/></td>
					<td><input type="text" name="statusTag" readonly/></td>
					<td colspan="2"><input type="text" name="<%=Teammember.SKILL%>" readonly/></td>
				</tr>
				<tr>
					<th><fmt:message key="activity" /></th>
					<th><fmt:message key="team_member.fte" /></th>
					<th><fmt:message key="team_member.date_in" /></th>
					<th><fmt:message key="team_member.date_out" /></th>
				</tr>
				<tr>
					<td><input type="text" name="<%=Teammember.PROJECTACTIVITY%>" readonly/></td>
					<td><input type="text" name="<%=Teammember.FTE%>" readonly/></td>
					<td><input type="text" name="<%=Teammember.DATEIN%>" readonly/></td>
					<td><input type="text" name="<%=Teammember.DATEOUT%>" readonly/></td>
				</tr>
    		</table>
    	</fieldset>
    	<div>&nbsp;</div>
    	<div id="commentsForPM">
			<fieldset>
				<legend><fmt:message key="comments.pm"/></legend>
				<div id="commentsPm"></div>
			</fieldset>
			<div>&nbsp;</div>
		</div>
		<div id="tableActions">
	  		<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th>
						<input type="radio" name="statusRe" class="status" id="approve" value="approve" style="width:20px;" onchange="changeAction()"/>
						&nbsp;<fmt:message key="approve"/>
					</th>
					<th>
						<input type="radio" name="statusRe" class="status" id="reject" value="reject" style="width:20px;" onchange="changeAction()"/>
						&nbsp;<fmt:message key="resource.turndown"/>
					</th>
					<th>
						<input type="radio" name="statusRe" class="status" id="proposed" value="proposed" style="width:20px;" onchange="changeAction()"/>
						&nbsp;<fmt:message key="resource.propose"/>
					</th>
				</tr>
	   		</table>
	   		<div>&nbsp;</div>
   		</div>
		<fieldset id="tableComments">
			<legend><fmt:message key="comments"/></legend>
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<td>
						<textarea name="commentsRm" id="commentsRm" style="width: 100%;" class="campo"></textarea>
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div>&nbsp;</div>
		<fieldset id="tableProposed">
			<legend><fmt:message key="resource.proposed.info"/></legend>
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th colspan="2" width="66%">
						<fmt:message key="resource" />
						<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="openFind()" />
					</th>
					<th width="34%"><fmt:message key="skill" /></th>
				</tr>
				<tr>
					<td colspan="2"><input name="proposed_fullname" id="proposed_fullname" class="campo" readonly/></td>
					<td>
						<select id="idSkill" name="idSkill" class="campo">
						</select>
					</td>
				</tr>
				<tr>
					<th><fmt:message key="team_member.fte"/></th>
					<th><fmt:message key="team_member.date_in"/></th>
					<th><fmt:message key="team_member.date_out"/></th>
				</tr>
				<tr>
					<td class="center"><input type="text" class="campo" style="width: 60px;" name="member_fte"/></td>
					<td class="center"><input type="text" class="campo fecha" name="member_datein" id="member_datein"/></td>
					<td class="center"><input type="text" class="campo fecha" name="member_dateout" id="member_dateout"/></td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<input type="submit" class="boton" id="buttonAction" style="width: 50px;" onclick="return actionResource();" value="<fmt:message key="reject" />">
			<a href="javascript:closeResource()" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
