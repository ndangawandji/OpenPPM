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

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--
var incomesTable;

function showFundingChart() {
	$("#chartFunding")
		.attr("src","<%=ProjectControlServlet.REFERENCE%>?accion=<%=ProjectControlServlet.FUNDING_CHART_IMG%>&id=${project.idProject}&d="+Math.random())
		.attr("height","575")
		.attr("width","750");
	show('fieldChartFunding');
}

readyMethods.add(function() {
	
	incomesTable = $('#tb_incomes').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		"aoColumns": [
              { "bVisible": false }, 
              { "sClass": "center", "sType": "es_date" },
              { "sClass": "right"},
              { "sClass": "center", "sType": "es_date" },
              { "sClass": "center"},
              { "sClass": "right"},
              { "sClass": "left"}, 
              { "sClass": "center", "bSortable": false }
      		]
	});
	$('#tb_incomes tbody tr').live('click', function (event) {
		fnSetSelectable(incomesTable, this);
	});
});
//-->
</script>

<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldControlFunding')"><fmt:message key="funding.control"/></legend>
	<div class="buttons">
		<img id="fieldControlFundingBtn" onclick="changeCookie('fieldControlFunding', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldControlFunding" class="hide" style="padding-top:10px;">
		<table id="tb_incomes" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="10%"><fmt:message key="funding.due_date"/></th>
					<th width="10%"><fmt:message key="funding.due_value"/></th>
					<th width="10%"><fmt:message key="funding.actual_date"/></th>
					<th width="10%"><fmt:message key="funding.days_date"/></th>
					<th width="10%"><fmt:message key="funding.actual_value"/></th>
					<th width="47%"><fmt:message key="income.description"/></th>
					<th width="5%">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="income" items="${project.incomeses}">
					<tr>
						<td>${income.idIncome}</td>
						<td><fmt:formatDate value="${income.plannedBillDate}" pattern="${datePattern}"/></td>
						<td>${tl:toCurrency(income.plannedBillAmmount)}</td>
						<td><fmt:formatDate value="${income.actualBillDate}" pattern="${datePattern}"/></td>
						<td>${income.actDaysToDate}</td>
						<td>${tl:toCurrency(income.actualBillAmmount)}</td>
						<td>${tl:escape(income.actualDescription)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="editIncome(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<fieldset class="level_3">
			<legend class="link" onclick="changeIco('fieldChartFunding', 'legend', showFundingChart)"><fmt:message key="funding.chart"/></legend>
			<div class="buttons">
				<img id="fieldChartFundingBtn" onclick="changeIco('fieldChartFunding', this, showFundingChart)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldChartFunding" class="hide">
				<div style="padding:10px;">
					<a href="javascript:showFundingChart()" class="boton"><fmt:message key="chart.refresh" /></a>
				</div>
				<img id="chartFunding" src="images/load.gif" class="center" style="margin-top:15px; margin-bottom:15px;"/>
			</div>								
		</fieldset>
	</div>
</fieldset>

