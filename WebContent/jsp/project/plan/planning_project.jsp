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
 -  Devoteam 09/06/2015 user story 40 : updating viewActivity(element) JavaScript function
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.common.Settings"%>
<%@page import="es.sm2.openppm.model.Milestones"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.model.Projectactivity"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_wbs">
	<fmt:param><fmt:message key="wbs_node"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_wbs">
	<fmt:param><fmt:message key="wbs_node"/></fmt:param>
</fmt:message>
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_milestone">
	<fmt:param><fmt:message key="milestone"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_milestone">
	<fmt:param><fmt:message key="milestone"/></fmt:param>
</fmt:message>
<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message key="data_not_found" var="data_not_found" />
<fmt:message key="loading_chart" var="loading_chart" />

<fmt:message key="msg.confirm" var="msgConfirm" />
<fmt:message key="investment.no_way_back" var="msgNoWayBack" />

<fmt:message key="error" var="fmt_error" />

<c:set var="documentStorage"><%=es.sm2.openppm.common.Constants.DOCUMENT_STORAGE%></c:set>

<jsp:include page="../common/header_project.jsp">
	<jsp:param value="P1" name="actual_page"/>
</jsp:include>

<c:set var="hasPermission" value="${tl:hasPermission(user,project.status,tab)}"/>
<c:set var="notDefined" scope="request"><fmt:message key="not_defined" /></c:set>	<!-- cnw us40 using in viewActivity(element) JavaScript function -->

<%-- 
Request Attributes:
	programs: 		Program list
	project:		Project to plan	
	milestones: 	Project milestones
	kpis:			Project KPIs
--%>

<script type="text/javascript">
<!--
//Rules for validate project
var planValidator;
var planAjax = new AjaxCall('<%=ProjectPlanServlet.REFERENCE%>','<fmt:message key="error"/>');

// Data Tables
var wbsNodesTable;
var activitiesTable;
var milestonesTable;

function saveProject() {
	
	if (planValidator.form()) {
		
		var f = document.forms["frm_project"];
		f.accion.value = "<%=ProjectPlanServlet.SAVE_PROJECT%>";
		loadingPopup();
		f.submit();
	}
}

function approveProject() {
	confirmUI("${msgConfirm }", "${msgNoWayBack }", "${msgYes }", "${msgNo }",
			function() {
		var f = document.forms["frm_project"];
		f.accion.value = "<%=ProjectPlanServlet.APPROVE_PROJECT%>";
		loadingPopup();
		f.submit();
	});
}

function addWBS() {
	
	var params = {
		accion: "<%=ProjectPlanServlet.JX_CONS_WBSNODES%>", 
		id: $('#id').val()
	};
	
	planAjax.call(params, function (data) {
		var f = document.frm_wbsnode;
		f.reset();
		f.wbs_id.value = '';
		$(f.wbs_desc).text('');

		var options = '';
    	for (var i = 0; i < data.length; i++) {
	    	options += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
   		}
    	$("#wbs_parent").attr('disabled','').html(options);

    	$('#wbsnode-popup').dialog('open');
	});
}

function loadWBSNode(wbsNode) {
	
	var f = document.forms["frm_wbsnode"];
	f.reset();
	f.wbs_id.value = wbsNode[0];
	f.wbs_parent.value = wbsNode[3];
	f.wbs_code.value = unEscape(wbsNode[1]);
	f.wbs_name.value = unEscape(wbsNode[2]);
	f.wbs_budget.value = wbsNode[5];
	f.wbs_ca.checked = $('#wbscheck_'+wbsNode[0]).is(':checked');
	$(f.wbs_desc).text(unEscape(wbsNode[7]));	
	if (f.wbs_ca.checked && '${hasPermission}' == 'true') {		
		$('input#wbs_budget').attr('disabled','');
	}
	else {
		$('input#wbs_budget').attr('disabled','disabled');
	}
	
	// Show edit WBS Node popup
	$('#wbsnode-popup').dialog('open');
}

function editWBS(element) {
	
	var wbsNode = wbsNodesTable.fnGetData( element.parentNode.parentNode );

	
	if (wbsNode[3] == '') {
		$("#wbs_parent").attr('disabled','disabled');
		$("select#wbs_parent").html('');
   		loadWBSNode(wbsNode);
    }
   	else {
	
   		var params = {
			accion: "<%=ProjectPlanServlet.JX_CONS_WBSNODES%>", 
			id: $('#id').val(),
			idNode: wbsNode[0]
		};
   		
   		planAjax.call(params, function (data) {
	    	var options = '';
	    	for (var i = 0; i < data.length; i++) {
		    	options += '<option value="' + data[i].id + '">' + escape(data[i].name) + '</option>';
	   		}
	    	$("select#wbs_parent").html(options);
	    	
	    	if('${hasPermission}' == 'true') {
	    		$("#wbs_parent").attr('disabled','');	
	    	}
	    	
	    	loadWBSNode(wbsNode);
		});
   	}
}
function deleteWBSConfirmated(id) {
	$('#dialog-confirm').dialog("close");
	var f = document.forms["frm_project"];
	f.accion.value = "<%=ProjectPlanServlet.DELETE_WBSNODE%>";
	f.wbs_id.value = id;
	loadingPopup();
	f.submit();
}

function deleteWBS(id) {
	$('#dialog-confirm-msg').html('${msg_confirm_delete_wbs}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": function() {
					deleteWBSConfirmated(id);
				},
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_confirm_delete_wbs}'
	);
	$('#dialog-confirm').dialog('open');
}

function viewActivity(element) {
	
	var activity = activitiesTable.fnGetData( element.parentNode.parentNode );

	var f = document.forms["frm_activity"];
	f.reset();
	f.idactivity.value = activity[1];
	f.name.value = unEscape(activity[2]);
	f.init_date.value = activity[3];
	f.end_date.value = activity[4];
	f.init_workload.value = activity[5];				// cnw us40 getting initial workload value from the table
	f.<%=Projectactivity.PV%>.value = activity[6];

	if($("#init_workload").val() != '${notDefined}') {	// cnw us40 if initial workload is defined, set her control input readonly
		$("#init_workload").attr("readonly", "readonly");
	}
	$("#act_end_date").datepicker("option", "minDate", $('#act_init_date').val());
	$("#act_init_date").datepicker("option", "maxDate", $('#act_end_date').val());
	$("#wbs_dictionary").text(unEscape(activity[7]));
	
	$('#activity-popup').dialog('open');
}

function addMilestone() {
	var f = document.frm_milestone;
	f.reset();
	f.milestone_id.value = '';
	$("#milestoneDesc").text('');
	$("#<%=Milestones.NOTIFICATIONTEXT%>").text('');
	updateActivityDates();
	$('#milestone-popup').dialog('open');

	$("#<%=Milestones.NOTIFY %>").trigger("change");
}

function viewMilestone(element) {

	var milestone = milestonesTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_milestone"];
	
	// Set milestone info
	f.milestone_id.value	= milestone[0];
	f.report_type.checked 	= (milestone[7] == "Y"?"true":"");
	f.label.value			= unEscape(milestone[8]);
	f.planned_date.value	= milestone[4];
	f.activity.value		= milestone[1];
	f.<%=Milestones.NOTIFY%>.checked	 = (milestone[10] == "true"?"true":"");
	f.<%=Milestones.NOTIFYDAYS%>.value	 = milestone[11];
	
	updateActivityDates(milestone[1]);
	
	$("#milestoneDesc").text(unEscape(milestone[3]));
	$("#<%=Milestones.NOTIFICATIONTEXT%>").text(unEscape(milestone[12]));
	

	$("#<%=Milestones.NOTIFY %>").trigger("change");
	$('#milestone-popup').dialog('open');
}

function deleteMilestoneConfirmated(id) {
	$('#dialog-confirm').dialog("close");
	
	var params = {
		accion: "<%=ProjectPlanServlet.JX_DELETE_MILESTONE%>", 
		milestone_id: id
	};
	
	planAjax.call(params, function(data){
		
		if (data.id) {
		    var anSelected = fnGetSelected( milestonesTable );
		    milestonesTable.fnDeleteRow( anSelected[0], null, true );
		}
	});
}

function deleteMilestone(element) {
	
	var milestone = milestonesTable.fnGetData( element.parentNode.parentNode );
	
	$('#dialog-confirm-msg').html('${msg_confirm_delete_milestone}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": function() {
					deleteMilestoneConfirmated(milestone[0]);
				},
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_confirm_delete_milestone}'
	);
	$('#dialog-confirm').dialog('open');
	return false;
}

function drawChart(DOMId, chartId, dataXML, width, height) {
	var chart1 = new FusionCharts("FusionCharts/FCF_Gantt.swf", DOMId, width, height); 
    chart1.setDataXML(dataXML);    
    chart1.render(chartId);
}

function scheduleChart() {
	
	var params = {
		accion: "<%=ProjectPlanServlet.JX_PLAN_GANTT_CHART%>",
		id: $("#id").attr("value"),
		filter_start: $('#filter_start').val(),
		filter_finish: $('#filter_finish').val()
	};
	
	$('#chartGantt').html('${loading_chart}');
	
	planAjax.call(params, function (data) {
		
		if (data.tasks == null) {
			$(".legend").hide();
			$("#chartGantt").html('${data_not_found}');
		}
		else {
			$(".legend").show(); 
			height = (parseInt(data.tasks) * 37)+80;
			height += "";
			drawChart('chartGanttId', "chartGantt", data.xml,"800",height);
		}
	});
}

function chartWBS() {
	
	var params = {
		accion: "<%=ProjectPlanServlet.JX_WBS_CHART%>",
		id: $("#id").attr("value")
	};
	
	$('#wbsChart').html('${loading_chart}');
	
	planAjax.call(params, function (data) {
		if (data.chart_code == null) {
			$("#wbsChart").html('${data_not_found}');
		}
		else {
			$('#wbsChart').html(data.chart_code);
			$(".gray").treeview({
				control: "#treecontrol",
				collapsed: true
			});
		}
	});
}

function hideWbsChart() {
	$('#content-wbs').hide('fast');
}
function showWbsChart() {
	$('#content-wbs').show('fast');
}

function hideScheduleChart() {
	$('#visibleGantt').hide();
}

function showScheduleChart() {
	$('#visibleGantt').show();
}

function validateWBS() {
	
	var params = {
		accion: "<%=ProjectPlanServlet.JX_WBS_VALIDATE%>", 
		<%=Project.IDPROJECT%>: $("#id").val()
	};
	
	planAjax.call(params);
}

function handleSliderChange(e, ui) {
  var maxScroll = $("#wbs-scroll").attr("scrollWidth") - $("#wbs-scroll").width();
  $("#wbs-scroll").animate({scrollLeft: ui.value * (maxScroll / 100) }, 1000);
}
function handleSliderSlide(e, ui){
  var maxScroll = $("#wbs-scroll").attr("scrollWidth") - $("#wbs-scroll").width();
  $("#wbs-scroll").attr({scrollLeft: ui.value * (maxScroll / 100) });
}
// When document is ready
readyMethods.add(function() {

	$("#content-slider").slider({
		  animate: true,
		  change: handleSliderChange,
		  slide: handleSliderSlide
		});
	
	wbsNodesTable = $('#tb_wbsnodes').dataTable({
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,		
		"bInfo": false,
		"iDisplayLength": 50,
		"aoColumns": [ 
             { "bVisible": false }, 
             { "sClass": "center" }, 
             { "bVisible": true }, 
             { "bVisible": false }, 
             { "sClass": "center", "bSortable": false },
             { "sClass": "right", "sType": "numeric" },
             { "sClass": "center", "bSortable": false },
             { "bVisible": false } 
     	]
	});
	
	activitiesTable = $('#tb_activities').dataTable({
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"aoColumns": [ 
		              { "bVisible": false }, 
		              { "bVisible": false }, 
		              { "bVisible": true }, 
		              { "sClass": "center", "sType": "es_date" }, 
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center", "bVisible": true},			// cnw us40 adding initial workload column
		              { "bVisible": false}, 
		              { "bVisible": false },
		              { "sClass": "center", "bSortable": false }
		      		]
	});

	$('#tb_activities tbody tr').live('click', function (event) {
		fnSetSelectable(activitiesTable, this);
	} );

	milestonesTable = $('#tb_milestones').dataTable({
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"aoColumns": [
		              { "bVisible": false  }, 
		              { "bVisible": false  }, 
		              { "bVisible": true  },
		              { "sClass": "left" },
		              { "sClass": "center", "sType": "es_date" },		              
		              { "sClass": "left","bSortable": false },
		              { "sClass": "left","bSortable": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "center", "bSortable": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false }
		      		]
	});

	$('#tb_milestones tbody tr').live('click', function (event) {
		fnSetSelectable(milestonesTable, this);
	} );

	
	var dates = $('#filter_start, #filter_finish').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "filter_start" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
		}
	});
	
	
	planValidator = $("#frm_project").validate({
		errorContainer: 'div#project-errors',
		errorLabelContainer: 'div#project-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			scope_statement: { maxlength: 1500 },
			schedule_hd_description: { maxlength: 500 }
		}
	});
});

//-->
</script>

<c:if test="${project.status eq status_initiating or project.status eq status_planning}">
<script>
	readyMethods.add(function() {
		wbsNodesTable.fnSetColumnVis( 6, true );
	});
	</script>
</c:if>
	
<div class="caja_formulario">
	<form name="frm_project" id="frm_project" method="post" action="<%=ProjectPlanServlet.REFERENCE%>">
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="id" id="id" value="${project.idProject}" />
		<input type="hidden" name="status" value="${project.status}" />
		<input type="hidden" name="wbs_id" id="wbs_id" />
		<input type="hidden" name="act_id" id="act_id" />
		<input type="hidden" name="milestone_id" id="milestone_id" />
		<%-- Params for Cost Plan --%>		
		<input type="hidden" name="income_id" id="income_id" />
		<input type="hidden" name="followup_id" id="followup_id" />
		<input type="hidden" name="cost_id" id="cost_id" />
		<input type="hidden" name="cost_type" id="cost_type" />
		<input type="hidden" name="iwo_id" id="iwo_id" />
		<input type="hidden" id="idDocument" name="idDocument" />
		<%-- Params for HR --%>
		<input type="hidden" name="idPerfOrg" id="idPerfOrg" value="${project.performingorg.idPerfOrg }" />
	
   		<div id="project-errors" class="ui-state-error ui-corner-all hide">
			<p>
				<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong><fmt:message key="msg.error_title"/></strong>
				&nbsp;(<b><span id="project-numerrors"></span></b>)
			</p>
			<ol></ol>
		</div>
		
		<%-- Information of Project --%>
		<jsp:include page="../common/info_project.jsp" flush="true" />
		
		<%-- SCOPE PLAN --%>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldPlanScope')"><fmt:message key="scope"/></legend>
			<div class="buttons">
				<img id="fieldPlanScopeBtn" onclick="changeCookie('fieldPlanScope', this)" class="link" src="images/ico_mas.gif">
			</div>
			
			<div id="fieldPlanScope" class="hide">
				<div class="hColor"><fmt:message key="scope_statement"/></div>						
				<div style="margin-top:10px;">
					<textarea name="scope_statement" id="scope_statement" class="campo" rows="8" style="width: 99%;">${project.scopeStatement}</textarea>
				</div>
				<div class="hColor" style="margin-top:10px;">
					<fmt:message key="wbs"/>
				</div>
				<table id="tb_wbsnodes" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%"><fmt:message key="wbs.wbs"/></th>
							<th width="12%"><fmt:message key="wbs.code"/></th>
							<th width="60%"><fmt:message key="wbs.name"/></th>
							<th width="0%"><fmt:message key="wbs.parent"/></th>
							<th width="5%"><fmt:message key="wbs.ca"/></th>
							<th width="15%"><fmt:message key="wbs.budget"/></th>
							<th width="8%">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img src="images/add.png" class="link" onclick="addWBS()" title="<fmt:message key="add"/>" />
								</c:if>
							</th>
							<th width="0%">&nbsp;</th>
						</tr>
					</thead>
					<c:set var="totalWBS" value="0"/>
					<c:forEach var="wbsNode" items="${wbsnodes}">
						<c:if test="${wbsNode.budget >= 0 and wbsNode.wbsnode != null}">							
							<c:set var="totalWBS" value="${totalWBS + wbsNode.budget}"/>
						</c:if>
					</c:forEach>
					<tbody>
						<c:forEach var="wbsNode" items="${wbsnodes}">
							<tr>
								<td>${wbsNode.idWbsnode}</td>
								<td>${tl:escape(wbsNode.code)}</td>
								<td>${tl:escape(wbsNode.name)}</td>
								<td>${wbsNode.wbsnode.idWbsnode}</td>
								<td><input id="wbscheck_${wbsNode.idWbsnode}" value="${wbsNode.idWbsnode}" type="checkbox" ${wbsNode.isControlAccount ? "checked" :"" } disabled/></td>
								<td id="budget_${wbsNode.idWbsnode}">
									<c:choose>
										<c:when test="${wbsNode.wbsnode == null and not wbsNode.isControlAccount}">
											${tl:toCurrency(totalWBS )}
										</c:when>
										<c:when test="${wbsNode.budget >= 0}">
											${tl:toCurrency(wbsNode.budget )}
										</c:when>
									</c:choose>
								</td>
								<td>
									<img onclick="editWBS(this)" class="link" src="images/view.png" title="<fmt:message key="view"/>"/>
									<c:if test="${tl:hasPermission(user,project.status,tab) and wbsNode.wbsnode ne null and not wbsNode.isControlAccount }">
										&nbsp;&nbsp;&nbsp;
										<img src="images/delete.jpg" class="link" onclick="deleteWBS(${wbsNode.idWbsnode})" title="<fmt:message key="delete"/>" />
									</c:if>
								</td>
								<td>${tl:escape(wbsNode.description)}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>			
				<a href="#" class="boton" onClick="validateWBS()"><fmt:message key="wbs.validate" /></a>
				
				<%-- CHECKLIST --%>
				<jsp:include page="plan_checklist.inc.jsp" flush="true"/>
				
				<fieldset style="margin-top:15px;" class="level_2">
					<legend class="link" onclick="changeIco('content-wbs', 'legend', chartWBS)"><fmt:message key="wbs"/></legend>
					<div class="buttons">
						<img id="content-wbsBtn" onclick="changeIco('content-wbs', this, chartWBS)" class="link" src="images/ico_mas.gif">
					</div>
					<div id="content-wbs" style="display:none">
						<div style="padding-top:5px;">
							<a href="javascript:chartWBS();" class="boton"><fmt:message key="chart.refresh" /></a>
						</div>
						<div id="wbs-scroll" style="padding: 10px 0px;"><div id="wbsChart"></div></div>
						<div id="content-slider"></div>
						<div style="padding-top: 10px;">
							<span class="wGroups">&nbsp;&nbsp;&nbsp;</span>&nbsp;<fmt:message key="work_group"/>&nbsp;
							<span class="cAccount">&nbsp;&nbsp;&nbsp;</span>&nbsp;<fmt:message key="wbs.ca_long"/>
						</div>
					</div>
				</fieldset>
			</div>
		</fieldset>

		<%-- SCHEDULE PLAN --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldPlanSchedule')"><fmt:message key="schedule"/></legend>
			<div class="buttons">
				<img id="fieldPlanScheduleBtn" onclick="changeCookie('fieldPlanSchedule', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldPlanSchedule" class="hide">
				<div class="hColor"><fmt:message key="schedule_high_level_description"/></div>						
				<div style="margin-top:10px;">
					<textarea name="schedule_hd_description" id="schedule_hd_description" class="campo" rows="8" style="width: 99%;">${project.hdDescription}</textarea>
				</div>				
				<div class="hColor" style="margin-top:10px;"><fmt:message key="activity_list"/></div>
				<table id="tb_activities" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%"><fmt:message key="activity.wp"/></th>
							<th width="0%"><fmt:message key="activity.act"/></th>
							<th width="50%"><fmt:message key="activity.name"/></th>
							<th width="15%"><fmt:message key="baseline_start"/></th>
							<th width="15%"><fmt:message key="baseline_finish"/></th>
							<th width="10%"><fmt:message key="activity.init_workload"/></th> <!-- cnw us40 adding column for the initial workload -->
							<th width="0%"><fmt:message key="planned_value"/></th>
							<th width="0%">&nbsp;</th>
							<th width="8%">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="activity" items="${activities}">
							<c:if test="${activity.wbsnode.isControlAccount}">
								<tr>
									<td>${activity.wbsnode.idWbsnode}</td>
									<td>${activity.idActivity}</td>
									<td>${tl:escape(activity.activityName)}</td>
									<td><fmt:formatDate value="${activity.planInitDate}" pattern="${datePattern}"/></td>
									<td><fmt:formatDate value="${activity.planEndDate}" pattern="${datePattern}"/></td>
									<td>		<!-- cnw us40 -->
										<c:if test="${activity.initWorkload eq null}"><fmt:message key="not_defined" /></c:if>
										<c:if test="${activity.initWorkload ne null}">${activity.initWorkload}</c:if>
									</td>
									<td>${tl:toCurrency(activity.pv)}</td>
									<td>${tl:escape(activity.wbsdictionary)}</td>
									<td>
										<img onclick="viewActivity(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
				<div class="hColor" style="margin-top:10px"><fmt:message key="milestones.list"/></div>
				<table id="tb_milestones" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th>&nbsp;</th>
							<th>&nbsp;</th>
							<th width="32%"><fmt:message key="activity.name"/></th>
							<th width="30%"><fmt:message key="milestone.desc"/></th>
							<th width="10%"><fmt:message key="milestone.due_date"/></th>							
							<th width="10%"><fmt:message key="milestone.show_sign"/></th>
							<th width="10%"><fmt:message key="milestone.notify"/></th>
							<th>&nbsp;</th>
							<th width="0%"><fmt:message key="milestone.label"/></th>
							<th width="8%">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img onclick="addMilestone()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
								</c:if>
							</th>
							<th>&nbsp;</th>
							<th>&nbsp;</th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="milestone" items="${milestones}">
							<tr>
								<td>${milestone.idMilestone}</td>
								<td>${milestone.projectactivity.idActivity}</td>
								<td>${tl:escape(milestone.projectactivity.activityName)}</td>
								<td>${tl:escape(milestone.description)}</td>
								<td><fmt:formatDate value="${milestone.planned}" pattern="${datePattern}"/></td>
								<td>
									<input type="checkbox" disabled="disabled"
										<c:if test="${milestone.reportType == 'Y'}">
											checked
										</c:if>
									/>
								</td>
								<td>
									<input type="checkbox" disabled="disabled" ${milestone.notify?"checked":""}/>
								</td>
								<td>${milestone.reportType}</td>
								<td>${tl:escape(milestone.label)}</td>
								<td>
									<img onclick="viewMilestone(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
									<c:if test="${tl:hasPermission(user,project.status,tab)}">
										&nbsp;&nbsp;&nbsp;
										<img onclick="deleteMilestone(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
									</c:if>
								</td>
								<td>${milestone.notify}</td>
								<td>${milestone.notifyDays}</td>
								<td>${tl:escape(milestone.notificationText)}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
            	<fieldset style="margin-top:15px" class="level_2">
            		<legend class="link" onclick="changeIco('visibleGantt', 'legend', scheduleChart)"><fmt:message key="schedule_chart"/></legend>
					<div class="buttons">
						 <img id="visibleGanttBtn" onclick="changeIco('visibleGantt', this, scheduleChart)" class="link" src="images/ico_mas.gif">
					</div>
            		<div id="visibleGantt" class="hide">
            			<div style="padding-top:10px;">
            				<span style="margin-right:5px;">
								<fmt:message key="dates.since"/>:&nbsp;
								<input type="text" id="filter_start" class="campo fecha alwaysEditable" value="${valPlanInitDate}"/>
            				</span>
            				<span style="margin-right:5px;">
								<fmt:message key="dates.until"/>:&nbsp;
								<input type="text" id="filter_finish" class="campo fecha alwaysEditable" value="${valPlanEndDate}"/>
							</span>
							<a href="javascript:scheduleChart();" class="boton"><fmt:message key="chart.refresh" /></a>
            			</div>
						<div id="chartGantt"></div>
					</div>
            	</fieldset>

			</div>
		</fieldset>
		
		<%-- PLAN COSTS --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldPlanCosts')"><fmt:message key="plan-costs"/></legend>
			<div class="buttons">
				<img id="fieldPlanCostsBtn" onclick="changeCookie('fieldPlanCosts', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldPlanCosts" class="hide" style="padding-top:10px;">
				<jsp:include page="plan_cost.inc.jsp" flush="true" />
			</div>
		</fieldset>
		
		<%-- PLAN HUMAN RESOURCES --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldPlanHR')"><fmt:message key="plan_hr"/></legend>
			<div class="buttons">
				<img id="fieldPlanHRBtn" onclick="changeCookie('fieldPlanHR', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldPlanHR" class="hide" style="padding-top:10px;">
				<jsp:include page="plan_hr.inc.jsp" flush="true" />
			</div>
		</fieldset>
		
		<%-- PROJECT CALENDAR --%>
		<div>&nbsp;</div>
		<jsp:include page="plan_calendar.inc.jsp" flush="true"/>
		
		<%-- TEAM CALENDAR --%>
		<div>&nbsp;</div>
		<jsp:include page="plan_team_calendar.inc.jsp" flush="true"/>
		
		<%-- KPI --%>
		<div>&nbsp;</div>
		<jsp:include page="plan_kpi.inc.jsp" flush="true"/>
		
	</form>
	
	<div style="">&nbsp;</div>
	
	<fmt:message var="documentationTitle" key="documentation.planning"/>
	<jsp:include page="../common/project_documentation_${documentStorage}.jsp">
		<jsp:param name="documentationType" value="<%=Constants.DOCUMENT_PLANNING %>"/>
		<jsp:param name="documentationTitle" value="${documentationTitle }"/>
	</jsp:include>
		
	<c:if test="${tl:hasPermission(user,project.status,tab)}">
		<div style="margin-top:15px;" class="right">
			<a href="#" class="boton" onClick="saveProject()"><fmt:message key="save" /></a>
			<c:if test="${project.status eq status_planning or project.status eq status_initiating}">
				<c:if test="${tl:isPluginActivated(pluginMSProject,plugins) }">
					<jsp:include page="../../plugins/msproject/msproject_import.jsp" flush="true" />
				</c:if>
			</c:if>								 
			<c:if test="${project.status eq status_planning}">
				<a href="javascript:approveProject();" class="boton ui-special" ><fmt:message key="execute_project" /></a>
			</c:if>
		</div>						
	</c:if>
</div>

<jsp:include page="new_wbsnode_popup.jsp" flush="true" />
<jsp:include page="edit_activity_popup.jsp" flush="true" />
<jsp:include page="new_milestone_popup.jsp" flush="true" />
<jsp:include page="new_cost_popup.jsp" flush="true" />
<jsp:include page="edit_teammember_popup.jsp" flush="true" />

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<jsp:include page="checklist_popup.jsp" flush="true" />
	<jsp:include page="new_income_popup.jsp" flush="true" />
	<jsp:include page="new_followup_popup.jsp" flush="true" />
	<jsp:include page="new_iwo_popup.jsp" flush="true" />
	<jsp:include page="calendar_popup.jsp" flush="true" />
	<jsp:include page="msg_rejected_teammember_popup.jsp" flush="true" />
	<jsp:include page="kpi_popup.jsp" flush="true" />
</c:if>
