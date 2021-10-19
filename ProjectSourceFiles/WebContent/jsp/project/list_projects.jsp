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
 -  Devoteam, 18/06/2015, user story 4 : adding permission to PM for the new project button
--%>
<%@page import="es.sm2.openppm.utils.ValidateUtil"%>
<%@page import="es.sm2.openppm.common.Settings"%>
<%@page import="es.sm2.openppm.model.Fundingsource"%>
<%@page import="es.sm2.openppm.model.Geography"%>
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.model.Projectactivity"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>
<%@page import="es.sm2.openppm.model.Category"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectInitServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="yes" var="msgYes" />
<fmt:message key="no" var="msgNo" />
<fmt:message key="msg.confirm_delete" var="msgConfirmDeleteProject">
	<fmt:param><fmt:message key="project"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msgTitleConfirmDeleteProject">
	<fmt:param><fmt:message key="project"/></fmt:param>
</fmt:message>
<fmt:message key="error" var="fmtError" />
<fmt:message key="data_not_found" var="dataNotFound" />

<c:if test="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_PMO) %>">
	<c:set var="deleteProject">&nbsp;&nbsp;&nbsp;<img onclick="deleteProject('+aData[0]+');" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg"></c:set>
</c:if>

<c:set var="projectScript">	
	{
		"sExtends" : "text",
		"sButtonText": '<fmt:message key="export.csv" />',
		"fnClick": function ( nButton, oConfig, oFlash ) { ProjectsToCSV(); }
	},
	{
		"sExtends" : "text",
		"sButtonText": '<fmt:message key="executive_report" />',
		"fnClick": function ( nButton, oConfig, oFlash ) { generateStatusReport(); }
	},
	{
		"sExtends" : "select_none",
		"sButtonText": "<fmt:message key="tabledata.deselect_all"/>"
	}
</c:set>

<script language="javascript" type="text/javascript" >
<!--
function ProjectsToCSV() {
	infoTable = true;
	funcInfoTable = infoProjectsCSV;
	projectsTable.fnDraw();
}

function infoProjectsCSV(dat) {
	var f = document.forms["frm_projects"];
	f.action = "<%=ProgramServlet.REFERENCE%>";
	f.accion.value = "<%=ProgramServlet.EXPORT_PROJECTS_CSV %>";
	f.ids.value = dat.ids;
	if(f.ids.value == "") {
		alertUI("${error_to_csv}", "${msg_no_export_to_csv}");
	}
	else {
		f.submit();	
	}		
}
//-->
</script>
<!-- cnw us4 adding this button for the project manager -->
<c:if test="<%=(SecurityUtil.isUserInRole(request, Constants.ROLE_PMO) || SecurityUtil.isUserInRole(request, Constants.ROLE_IM)) || SecurityUtil.isUserInRole(request, Constants.ROLE_PM) %>"> 
	<c:set var="projectScript">
		${projectScript }
		,{
			"sExtends" : "text",
			"sButtonText": '<fmt:message key="new" />',
			"fnClick": function ( nButton, oConfig, oFlash ) { newProject(); },
			"sButtonClass": "newproject",
			"sButtonClassHover": "newproject"
		}
	</c:set>
<script language="javascript" type="text/javascript" >
<!--
	function newProject() {
		var f = document.forms["frm_projects"];
	
		f.action = '<%=ProjectServlet.REFERENCE%>';
		f.accion.value = "<%=ProjectServlet.NEW_PROJECT%>";
		f.submit();
	}
//-->
</script>
</c:if>
<script language="javascript" type="text/javascript" >
<!--
var infoTable = false;
var projectsTable;
var funcInfoTable;

var programAjax = new AjaxCall('<%=ProgramServlet.REFERENCE%>','<fmt:message key="error" />');
var projectAjax = new AjaxCall('<%=ProjectServlet.REFERENCE%>','<fmt:message key="error" />');

function deleteProjectConfirmated(id) {
	$('#dialog-confirm').dialog("close"); 
	var f = document.forms["frm_projects"];

	f.action = '<%=ProjectServlet.REFERENCE%>';
	f.accion.value = "<%=ProjectServlet.DELETE_PROJECT%>";
	f.id.value = id;
	loadingPopup();
	f.submit();
}

function deleteProject(id) {

	confirmUI("${msgTitleConfirmDeleteProject }", "${msgConfirmDeleteProject }", "${msgYes }", "${msgNo }",
			function() {
		deleteProjectConfirmated(id);
		$('#dialog-confirm').dialog("close");
	});
}

function viewProject(id, status) {

	var f = document.forms["frm_projects"];
	f.id.value = id;

	f.accion.value = "";
	
	if (status == 'P') {
		f.action = "<%=ProjectPlanServlet.REFERENCE%>";
	}
	else if (status == 'C') {
		f.action = "<%=ProjectControlServlet.REFERENCE%>";
	}
	else {
		f.action = "<%=ProjectInitServlet.REFERENCE%>";
	}
	f.submit();
}

function generateStatusReport() {
	
	infoTable = true;
	funcInfoTable = fnInfoTable;
	projectsTable.fnDraw();
}

function fnInfoTable(data) {
	
	var f = document.forms["frm_projects"];
	
	f.action = '<%=ProjectServlet.REFERENCE %>';
	f.accion.value = "<%=ProjectServlet.GENERATE_STATUS_REPORT %>";
	f.ids.value = data.ids;
	f.submit();
}

function showValueChart() {
	infoTable = true;
	funcInfoTable = fnIds;
	projectsTable.fnDraw();
}

function fnIds(data) {
	$("#chart_valuechartImage")
		.attr("src","program?accion=chart-bubble&investiment=false&ids="+data.ids+"&d="+Math.random())
		.attr("height","850")
		.attr("width","850");
	show('chart_valuechart');
}

function showChartGantt() {
	infoTable = true;
	funcInfoTable = fnIdsGantt;
	projectsTable.fnDraw();
}
var chartGantt;
function fnIdsGantt(dat) {
	programAjax.call({
		accion: "<%=ProgramServlet.JX_CONS_GANTT%>",
		ids: dat.ids,
		propiedad: dat.propiedad,
		orden: dat.orden,
		since: $('#since').val(),
		until: $('#until').val()
	}, function(data) {
		if (data.xml == "false" || typeof data.xml === 'undefined') { $("#chart_gantt").html('${dataNotFound}'); }
		else { 
			height = (parseInt(data.tasksGantt) * 37)+80;
			chartGantt = new FusionCharts("FusionCharts/FCF_Gantt.swf", "GanttId", 850, height);
		    chartGantt.setDataXML(data.xml);
		    chartGantt.render("chart_gantt");
		}
		show('chart_valuechart_gantt');
	});
}
function resetDatesGantt() {
	$("#since").val('');
	$("#until").val('');
	showChartGantt();
}

readyMethods.add(function () {
	
	custType = $('#idCustomerType').filterSelect({'selectFilter':'idCustomer'});
	loadFilterState();
	
	projectsTable = $('#tb_projects').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"bServerSide": true,
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"iDisplayLength": 25,
		"aaSorting": [[5,'desc']],
		"bFilter": false,
		"bStateSave": true,
		"sCookiePrefix":"openppm_pro_",
		"iCookieDuration": 31536000,
		"oTableTools": {
			"sRowSelect": "multi",
			"sSwfPath": "swf/copy_cvs_xls_pdf.swf",
			"aButtons": [ <%= pageContext.getAttribute("projectScript")%> ]
		},
		"sAjaxSource": '<%=ProjectServlet.REFERENCE%>',
		"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
			$('td:eq(<%=ValidateUtil.numOfCulumnsForProject()%>)', nRow).html(
					'<nobr><img onclick="viewProject('+aData[0]+
							',\''+aData[1]+'\');" title="<fmt:message key="view"/>" class="link" src="images/view.png">${deleteProject}</nobr>'
						); 
					
			return nRow;
		},
		"fnServerData": function ( sSource, aoData, fnCallback ) {
			
			var ids = $('#ids').val();
			if ($('#ids').val() != '' && ids != null && ids != 'null') { $("#filterColumnSelected").show(); }
			else { $("#filterColumnSelected").hide(); }
			
			aoData.push( { "name": "accion", "value": "<%=ProjectServlet.JX_FILTER_TABLE %>" } );
			aoData.push( { "name": "<%=Project.INTERNALPROJECT%>", "value": $('#filterInternal').is(':checked') } );
			aoData.push( { "name": "<%=Projectactivity.PLANINITDATE%>", "value": $('#filter_start').val() } );
			aoData.push( { "name": "<%=Projectactivity.PLANENDDATE%>", "value": $('#filter_finish').val() } );
			aoData.push( { "name": "<%=Project.BUDGETYEAR%>", "value": $('#<%=Project.BUDGETYEAR%>').val() } );
			aoData.push( { "name": "customertype.idCustomerType", "value": $('#idCustomerType').val()+"" } );
			aoData.push( { "name": "customer.idCustomer", "value": $('#idCustomer').val()+"" } );
			aoData.push( { "name": "program.idProgram", "value": $('#idProgram').val()+"" } );
			aoData.push( { "name": "employeeByProjectManager.idEmployee", "value": $('#idPM').val()+"" } );
			aoData.push( { "name": "employeeBySponsor.idEmployee", "value": $('#idSponsor').val()+"" } );
			aoData.push( { "name": "category.idCategory", "value": $('#<%=Category.IDCATEGORY%>').val()+"" } );
			aoData.push( { "name": "seller.idSeller", "value": $('#idSeller').val()+"" } );
			aoData.push( { "name": "geography.idGeography", "value": $('#<%=Geography.IDGEOGRAPHY%>').val()+"" } );
			aoData.push( { "name": "fundingsource.idFundingSource", "value": $('#<%=Fundingsource.IDFUNDINGSOURCE%>').val()+"" } );
			aoData.push( { "name": "<%=Project.IDPROJECT%>", "value": ids } );
			aoData.push( { "name": "<%=Project.PROJECTNAME%>", "value": $('#<%=Project.PROJECTNAME%>').val() } );
			
		    var checkboxs = document.getElementsByName('filter');

		    for(var i = 0, inp; inp = checkboxs[i]; i++) {
		        if (inp.type.toLowerCase() == 'checkbox' && inp.checked) {
					aoData.push( { "name": "<%=Project.STATUS%>", "value": inp.value } );
		        }
		    }
		    if (infoTable) {
		    	aoData.push( { "name": "infoTable", "value": infoTable } );
		    	projectAjax.call(aoData,funcInfoTable);
		    	infoTable = false;
		    }
		    else {
		    	projectAjax.call(aoData,function (data) {
		    		$('#sumBudget').text(toCurrency(data.sumBudget));
		    		fnCallback(data);
		    	});
		    }
		},
		"aoColumns": [ 
	            { "bVisible": false, "bSortable": false }, 
	            { "bVisible": false, "bSortable": false }, 
	            { "bVisible": <%=Settings.PROJECT_COL_RAG%>, "sClass": "center",   "sWidth": "4%", "bSortable": false},
	            { "bVisible": <%=Settings.PROJECT_COL_START%>, "sClass": "left",   "sWidth": "6%"}, 
	            { "bVisible": <%=Settings.PROJECT_COL_ACCOUNTING_CODE%>, "sClass": "left",   "sWidth": "7%"}, 
	            { "bVisible": <%=Settings.PROJECT_COL_PROJECT_NAME%>, "sClass": "left",   "sWidth": "18%" },
	            { "bVisible": <%=Settings.PROJECT_COL_SHORT_NAME%>, "sClass": "left",   "sWidth": "8%" },
	            { "bVisible": <%=Settings.PROJECT_COL_BUDGET%>, "sClass": "right",  "sWidth": "8%" },
	            { "bVisible": <%=Settings.PROJECT_COL_PRIORITY%>, "sClass": "right",  "sWidth": "6%" },
	            { "bVisible": <%=Settings.PROJECT_COL_POC%>, "sClass": "right",  "sWidth": "8%", "bSortable": false },
	            { "bVisible": <%=Settings.PROJECT_COL_BASELINE_START%>, "sClass": "center", "sWidth": "7%", "sType": "es_date" },
	            { "bVisible": <%=Settings.PROJECT_COL_BASELINE_FINISH%>, "sClass": "center", "sWidth": "7%", "sType": "es_date" },
	            { "bVisible": <%=Settings.PROJECT_COL_START%>, "sClass": "center", "sWidth": "7%", "sType": "es_date", "bSortable": false },
	            { "bVisible": <%=Settings.PROJECT_COL_FINISH%>, "sClass": "center", "sWidth": "7%", "sType": "es_date", "bSortable": false },
	            { "bVisible": <%=Settings.PROJECT_COL_AC%>, "sClass": "right", "bSortable": false },
	            { "bVisible": <%=Settings.PROJECT_COL_INTERNAL_EFFORT%>, "sClass": "right" },
	            { "bVisible": <%=Settings.PROJECT_COL_EXTERNAL_COST%>, "sClass": "right", "bSortable": false },
	            { "sClass": "center", "sWidth": "7%", "bSortable": false }
      		]
	});
	var sinceUntil = $('#since, #until').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "since" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			sinceUntil.not(this).datepicker("option", option, date);
		}
	});
});
//-->
</script>

<form id="frm_projects" name="frm_projects" method="post" onsubmit="return false;">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" id="id" name="id" />
	<input type="hidden" id="ids" name="ids" />

	<jsp:include page="common/filter_project.jsp" flush="true">
		<jsp:param value="projectsTable" name="table"/>
	</jsp:include>
	<div>
		<table id="tb_projects" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
					<th><fmt:message key="rag" /></th>
					<th><fmt:message key="status" /></th>
					<th><fmt:message key="project.accounting_code" /></th>
					<th><fmt:message key="project" /></th>
					<th><fmt:message key="project.chart_label" /></th>
					<th>
						<fmt:message key="activity.budget" />
						<br><span id="sumBudget"></span>
					</th>
					<th><fmt:message key="table.priority" /></th>
					<th><fmt:message key="table.poc" /></th>
					<th><fmt:message key="baseline_start" /></th>
					<th><fmt:message key="baseline_finish" /></th>
					<th><fmt:message key="start" /></th>
					<th><fmt:message key="finish" /></th>
					<th><fmt:message key="followup.ac" /></th>
					<th><fmt:message key="internal_effort" /></th>
					<th><fmt:message key="external_costs" /></th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</form>

<%-- SATUS REPORT --%>
<div style="">&nbsp;</div>
<jsp:include page="common/status_report.inc.jsp" flush="true"/>

<%-- SCHEDULE CHART --%>
<div style="">&nbsp;</div>
<fieldset>
	<legend class="link" onclick="changeIco('chart_valuechart_gantt', 'legend', showChartGantt)"><fmt:message key="schedule_chart"/></legend>
	<div class="buttons">
		<img id="chart_valuechart_ganttBtn" onclick="changeIco('chart_valuechart_gantt', this, showChartGantt)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="chart_valuechart_gantt" style="margin-top: 20px;" class="hide">
		<div style="padding-top:10px;">
       		<span style="margin-right:5px;">
				<fmt:message key="dates.since"/>:&nbsp;
				<input type="text" id="since" class="campo fecha"/>
        	</span>
     		<span style="margin-right:5px;">
				<fmt:message key="dates.until"/>:&nbsp;
				<input type="text" id="until" class="campo fecha"/>
			</span>
			<a href="javascript:showChartGantt();" class="boton"><fmt:message key="chart.refresh"/></a>
			<a href="javascript:resetDatesGantt();" class="boton"><fmt:message key="filter.default"/></a>
        </div>
		<div id="chart_gantt" align="center"></div>
		<div class="legend">
			<span style="background-color:#4567aa;">&nbsp;&nbsp;</span><fmt:message key="cost.actual" />
			<span style="background-color:#000000;">&nbsp;&nbsp;</span><fmt:message key="percent_complete" />
			<span style="background-color:#A9A9A9;">&nbsp;&nbsp;</span><fmt:message key="cost.planned" />
		</div>
	</div>
</fieldset>

<%-- BUBBLE CHART --%>
<div style="">&nbsp;</div>
<fieldset>
	<legend class="link" onclick="changeIco('chart_valuechart', 'legend', showValueChart)"><fmt:message key="dashboard"/></legend>
	<div class="buttons">
		<img id="chart_valuechartBtn" onclick="changeIco('chart_valuechart', this, showValueChart)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="chart_valuechart" style="margin-top: 20px;" class="hide">
		<div style="margin-left:30px; margin-bottom:10px;">
			<a href="javascript:showValueChart();" class="boton"><fmt:message key="chart.refresh"/></a>
		</div>
		<div class="center">
			<img id="chart_valuechartImage" src="images/load.gif"/>
		</div>
	</div>
</fieldset>
