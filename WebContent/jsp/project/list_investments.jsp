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
<%@page import="es.sm2.openppm.common.Settings"%>
<%@page import="es.sm2.openppm.utils.ValidateUtil"%>
<%@page import="es.sm2.openppm.model.Fundingsource"%>
<%@page import="es.sm2.openppm.model.Geography"%>
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

<fmt:message key="error" var="fmtError" />
<fmt:message key="data_not_found" var="dataNotFound" />
<c:choose>
	<c:when test="<%=SecurityUtil.hasPermission(request, ProjectServlet.JX_APPROVE_INVESTMENT) %>">
		<c:set var="buttonInv">
			&nbsp;<img onclick="viewInvestment('+aData[0]+')" title="<fmt:message key="view"/>" class="link" src="images/view.png">'+
			'&nbsp;&nbsp;&nbsp;<img onclick="openApproveInvestment('+aData[0]+')" title="<fmt:message key="investment.change_status"/>" class="link ico" src="images/modify.png">
		</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="buttonInv">
			&nbsp;<img onclick="viewInvestment('+aData[0]+')" title="<fmt:message key="view"/>" class="link" src="images/view.png">
		</c:set>
	</c:otherwise>
</c:choose>
<c:set var="investmentScript">
	{
		"sExtends" : "text",
		"sButtonText": '<fmt:message key="export.csv" />',
		"fnClick": function ( nButton, oConfig, oFlash ) { InvestmentsToCSV(); }
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
function InvestmentsToCSV() {
	infoTable = true;
	funcInfoTable = infoInvestmentsCSV;
	investmentsTable.fnDraw();
}

function infoInvestmentsCSV(dat) {
	var f = document.forms["frm_investments"];
	f.action = "<%=ProgramServlet.REFERENCE%>";
	f.accion.value = "<%=ProgramServlet.EXPORT_INVESTMENTS_CSV %>";
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

<c:if test="<%=(SecurityUtil.isUserInRole(request, Constants.ROLE_PMO) || SecurityUtil.isUserInRole(request, Constants.ROLE_IM)) %>">
	<c:set var="investmentScript">
		${investmentScript }
		,{
			"sExtends" : "text",
			"sButtonText": '<fmt:message key="new" />',
			"fnClick": function ( nButton, oConfig, oFlash ) { newInvestment(); },
			"sButtonClass": "newproject",
			"sButtonClassHover": "newproject"
		}
	</c:set>
<script language="javascript" type="text/javascript" >
<!--
	function newInvestment() {
		var f = document.forms["frm_investments"];
	
		f.action = '<%=ProjectServlet.REFERENCE%>';
		f.accion.value = "<%=ProjectServlet.NEW_INVERTMENT%>";
		f.submit();
	}
//-->
</script>
</c:if>
<script language="javascript" type="text/javascript" >
<!--
var infoTable = false;
var investmentsTable;
var funcInfoTable;

var programAjax = new AjaxCall('<%=ProgramServlet.REFERENCE%>','<fmt:message key="error" />');
var projectAjax = new AjaxCall('<%=ProjectServlet.REFERENCE%>','<fmt:message key="error" />');

function viewInvestment(id) {

	var f = document.forms["frm_investments"];
	f.id.value = id;
	f.action = "<%=ProjectInitServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectInitServlet.VIEW_INVESTMENT%>";
	f.submit();
}

function generateStatusReport() {
	
	infoTable = true;
	funcInfoTable = fnInfoTable;
	investmentsTable.fnDraw();
}

function fnInfoTable(data) {
	
	var f = document.forms["frm_investments"];
	
	f.action = '<%=ProjectServlet.REFERENCE %>';
	f.accion.value = "<%=ProjectServlet.GENERATE_STATUS_REPORT %>";
	f.ids.value = data.ids;
	f.submit();
}
function showValueChart() {
	infoTable = true;
	funcInfoTable = fnIds;
	investmentsTable.fnDraw();
}

function fnIds(data) {
	$("#chart_valuechartImage")
		.attr("src","program?accion=chart-bubble&investiment=true&ids="+data.ids+"&d="+Math.random())
		.attr("height","850")
		.attr("width","850");
	show('chart_valuechart');
}

function showChartGantt() {
	infoTable = true;
	funcInfoTable = fnIdsGantt;
	investmentsTable.fnDraw();
}

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
		    var chart1 = new FusionCharts("FusionCharts/FCF_Gantt.swf", "GanttId", 850, height); 
		    chart1.setDataXML(data.xml);   
		    chart1.render("chart_gantt");
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
	
	investmentsTable = $('#tb_investments').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"bServerSide": true,
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"iDisplayLength": 25,
		"aaSorting": [[3,'desc']],
		"bFilter": false,
		"bStateSave": true,
		"iCookieDuration": 31536000,
		"sCookiePrefix":"openppm_inv_",
		"oTableTools": {
			"sRowSelect": "multi",
			"sSwfPath": "swf/copy_cvs_xls_pdf.swf",
			"aButtons": [ <%= pageContext.getAttribute("investmentScript")%> ]
		},
		"sAjaxSource": '<%=ProjectServlet.REFERENCE%>',
		"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
			$('td:eq(<%=ValidateUtil.numOfCulumnsForInvestment()%>)', nRow).html('<nobr>${buttonInv}</nobr>');
					
			return nRow;
		},
		"fnServerData": function ( sSource, aoData, fnCallback ) {
			
			var ids = $('#ids').val();
			if ($('#ids').val() != '' && ids != null && ids != 'null') { $("#filterColumnSelected").show(); }
			else { $("#filterColumnSelected").hide(); }
			
			aoData.push( { "name": "accion", "value": "<%=ProjectServlet.JX_FILTER_TABLE_INVESTMENTS %>" } );
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
					aoData.push( { "name": "<%=Project.INVESTMENTSTATUS%>", "value": inp.value } );
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
	            { "bVisible": false },
	            { "bVisible": <%=Settings.INVESTMENT_COL_STATUS%>, "sClass": "left", "sWidth": "8%"}, 
	            { "bVisible": <%=Settings.INVESTMENT_COL_ACCOUNTING_CODE%>, "sClass": "left", "sWidth": "7%"}, 
	            { "bVisible": <%=Settings.INVESTMENT_COL_NAME%>, "sClass": "left", "sWidth": "20%" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_SHORT_NAME%>, "sClass": "left", "sWidth": "8%" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_BUDGET%>, "sClass": "right", "sWidth": "10%" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_PRIORITY%>, "sClass": "right", "sWidth": "5%" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_PROBABILITY%>, "sClass": "right", "sWidth": "7%" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_BASELINE_START%>, "sClass": "center", "sWidth": "7%", "sType": "es_date" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_BASELINE_FINISH%>, "sClass": "center", "sWidth": "7%", "sType": "es_date" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_START%>, "sClass": "center", "sWidth": "7%", "sType": "es_date", "bSortable": false },
	            { "bVisible": <%=Settings.INVESTMENT_COL_FINISH%>, "sClass": "center", "sWidth": "7%", "sType": "es_date", "bSortable": false },
	            { "bVisible": <%=Settings.INVESTMENT_COL_INTERNAL_EFFORT%>, "sClass": "right" },
	            { "bVisible": <%=Settings.INVESTMENT_COL_EXTERNAL_COST%>, "sClass": "right", "bSortable": false },
	            { "sClass": "left", "sWidth": "7%", "bSortable": false }
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

<!-- Form to download a file -->
<form name="frm_project" id="frm_project" method="post">
	<input type="hidden" name="accion" value="" />	
	<input type="hidden" id="idDocument" name="idDocument" />
</form>

<form id="frm_investments" name="frm_investments" method="post" onsubmit="return false;">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" id="id" name="id" />
	<input type="hidden" id="ids" name="ids" />

	<jsp:include page="common/filter_investment.jsp" flush="true">
		<jsp:param value="investmentsTable" name="table"/>
	</jsp:include>
	<div>
		<table id="tb_investments" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th><fmt:message key="status" /></th>
					<th><fmt:message key="project.accounting_code" /></th>
					<th><fmt:message key="investment" /></th>
					<th><fmt:message key="project.chart_label" /></th>
					<th>
						<fmt:message key="activity.budget" />
						<br><span id="sumBudget"></span>
					</th>
					<th><fmt:message key="table.priority" /></th>
					<th><fmt:message key="table.probability" /></th>
					<th><fmt:message key="investment.baseline_start" /></th>
					<th><fmt:message key="investment.baseline_finish" /></th>
					<th><fmt:message key="calendar.start" /></th>
					<th><fmt:message key="calendar.finish" /></th>
					<th><fmt:message key="internal_effort" /></th>
					<th><fmt:message key="external_costs" /></th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</form>

<!-- SCHEDULE CHART -->
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
		<div id="chart_gantt" class="center"></div>
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

<jsp:include page="common/approve_investment.jsp" flush="true"/>
