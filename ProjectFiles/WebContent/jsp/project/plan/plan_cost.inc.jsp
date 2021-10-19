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
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="actions.projects.approve_project" var="act_approve" />
<fmt:message key="actions.projects.delete_income" var="act_del_income" />
<fmt:message key="actions.projects.delete_followup" var="act_del_followup" />
<fmt:message key="actions.projects.delete_cost" var="act_del_cost" />
<fmt:message key="actions.projects.delete_iwo" var="act_del_iwo" />
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_income">
	<fmt:param><fmt:message key="income"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_income">
	<fmt:param><fmt:message key="income"/></fmt:param>
</fmt:message>
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_followup">
	<fmt:param><fmt:message key="followup"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_followup">
	<fmt:param><fmt:message key="followup"/></fmt:param>
</fmt:message>
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_cost">
	<fmt:param><fmt:message key="cost"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_cost">
	<fmt:param><fmt:message key="cost"/></fmt:param>
</fmt:message>
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_iwo">
	<fmt:param><fmt:message key="iwo"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_iwo">
	<fmt:param><fmt:message key="iwo"/></fmt:param>
</fmt:message>
<fmt:message key="select_opt" var="msg_select_opt" />
<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message key="data_not_found" var="data_not_found" />
<fmt:message key="pl_chart.warning_pl_data" var="warning_pl" />

<fmt:message key="loading_chart" var="loading_chart" />

<c:set var="expense_id"><%=Constants.COST_TYPE_EXPENSE%></c:set>
<fmt:message key="cost.type.expense" var="expense_value"></fmt:message>
<c:set var="direct_id"><%=Constants.COST_TYPE_DIRECT%></c:set>
<fmt:message key="cost.type.direct" var="direct_value"></fmt:message>
<fmt:message key="error" var="fmt_error" />
<c:set var="type_expenses"><fmt:message key="expenses"/></c:set>
<c:set var="type_direct"><fmt:message key="direct_costs"/></c:set>


<%-- 
Request Attributes:
	programs: 		Program list
	project:		Project to plan	
	followups:		List of project Followup
	costs:			List of project detailed Costs
	iwos:			List of project IWOs
	budgetaccounts:	List of budget accounts
--%>


<script type="text/javascript">
<!--

var incomesTable;
var followupsTable;
var costsTable;
var iwosTable;

function drawChartPL(DOMId, chartId, dataXML, width, height) {
	var chart1 = new FusionCharts("FusionCharts/FCF_StackedColumn2D.swf", DOMId, width, height); 
    chart1.setDataXML(dataXML);    
    chart1.render(chartId);
}

function plChart() {
	
	$('#chartPL').html('${loading_chart}');
	
	var params = {
		accion: "<%=ProjectPlanServlet.JX_PL_CHART%>",
		id: $("#id").attr("value")
	};
	
	planAjax.call(params, function (data) {
		if (data.xml == "false") { $("#chartPL").html('${data_not_found}'); }
		else {
			drawChartPL('chartPLDOM', "chartPL", data.xml,"400","400");
			if (data.warning) { $("#chartPL_warning").html('${warning_pl}'); }
		}
	});
}

function drawChartFollowups(DOMId,xml){
	var chart1 = new FusionCharts("FusionCharts/FCF_Line.swf", DOMId, "750", "575"); 
    chart1.setDataXML(xml);    
    chart1.render('chartDivFollouwps');
}

function cbChart(){
	
	$('#chartDivFollouwps').html('${loading_chart}');

	var params = {
		accion: "<%=ProjectPlanServlet.JX_PROJECT_COSTS_CHART%>",
		id: $("#id").attr("value")
	};
	
	planAjax.call(params, function (data) {
		if (data.xml == "false") { $("#chartDivFollouwps").html('${data_not_found}'); }
		else { drawChartFollowups('chartFollowups',data.xml); }
	});
 }

// Add Income for Finance plan
function addIncome() {
	var f = document.forms["frm_income"];
	f.reset();
	f.income_id.value = -1;
	$("#income_description").text('');
	
	$('#income-popup').dialog('open');
	return false;
}
function editIncome(element) {
		
	var income = incomesTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_income"];
	f.income_id.value = income[0];
	f.income_planned_date.value = income[1];
	f.income_planned_amount.value = income[3];
	$("#income_description").text(unEscape(income[4]));
	
	$('#income-popup').dialog('open');
}
function deleteIncomeConfirmated(id) {
	$('#dialog-confirm').dialog("close"); 
	var f = document.forms["frm_project"];

	f.action = '<%=ProjectPlanServlet.REFERENCE%>';
	f.accion.value = "<%=ProjectPlanServlet.DEL_INCOME%>";
	f.income_id.value = id;
	loadingPopup();
	f.submit();
}

function deleteIncome(element) {

	var income = incomesTable.fnGetData( element.parentNode.parentNode );
	
	$('#dialog-confirm-msg').html('${msg_confirm_delete_income}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": function() {
					deleteIncomeConfirmated(income[0]);
				},
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_confirm_delete_income}'
	);
	$('#dialog-confirm').dialog('open');
}

function addFollowup() {
	var f = document.forms["frm_followup"];
	f.reset();
	f.followup_id.value = -1;
	
	$('#followup-popup').dialog('open');
	return false;
}
function editFollowup(element) {
	
	var followup = followupsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_followup"];
	f.followup_id.value	= followup[0];
	f.date.value		= followup[1];
	f.daysToDate.value	= followup[2];
	f.pv.value			= followup[3];
	
	$('#followup-popup').dialog('open');
}
function deleteFollowupConfirmated(id) {
	$('#dialog-confirm').dialog("close"); 
	var f = document.forms["frm_project"];

	f.action = '<%=ProjectPlanServlet.REFERENCE%>';
	f.accion.value = "<%=ProjectPlanServlet.DEL_FOLLOWUP%>";
	f.followup_id.value = id;
	loadingPopup();
	f.submit();
}

function deleteFollowup(element) {

	var followup = followupsTable.fnGetData( element.parentNode.parentNode );
	
	$('#dialog-confirm-msg').html('${msg_confirm_delete_followup}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": function() {
					deleteFollowupConfirmated(followup[0]);
				},
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_confirm_delete_followup}'
	);
	$('#dialog-confirm').dialog('open');
	return false;
}

function addCost(type, id) {

	var f = document.forms.frm_cost;
	f.reset();
	f.cost_id.value = '';
	
	$('#legend').text(type);
	$('#cost_cost_type').val(id);

	filterCost.filterSelect('filter');
	
	$('#cost-popup').dialog('open');
}
function editCost(element, type, id) {
	
	var cost = costsTable.fnGetData( element.parentNode.parentNode );
	var f = document.forms.frm_cost;
	
	f.reset();
	f.cost_id.value			= cost[0];
	f.cost_cost_type.value	= <%=Constants.COST_TYPE_DIRECT%>;
	f.cost_planned.value	= cost[4];		
	f.desc.value			= unEscape(cost[3]);
	
	$('#legend').text(type);
	$('#cost_cost_type').val(id);

	filterCost.filterSelect('filter', cost[6]);
	
	$('#cost-popup').dialog('open');
}

function editExpense(element, type, id) {
	
	var expense = expensesTable.fnGetData( element.parentNode.parentNode );
	var f = document.forms["frm_cost"];
	
	f.reset();
	f.cost_id.value			= expense[0];
	f.cost_cost_type.value	= <%=Constants.COST_TYPE_EXPENSE%>;
	f.cost_planned.value	= expense[4];		
	f.desc.value			= unEscape(expense[3]);
	
	$('#legend').text(type);
	$('#cost_cost_type').val(id);

	filterCost.filterSelect('filter', expense[6]);
	
	$('#cost-popup').dialog('open');
}

function deleteCostConfirmated(id, type) {
	$('#dialog-confirm').dialog("close");
	
	var f = document.forms["frm_project"];

	f.action = '<%=ProjectPlanServlet.REFERENCE%>';
	f.accion.value = "<%=ProjectPlanServlet.DEL_COST%>";
	f.cost_id.value = id;
	f.cost_type.value = type;
	loadingPopup();
	f.submit();
}

function deleteCost(element, type) {
	
	var tableData	= (type == '${direct_id}'?costsTable:expensesTable);
	var expense		= tableData.fnGetData( element.parentNode.parentNode );
	
	$('#dialog-confirm-msg').html('${msg_confirm_delete_cost}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": function() {
					deleteCostConfirmated(expense[0], type);
				},
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_confirm_delete_cost}'
	);
	$('#dialog-confirm').dialog('open');
}

function addIWO() {
	var f = document.forms["frm_iwo"];
	f.reset();
	f.iwo_id.value = '';
	$('#iwo-popup').dialog('open');
}
function editIWO(element) {
	
	var iwo = iwosTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_iwo"];
	f.iwo_id.value		= iwo[0];
	f.iwo_planned.value = iwo[1];
	f.iwo_desc.value	= unEscape(iwo[2]);
	
	$('#iwo-popup').dialog('open');
}
function deleteIWOConfirmated(id) {
	$('#dialog-confirm').dialog("close"); 
	
	var f = document.forms["frm_project"];
	f.action = '<%=ProjectPlanServlet.REFERENCE%>';
	f.accion.value = "<%=ProjectPlanServlet.DEL_IWO%>";
	f.iwo_id.value = id;
	loadingPopup();
	f.submit();
}

function deleteIWO(element) {
	
	var iwo = iwosTable.fnGetData( element.parentNode.parentNode );

	$('#dialog-confirm-msg').html('${msg_confirm_delete_iwo}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": function() {
					deleteIWOConfirmated(iwo[0]);
				},
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_confirm_delete_iwo}'
	);
	$('#dialog-confirm').dialog('open');
}

function showFundingChart() {
	$("#chartDivIncomes")
		.attr("src","<%=ProjectPlanServlet.REFERENCE%>?accion=<%=ProjectPlanServlet.FINANCE_CHART_IMG%>&id=${project.idProject}&d="+Math.random())
		.attr("height","575")
		.attr("width","750");
	show('fieldChartDivIncomes');
}

// When document is ready
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
		              { "sClass": "center"},
		              { "sClass": "right"},
		              { "sClass": "left"}, 
		              { "sClass": "center", "bSortable": false }
		      		]
	});

	$('#tb_incomes tbody tr').live('click', function (event) {
		fnSetSelectable(incomesTable, this);
	} );

	followupsTable = $('#tb_followups').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		"aoColumns": [
		              { "bVisible": false }, 
		              { "sClass": "center", "sType": "es_date" }, 
		              { "sClass": "center"},
		              { "sClass": "right"},
		              { "sClass": "center", "bSortable": false }
		      		]
	});
	$('#tb_followups tbody tr').live('click', function (event) {
		fnSetSelectable(followupsTable, this);
	} );

	costsTable = $('#tb_costs').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"aoColumns": [
		              { "bVisible": false },		              
		              { "bVisible": false }, 
		              { "sClass": "left" },
		              { "sClass": "right" }, 
		              { "sClass": "left" },
		              { "sClass": "center", "bSortable": false },
		              { "bVisible": false }
		      		]
	});

	$('#tb_costs tbody tr').live('click', function (event) {
		fnSetSelectable(costsTable, this);
	} );
	
	expensesTable = $('#tb_expenses').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"aoColumns": [
		              { "bVisible": false },		              
		              { "bVisible": false }, 
		              { "sClass": "left" },
		              { "sClass": "left" },
		              { "sClass": "right" }, 
		              { "sClass": "center", "bSortable": false },
		              { "bVisible": false }
		      		]
	});

	$('#tb_expenses tbody tr').live('click', function (event) {
		fnSetSelectable(expensesTable, this);
	} );

	iwosTable = $('#tb_iwos').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"aoColumns": [
		              { "bVisible": false }, 
		              { "sClass": "right" }, 
		              { "sClass": "left"},
		              { "sClass": "center", "bSortable": false }
		      		]
	});
	
	$('#tb_iwos tbody tr').live('click', function (event) {
		fnSetSelectable(iwosTable, this);
	} );
	
    $.each( $(".formatNumbers"), function() {
		number = $(this).html();
		$(this).html(formatNumber(number,"${f_separator}","${f_decimal}"));
	});
});
//-->
</script>
		
<%-- FUNDING --%>

<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldFinancePlan')"><fmt:message key="funding"/></legend>
	<div class="buttons">
		<img id="fieldFinancePlanBtn" onclick="changeCookie('fieldFinancePlan', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldFinancePlan" style="padding-top:10px;" class="hide">
		<table id="tb_incomes" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="15%"><fmt:message key="funding.due_date"/></th>
					<th width="10%"><fmt:message key="funding.days_date"/></th>
					<th width="15%"><fmt:message key="funding.due_value"/></th>
					<th width="52%"><fmt:message key="income.description"/></th>
					<th width="8%">
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="addIncome()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>
					</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="income" items="${project.incomeses}">
					<tr>
						<td>${income.idIncome}</td>
						<td><fmt:formatDate value="${income.plannedBillDate}" pattern="${datePattern}"/></td>
						<td>${income.planDaysToDate}</td>
						<td>${tl:toCurrency(income.plannedBillAmmount)}</td>
						<td>${tl:escape(income.plannedDescription)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="editIncome(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
								<img onclick="deleteIncome(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<fieldset class="level_3">
			<legend class="link" onclick="changeIco('fieldChartDivIncomes', 'legend', showFundingChart)"><fmt:message key="funding.chart"/></legend>
			<div class="buttons">
				<img id="fieldChartDivIncomesBtn" onclick="changeIco('fieldChartDivIncomes', this, showFundingChart)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldChartDivIncomes" class="hide">
				<div style="padding:10px;">
					<a href="javascript:showFundingChart()" class="boton"><fmt:message key="chart.refresh" /></a>
				</div>
				<img id="chartDivIncomes" src="images/load.gif" class="center" style="margin-top:15px; margin-bottom:15px;"/>
			</div>
		</fieldset>
	</div>
</fieldset>

<%-- PLANNED VALUE --%>
<div>&nbsp;</div>
<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldBaseLinePlan')"><fmt:message key="planned_value"/></legend>
	<div class="buttons">
		<img id="fieldBaseLinePlanBtn" onclick="changeCookie('fieldBaseLinePlan', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldBaseLinePlan" style="padding-top:10px;" class="hide">
		<table id="tb_followups" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="35%"><fmt:message key="followup.date"/></th>
					<th width="30%"><fmt:message key="planned_value.days_date"/></th>
					<th width="27%"><fmt:message key="planned_value.value"/></th>
					<th width="8%">
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="addFollowup()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="followup" items="${followups}">
					<tr>
						<td>${followup.idProjectFollowup}</td>
						<td><fmt:formatDate value="${followup.followupDate}" pattern="${datePattern}"/></td>
						<td>${followup.daysToDate}</td>
						<td>${tl:toCurrency(followup.pv)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="editFollowup(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
								<img onclick="deleteFollowup(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<fieldset class="level_3">
			<legend class="link" onclick="changeIco('fieldPlannedValueChart', 'legend', cbChart)"><fmt:message key="planned_value.chart"/></legend>
			<div class="buttons">
				<img id="fieldPlannedValueChartBtn" onclick="changeIco('fieldPlannedValueChart', this, cbChart)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="fieldPlannedValueChart" class="hide">
				<div style="padding:10px;">
					<a href="javascript:cbChart();" class="boton"><fmt:message key="chart.refresh" /></a>
				</div>
				<div id="chartDivFollouwps" align="center" style="margin-top: 5px;"></div>
			</div>
		</fieldset>	
	</div>
</fieldset>

<%-- COST DETAIL PLAN --%>

<div style="">&nbsp;</div>
<fieldset class="level_2">
	<legend class="link" onclick="changeCookie('fieldCostsPlan')"><fmt:message key="cost_detail_plan"/></legend>
	<div class="buttons">
		<img id="fieldCostsPlanBtn" onclick="changeCookie('fieldCostsPlan', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldCostsPlan" style="padding-top:10px;" class="hide">
		
		<%-- EXPENSES --%>
		<div class="hColor"><fmt:message key="expenses"/></div>
		<table id="tb_expenses" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>							
					<th width="0%">&nbsp;</th>
					<th width="40%"><fmt:message key="cost.charge_account"/></th>
					<th width="42%"><fmt:message key="cost.desc"/></th>
					<th width="10%"><fmt:message key="cost.value"/></th>
					<th width="8%">
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="addCost('${type_expenses}', '${expense_id}')" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>
					</th>
					<th width="0%">&nbsp;</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="cost" items="${costs}">							
					<c:forEach var="expense" items="${cost.expenseses }">
						<tr>
							<td>${expense.idExpense}</td>										
							<td>${expense_id }</td>
							<td>${tl:escape(expense.budgetaccounts.description) }</td>
							<td>${tl:escape(expense.description )}</td>
							<td>${tl:toCurrency(expense.planned )}</td>
							<td>
								<img onclick="editExpense(this,'${type_expenses}', '${expense_id}')" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									&nbsp;&nbsp;&nbsp;
									<img onclick="deleteCost(this, ${expense_id })" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
								</c:if>
							</td>
							<td>${expense.budgetaccounts.idBudgetAccount }</td>
						</tr>
					</c:forEach>
				</c:forEach>
			</tbody>
		</table>
		
		<%-- DIRECT COSTS --%>
		<div class="hColor"><fmt:message key="direct_costs"/></div>
		<table id="tb_costs" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>							
					<th width="0%">&nbsp;</th>
					<th width="40%"><fmt:message key="cost.charge_account"/></th>
					<th width="42%"><fmt:message key="cost.desc"/></th>
					<th width="10%"><fmt:message key="cost.value"/></th>
					<th width="8%">
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="addCost('${type_direct}', '${direct_id}')" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>
					</th>
					<th width="0%">&nbsp;</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="cost" items="${costs}">
					<c:forEach var="direct" items="${cost.directcostses }">
						<tr>
							<td>${direct.idDirectCosts}</td>										
							<td>${direct_id }</td>
							<td>${tl:escape(direct.budgetaccounts.description) }</td>
							<td>${tl:escape(direct.description )}</td>
							<td>${tl:toCurrency(direct.planned )}</td>
							<td>
								<img onclick="editCost(this,'${type_direct}', '${direct_id}')" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									&nbsp;&nbsp;&nbsp;
									<img onclick="deleteCost(this, ${direct_id })" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
								</c:if>
							</td>
							<td>${direct.budgetaccounts.idBudgetAccount }</td>
						</tr>
					</c:forEach>							
				</c:forEach>
			</tbody>
		</table>
					
		<%-- RESERVES --%>
		<div class="hColor"><fmt:message key="reserves"/></div>
		<table id="tb_iwos" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%"><fmt:message key="iwo"/></th>
					<th width="10%"><fmt:message key="iwo.value"/></th>
					<th width="82%"><fmt:message key="iwo.desc"/></th>
					<th width="8%">
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="addIWO()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>
					</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="iwo" items="${iwos}">
					<tr>
						<td>${iwo.idIwo}</td>
						<td>${tl:toCurrency(iwo.planned)}</td>
						<td>${tl:escape(iwo.description)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="editIWO(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
								<img onclick="deleteIWO(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
					
		<%-- CHART --%>
		<fieldset style="margin-top:15px;" class="level_3">
			<legend class="link" onclick="changeIco('chartPL_block', 'legend', plChart)"><fmt:message key="finance_chart"/></legend>
			<div class="buttons">
				<img id="chartPL_blockBtn" onclick="changeIco('chartPL_block', this, plChart)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="chartPL_block" class="hide">
				<div style="padding:10px;">
					<a href="javascript:plChart();" class="boton"><fmt:message key="chart.refresh" /></a>
				</div>
				<div id="chartPL" align="center" style="margin-top: 5px;"></div>
				<div id="chartPL_warning" align="center"></div>
			</div>
		</fieldset>
	</div>
</fieldset>
