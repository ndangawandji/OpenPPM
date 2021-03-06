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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<fmt:message key="error" var="fmt_error" />
<fmt:message key="msg.error.project_cost_autocalculated" var="fmt_error_cost" />
<fmt:message key="data_not_found" var="data_not_found" />
<fmt:message key="pl_chart.warning_pl_data" var="warning_pl" />
<fmt:message key="loading_chart" var="loading_chart" />

<c:set var="expense_id"><%=Constants.COST_TYPE_EXPENSE%></c:set>
<fmt:message key="cost.type.expense" var="expense_value"></fmt:message>
<c:set var="direct_id"><%=Constants.COST_TYPE_DIRECT%></c:set>
<fmt:message key="cost.type.direct" var="direct_value"></fmt:message>

<script type="text/javascript">
<!--
//Cost editable?
var costEditable = false;
var iwosTable;

function hidePLChart() {
	$('#chart_pl_block').hide();
}

function showPLChart() {
	$('#chart_pl_block').show();
}

function editCost(element) { // Only actual cost is editable
	
	var cost = directsTable.fnGetData( element.parentNode.parentNode );
			
	var f = document.forms["frm_cost"];
	f.reset();
	f.cost_id.value = cost[0];
	f.budget_account.value = unEscape(cost[1]);
	f.desc.value = unEscape(cost[2]);			
	f.cost_planned.value = cost[3];
	f.cost_actual.value = cost[4]; //Cost without currency symbol
	f.cost_date.value = cost[5];
	f.cost_cost_type.value = cost[6];
	
	$('#sumProjectCost').show();
	$('#sumProjectExpenses').hide();
	$('#cost-popup').dialog('open');
}

function editExpense(element) { // Only actual cost is editable
	
	var expense = expensesTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_cost"];
	f.reset();
	f.cost_id.value = expense[0];
	f.budget_account.value = unEscape(expense[1]);
	f.desc.value = unEscape(expense[2]);			
	f.cost_planned.value = expense[3];
	f.cost_actual.value = expense[4]; //Cost without currency symbol
	f.cost_date.value = expense[5];
	f.cost_cost_type.value = expense[6];
	$('#sumProjectExpenses').text(expense[8]);
	
	$('#sumProjectCost').hide();	
	$('#sumProjectExpenses').show();
	$('#cost-popup').dialog('open');
}

function editIwo(element) {
	
	var iwo = iwosTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_iwo"];
	f.iwo_id.value = iwo[0];
	f.iwo_date.value = iwo[3];
	f.iwo_planned.value = iwo[1];
	f.iwo_actual.value = iwo[5];
	f.iwo_desc.value = unEscape(iwo[4]);
	
	$('#iwo-popup').dialog('open');
}

function drawChartPL(DOMId, chartId, dataXML, width, height) {
	var chart1 = new FusionCharts("FusionCharts/FCF_StackedColumn2D.swf", DOMId, width, height); 
    chart1.setDataXML(dataXML);    
    chart1.render(chartId);
}

function plChart() {
	
	$('#chart_pl').html('${loading_chart}');
	
	var params = {
		accion: "<%=ProjectControlServlet.JX_PL_CHART %>",
		id: $("#id").attr("value")
	};
	
	controlAjax.call(params, function(data) {
		if (data.xml == "false") { $("#chart_pl").html('${data_not_found}'); }
		else {
			drawChartPL("chartPLDOM", "chart_pl", data.xml,"400","400");
			if (data.warning) { $("#chart_pl_warning").html('${warning_pl}'); }
		}
	});
}

readyMethods.add(function() {
	directsTable = $('#tb_directs').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"aoColumns": [		              
		              { "bVisible": false },		              
		              { "bVisible": true },
		              { "bVisible": true },
		              { "sClass": "right"},
		              { "sClass": "right"}, 
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "center", "bSortable": false }
		      		]
	});

	$('#tb_directs tbody tr').live('click', function (event) {
		fnSetSelectable(directsTable, this);
	} );
	
	expensesTable = $('#tb_expenses').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"aoColumns": [		              
		              { "bVisible": false },		              
		              { "bVisible": true },
		              { "bVisible": true },
		              { "sClass": "right"},
		              { "sClass": "right"}, 
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "center", "bSortable": false },
		              { "bVisible": false }
		      		]
	});

	$('#tb_expenses tbody tr').live('click', function (event) {
		fnSetSelectable(expensesTable, this);
	} );

	hideCookie('field_cost_controlling');

	iwosTable = $('#tb_iwos').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"aoColumns": [
					  { "bVisible": false },
		              { "sClass": "right" }, 
		              { "sClass": "right" },
		              { "sClass": "center", "sType": "es_date" }, 
		              { "bVisible": true },
		              { "bVisible": false },
		              { "sClass": "center", "bSortable": false }
		      		]
	});
	
	$('#tb_iwos tbody tr').live('click', function (event) {
		fnSetSelectable(iwosTable, this);
	});
});
//-->
</script>

<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldControlDetail')"><fmt:message key="cost_detail_control"/></legend>
	<div class="buttons">
		<img id="fieldControlDetailBtn" onclick="changeCookie('fieldControlDetail', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldControlDetail" class="hide" style="padding-top:10px;">
	
		<%-- EXPENSES TABLE --%>
		<div class="hColor"><fmt:message key="expenses"/></div>
		<table id="tb_expenses" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="35%"><fmt:message key="cost.charge_account"/></th>
					<th width="40%"><fmt:message key="cost.desc"/></th>
					<th width="10%"><fmt:message key="cost.planned"/></th>
					<th width="10%"><fmt:message key="cost.actual"/></th>
					<th width="0%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
					<th width="5%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="cost" items="${costs}">					
					<c:forEach var="expense" items="${cost.expenseses }">
						<tr>			
							<td>${expense.idExpense}</td>				
							<td>${tl:escape(expense.budgetaccounts.description)}</td>
							<td>${tl:escape(expense.description)}</td>
							<td>${tl:toCurrency(expense.planned)}</td>
							<td>${tl:toCurrency(expense.actual)}</td>
							<td><fmt:formatDate value="${cost.costDate}" pattern="${datePattern}" /></td>
							<td>${expense_id }</td>
							<td>
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img onclick="editExpense(this)" class="link" src="images/view.png" title="<fmt:message key="view"/>"/>									
								</c:if>
							</td>
							<td>${tl:toCurrency(expense.sumExpenseSheet)}</td>
						</tr>
					</c:forEach>
				</c:forEach>
			</tbody>
		</table>
		
		<%-- COSTS TABLE --%>
		<div class="hColor"><fmt:message key="direct_costs"/></div>							
		<table id="tb_directs" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>					
					<th width="0%">&nbsp;</th>
					<th width="35%"><fmt:message key="cost.charge_account"/></th>
					<th width="40%"><fmt:message key="cost.desc"/></th>
					<th width="10%"><fmt:message key="cost.planned"/></th>
					<th width="10%"><fmt:message key="cost.actual"/></th>
					<th width="0%">&nbsp;</th>
					<th width="0%">&nbsp;</th>
					<th width="5%">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="cost" items="${costs}">
					<c:forEach var="direct" items="${cost.directcostses }">
						<tr>		
							<td>${direct.idDirectCosts}</td>		
							<td>${tl:escape(direct.budgetaccounts.description)}</td>
							<td>${tl:escape(direct.description)}</td>
							<td>${tl:toCurrency(direct.planned)}</td>
							<td>${tl:toCurrency(direct.actual)}</td>
							<td><fmt:formatDate value="${cost.costDate}" pattern="${datePattern}" /></td>
							<td>${direct_id }</td>
							<td>
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img onclick="editCost(this)" class="link" src="images/view.png" title="<fmt:message key="view"/>"/>									
								</c:if>
							</td>
						</tr>
					</c:forEach>					
				</c:forEach>
			</tbody>
		</table>
				
		<%-- RESERVES TABLE --%>
		<div class="hColor"><fmt:message key="reserves"/></div>								
		<table id="tb_iwos" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%"><fmt:message key="iwo"/></th>
					<th width="10%"><fmt:message key="iwo.planned"/></th>
					<th width="10%"><fmt:message key="iwo.actual"/></th>
					<th width="10%"><fmt:message key="iwo.date"/></th>
					<th width="75%"><fmt:message key="iwo.desc"/></th>
					<th width="0%">&nbsp;</th>
					<th width="5%">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="iwo" items="${iwos}">
					<tr>
						<td>${iwo.idIwo}</td>
						<td>${tl:toCurrency(iwo.planned)}</td>
						<td>${tl:toCurrency(iwo.actual)}</td>
						<td><fmt:formatDate value="${iwo.projectcosts.costDate}" pattern="${datePattern}" /></td>
						<td>${tl:escape(iwo.description)}</td>
						<td>${tl:toCurrency(iwo.actual)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">								
								<img onclick="editIwo(this)" class="link" src="images/view.png" title="<fmt:message key="view"/>"/>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>		
		<fieldset class="level_3">
			<legend class="link" onclick="changeIco('chart_pl_block', 'legend', plChart)"><fmt:message key="finance_chart"/></legend>
			<div class="buttons">
				<img id="chart_pl_blockBtn" onclick="changeIco('chart_pl_block', this, plChart)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="chart_pl_block" class="hide">
				<div style="padding:10px;">
					<a href="javascript:plChart();" class="boton"><fmt:message key="chart.refresh" /></a>
				</div>
				<div id="chart_pl" align="center" style="margin-top: 5px;"></div>
				<div id="chart_pl_warning" align="center"></div>
			</div>
		</fieldset>
	</div>
</fieldset>
