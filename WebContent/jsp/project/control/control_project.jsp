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
 	Update : Xavier De Langautier
 	Devoteam, 2015-05-19, user story 15 : ADD Remaining workload in Control Scope Frame on project/activities 
 	                                    : include new jsp => teammember_activity_popup.jsp                          			
  --%>
<%@page import="es.sm2.openppm.common.Settings"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.model.Milestones"%>
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.model.Projectactivity"%>
<jsp:useBean id="now" class="java.util.Date" scope="page" />
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<fmt:setLocale value="${locale}" scope="request" />

<fmt:message key="actions.projects.save_grsc" var="act_save_grsc" />
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete" />
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete" />
<fmt:message key="select_opt" var="msg_select_opt" />
<fmt:message key="data_not_found" var="data_not_found" />
<fmt:message key="loading_chart" var="loading_chart" />

<fmt:message key="error" var="fmt_error" />

<c:set var="documentStorage"><%=Constants.DOCUMENT_STORAGE%></c:set>


<%-- 
Request Attributes:
	project:		Project to control	
	followups:		List of project Followup
	milestones: 	Project milestones
	changes:		List of changes (included requested)
	changeTypes:	Change types List (for control_change_popup.jsp)
--%>

<script type="text/javascript">
<!--
var controlAjax = new AjaxCall('<%=ProjectControlServlet.REFERENCE%>','<fmt:message key="error"/>');


//Validate project to approve?
var approveRequired = false;

var followupsTable;
var activitiesTable;
var milestonesTable;
var activityScopeTable;
var teammemberActivityTable;   //us 15
var changeListTable;
var changeRequestTable;
var wbsscroll;
var teamtable;   //us15

function saveGRSC() {
	var f = document.frm_project;

	var idFollowup = f.followup_control.value;
	
	if (idFollowup != '') {
		
		var params = {
			accion: "<%=ProjectControlServlet.JX_SAVE_FOLLOWUP %>", 
			// Project data
			id: f.id.value,
			followup_id: idFollowup,
			general_status: f.general_status.value,
			general_desc: f.general_desc.value,
			risk_status: f.risk_status.value,
			risk_desc: f.risk_desc.value,
			schedule_status: f.schedule_status.value,
			schedule_desc: f.schedule_desc.value,
			cost_status: f.cost_status.value,
			cost_desc: f.cost_desc.value
		};
		
		controlAjax.call(params, function(data) {
				// Update Cualitative control table
				$('#desc_g_'+idFollowup).html(escape(f.general_desc.value));
				$('#desc_r_'+idFollowup).html(escape(f.risk_desc.value));
				$('#desc_s_'+idFollowup).html(escape(f.schedule_desc.value));
				$('#desc_c_'+idFollowup).html(escape(f.cost_desc.value));

				$('#status_g_'+idFollowup).removeClass();
				$('#status_g_'+idFollowup).addClass($('#general_status').children("[selected]").attr('class'));
				$('#status_r_'+idFollowup).removeClass();
				$('#status_r_'+idFollowup).addClass($('#risk_status').children("[selected]").attr('class'));
				$('#status_s_'+idFollowup).removeClass();
				$('#status_s_'+idFollowup).addClass($('#schedule_status').children("[selected]").attr('class'));
				$('#status_c_'+idFollowup).removeClass();
				$('#status_c_'+idFollowup).addClass($('#cost_status').children("[selected]").attr('class'));
		});
	}
}

function editFollowup(element) {

	var followup = followupsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_followup"];

	// Recover followup info
	f.followup_id.value	= followup[0];
	f.ev.value 			= followup[5];
	f.ac.value 			= followup[6];
	f.statusDate.value 	= followup[1];

	var ev = toNumber(f.ev.value);
	var bac = toNumber(f.bac.value);
	
	if (ev >= 0 && bac > 0) {
		f.poc.value = formatInteger((ev*100/bac));
	}
	// Display followup info
	$('#followup-popup').dialog('open');
}

function evmToCSV() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectControlServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectControlServlet.EXPORT_EVM_CSV %>";
	f.submit();
	return false;
}

function statusReportToCSV() {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectControlServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectControlServlet.EXPORT_SR_CSV %>";
	f.submit();
	return false;
}

function drawCharts(DOMId,xml,chartID,width,heigth){
	var chart = new FusionCharts("FusionCharts/FCF_MSLine.swf", DOMId, width, heigth); 
    chart.setDataXML(xml);    
    chart.render(chartID);
}
function drawChartCosts(DOMId,xml,chartID,width,heigth){
	var chart = new FusionCharts("FusionCharts/FCF_Line.swf", DOMId, width, heigth); 
    chart.setDataXML(xml);    
    chart.render(chartID);
}
function costCharts() {

	var DOMId1 = 'chartCostDOM';
	var DOMId2 = 'chartTVDOM';
	var DOMId3 = 'chartCVDOM';
	
	$('#chartFollowup').html('${loading_chart}');
	
	var params = {
		accion: "<%=ProjectControlServlet.JX_COST_CONTROL_CHART %>",
		id: $("#id").attr("value")
	};
	
	controlAjax.call(params, function(data) {
		if (typeof data.xml === 'undefined' || data.xml == "false"){ $("#chartFollowup").html('${data_not_found}'); }
		else {
			drawCharts(DOMId1,data.xml,'chartFollowup','750','400');
		}
		if (typeof data.xmlTime === 'undefined' || data.xmlTime == "false"){ $("#chartTimeVariance").html('${data_not_found}'); }
		else {
			drawChartCosts(DOMId2,data.xmlTime,'chartTimeVariance','750','400');
		}
		if (typeof data.xmlCost === 'undefined' || data.xmlCost == "false"){ $("#chartCostVariance").html('${data_not_found}'); }
		else {
			drawChartCosts(DOMId3,data.xmlCost,'chartCostVariance','750','400');
		}
	});
}

function controlScopeActivity(element) {
	
	var activity = activityScopeTable.fnGetData( element.parentNode.parentNode );

	var f = document.forms["frm_scope_activity"];
	// Recover activity info
	f.id.value = $('#id').attr('value');
	f.activity_id.value	= activity[0];
	f.name.value		= unEscape(activity[1]);
	f.bac.value 		= activity[2];
	f.ev.value 			= activity[3];
	f.poc.value 		= activity[4];

	// Display activity info
	$('#scope-activity-popup').dialog('open');
}

/* 
* Add : Devoteam Xavier de Langautier 2015/06/01 us 15
* 		function : controlViewTeammemberActivity
*                  Display  remainning workload for each teammember of the selected activity
 */

 function controlViewTeammemberActivity(element) {
	var activity = activityScopeTable.fnGetData( element.parentNode.parentNode );
   	
	var f = document.forms["frm_teammember_activity"];
		// Recover activity info
 	f.id.value = $('#id').attr('value');
 	f.activity_id.value	= activity[0];
 	f.projectactivity_name.value = activity[1];
    var params = {
 	accion: "<%=ProjectControlServlet.JX_GET_TEAMMEMBER %>", 
			id: activity[0]
 	};
    teamtable.fnClearTable();
    controlAjax.call(params, function(data) {
    	for(var i=0; i< data.length; i++) {
    		teamtable.fnAddData([
    		     data[i].teamFullName,
    		     data[i].teamDateIn,
    		     data[i].teamDateOut,
    		     data[i].teamRemainingWorkload,
    		     data[i].teamWorkload
    		     ])    	    	
    	}			
	});                      
	$('#teammember-activity-popup').dialog('open');
	} 

function controlActivity(element) {
	
	var activity = activitiesTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_activity"];
	// Recover activity info
	f.id.value = $('#id').attr('value');
	f.activity_id.value	= activity[0];
	f.name.value 		= unEscape(activity[1]);
	f.<%=Projectactivity.ACTUALINITDATE %>.value = activity[5];
	f.<%=Projectactivity.ACTUALENDDATE %>.value = activity[6];

	// Display activity info
	$('#activity-popup').dialog('open');
}

function controlMilestone(element) {
	
	var milestone = milestonesTable.fnGetData( element.parentNode.parentNode );
				
	var f = document.forms["frm_milestone"];

	updateActivityDates(milestone[8]);
	
	// Recover followup info
	f.milestone_id.value	= milestone[0];
	f.activity.value 		= unEscape(milestone[1]);
	f.milestone_desc.value	= unEscape(milestone[2]);
	f.dueDate.value			= milestone[3];
	f.achieved.value 		= milestone[5];
	$('#<%=Milestones.ACHIEVEDCOMMENTS %>').text(unEscape(milestone[6]));
	// Display milestone info
	$('#milestone-popup').dialog('open');
}

function drawChartGantt(DOMId, dataXML, width, height) {
	var chart1 = new FusionCharts("FusionCharts/FCF_Gantt.swf", DOMId, width, height); 
    chart1.setDataXML(dataXML);    
    chart1.render("chartGantt");
}

function scheduleChart(DOMId) {
	controlAjax.call({
			accion: "<%=ProjectControlServlet.JX_CONTROL_GANTT_CHART %>",
			id: $("#id").attr("value"),
			filter_start: $('#filter_start').val(),
			filter_finish: $('#filter_finish').val()
		},function(data) {
			if (data.tasks == null) {
				$("#legendGanttChart").hide();
				$("#chartGantt").html('${data_not_found}');
			}
			else {
				$("#legendGanttChart").show(); 
				height = (parseInt(data.tasks) * 37)+80;
				drawChartGantt(DOMId, data.xml,"800",height+"");
			}
	});
}

function wbsChart() {
	
	var params = {
		accion: "<%=ProjectControlServlet.JX_WBS_CHART %>",
		id: $("#id").attr("value")
	};
	
	$('#chartWBS').html('${loading_chart}');
	
	controlAjax.call(params, function(data) {
		if (data.chart_code == null) {
			$("#chartWBS").html('${data_not_found}');
		}
		else {
			$('#chartWBS').html(data.chart_code);
			$(".gray").treeview({
				control: "#treecontrol",
				collapsed: true
			});
		}
	});
}


function addChangeRequest() {
	$('#change_request_id').attr('value', '');
	resetChangeRequest();
	$('#change-popup').dialog('open');
	return false;
}

function editChangeRequestList(element) {
	
	var aData = changeListTable.fnGetData( element.parentNode.parentNode );
	aData[14] = aData[18];
	editChangeRequest(aData);
}
function editChangeRequestStatus(element) {
	
	var aData = changeRequestTable.fnGetData( element.parentNode.parentNode );
	editChangeRequest(aData);
}
function editChangeRequest(aData) {
		
	resetChangeRequest();
	$('#change-popup').dialog('open');
	
	// Set Change Request info
	var f = document.forms["frm_change"];
	f.change_id.value 	= aData[0];
	f.type.value 		= aData[8];
	f.priority.value 	= aData[4];
	f.date.value 		= aData[5];
	f.desc.value 		= unEscape(aData[2]);
	f.solution.value 	= unEscape(aData[9]);
	f.originator.value	= unEscape(aData[6]);
	$('#originator').show();
	
	if (aData[10] != '') { // Analyzed
		f.wbsnode.value 	= aData[10];
		f.effort.value 		= aData[11];
		f.cost.value 		= aData[12];
		f.impact.value 		= unEscape(aData[13]);
		
		showAnalyzeInputs();

		if (aData[14] != '') { // Resolved
			//Poner campos resolution.
			if (aData[14] == 'true') {
				$("input[name='resolution']")[0].checked = true;
			} else {
				$("input[name='resolution']")[1].checked = true;
			}
			f.resolution_date.value = aData[15];
			f.resolution_reason.value = unEscape(aData[16]);
			
			showResolutionInputs();				
		}
		else {
			$('#btn_resolve').show();
		}
	}
	else {
		$('#btn_analyze').show();
	}
}

function toChangePDF(idChange) {
	if (idChange != '') {
		var f = document.forms["frm_project"];
		f.action = "<%=ProjectControlServlet.REFERENCE%>";
		f.accion.value = "<%=ProjectControlServlet.EXPORT_CHANGE %>";
		f.change_export_id.value = idChange;
		f.submit();
		return false;
	}
	return false;
}

function fnChangeListDetails ( nTr )
{
	var aData = changeListTable.fnGetData( nTr );
	var out = "";

	var params = {
		accion: "<%=ProjectControlServlet.JX_CONS_CHANGE %>",
		change_id: aData[0]
	};
	
	// Consult control change info
	controlAjax.call(params, function(data) {
		out = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
		out += '<tr><td colspan="3">Description:</td><td colspan="3">'+data.desc+'</td></tr>';
		out += '<tr>';
		out += '<td>Change type:</td><td>'+data.type_desc+'</td>';
		out += '<td>Priority:</td><td>'+data.priority+'</td>';
		out += '<td>Originator:</td><td>'+data.originator+'</td>';
		out += '</tr>';
		out += '<tr><td colspan="3">Solution:</td><td colspan="3">'+data.solution+'</td></tr>';
		out += '</table>';
	});

	return out;
}

function changeColor(idSelect) {
	if (idSelect != '') {
		$('#'+idSelect).removeClass();
		$('#'+idSelect).addClass('campo');
		$('#'+idSelect).addClass('statusReport');
		$('#'+idSelect).addClass($('#'+idSelect).children("[selected]").attr('class'));
	}
}

function handleSliderChange(e, ui) {
  var maxScroll = $("#wbs-scroll").attr("scrollWidth") - $("#wbs-scroll").width();
  $("#wbs-scroll").animate({scrollLeft: ui.value * (maxScroll / 100) }, 1000);
}
function handleSliderSlide(e, ui){
  var maxScroll = $("#wbs-scroll").attr("scrollWidth") - $("#wbs-scroll").width();
  $("#wbs-scroll").attr({scrollLeft: ui.value * (maxScroll / 100) });
}

function validateDates(value, msg) {

	stateValidate = false;
	if(!dateBefore('${valActInitDate}', value, '${datePattern}')
			|| !dateBefore(value, '${valActEndDate}', '${datePattern}')) {
	 
		alertUI("${fmt_error}",msg);
	}
	else {
		stateValidate = true;
	}
	return stateValidate;

}

function applyOrder() {
	var f = document.forms.frm_project;
	f.scrollTop.value = $(document).scrollTop();
	toControlProject();
}

// When document is ready
readyMethods.add(function() {

	$("#content-slider").slider({
	  animate: true,
	  change: handleSliderChange,
	  slide: handleSliderSlide
	});
	
	$('#followup_control').change(function () {
		if ($(this).val() != '') {
			
			$(".statusReport").attr("disabled","");
			
			var f = document.forms["frm_project"];
			
			var params = {
				accion: "<%=ProjectControlServlet.JX_CONS_FOLLOWUP %>",
				followup_id: $(this).val()
			};
			
			controlAjax.call(params, function(data) {
				f.general_status.value	= data.general_status;
				changeColor('general_status');
				f.general_desc.value 	= data.general_desc;
				f.risk_status.value 	= data.risk_status;
				changeColor('risk_status');
				f.risk_desc.value 		= data.risk_desc;
				f.schedule_status.value = data.schedule_status;
				changeColor('schedule_status');
				f.schedule_desc.value 	= data.schedule_desc;
				f.cost_status.value 	= data.cost_status;
				changeColor('cost_status');
				f.cost_desc.value 		= data.cost_desc;
			});
		}
		else { $(".statusReport").attr("disabled","disabled"); }
	});

	$('.select_color').change(function() {
		changeColor($(this).attr('id'));
	});
	
	followupsTable = $('#tb_followups').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		"aoColumns": [
		              { "bVisible": false },
		              { "sClass": "center", "sType": "es_date"}, 
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "center"},
		              { "sClass": "center"},
		              { "sClass": "center"},
		              { "sClass": "center"},
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "center", "bSortable": false }
		      		]
	});

	$('#tb_followups tbody tr').live('click', function (event) {
		fnSetSelectable(followupsTable, this);
	} );
	
	activitiesTable = $('#tb_activities').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aoColumns": [ 
		              { "bVisible": false },
		              { "bVisible": true }, 
		              { "bVisible": false },
		              { "sClass": "center", "sType": "es_date" }, 
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center", "sType": "es_date" }, 
		              { "sClass": "center", "sType": "es_date" },
		              { "bVisible": false, "sClass": "right" },
		              { "sClass": "center", "bSortable": false }
		      		]
	});

	$('#tb_activities tbody tr').live('click', function (event) {
		fnSetSelectable(activitiesTable, this);
	} );
	

	milestonesTable = $('#tb_milestones').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aoColumns": [
		              { "bVisible": false },
		              { "bVisible": true }, 
		              { "bVisible": true },
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center" },
		              { "sClass": "center", "sType": "es_date" },
		              { "bVisible": true },
		              { "sClass": "center", "bSortable": false },
		              { "bVisible": false }
		      		]
	});

	milestonesTable.fnSetColumnVis( 0, false );

	$('#tb_milestones tbody tr').live('click', function (event) {
		fnSetSelectable(milestonesTable, this);
	} );

	activityScopeTable = $('#tb_activities_scope').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aoColumns": [ 
             { "bVisible": false }, 
             { "bVisible": true }, 
             { "sClass": "right" },
             { "sClass": "right"}, 
             { "sClass": "right"},
             { "sClass": "right"},                       //  us15 Remainig on the activity
             { "sClass": "center", "bSortable": false},  //us15  Button to display  remaining per teammember
             { "sClass": "center", "bSortable": false}
     	]
	});

	$('#tb_activities_scope tbody tr').live('click', function (event) {
		fnSetSelectable(activityScopeTable, this);
	} );
	
	changeListTable = $('#tb_changes_list').dataTable({
		"oLanguage": datatable_language,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 50,
		"aaSorting": [[ 4, "asc" ]],
		"aoColumns": [ 
		              { "bVisible": false }, 
		              { "bVisible": false }, 
		              { "bVisible": true }, 
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "center", "sType": "es_date" }, 
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "center" },
		              { "sClass": "right" },
		              { "bVisible": false },
		              { "sClass": "center" },
		              { "sClass": "center", "sType": "es_date" },
		              { "bVisible": false },
		              { "sClass": "center", "bSortable": false },
		              { "bVisible": false }
		      		]
	});

	changeRequestTable = $('#tb_changes_request').dataTable({
		"oLanguage": datatable_language,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 50,
		"aaSorting": [[ 4, "asc" ]],
		"aoColumns": [ 
		              { "bVisible": false }, 
		              { "bVisible": true }, 
		              { "bVisible": true }, 
		              { "sClass": "left" },
		              { "bVisible": false },
		              { "sClass": "center", "sType": "es_date" }, 
		              { "bVisible": true },
		              { "bVisible": true },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "center", "bSortable": false }
		      		]
	});

	$('#tb_changes_request tbody tr').live('click', function (event) {
		fnSetSelectable(changeRequestTable, this);
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
	
	//us15  teammember_activity popup :  
	//           detail : Table of teammember remaining on an activity => jsp : teammmeber_activity_popup.jsp
	teamtable = $('#teammember_activity').dataTable({
		"oLanguage": datatable_language,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 50,
		"aoColumns": [
	          { "sClass": "center" },
	          { "sClass": "center" },  
	          { "sClass": "center" },
	          { "sClass": "center" },
	          { "sClass": "center" }
	 		]
		});

 	$('#teammember_activity tbody tr').live('click', function (event) {
		fnSetSelectable(teamtable, this);
		}); 
});

</script>
<jsp:include page="../common/header_project.jsp">
	<jsp:param value="C" name="actual_page"/>
</jsp:include>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
<script>

function saveStatusDate(date) {
	
	var params = {
		accion:'<%=ProjectControlServlet.JX_UPDATE_STATUS_DATE%>',
		<%=Project.IDPROJECT%>:'${project.idProject}',
		<%=Project.STATUSDATE%>:date
	};
	
	controlAjax.call(params,function(data) {
		
		$(".<%=Project.STATUSDATE%>").html(data.<%=Project.STATUSDATE%>);
		$("#<%=Project.STATUSDATE%>").val(data.<%=Project.STATUSDATE%>);
	});
}

readyMethods.add(function() {
	var dates = $('#<%=Project.STATUSDATE %>').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true
	});
	
	$('#<%=Project.STATUSDATE %>').bind('change',function() {
		saveStatusDate($(this).val());
	});
});
</script>
</c:if>

<div class="caja_formulario">
	<form name="frm_project" id="frm_project" method="post">
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="id" id="id" value="${project.idProject}" />
		<input type="hidden" name="status" value="${project.status}" />
		<input type="hidden" id="followup_id" />
		<input type="hidden" id="milestone_id" />
		<input type="hidden" id="activity_id" name="activity_id" />
		<input type="hidden" id="ev" name="ev" />
		<input type="hidden" id="change_request_id" name="change_request_id" />
		<input type="hidden" id="change_export_id" name="change_export_id" />
		<input type="hidden" id="idDocument" name="idDocument" />
		<input type="hidden" name="scrollTop" />
		
   		<%-- Information of Project --%>
		<jsp:include page="../common/info_project.jsp" flush="true" />
		
		<%-- SCOPE CONTROL --%>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('tb_scope')"><fmt:message key="scope_control"/></legend>
			<div class="buttons">
				<img id="tb_scopeBtn" onclick="changeCookie('tb_scope', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="tb_scope" class="hide" style="padding-top:10px;">
				<div>
					<span class="hColor"><fmt:message key="project.status_date" />:</span>
					<input type="text" class="campo fecha" id="<%=Project.STATUSDATE %>"
						value="<fmt:formatDate value="${project.statusDate}" pattern="${datePattern}"/>"
						style="margin-left:20px;"
					/>
				</div>
				<table id="tb_activities_scope" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th>&nbsp;</th>
							<th width="44%"><fmt:message key="activity.name"/></th>
							<th width="10%"><fmt:message key="bac"/></th>
							<th width="10%"><fmt:message key="activity.ev"/></th>
							<th width="10%"><fmt:message key="percent_complete"/></th>
							<th width="10%"><fmt:message key="team_member.remaining_workload"/></th>      <!-- US 15 Remain Workload -->
							<th width="8%"> &nbsp;</th>                                                              <!-- US 15 Remain Workload for teammember -->
							<th width="8%">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="sumEVActivity" scope="request">0</c:set>
						<c:set var="sumBudget">0</c:set>
						<c:forEach var="activity" items="${project.projectactivities}">
							<c:if test="${activity.wbsnode.isControlAccount}">
								<tr>
									<td>${activity.idActivity}</td>
									<td>${tl:escape(activity.activityName)}</td>
									<td>${tl:toCurrency(activity.wbsnode.budget)}</td>
									<td>${tl:toCurrency(activity.ev)}</td>
									<td>${tl:toCurrency(activity.poc)}</td>
															<!--   begin  us 15  reamining workload for the activity -->
									<td>${tl:toCurrency(activity.remainingWorkload) }</td> 
															<!--  end us 15  -->
									<td>      <!--  remaining activity for teammember us 15 -->
										<c:if test="${tl:hasPermission(user,project.status,tab)}">																		
										  <img onclick="controlViewTeammemberActivity(this)" title="<fmt:message key="detail"/>" class="link ico" src="images/ico_gesitona_tiempo.gif">			
										</c:if>
									</td>
									<td>
										<c:if test="${tl:hasPermission(user,project.status,tab)}">			
											<c:set var="activityid_ligne">${activity.idActivity}</c:set>					
											<img onclick="controlScopeActivity(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">
										</c:if>
									</td>
								</tr>
								<c:set var="sumEVActivity" scope="request">${sumEVActivity + activity.ev }</c:set>
								<c:set var="sumBudget">${sumBudget + activity.wbsnode.budget}</c:set>
							</c:if>
						</c:forEach>
					</tbody>
					<tfoot>
					<tr>
						<td>&nbsp;</td>
						<td><b><fmt:message key="total"/></b></td>
						<td class="right">${tl:toCurrency(sumBudget) }</td>
						<td class="right">${tl:toCurrency(sumEVActivity) }</td>
						<td class="right">${tl:toCurrency(rootActivity.pocCalc)}</td>
						<td>&nbsp;</td>   <!-- us 15  remaining -->
						<td>&nbsp;</td>   <!-- us 15  remaining -->
						<td>&nbsp;</td>
					</tr>
					</tfoot>
				</table>
				
				<%-- CHECKLIST --%>
				<jsp:include page="control_checklist.inc.jsp" flush="true" />
				<fieldset class="level_2">
					<legend class="link" onclick="changeIco('content-wbs', 'legend', wbsChart)"><fmt:message key="wbs_chart"/></legend>
					<div class="buttons">
						<img id="content-wbsBtn" onclick="changeIco('content-wbs', this, wbsChart)" class="link" src="images/ico_mas.gif">
					</div>
					<div id="content-wbs" style="display:none;">
						<div style="padding: 10px;">
							<a href="javascript:wbsChart();" class="boton"><fmt:message key="chart.refresh" /></a>
						</div>
						<div id="content-slider"></div>
						<div id="wbs-scroll" style="padding-top: 10px;"><div id="chartWBS"></div></div>
						<div style="padding-top: 10px;">
							<span class="wGroups">&nbsp;&nbsp;&nbsp;</span>&nbsp;<fmt:message key="work_group"/>&nbsp;
							<span class="cAccount">&nbsp;&nbsp;&nbsp;</span>&nbsp;<fmt:message key="wbs.ca_long"/>
						</div>
					</div>
				</fieldset>
			</div>
		</fieldset>
		
		<%-- SCHEDULE CONTROL --%>	
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('tb_schedule')"><fmt:message key="schedule_control"/></legend>
			<div class="buttons">
				<img id="tb_scheduleBtn" onclick="changeCookie('tb_schedule', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="tb_schedule" class="hide" style="padding-top:10px;">
				<div class="hColor"><fmt:message key="activity_list"/></div>
				<div>
					<span class="hColor"><fmt:message key="project.status_date" />:</span>
					<span class="<%=Project.STATUSDATE %>">
						<fmt:formatDate value="${project.statusDate}" pattern="${datePattern}"/>
					</span>
				</div>
				<table id="tb_activities" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th><fmt:message key="activity.act"/></th>
							<th width="46%"><fmt:message key="activity.name"/></th>
							<th width="0%"><fmt:message  key="percent_complete"/></th>
							<th width="13%"><fmt:message key="baseline_start"/></th>
							<th width="13%"><fmt:message key="baseline_finish"/></th>
							<th width="10%"><fmt:message key="activity.actual_init_date"/></th>
							<th width="10%"><fmt:message key="activity.actual_end_date"/></th>
							<th width="0%"><fmt:message  key="activity.ev"/></th>
							<th width="8%"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="activity" items="${project.projectactivities}">
							<c:if test="${activity.wbsnode.isControlAccount}">
								<tr>
									<td>${activity.idActivity}</td>
									<td>${tl:escape(activity.activityName)}</td>
									<td><fmt:formatNumber type="percent" minFractionDigits="2" maxFractionDigits="2" value="${activity.poc}"/></td>
									<td><fmt:formatDate value="${activity.planInitDate}" pattern="${datePattern}"/></td>
									<td><fmt:formatDate value="${activity.planEndDate}" pattern="${datePattern}"/></td>
									<td><fmt:formatDate value="${activity.actualInitDate}" pattern="${datePattern}"/></td>
									<td><fmt:formatDate value="${activity.actualEndDate}" pattern="${datePattern}"/></td>
									<td>${tl:toCurrency(activity.ev)}</td>
									<td>
										<c:if test="${tl:hasPermission(user,project.status,tab)}">
											<img onclick="controlActivity(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">										
										</c:if>
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
							<th width="18%"><fmt:message key="activity.name"/></th>
							<th width="25%"><fmt:message key="milestone.desc"/></th>
							<th width="10%"><fmt:message  key="milestone.due_date"/></th>							
							<th width="10%"><fmt:message  key="milestone.show_sign"/></th>
							<th width="10%"><fmt:message  key="milestone.actual_date"/></th>
							<th width="19%"><fmt:message key="milestone.achievement_comments"/></th>
							<th>&nbsp;</th>
							<th width="8%">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="milestone" items="${milestones}">
							<tr>
								<td>${milestone.idMilestone}</td>
								<td>${tl:escape(milestone.projectactivity.activityName)}</td>
								<td>${tl:escape(milestone.description)}</td>
								<td><fmt:formatDate value="${milestone.planned}" pattern="${datePattern}"/></td>
								<td>
									<input type="checkbox" disabled="disabled"
										<c:if test="${milestone.reportType == 'Y'}">checked</c:if> 
									/>
								</td>
								<td><fmt:formatDate value="${milestone.achieved}" pattern="${datePattern}"/></td>
								<td>${tl:escape(milestone.achievedComments)}</td>
								<td>
									<c:if test="${tl:hasPermission(user,project.status,tab)}">
										<img onclick="controlMilestone(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">										
									</c:if>
								</td>
								<td>${milestone.projectactivity.idActivity }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div>&nbsp;</div>
				<fieldset class="level_2">
					<legend class="link" onclick="changeCookie('controlGanttChart')"><fmt:message key="schedule_chart"/></legend>
					<div class="buttons">
						<img id="controlGanttChartBtn" onclick="changeCookie('controlGanttChart', this)" class="link" src="images/ico_mas.gif">
					</div>
					<div id="controlGanttChart" class="hide">
						<div style="padding-top:10px;">
            				<span style="margin-right:5px;">
								<fmt:message key="dates.since"/>:&nbsp;
								<input type="text" id="filter_start" class="campo fecha alwaysEditable" value="${valActInitDate}"/>
            				</span>
            				<span style="margin-right:5px;">
								<fmt:message key="dates.until"/>:&nbsp;
								<input type="text" id="filter_finish" class="campo fecha alwaysEditable" value="${valActEndDate}"/>
							</span>
							<a href="javascript:scheduleChart('chartGanttDOM');" class="boton"><fmt:message key="chart.refresh" /></a>
            			</div>
						<div id="chartGantt" class="center"></div>
						<div class="legend hide" id="legendGanttChart">
							<span style="background-color:#4567aa;">&nbsp;&nbsp;</span><fmt:message key="cost.actual" />
							<span style="background-color:#000000;">&nbsp;&nbsp;</span><fmt:message key="percent_complete" />
							<span style="background-color:#A9A9A9;">&nbsp;&nbsp;</span><fmt:message key="cost.planned" />
						</div>
					</div>
				</fieldset>
				<div style="padding-top:12px;">
					<c:if test="${tl:hasPermission(user,project.status,tab)}">
						<c:if test="${project.status eq status_control and tl:isPluginActivated(pluginMSProject,plugins)}">
							<jsp:include page="../../plugins/msproject/msproject_update.jsp" flush="true" />
						</c:if>	
					</c:if>
				</div>
			</div>
		</fieldset>
		
		<%-- COST CONTROL --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldControlCost')"><fmt:message key="cost_control"/></legend>
			<div class="buttons">
				<img id="fieldControlCostBtn" onclick="changeCookie('fieldControlCost', this)" class="link" src="images/ico_mas.gif">	
			</div>
			<div id="fieldControlCost" class="hide" style="padding-top:10px;">
	
				<%-- CONTROL FUNDING --%>
				<jsp:include page="control_funding.inc.jsp" flush="true"/>
				
				<%-- EARNED VALUE MANAGEMENT --%>
				<div>&nbsp;</div>
				<fieldset class="level_2">
					<legend class="link" onclick="changeCookie('fieldControlCostEV')"><fmt:message key="followup.earner_management"/></legend>
					<div class="buttons">
						<img onclick="evmToCSV()" class="link" src="images/csv.png" title="${msg_to_excel}">
						<img id="fieldControlCostEVBtn" onclick="changeCookie('fieldControlCostEV', this)" class="link" src="images/ico_mas.gif">
					</div>
					<div id="fieldControlCostEV" class="hide" style="padding-top:15px;">
						<table id="tb_followups" class="tabledata" cellspacing="1" width="100%">
							<thead>
								<tr>
									<th>&nbsp;</th>
									<th><fmt:message key="followup.date"/></th>
									<th><fmt:message key="funding.days_date"/></th>
									<th><fmt:message key="followup.es"/></th>
									<th><fmt:message key="followup.pv"/></th>
									<th><fmt:message key="followup.ev"/></th>
									<th><fmt:message key="followup.ac"/></th>
									<th><fmt:message key="followup.poc"/></th>
									<th><fmt:message key="followup.cpi"/></th>
									<th><fmt:message key="followup.spi"/></th>
									<th><fmt:message key="followup.spit"/></th>
									<th><fmt:message key="followup.cv"/></th>
									<th><fmt:message key="followup.sv"/></th>
									<th><fmt:message key="followup.svt"/></th>
									<th><fmt:message key="followup.eac"/></th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="followup" items="${followups}">
									<c:set var="follES" value="${tl:getES(followups,followup)}"/>
									<c:set var="daysToDate" value="${followup.daysToDate}"/>
									<tr>
										<td>${followup.idProjectFollowup}</td>
										<td><fmt:formatDate value="${followup.followupDate}" pattern="${datePattern}" /></td>
										<td>${daysToDate}</td>
										<td><fmt:formatNumber type="number" maxFractionDigits="0" value="${follES}"/></td>
										<td>${tl:toCurrency(followup.pv)}</td>
										<td>${tl:toCurrency(followup.ev)}</td>
										<td>${tl:toCurrency(followup.ac)}</td>
										<td><fmt:formatNumber type="percent" minFractionDigits="2" maxFractionDigits="2" value="${followup.poc}"/></td>
										<td>${tl:toCurrency(followup.cpi)}</td>
										<td>${tl:toCurrency(followup.spi)}</td>
										<td>${follES > 0 and daysToDate ne null && daysToDate > 0?tl:toCurrency((follES/daysToDate)):"" }</td>
										<td>${tl:toCurrency(followup.cv)}</td>
										<td>${tl:toCurrency(followup.sv)}</td>
										<td>
											<c:if test="${follES > 0 and daysToDate ne null}">
												<fmt:formatNumber type="number" maxFractionDigits="0" value="${(follES-daysToDate)}"/>
											</c:if>
										</td>
										<td>${tl:toCurrency(followup.eac) }</td>
										<td>
											<c:if test="${tl:hasPermission(user,project.status,tab)}">
												<img onclick="editFollowup(this)" class="link" src="images/view.png" title="<fmt:message key="view"/>"/>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<fieldset class="level_3">
							<legend class="link" onclick="changeIco('costcharts', 'legend', costCharts)"><fmt:message key="cost_charts"/></legend>
							<div class="buttons">
								<img id="costchartsBtn" onclick="changeIco('costcharts', this, costCharts)" class="link" src="images/ico_mas.gif">
							</div>
							<div id="costcharts" class="center" style="display:none;">
								<div style="padding:10px;" class="left">
									<a href="javascript:costCharts();" class="boton"><fmt:message key="chart.refresh" /></a>
								</div>
								<div id="chartFollowup" align="center"></div>
								<div id="chartTimeVariance" align="center"></div>
								<div id="chartCostVariance" align="center"></div>
							</div>
						</fieldset>
					</div>
				</fieldset>
				
				<%-- COSTS --%>
				<div>&nbsp;</div>
				<jsp:include page="control_cost.inc.jsp"></jsp:include>
			</div>
		</fieldset>
		
		<%-- CONTROL HUMAN RESOURCES --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldControlHumanResources')"><fmt:message key="control.human_resources"/></legend>
			<div class="buttons">
				<img id="fieldControlHumanResourcesBtn" onclick="changeCookie('fieldControlHumanResources', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldControlHumanResources" class="hide" style="padding-top:15px;">
				<jsp:include page="control_resource.inc.jsp"></jsp:include>
			</div>		
		</fieldset>
		
		<%-- STATUS REPORT --%>
		<div style="">&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldControlCualitative')"><fmt:message key="status_report"/></legend>
			<div class="buttons">
				<img onclick="statusReportToCSV()" class="link" src="images/csv.png" title="${msg_to_excel}">
				<img id="fieldControlCualitativeBtn" onclick="changeCookie('fieldControlCualitative', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldControlCualitative" class="hide">
				<c:if test="${tl:hasPermission(user,project.status,tab)}">
					<table width="100%" border="0" cellpadding="5" cellspacing="0">
						<tr>
							<td width="8%"><b><fmt:message key="date"/></b></td>
							<td colspan="2">
								<select name="followup_control" id="followup_control" class="campo">
									<option value="">${msg_select_opt}</option>
									<c:forEach var="followup" items="${followups}">
										<option value="${followup.idProjectFollowup}"><fmt:formatDate value="${followup.followupDate}" pattern="${datePattern}"/></option>
									</c:forEach>
								</select>
							</td>
							<td width="72%">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<a href="javascript:openCreateFollowup()" class="boton"><fmt:message key="new"/></a>
								</c:if>
							</td>
						</tr>
						<tr>
							<th colspan="4" class="titulo"><fmt:message key="general"/></th>
						</tr>
						<tr>
							<th><fmt:message key="status"/></th>
							<td>
								<select name="general_status" id="general_status" class="campo select_color statusReport" disabled>
									<option value="" selected><fmt:message key="sel_opt"/></option>
									<option class="high_importance" value="<%=Constants.RISK_HIGH %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="medium_importance" value="<%=Constants.RISK_MEDIUM %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="normal_importance" value="<%=Constants.RISK_NORMAL %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="low_importance" value="<%=Constants.RISK_LOW %>">&nbsp;&nbsp;&nbsp;</option>
								</select>
							</td>
							<th><fmt:message key="desc"/></th>
							<td>
								<input type="text" name="general_desc" class="campo statusReport" maxlength="300" disabled/>
							</td>
						</tr>
						<tr>
							<th colspan="4" class="titulo"><fmt:message key="risk"/></th>
						</tr>
						<tr>
							<th><fmt:message key="status"/></th>
							<td>
								<select name="risk_status" id="risk_status" class="campo select_color statusReport" disabled>
									<option value="" selected><fmt:message key="sel_opt"/></option>
									<option class="high_importance" value="<%=Constants.RISK_HIGH %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="medium_importance" value="<%=Constants.RISK_MEDIUM %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="normal_importance" value="<%=Constants.RISK_NORMAL %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="low_importance" value="<%=Constants.RISK_LOW %>">&nbsp;&nbsp;&nbsp;</option>
								</select>
							</td>
							<th><fmt:message key="desc"/></th>
							<td>
								<input type="text" name="risk_desc" class="campo statusReport" maxlength="300" disabled/>
							</td>
						</tr>
						<tr>
							<th colspan="4" class="titulo"><fmt:message key="schedule"/></th>
						</tr>
						<tr>
							<th><fmt:message key="status"/></th>
							<td>
								<select name="schedule_status" id="schedule_status" class="campo select_color statusReport" disabled>
									<option value="" selected><fmt:message key="sel_opt"/></option>
									<option class="high_importance" value="<%=Constants.RISK_HIGH %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="medium_importance" value="<%=Constants.RISK_MEDIUM %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="normal_importance" value="<%=Constants.RISK_NORMAL %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="low_importance" value="<%=Constants.RISK_LOW %>">&nbsp;&nbsp;&nbsp;</option>
								</select>
							</td>
							<th><fmt:message key="desc"/></th>
							<td>
								<input type="text" name="schedule_desc" class="campo statusReport" maxlength="300" disabled/>
							</td>
						</tr>
						<tr>
							<th colspan="4" class="titulo"><fmt:message key="cost"/></th>
						</tr>
						<tr>
							<th><fmt:message key="status"/></th>
							<td>
								<select name="cost_status" id="cost_status" class="campo select_color statusReport" disabled>
									<option value="" selected><fmt:message key="sel_opt"/></option>
									<option class="high_importance" value="<%=Constants.RISK_HIGH %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="medium_importance" value="<%=Constants.RISK_MEDIUM %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="normal_importance" value="<%=Constants.RISK_NORMAL %>">&nbsp;&nbsp;&nbsp;</option>
									<option class="low_importance" value="<%=Constants.RISK_LOW %>">&nbsp;&nbsp;&nbsp;</option>
								</select>
							</td>
							<th><fmt:message key="desc"/></th>
							<td>
								<input type="text" name="cost_desc" class="campo statusReport" maxlength="300" disabled/>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<a href="javascript:saveGRSC();" class="boton"><fmt:message key="save" /></a>
							</td>
							<th>
								<fmt:message key="order"/>:&nbsp;
								<select class="campo" name="orderFollowup" style="width: 100px;">
									<option value="<%=Constants.ASCENDENT%>" ${orderFollowup eq "asc"?"selected":""}><fmt:message key="order.asc"/></option>
									<option value="<%=Constants.DESCENDENT%>" ${orderFollowup eq "desc"?"selected":""}><fmt:message key="order.desc"/></option>
								</select>
								&nbsp;
								<a href="javascript:applyOrder();" class="boton"><fmt:message key="apply" /></a>
							</th>
						</tr>
					</table>
				</c:if>
				<div>&nbsp;</div>
				<table cellpadding="0" cellspacing="1" width="100%" class="tabledata">
					<thead style="background-color:#DDE8F4;">
						<tr>
							<th width="5%"><fmt:message key="date"/></th>
							<th width="5%"><fmt:message key="status"/></th>
							<th width="10%"><fmt:message key="type"/></th>
							<th width="80%"><fmt:message key="desc"/></th>
						</tr>
					</thead>
					<tbody>
						<c:set var="classTR">even</c:set>
						<c:forEach var="followup" items="${followups}">
							<c:set var="classTR">${classTR == "even"?"odd":"even" }</c:set>
							<c:set value="" var="css_general"/>
							<c:choose>
								<c:when test="${followup.generalFlag == 'H'}"><c:set value="high_importance" var="css_general"/></c:when>
								<c:when test="${followup.generalFlag == 'M'}"><c:set value="medium_importance" var="css_general"/></c:when>
								<c:when test="${followup.generalFlag == 'L'}"><c:set value="low_importance" var="css_general"/></c:when>
								<c:when test="${followup.generalFlag == 'N'}"><c:set value="normal_importance" var="css_general"/></c:when>
							</c:choose>
							<c:set value="" var="css_risk"/>
							<c:choose>
								<c:when test="${followup.riskFlag == 'H'}"><c:set value="high_importance" var="css_risk"/></c:when>
								<c:when test="${followup.riskFlag == 'M'}"><c:set value="medium_importance" var="css_risk"/></c:when>
								<c:when test="${followup.riskFlag == 'L'}"><c:set value="low_importance" var="css_risk"/></c:when>
								<c:when test="${followup.riskFlag == 'N'}"><c:set value="normal_importance" var="css_risk"/></c:when>
							</c:choose>
							<c:set value="" var="css_schedule"/>
							<c:choose>
								<c:when test="${followup.scheduleFlag == 'H'}"><c:set value="high_importance" var="css_schedule"/></c:when>
								<c:when test="${followup.scheduleFlag == 'M'}"><c:set value="medium_importance" var="css_schedule"/></c:when>
								<c:when test="${followup.scheduleFlag == 'L'}"><c:set value="low_importance" var="css_schedule"/></c:when>
								<c:when test="${followup.scheduleFlag == 'N'}"><c:set value="normal_importance" var="css_schedule"/></c:when>
							</c:choose>
							<c:set value="" var="css_cost"/>
							<c:choose>
								<c:when test="${followup.costFlag == 'H'}"><c:set value="high_importance" var="css_cost"/></c:when>
								<c:when test="${followup.costFlag == 'M'}"><c:set value="medium_importance" var="css_cost"/></c:when>
								<c:when test="${followup.costFlag == 'L'}"><c:set value="low_importance" var="css_cost"/></c:when>
								<c:when test="${followup.costFlag == 'N'}"><c:set value="normal_importance" var="css_cost"/></c:when>
							</c:choose>
							<tr class="${classTR } ${classHide }">
								<td rowspan="4" class="center"><fmt:formatDate value="${followup.followupDate}" pattern="${datePattern}"/></td>
								<td class="left"><div id="status_g_${followup.idProjectFollowup}" class="${css_general }">&nbsp;</div></td>
								<td class="left"><fmt:message key="general"/></td>
								<td id="desc_g_${followup.idProjectFollowup}" class="left">${tl:escape(followup.generalComments)}</td>
							</tr>
							<tr class="${classTR } ${classHide }">
								<td class="left"><div id="status_r_${followup.idProjectFollowup}" class="${css_risk }">&nbsp;</div></td>
								<td class="left"><fmt:message key="risk"/></td>
								<td id="desc_r_${followup.idProjectFollowup}" class="left">${tl:escape(followup.risksComments)}</td>
							</tr>
							<tr class="${classTR } ${classHide }">
								<td class="left"><div id="status_s_${followup.idProjectFollowup}" class="${css_schedule }">&nbsp;</div></td>
								<td class="left"><fmt:message key="schedule"/></td>
								<td id="desc_s_${followup.idProjectFollowup}" class="left">${tl:escape(followup.scheduleComments)}</td>
							</tr>
							<tr class="${classTR } ${classHide }">
								<td class="left"><div id="status_c_${followup.idProjectFollowup}" class="${css_cost }">&nbsp;</div></td>
								<td class="left"><fmt:message key="cost"/></td>
								<td id="desc_c_${followup.idProjectFollowup}" class="left">${tl:escape(followup.costComments)}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</fieldset>

		<%-- CHANGE MANAGEMENT --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('fieldControlChanges')"><fmt:message key="change.management"/></legend>
			<div class="buttons">
				<img id="fieldControlChangesBtn" onclick="changeCookie('fieldControlChanges', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldControlChanges" class="hide">
				<div class="hColor" style="margin-top:10px;"><fmt:message key="change_control_list"/></div>		
				<table id="tb_changes_list" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="42%"><fmt:message key="change.desc"/></th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="10%"><fmt:message key="change.date"/></th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="9%"><fmt:message key="change.effort"/></th>
							<th width="10%"><fmt:message key="change.cost"/></th>
							<th width="0%">&nbsp;</th>
							<th width="10%"><fmt:message key="change.resolution"/></th>
							<th width="11%"><fmt:message key="change.resolution_date"/></th>
							<th width="0%">&nbsp;</th>
							<th width="8%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="change" items="${changes}">
							<c:if test="${not empty change.resolution}">
								<tr>
									<td>${change.idChange}</td>
									<td></td>
									<td>${tl:escape(change.description)}</td>
									<td>
										<c:if test="${change.priority == 'H'}"><fmt:message key="change.priority.high"/></c:if>
										<c:if test="${change.priority == 'N'}"><fmt:message key="change.priority.normal"/></c:if>
										<c:if test="${change.priority == 'L'}"><fmt:message key="change.priority.low"/></c:if>
									</td>
									<td>${change.priority}</td>
									<td><fmt:formatDate value="${change.changeDate}" pattern="${datePattern}"/></td>
									<td>${tl:escape(change.originator)}</td>
									<td>${tl:escape(change.changetype.description)}</td>
									<td>${change.changetype.idChangeType}</td>
									<td>${tl:escape(change.recommendedSolution)}</td>
									<td>${change.wbsnode.idWbsnode}</td>
									<td>${change.estimatedEffort}</td>
									<td>${tl:toCurrency(change.estimatedCost)}</td>
									<td>${tl:escape(change.impactDescription)}</td>
									<td>
										<c:choose>
											<c:when test="${change.resolution}"><fmt:message key="change.accepted"/></c:when>
											<c:otherwise><fmt:message key="change.rejected"/></c:otherwise>
										</c:choose>
									</td>
									<td><fmt:formatDate value="${change.resolutionDate}" pattern="${datePattern}"/></td>
									<td>${tl:escape(change.resolutionReason)}</td>
									<td>
										<img onclick="toChangePDF(${change.idChange});" class="link" src="images/ico_pdf.gif" alt="[PDF]" title="${msg_to_pdf}" />
										&nbsp;&nbsp;&nbsp;
										<img onclick="editChangeRequestList(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
									</td>
									<td>${change.resolution}</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
				<div class="hColor" style="margin-top:10px;"><fmt:message key="request_change_list"/>&nbsp;:&nbsp;<fmt:message key="status"/></div>
				<table id="tb_changes_request" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%">&nbsp;</th>
							<th width="8%"><fmt:message key="status"/></th>
							<th width="25%"><fmt:message key="change.desc"/></th>
							<th width="10%"><fmt:message key="change.priority"/></th>
							<th width="0%">&nbsp;</th>
							<th width="9%"><fmt:message key="change.date"/></th>
							<th width="20%"><fmt:message key="change.originator"/></th>
							<th width="20%"><fmt:message key="change.change_type"/></th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="8%">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img onclick="addChangeRequest()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
								</c:if>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="change" items="${changes}">
							<c:if test="${empty change.resolution}">
								<tr>
									<td>${change.idChange}</td>
									<td>
										<c:choose>
											<c:when test="${change.wbsnode eq null}"><fmt:message key="change.open"/></c:when>
											<c:otherwise><fmt:message key="analyze"/></c:otherwise>
										</c:choose>
									</td>
									<td>${tl:escape(change.description)}</td>
									<td>
										<c:if test="${change.priority == 'H'}"><fmt:message key="change.priority.high"/></c:if>
										<c:if test="${change.priority == 'N'}"><fmt:message key="change.priority.normal"/></c:if>
										<c:if test="${change.priority == 'L'}"><fmt:message key="change.priority.low"/></c:if>
									</td>
									<td>${change.priority}</td>
									<td><fmt:formatDate value="${change.changeDate}" pattern="${datePattern}"/></td>
									<td>${tl:escape(change.originator)}</td>
									<td>${tl:escape(change.changetype.description)}</td>
									<td>${change.changetype.idChangeType}</td>
									<td>${tl:escape(change.recommendedSolution)}</td>
									<td>${change.wbsnode.idWbsnode}</td>
									<td>${change.estimatedEffort}</td>
									<td>${tl:toCurrency(change.estimatedCost)}</td>
									<td>${tl:escape(change.impactDescription)}</td>
									<td>${change.resolution}</td>
									<td><fmt:formatDate value="${change.resolutionDate}" pattern="${datePattern}"/></td>
									<td>${tl:escape(change.resolutionReason)}</td>
									<td>
										<img onclick="toChangePDF(${change.idChange});" class="link" src="images/ico_pdf.gif" alt="[PDF]" title="${msg_to_pdf}" />
										&nbsp;&nbsp;&nbsp;
										<img onclick="editChangeRequestStatus(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</fieldset>
		
		<%-- KPI PROJECT --%>
		<div style="">&nbsp;</div>
		<jsp:include page="control_kpi.inc.jsp"></jsp:include>
	</form>
	
	<%--  DOCUMENTATION --%>
	<div>&nbsp;</div>
	<fmt:message var="documentationTitle" key="documentation.control"/>	
	<jsp:include page="../common/project_documentation_${documentStorage}.jsp">		
		<jsp:param name="documentationType" value="<%=Constants.DOCUMENT_CONTROL %>"/>
		<jsp:param name="documentationTitle" value="${documentationTitle }"/>
	</jsp:include>

</div>

<jsp:include page="change_popup.jsp" flush="true" />

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<jsp:include page="scope_activity_popup.jsp" flush="true" />
    <jsp:include page="teammember_activity_popup.jsp" flush="true" /> 
	<jsp:include page="checklist_popup.jsp" flush="true" />
	<jsp:include page="activity_popup.jsp" flush="true" />
	<jsp:include page="milestone_popup.jsp" flush="true" />
	<jsp:include page="income_popup.jsp" flush="true" />
	<jsp:include page="followup_popup.jsp" flush="true" />
	<jsp:include page="cost_popup.jsp" flush="true" />
	<jsp:include page="iwo_popup.jsp" flush="true" />
	<jsp:include page="new_followup_popup.jsp" flush="true" />
	<jsp:include page="kpi_popup.jsp" flush="true" />
	
	<c:if test="${tl:isPluginActivated(pluginMSProject,plugins) }">
		<jsp:include page="../../plugins/msproject/msproject_popup.jsp" flush="true" />
	</c:if>
</c:if>
