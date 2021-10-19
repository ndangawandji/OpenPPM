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
<%@page import="es.sm2.openppm.model.Skill"%>
<%@page import="es.sm2.openppm.model.Teammember"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.model.Contact"%>
<%@page import="es.sm2.openppm.model.Employee"%>
<%@page import="es.sm2.openppm.model.Performingorg"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<%-- Messages --%>
<fmt:message key="error" var="fmtError" />

<%-- Messages for Confirmation --%>
<fmt:message key="msg.confirm_release" var="fmtReleaseMsgMember">
	<fmt:param><fmt:message key="team_member"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_release" var="fmtReleaseTitleMember">
	<fmt:param><fmt:message key="team_member"/></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var teamTable;
var searchTable;
var findates;

function newTeamMember(element) {
	
	var f = document.frm_member;
	f.reset();
	
	var aData = searchTable.fnGetData( element.parentNode.parentNode );
	
	$("#act_planInitDate").text("");
	$("#act_planEndDate").text("");
	$('#tm_fullname').text(aData[1]);
	$('#skill').html(aData[8]);
	$('#<%=Employee.COSTRATE%>').text(aData[5]);
	$('#<%=Contact.BUSINESSPHONE%>').text(aData[10]);
	$('#<%=Contact.MOBILEPHONE%>').text(aData[11]);
	$('#<%=Contact.EMAIL%>').text(aData[12]);
	$('#idSkill').html(aData[13]);
	$("#commentsPM").text('');
	
	f.employee_id.value = aData[0];
	f.idmember.value	= '';

	$('#btnReleased, #commentsForRM, #btnUpdate').hide();
	$('#btnPreassigned').show();
	
	$('#idActivity').attr('disabled', '');
	$('#idSkill').attr('disabled', '');
	$('#<%=Teammember.SELLRATE %>').attr('disabled', '');
	$('#member_fte').attr('disabled', '');
	
	chargeBTPop();
	$('#member_datein').datepicker('enable');
	showTeamMemberPopup();
}


function optionsSkills(data) {
	var options = '<option value=""><fmt:message key="select_opt"/></option>';
	
	$(data).each(function() {
		
		options += '<option value="'+this.<%=Skill.IDSKILL%>+'">'+escape(this.<%=Skill.NAME%>)+'</option>';

	});
	return options;
}

function findTeamMembers() {
	searchTable.fnClearTable();
	planAjax.call({
			accion: "<%=ProjectPlanServlet.JX_FIND_MEMBER %>",
			idSkill: $('#f_skill').val()+"",
			<%=Performingorg.IDPERFORG %>: $('#<%=Performingorg.IDPERFORG %>_select').val(),
			idResourceManager: $('#idResourceManager_select').val()
		}, function(data) {

			for(var i=0; i< data.length; i++) {
				searchTable.fnAddData( [
						data[i].id,				
	            		escape(data[i].fullname),
	            		escape(data[i].profile),
	            		escape(data[i].resource_manager),
	            		'',
	            		data[i].cost_rate,
	            		escape(data[i].performing_org),
	            		data[i].contact_id,
	            		(data[i].skill == ' ' ? ' ' : ('<div class="btitle" title="' + escape(data[i].skills) + '">' + escape(data[i].skill) + '...</div>')),
	            		'<img onclick="newTeamMember(this)" title="<fmt:message key="staff.pre_assign"/>" class="link ico" src="images/add_proj.png">',
	            		escape(data[i].<%=Contact.BUSINESSPHONE%>),
	            		escape(data[i].<%=Contact.MOBILEPHONE%>),
	            		escape(data[i].<%=Contact.EMAIL%>),
	            		optionsSkills(data[i].skillArray)
		           	]);
	        }
			chargeBT();	
	});
}

function chargeBT() {
	$('.btitle').bt({
		fill: '#F9FBFF',
		cssStyles: {color: '#343C4E', width: 'auto'},
		width: 250,
		padding: 10,
		cornerRadius: 5,
		spikeLength: 15,
		spikeGirth: 5,
		shadow: true,
		positions: 'top'
	});
}

function updateFteTable() {
	planAjax.call({
		accion:"<%=ProjectPlanServlet.JX_UPDATE_STAFFING_TABLE%>",
		idProject:'${project.idProject}',
		since: $("#resourcesStart").val(),
		until: $("#resourcesFinish").val()
	},function(data) {
		$('#staffingTable').html(data);
	},'html');
}

// When document is ready
readyMethods.add(function() {

	teamTable = $('#tb_team').dataTable({
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"iDisplayLength": 50,
		"bAutoWidth": false,
		"aaSorting": [[0,'desc']],
		"aoColumns": [
              { "bVisible": false },
              { "sWidth": "19%" }, 
              { "sWidth": "21%" },  
              { "sClass": "center", "sWidth": "10%" }, 
              { "sClass": "center", "sWidth": "10%" }, 
              { "sWidth": "18%" }, 
              { "sClass": "center", "sWidth": "8%" }, 
              { "sClass": "center", "sWidth": "8%" },
              { "sClass": "center", "sWidth": "4%", "bSortable" : false  }
      		]
	});

	$('#tb_team tbody tr').live('click', function (event) {
		fnSetSelectable(teamTable, this);
	} );
	
	searchTable = $('#find_result').dataTable({
		"oLanguage": datatable_language,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 50,
		"aoColumns": [
			  { "bVisible": false },
              { "sClass": "left" },
			  { "bVisible": false },
              { "sClass": "left" }, 
              { "bVisible": false }, 
              { "sClass": "right"}, 
              { "sClass": "left" }, 
              { "bVisible": false },
              { "sClass": "left" }, 
              { "sClass": "center", "bSortable": false },
              { "bVisible": false },
              { "bVisible": false },
              { "bVisible": false },
              { "bVisible": false }
     		]
	});


	$('#find_result tbody tr').live('click', function (event) {
		fnSetSelectable(searchTable, this);
	});
	
	$('div.dataTables_paginate span').live('mouseup', function() {
		setTimeout("chargeBT()",1000);
	});
	
	var dates = $('#resourcesStart, #resourcesFinish').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "resourcesStart" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
		}
	});
	chargeBT();
});
//-->
</script>
<div class="hColor"><fmt:message key="team_members"/></div>
<table id="tb_team" class="tabledata" cellspacing="1" width="100%">
	<thead>
		<tr>
			<th>&nbsp;</th>
			<th><fmt:message key="contact.fullname"/></th>
			<th><fmt:message key="activity"/></th>
			<th><fmt:message key="team_member.fte"/></th>
			<th><fmt:message key="status"/></th>
			<th><fmt:message key="perforg"/></th>
			<th><fmt:message key="team_member.date_in"/></th>
			<th><fmt:message key="team_member.date_out"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="member" items="${team}">
			<tr>
				<td>${member.idTeamMember}</td>
				<td>${tl:escape(member.employee.contact.fullName)}</td>
				<td>${tl:escape(member.projectactivity.activityName) }</td>
				<td>${member.fte +0}%</td>
				<td><fmt:message key="resource.${member.status}"/></td>
				<td>${tl:escape(member.employee.performingorg.name)}</td>
				<td><fmt:formatDate value="${member.dateIn}" pattern="${datePattern}" /></td>
				<td><fmt:formatDate value="${member.dateOut}" pattern="${datePattern}" /></td>
				<td><img onclick="editTeamMember(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png"></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<c:if test="${tl:hasPermission(user,project.status,tab)}">

<%-- FIND RESOURCE --%>
<div style="">&nbsp;</div>
<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldFindResource')"><fmt:message key="find"/></legend>
	<div class="buttons">
		<img id="fieldFindResourceBtn" onclick="changeCookie('fieldFindResource', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldFindResource" class="hide">
		<table id="find_filter" cellspacing="0" width="100%" style="text-align: center; padding-bottom: 10px;">
			<tr>
				<th width="40%"><fmt:message key="skill"/></th>
				<th width="25%"><fmt:message key="maintenance.businessline.perf_org"/></th>
				<th width="25%"><fmt:message key="maintenance.employee.resource_manager"/></th>
				<th width="10%" rowspan="2">
					<a class="boton" href="javascript:findTeamMembers();"><fmt:message key="find"/></a>
				</th>
			</tr>
			<tr>
				<td>
					<select id="f_skill" name="f_skill" class="campo" multiple="multiple">
						<c:forEach var="skill" items="${skills}">



							<option value="${skill.idSkill}">${skill.name}</option>


						</c:forEach>
					</select>
				</td>
				<td>
					<select id="<%=Performingorg.IDPERFORG %>_select" name="<%=Performingorg.IDPERFORG %>" class="campo">
						<option value="-1" selected><fmt:message key="select_opt"/></option>
						<c:forEach var="perforg" items="${perforgs}">
							<option value="${perforg.idPerfOrg}">${perforg.name}</option>
						</c:forEach>
					</select>
				</td>
				<td>
					<select id="idResourceManager_select" name="idResourceManager" class="campo">
						<option value="-1" selected><fmt:message key="select_opt"/></option>
						<c:forEach var="rm" items="${resourceManagers}">
							<option value="${rm.idEmployee}">${rm.contact.fullName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<table id="find_result" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="25%"><fmt:message key="contact.fullname"/></th>
					<th width="0%"><fmt:message key="profile"/></th>
					<th width="20%"><fmt:message key="resource_manager"/></th>
					<th width="0%">&nbsp;</th>
					<th width="10"><fmt:message key="cost.rate"/></th>
					<th width="20%"><fmt:message key="perforg"/></th>
					<th width="0%">&nbsp;</th>
					<th width="25"><fmt:message key="skill"/></th>
					<th width="5%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</fieldset>
</c:if>

<%-- PROJECT STAFFING TABLE --%>
<div style="">&nbsp;</div>
<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldPlanStaffing')"><fmt:message key="project_staffing"/></legend>
	<div class="buttons">
		<img id="fieldPlanStaffingBtn" onclick="changeCookie('fieldPlanStaffing', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldPlanStaffing" style="padding-top: 15px;" class="hide">
		<div>
     		<span style="margin-right:5px;">
				<fmt:message key="dates.since"/>:&nbsp;
				<input type="text" id="resourcesStart" class="campo fecha alwaysEditable" value="${valPlanInitDate}"/>
     		</span>
        	<span style="margin-right:5px;">
				<fmt:message key="dates.until"/>:&nbsp;
				<input type="text" id="resourcesFinish" class="campo fecha alwaysEditable" value="${valPlanEndDate}"/>
			</span>
			<a href="javascript:updateFteTable();" class="boton"><fmt:message key="staff.refresh" /></a>
		</div>
		<div id="staffingTable"></div>
	</div>
</fieldset>
