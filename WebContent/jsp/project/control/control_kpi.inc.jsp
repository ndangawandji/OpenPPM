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
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script language="javascript" type="text/javascript" >
<!--
var kpiTable;

function kpiToCSV() {
	var f = document.frm_project;
	f.accion.value = "<%=ProjectControlServlet.EXPORT_KPI_CSV %>";
	f.submit();
}

function calcTotalNormalicedValue() {
	
	var target = parseFloat($('#projectUpperThreshold').text());
	var threshold = parseFloat($('#projectLowerThreshold').text());
	var value = toNumber($('#totalValue').text());
	
	var total;
	if ((target-threshold) != 0 && ((value -threshold)/(target-threshold) < 0)) {
		total = 0;
	}
	else if ((target-threshold) != 0 && ((value -threshold)/(target-threshold) > 1)) {
		total = 100;
	}
	else {
		total = (target-threshold) != 0 && ((value -threshold)/(target-threshold) > 1);
	}
	$('#totalNormalicedValue').text(toCurrency(total));
	$('#projectColorRAG').html('<span class="'+typeAdjustedValue(total)+'">&nbsp;&nbsp;&nbsp;</span>');
}

function typeAdjustedValue(value) {
	
	var riskColor = 'risk_medium';
	
	if (value >= 100) { riskColor = 'risk_low'; }
	else if (value <= 0) {riskColor = 'risk_high'; }
	
	return riskColor;
}

readyMethods.add(function () {

	kpiTable = $('#tb_kpi').dataTable({
		"sPaginationType": "full_numbers",
		"iDisplayLength": 50,
		"oLanguage": datatable_language,
		"aoColumns": [ 
             { "bVisible": false }, 
             { "bVisible": false },
             { "sClass": "center", "bSortable": false }, 
             { "sClass": "left" },
             { "sClass": "left" },
             { "sClass": "right" }, 
             { "sClass": "right" }, 
             { "sClass": "right" }, 
             { "sClass": "right" },
             { "sClass": "right" },
             { "sClass": "right" },
             { "sClass": "center", "bSortable": false }
    	]
	});

	$('#tb_kpi tbody tr').live('click', function (event) {
		fnSetSelectable(kpiTable, this);
	});
	
	calcTotalNormalicedValue();
});
//-->
</script>

<fieldset class="level_1">
	<legend class="link" onclick="changeCookie('fieldControlKpi')"><fmt:message key="kpi.name"/></legend>
	<div class="buttons">
		<img onclick="kpiToCSV()" class="link" src="images/csv.png" title="${msg_to_excel}">
		<img id="fieldControlKpiBtn" onclick="changeCookie('fieldControlKpi', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldControlKpi" class="hide" style="padding-top:15px;">
		<table id="tb_kpi" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
					<th width="4%">&nbsp;</th>
					<th width="20%"><fmt:message key="kpi.metric" /></th>
					<th width="29%"><fmt:message key="kpi.definition" /></th>
					<th width="6%"><fmt:message key="kpi.upper_threshold" /></th>
					<th width="8%"><fmt:message key="kpi.lower_threshold" /></th>
					<th width="8%"><fmt:message key="kpi.normalized_value" />&nbsp;%</th>
					<th width="8%"><fmt:message key="kpi.weight" />&nbsp;%</th>
					<th width="8%"><fmt:message key="kpi.value" /></th>
					<th width="5%"><fmt:message key="kpi.score" />&nbsp;%</th>
					<th width="4%">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="totalWeight" value="0"/>
				<c:set var="totalScore" value="0"/>
				<c:forEach var="kpi" items="${project.projectkpis }">
					<c:set var="totalWeight" value="${kpi.weight + totalWeight}"/>
					<c:set var="totalScore" value="${kpi.score + totalScore}"/>
					<tr>
						<td>${kpi.idProjectKpi}</td>
						<td>${kpi.metrickpi.idMetricKpi}</td>
						<td>
							<c:set var="riskColor">risk_medium</c:set>
							<c:choose>
								<c:when test="${kpi.adjustedValue >= 100}"><c:set var="riskColor">risk_low</c:set></c:when>
								<c:when test="${kpi.adjustedValue <= 0}"><c:set var="riskColor">risk_high</c:set></c:when>
							</c:choose>
							<span class="${riskColor }">&nbsp;&nbsp;&nbsp;</span>
						</td>
						<td>${tl:escape(kpi.metrickpi.name)}</td>
						<td>${tl:escape(kpi.metrickpi.definition)}</td>
						<td>${kpi.upperThreshold}</td>
						<td>${kpi.lowerThreshold}</td>
						<td>${tl:toCurrency(kpi.adjustedValue)}</td>
						<td>${kpi.weight}</td>
						<td>${kpi.value}</td>
						<td>${tl:toCurrency(kpi.score)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="editKpi(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${fn:length(project.projectkpis) > 0}">
				<tfoot>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><div class="center" id="projectColorRAG"></div>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><div class="right" id="projectUpperThreshold">${project.upperThreshold }</div></td>
						<td><div class="right" id="projectLowerThreshold">${project.lowerThreshold }</div></td>
						<td><div class="right" id="totalNormalicedValue"></div></td>
						<td><div class="right">${totalWeight }</div></td>
						<td><div class="right" id="totalValue">${tl:toCurrency(totalScore) }</div></td>
						<td><div class="right" id="totalScore">${tl:toCurrency(totalScore) }</div></td>
						<td>&nbsp;</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
</fieldset>
