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
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="msg_to_csv" var="msg_to_csv" />
<fmt:message key="msg.error.export_to_csv" var="error_to_csv" />
<fmt:message key="msg.no_export_to_csv" var="msg_no_export_to_csv">
	<fmt:param><fmt:message key="projects"/></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--

function statusReportToCSV() {
	infoTable = true;
	funcInfoTable = infoStatusReportCSV;
	projectsTable.fnDraw();
}

function infoStatusReportCSV(dat) {
	var f = document.forms["frm_projects"];
	f.action = "<%=ProgramServlet.REFERENCE%>";
	f.accion.value = "<%=ProgramServlet.EXPORT_STATUS_REPORT_CSV %>";
	f.ids.value = dat.ids;
	if(f.ids.value == "") {
		alertUI("${error_to_csv}", "${msg_no_export_to_csv}");
	}
	else {
		f.submit();	
	}		
}

function color_css(status) {

	switch(status) {
		case 'H': type_css = 'high_importance'; break;
		case 'M': type_css = 'medium_importance'; break;
		case 'L': type_css = 'low_importance'; break;
		case 'N': type_css = 'normal_importance'; break;
		default: type_css = '';
	}
	return type_css;
}

function infoStatusReport() {
	infoTable = true;
	funcInfoTable = showStatusReport;
	projectsTable.fnDraw();
}

function showStatusReport(dat) {
	
	programAjax.call({
		accion: "<%=ProgramServlet.JX_SATUS_REPORT%>",
		property: dat.propiedad,
		order: dat.orden,
		ids: dat.ids
	}, function(data) {
		
		var tableHtml = "";
		
		var classTR = 'even';
		
		for (var i=0; i < data.length;i++) {
			
			css_general = color_css(data[i].general_status);
			css_risk = color_css(data[i].risk_status);
			css_schedule = color_css(data[i].schedule_status);
			css_cost = color_css(data[i].cost_status);
			
			classTR = (classTR == 'even'?'odd':'even');
			
			tableHtml += '<tr class="'+classTR+'">' +
				'<td rowspan="4" class="left">'+escape(data[i].projectName)+'</td>' +
				'<td rowspan="4" class="center">'+(data[i].date ? data[i].date : "")+'</td>' +
				'<td class="left"><div class="'+css_general+'">&nbsp;</div></td>'+
				'<td class="left"><fmt:message key="general"/></td>'+
				'<td class="left">'+(data[i].general_desc ? escape(data[i].general_desc) : "")+'</td>'+
				'<td rowspan="4" class="center"><img onclick="viewProject('+data[i].idProject+',\'<%=Constants.STATUS_CONTROL%>\');" title="<fmt:message key="view"/>" class="link" src="images/view.png"></td>' +
				'</tr>' +
				'<tr class="'+classTR+'">' +
				'<td class="left"><div class="'+css_risk+'">&nbsp;</div></td>'+
				'<td class="left"><fmt:message key="risk"/></td>'+
				'<td class="left">'+(data[i].risk_desc ? escape(data[i].risk_desc) : "")+'</td>'+
				'</tr>' +
				'<tr class="'+classTR+'">' +
				'<td class="left"><div class="'+css_schedule+'">&nbsp;</div></td>'+
				'<td class="left"><fmt:message key="schedule"/></td>'+
				'<td class="left">'+(data[i].schedule_desc ? escape(data[i].schedule_desc) : "")+'</td>'+
				'</tr>' +
				'<tr class="'+classTR+'">' +
				'<td class="left"><div class="'+css_cost+'">&nbsp;</div></td>'+
				'<td class="left"><fmt:message key="cost"/></td>'+
				'<td class="left">'+(data[i].cost_desc ? escape(data[i].cost_desc) : "")+'</td>'+
				'</tr>';
		}
		
		$("#add_datacualitative").html(tableHtml);
		
		show('fieldProgStatusReport');
	});
}
//-->
</script>

<fieldset>
	<legend class="link" onclick="changeIco('fieldProgStatusReport', 'legend', infoStatusReport)"><fmt:message key="status_report"/></legend>
	<div class="buttons">
		<img onclick="statusReportToCSV()" class="link" src="images/csv.png" title="${msg_to_csv}">
		<img id="fieldProgStatusReportBtn" onclick="changeIco('fieldProgStatusReport', this, infoStatusReport)" class="link" src="images/ico_mas.gif">
	</div>
	<div class="hide" id="fieldProgStatusReport" style="margin:10px 0px 10px 0px;">
		<div style="padding-bottom:10px;">
			<a href="javascript:infoStatusReport();" class="boton"><fmt:message key="status_report.refresh"/></a>	
		</div>
		
		<table cellpadding="0" cellspacing="1" width="100%" class="tabledata">
			<thead style="background-color:#DDE8F4;">
				<tr>
					<th width="20%"><fmt:message key="project_name"/></th>
					<th width="5%"><fmt:message key="date"/></th>
					<th width="5%"><fmt:message key="status"/></th>
					<th width="10%"><fmt:message key="type"/></th>
					<th width="56%"><fmt:message key="desc"/></th>
					<th width="4%">&nbsp;</th>
				</tr>
			</thead>
			<tbody id="add_datacualitative"></tbody>
		</table>
	</div>
</fieldset>
