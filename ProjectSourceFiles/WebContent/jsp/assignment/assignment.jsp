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

<%-----------------------------------------------------------------------------
-  Update : Devoteam, Cédric Ndanga Wandji
-   2015/04/09, userstory 10 : readyMethods.add(function())
-   2015/04/09, userstory 10 : adding column Days to <table id="tb_assignment">
-  Update : Devoteam, Xavier de Langautier
-   2015/04/23, user story 9:  Update header as table : tb_assigment
<<<<<<< TREE
-   2015/04/24, user story 9:   tb_assigment : Add column remaining_workload  (Reste à faire)
=======
-   2015/04/24, user story 9:   tb_assigment : Add column remaining_workload (Reste à faire)
>>>>>>> MERGE-SOURCE
-                               assignmentTable  : add a new line
------------------------------------------------------------------------------%>



<%@page import="es.sm2.openppm.servlets.AssignmentServlet"%>
<%@page import="es.sm2.openppm.model.Timesheet"%>
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="allow_working_non_labor" var="msgNonLaborDay"/>
<fmt:message key="restore_calendar_exceptions" var="msgRestoreCalendar"/>

<c:set var="statusInit" value="<%=Constants.STATUS_INITIATING %>"/>
<c:set var="statusPlan" value="<%=Constants.STATUS_PLANNING %>"/>
<c:set var="statusControl" value="<%=Constants.STATUS_CONTROL %>"/>
<c:set var="statusClosed" value="<%=Constants.STATUS_CLOSED %>"/>

<script type="text/javascript">
<!--
var assignmentTable;
var assignmentAjax = new AjaxCall('<%=AssignmentServlet.REFERENCE%>','<fmt:message key="error"/>');

function dateFilter() {
	var f = document.forms["frm_assignment"];
	f.accion.value = "<%=AssignmentServlet.FILTER_ASSIGNMENTS%>";
	f.submit();
}

function resetFilter() {
	$("#statusFilter").val('');
	$("#projectFilter").val('');
	$("#since").val('');
	$("#until").val('');
	$("#projectStatusFilter").val('');
	
	assignmentTable.fnResetAllFilters();
}

readyMethods.add(function() {
	
	assignmentTable = $('#tb_assignment').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aoColumns": [
			{ "bVisible": false },
			{ "bVisible": false },
			{ "bVisible": false },
			{ "sClass": "left"},
			{ "sClass": "left"},
			{ "sClass": "left"},
			{ "sClass": "center"},
			{ "sClass": "center"},
			{ "sClass": "right"},
			{ "sClass": "right"}, // us19 : rajout de l'alignement droite sur la nouvelle colone Days
			{ "sClass": "right"} // us9 : rajout remaining workload
     	],
     	"fnDrawCallback": function ( oSettings ) {
            if ( oSettings.aiDisplay.length == 0 ) {return;}
            var nTrs = $('#tb_assignment tbody tr');
            var iColspan = nTrs[0].getElementsByTagName('td').length;
            var sLastGroup = "";
            for ( var i=0 ; i<nTrs.length ; i++ ) {
                var iDisplayIndex = oSettings._iDisplayStart + i;
                var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[0];
                if ( sGroup != sLastGroup ) {
                    var nGroup = document.createElement( 'tr' );
                    var nCell = document.createElement( 'td' );
                    nCell.colSpan = iColspan;
                    nCell.className = "groupRow";
                    nCell.innerHTML = sGroup;
                    nGroup.appendChild( nCell );
                    nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
                    sLastGroup = sGroup;
                }
            }
        },
        "aoColumnDefs": [
			{ "bVisible": false, "aTargets": [ 0 ] }
		],
		"aaSortingFixed": [[ 0, 'asc' ]],
		"aaSorting": [[ 2, 'asc' ]],
        "sDom": 'lfr<"giveHeight"t>ip'
	});
	
	var sinceUntil = $('#since, #until').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {			
			dateFilter();
		}
	});
	
	$("#statusFilter").change( function() {
		assignmentTable.fnFilter($("#statusFilter").val(),5);
	});
	
	$("#projectFilter").change( function() {
		assignmentTable.fnFilter($("#projectFilter").val(),1);
	});
	
	$("#projectStatusFilter").change( function() {
		assignmentTable.fnFilter($("#projectStatusFilter").val(),2);
	});
	
	$('#since').keyup( function() { if($('#since').val().length == 10 || $('#since').val().length == 0) {dateFilter();} } );
	$('#until').keyup( function() { if($('#until').val().length == 10 || $('#until').val().length == 0) {dateFilter();} } );
		
	assignmentTable.fnResetAllFilters();
	
});

//-->
</script>

<form name="frm_assignment" id="frm_assignment" action="<%=AssignmentServlet.REFERENCE%>" method="post">
	
	<input type="hidden" name="accion" value="" />	
	
	<fieldset style="margin-bottom: 15px; padding-top: 10px; padding-bottom: 5px;">
		<div class="hColor"><fmt:message key="filter"/></div>
		<table width="100%" border="0" cellpadding="7" cellspacing="1"> 
			<tr>
				<th width="15%"><fmt:message key="assignments.status"/>:</th>
				<td width="37%">
					<select id="statusFilter" class="campo" style="width:100%;">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<option value="<fmt:message key="team_member.proposed" />"><fmt:message key="team_member.proposed" /></option>
						<option value="<fmt:message key="team_member.preassigned" />"><fmt:message key="team_member.preassigned" /></option>
						<option value="<fmt:message key="team_member.assigned" />"><fmt:message key="team_member.assigned" /></option>
						<option value="<fmt:message key="team_member.turneddown" />"><fmt:message key="team_member.turneddown" /></option>
					</select>
				</td>	
				<td width="0%">&nbsp;</td>			
				<th width="13%"><fmt:message key="project"/>:</th>
				<td width="35%">
					<select id="projectFilter" class="campo" style="width:100%;">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<c:forEach var="project" items="${projects}">
							<option value="${project.idProject}">${project.projectName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><fmt:message key="dates"/></th>
				<td>
					<span style="margin-right:5px;">
						<fmt:message key="dates.since"/>:&nbsp;
						<input type="text" id="since" name="since" class="campo fecha" value="<fmt:formatDate value="${dateIn}" pattern="${datePattern}"/>" maxlength="10" />
		       		</span>
		    		<span style="margin-right:5px;">
						<fmt:message key="dates.until"/>:&nbsp;
						<input type="text" id="until" name="until" class="campo fecha" value="<fmt:formatDate value="${dateOut}" pattern="${datePattern}" />" maxlength="10" />
					</span>
				</td>
				<td>&nbsp;</td>
				<th><fmt:message key="project_status"/>:</th>
				<td>
					<select id="projectStatusFilter" class="campo" style="width:100%;">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<option value="${statusInit}"><fmt:message key="project_status.${statusInit}" /></option>
						<option value="${statusPlan}"><fmt:message key="project_status.${statusPlan}" /></option>
						<option value="${statusControl}"><fmt:message key="project_status.${statusControl}" /></option>
						<option value="${statusClosed}"><fmt:message key="project_status.${statusClosed}" /></option>
					</select>
				</td>
			</tr>			
		</table>
		<div class="popButtons">
			<a href="javascript:resetFilter();" class="boton" ><fmt:message key="filter.reset" /></a>
		</div>
	</fieldset>
				
	<table id= "tb_assignment" width="100%" class="tabledata" cellspacing="1">
		<thead>  <!--  us9   ajout du reste à faire => remodelage des workload avec 2 sous colonnes dans le header ajout du rowspan et du cospan dans les <th>-->
			<tr>
			    <th rowspan=2 width="0%">&nbsp;</th> 					
				<th rowspan=2 width="0%">&nbsp;</th>
				<th rowspan=2 width="0%">&nbsp;</th>
				<th rowspan=2 width="50%"><fmt:message key="project"/></th>
				<th rowspan=2 width="15%"><fmt:message key="project_manager"/></th>					
				<th rowspan=2 width="10%"><fmt:message key="status"/></th>
				<th rowspan=2 width="10%"><fmt:message key="team_member.date_in"/></th>
				<th rowspan=2 width="10%"><fmt:message key="team_member.date_out"/></th>
				<th rowspan=2 width="10%"><fmt:message key="team_member.remaining_workload"/></th>
				<th colspan=2 width="15%"> <fmt:message key="team_member.forecast"/></th>  <!-- us9 -->
				<tr>			     
				     <th><fmt:message key="percent"/></th>  <!--  us9 : Modification pour ne mettre que le libelle % -->
				     <th><fmt:message key="team_member.days"/></th> <!-- us10 : rajout de la nouvelle colone pour le nombre de jours -->
			    </tr>
			</tr>                                                                           <!-- end us9 -->
		</thead>
		<tbody>
			<c:forEach var="member" items="${teamMembers}">
				<tr>
					<td>${member.projectactivity.project.projectName}</td>
					<td>${member.projectactivity.project.idProject}</td>
					<td>${member.projectactivity.project.status}</td>
					<td>${member.projectactivity.activityName}</td>
					<td>${member.projectactivity.project.employeeByProjectManager.contact.fullName}</td>												
					<td><fmt:message key="team_member.${member.status}" /></td>
					<td><fmt:formatDate value="${member.dateIn}" pattern="${datePattern}"/></td>
					<td><fmt:formatDate value="${member.dateOut}" pattern="${datePattern}"/></td>
					<td>${member.remainingWorkload}</td> <!-- us9 : rajout de la nouvelle colone pour le reste à faire -->
					<%-- <td>${member.remainingWorkload}<fmt:message key="team_member.unitday" /></td> --%>  <!-- us9 : rajout de la nouvelle colone pour le reste à faire -->
					<td>${member.fte}%</td>
					<td>${member.days}</td> <!-- us10 : rajout de la nouvelle colone pour le nombre de jours -->
					<%-- <td>${member.days}<fmt:message key="team_member.unitday" /></td>  --%><!-- us10 : rajout de la nouvelle colone pour le nombre de jours + unité-->
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>&nbsp;</div>
</form>
