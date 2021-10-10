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
<%@page import="java.util.Date"%>
<%@page import="es.sm2.openppm.utils.DateUtil"%>
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="data_not_found" var="dataNotFound" />

<script language="javascript" type="text/javascript" >
<!--
var staffingTable;

function drawChartHistogram(DOMId, chartId, dataXML, width, height) {
	var chart1 = new FusionCharts("FusionCharts/FCF_StackedColumn2D.swf", DOMId, width, height); 
    chart1.setDataXML(dataXML);    
    chart1.render(chartId);
}

function chartHistogram(DOMId,visible) {
	
	controlAjax.call({
			accion: "<%=ProjectControlServlet.JX_HISTOGRAM_CHART%>",
			idProject: '${project.idProject}',
			since: $('#histogramStart').val(),
			until: $('#histogramFinish').val()
		},function(data) {
			
			if (typeof data.xml === "undefined") { $("#chartHistogram").html('${dataNotFound}'); }
			else { drawChartHistogram("ChartId", "chartHistogram", data.xml,"800","400"); }
	});
}

function updateFteTable() {
	controlAjax.call({
		accion:"<%=ProjectControlServlet.JX_UPDATE_STAFFING_TABLE%>",
		idProject:'${project.idProject}',
		since: $("#resourcesStart").val(),
		until: $("#resourcesFinish").val()
	},function(data) {
		$('#staffingTable').html(data);
	},'html');
}

readyMethods.add(function () {

	var histogramDates = $('#histogramStart, #histogramFinish').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "histogramStart" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			histogramDates.not(this).datepicker("option", option, date);
		}
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
});
//-->
</script>

<%--  CHART HISTOGRAM --%>
<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldControlHistogram')"><fmt:message key="project.resource_histogram"/></legend>
	<div class="buttons">
		<img id="fieldControlHistogramBtn" onclick="changeCookie('fieldControlHistogram', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldControlHistogram" style="padding-top: 15px;" class="hide">
		<div>
     		<span style="margin-right:5px;">
				<fmt:message key="dates.since"/>:&nbsp;
				<input type="text" id="histogramStart" class="campo fecha alwaysEditable" value="${valActInitDate}"/>
     		</span>
        	<span style="margin-right:5px;">
				<fmt:message key="dates.until"/>:&nbsp;
				<input type="text" id="histogramFinish" class="campo fecha alwaysEditable"
				value="<fmt:formatDate pattern="${datePattern}" value="<%=DateUtil.getLastWeekDay(new Date())%>"/>"/>
			</span>
			<a href="javascript:chartHistogram();" class="boton"><fmt:message key="project.chart" /></a>
		</div>
		<div id="chartHistogram" class="center"></div>
	</div>
</fieldset>

<%-- PROJECT STAFFING TABLE --%>
<div style="">&nbsp;</div>
<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldControlStaffing')"><fmt:message key="project_staffing"/></legend>
	<div class="buttons">
		<img id="fieldControlStaffingBtn" onclick="changeCookie('fieldControlStaffing', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldControlStaffing" style="padding-top: 15px;" class="hide">
		<div>
     		<span style="margin-right:5px;">
				<fmt:message key="dates.since"/>:&nbsp;
				<input type="text" id="resourcesStart" class="campo fecha alwaysEditable" value="${valActInitDate}"/>
     		</span>
        	<span style="margin-right:5px;">
				<fmt:message key="dates.until"/>:&nbsp;
				<input type="text" id="resourcesFinish" class="campo fecha alwaysEditable"
				value="<fmt:formatDate pattern="${datePattern}" value="<%=DateUtil.getLastWeekDay(new Date())%>"/>"/>
			</span>
			<a href="javascript:updateFteTable();" class="boton"><fmt:message key="staff.refresh" /></a>
		</div>
		<div id="staffingTable"></div>
	</div>
</fieldset>
