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
<%@page import="es.sm2.openppm.servlets.ExpenseSheetServlet"%>
<%@page import="es.sm2.openppm.model.Expensesheet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="app2" value="<%=Constants.EXPENSE_STATUS_APP2 %>"/>
<c:set var="btn_comments"><img onclick="javascript:viewComments(this);" title="<fmt:message key="comments.view"/>" class="ico link" src="images/comments_delete.png"/></c:set>
<c:set var="approveLevel">app3</c:set>

<script type="text/javascript">
<!--
var expenseSheetAjax = new AjaxCall('<%=ExpenseSheetServlet.REFERENCE%>','<fmt:message key="error"/>');
var employeesTable;

function approveExpenseSel() {
	
	if (employeesTable.fnGetSelectedsCol() == null) {
		alertUI('<fmt:message key="msg.info"/>','<fmt:message key="msg.info.selcet_row"/>');
	}
	else {
		confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
				'<fmt:message key="yes"/>','<fmt:message key="no"/>',
				function(msg) {
					
					var f = document.frm_expense_sheet;
					f.accion.value = '<%=ExpenseSheetServlet.APPROVE_SEL_EXPENSESHEET%>';
					f.comments.value = msg;
					f.idEmployees.value = employeesTable.fnGetSelectedsCol();
					loadingPopup();
					f.submit();
				}
		);
	}
}

function rejectExpenseSel() {
	
	if (employeesTable.fnGetSelectedsCol() == null) {
		alertUI('<fmt:message key="msg.info"/>','<fmt:message key="msg.info.selcet_row"/>');
	}
	else {
		confirmTextUI('<fmt:message key="reject"/>', '<fmt:message key="comments"/>',
				'<fmt:message key="yes"/>','<fmt:message key="no"/>',
				function(msg) {
					
					var f = document.frm_expense_sheet;
					f.accion.value = '<%=ExpenseSheetServlet.REJECT_SEL_EXPENSESHEET%>';
					f.comments.value = msg;
					f.idEmployees.value = employeesTable.fnGetSelectedsCol();
					loadingPopup();
					f.submit();
				}
		);
	}
}

function approveSheet() {
	confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				
				var f = document.frm_expense_sheet;
				f.accion.value = "<%=ExpenseSheetServlet.APPROVE_ALL_EXPENSESHEET %>";
				f.comments.value = msg;
				loadingPopup();
				f.submit();
			}
	);
}

function rejectSheet() {
	confirmTextUI('<fmt:message key="reject"/>', '<fmt:message key="comments"/>',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				
				var f = document.frm_expense_sheet;
				f.accion.value = "<%=ExpenseSheetServlet.REJECT_ALL_EXPENSESHEET %>";
				f.comments.value = msg;
				loadingPopup();
				f.submit();
			}
	);
}

function changeMonth(accion) {
	var f = document.frm_expense_sheet;
	f.accion.value = accion;
	loadingPopup();
	f.submit();
}

function viewExpenseSheet(idEmployee) {
	
	var f = document.frm_expense_sheet;
	f.accion.value = '';
	f.idEmployee.value	= idEmployee;
	loadingPopup();
	f.submit();
}

readyMethods.add(function() {
	
	employeesTable = $('#tb_employees').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"oTableTools": { "sRowSelect": "multi", "aButtons": [] },
		"aoColumns": [
              { "bVisible": false },
              { "sClass": "left", "sWidth": "85%" },
              { "sClass": "center", "sWidth": "5%"},
              { "sClass": "center", "sWidth": "5%"},
              { "sClass": "center", "sWidth": "5%", "bSortable": false },
     	]
	});
	
	expenseSheetTable = $('#tb_expenseSheet').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"bPaginate": false,
		"aoColumns": [ 
            { "bVisible": false },
            { "bVisible": false },
			{ "sWidth": "20%" },
            { "sClass": "center", "sWidth": "12%", "bSortable" : false },
            { "sClass": "center", "sWidth": "18%", "bSortable" : false },
            { "sClass": "center", "sWidth": "5%", "bSortable" : false },
            { "sWidth": "5%", "bSortable" : false },
			{ "sClass": "center", "sWidth": "5%", "bSortable" : false },
			{ "sClass": "center", "sWidth": "20%", "bSortable" : false },
            { "sClass": "center", "sWidth": "5%", "bSortable" : false },
            { "sClass": "center", "sWidth": "4%", "bSortable" : false },
            { "sClass": "center", "sWidth": "11%", "bSortable" : false }
    	],
    	"fnDrawCallback": function ( oSettings ) {
            if ( oSettings.aiDisplay.length == 0 ) { return; }
             
            var nTrs = $('#tb_expenseSheet tbody tr');
            var iColspan = nTrs[0].getElementsByTagName('td').length;
            var sLastGroup = "";
            for ( var i=0 ; i<nTrs.length ; i++ ) {
                var iDisplayIndex = oSettings._iDisplayStart + i;
                var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[0];
                if ( sGroup != sLastGroup ) {
                    var nGroup = document.createElement( 'tr' );
                    var nCell = document.createElement( 'td' );
                    nCell.colSpan = iColspan;
                    nCell.className = "groupRow";
                    nCell.innerHTML = sGroup;
                    nGroup.appendChild( nCell );
                    nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
                    sLastGroup = sGroup;
                }
            }
        },
        "aoColumnDefs": [
			{ "bVisible": false, "aTargets": [ 0 ] }
		],
		"aaSortingFixed": [[ 0, 'asc' ]],
		"aaSorting": [[ 2, 'asc' ]],
        "sDom": 'lfr<"giveHeight"t>ip'
	});
	
	$('.expenseDate').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'both',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		stepMonths: 0
	});
	
	$("#filter").change( function() {
		expenseSheetTable.fnFilter($("#filter").val(),10);
	});
	
	$('#tb_expenseSheet tbody tr').live('click', function (event) {
		expenseSheetTable.fnSetSelectable(this,'selected_internal');
	});
});

//-->
</script>

<form name="frm_expense_sheet" id="frm_expense_sheet" action="<%=ExpenseSheetServlet.REFERENCE%>" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="comments" value="" />
	<input type="hidden" name="idEmployees" value="" />
	<input type="hidden" name="idEmployee" value="${employee.idEmployee }" />
	<input type="hidden" name="sheetDate" value="<fmt:formatDate value="${sheetDate}" pattern="${datePattern}"/>" />
	
	<fieldset>
		<table width="100%" border="0" cellpadding="7" cellspacing="1">
			<tr>
				<td width="65%">&nbsp;</td>
				<th width="35%" align="right">
					<img onclick="changeMonth('<%=ExpenseSheetServlet.PREV_MONTH_SHEET %>');"  src="images/after.ico"></img>
					<span class="hColor"><fmt:message key="month.month_${month}" />&nbsp;<fmt:formatDate value="${sheetDate}" pattern="yyyy"/></span>
					<img onclick="changeMonth('<%=ExpenseSheetServlet.NEXT_MONTH_SHEET %>');" src="images/next.png"/>
				</th>
			</tr>
		</table>
		<table id="tb_employees" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th><fmt:message key="contact.fullname"/></th>
					<th><fmt:message key="status"/></th>
					<th><fmt:message key="total"/></th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="employee" items="${approvals }">
					<tr>
						<td>${employee.idEmployee }</td>
						<td>${tl:escape(employee.contact.fullName) }</td>
						<td><fmt:message key="applevel.${tl:getStatusResourceExpense(employee.idEmployee, user.idEmployee, sheetDate, app2, approveLevel, user) }"/></td>
						<td>${tl:toCurrency(tl:getCostResource(employee.idEmployee, user.idEmployee, sheetDate, user, approveRol)) }</td>
						<td><img src="images/view.png" onclick="viewExpenseSheet(${employee.idEmployee })" title="<fmt:message key="view"/>"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div>&nbsp;</div>
		<div>
			<a class="button_img position_right" href="javascript:rejectExpenseSel();"><img src="images/reject.png"/><span><fmt:message key="reject"/></span></a>
			<a class="button_img position_right" href="javascript:approveExpenseSel();"><img src="images/approve.png"/><span><fmt:message key="approve"/></span></a>
		</div>
		<div>&nbsp;</div>
		<c:if test="${expenses ne null and not empty expenses}">
			<fieldset>
				<legend>${tl:escape(employee.contact.fullName) }</legend>
				<table width="100%" border="0" cellpadding="7" cellspacing="1">
					<tr>
						<th width="5%"><fmt:message key="filter"/>:</th>
						<td width="40%">
							<select id="filter" class="campo" style="width:100%;">
								<option value="" selected><fmt:message key="select_opt"/></option>
								<option value="<fmt:message key="applevel.app2"/>"><fmt:message key="applevel.app2_desc" /></option>
								<option value="<fmt:message key="applevel.app3"/>"><fmt:message key="applevel.app3_desc" /></option>
							</select>
						</td>
						<td width="20%">&nbsp;</td>
						<th width="35%" align="right">
							<img onclick="changeMonth('<%=ExpenseSheetServlet.PREV_MONTH_SHEET %>');"  src="images/after.ico"></img>
							<span class="hColor"><fmt:message key="month.month_${month}" />&nbsp;<fmt:formatDate value="${sheetDate}" pattern="yyyy"/></span>
							<img onclick="changeMonth('<%=ExpenseSheetServlet.NEXT_MONTH_SHEET %>');" src="images/next.png"/>
						</th>
					</tr>
				</table>
				<table id="tb_expenseSheet" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th>&nbsp;</th>
							<th>&nbsp;</th>
							<th>&nbsp;</th>
							<th><fmt:message key="date" /></th>
							<th><fmt:message key="expenses.type" /></th>
							<th><fmt:message key="expenses.reimburs" /></th>
							<th><fmt:message key="expenses.paid_employee" /></th>
							<th><fmt:message key="expenses.autorization_number" /></th>
							<th><fmt:message key="desc" /></th>
							<th><fmt:message key="cost" /></th>
							<th><fmt:message key="state" /></th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="totalCost" value="0"/>
						<c:forEach var="expenseSheet" items="${expenses}">
							<c:set var="totalCost" value="${totalCost + expenseSheet.cost}"/>
							<tr>
								<td>
									<c:choose>
										<c:when test="${expenseSheet.project ne null }"><b><fmt:message key="expensesheet.project"/></b></c:when>
										<c:otherwise><b><fmt:message key="expensesheet.operation"/></b></c:otherwise>
									</c:choose>
								</td>
								<td>${expenseSheet.idExpenseSheet }</td>
								<td>
									<c:choose>
										<c:when test="${expenseSheet.project ne null }">${tl:escape(expenseSheet.project.projectName) }</c:when>
										<c:otherwise>${tl:escape(expenseSheet.operation.operationName) }</c:otherwise>
									</c:choose>
									<input type="hidden" name="idExpenseSheet" value="${expenseSheet.idExpenseSheet }"/>
								</td>
								<td><fmt:formatDate value="${expenseSheet.expenseDate}" pattern="${datePattern}"/></td>
								<td>
									<c:choose>
										<c:when test="${expenseSheet.project ne null }">${tl:escape(expenseSheet.expenses.budgetaccounts.description) }</c:when>
										<c:otherwise>${tl:escape(expenseSheet.expenseaccounts.description)}</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:if test="${expenseSheet.reimbursable}">
										<fmt:message key="expenses.reimburs" />
									</c:if>
								</td>
								<td>
									<c:if test="${expenseSheet.paidEmployee}">
										<fmt:message key="expenses.paid_employee" />
									</c:if>
								</td>
								<td>${expenseSheet.autorizationNumber}</td>
								<td>${tl:escape(expenseSheet.description)}</td>
								<td>${tl:toCurrency(expenseSheet.cost)}</td>
								<td><fmt:message key="applevel.${expenseSheet.status}"/></td>
								<td><nobr>${btn_comments }</nobr></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="9">&nbsp;</td>
							<td><b>${tl:toCurrency(totalCost) }</b></td>
						</tr>
					</tfoot>
				</table>
				<div>&nbsp;</div>
				<div>
					<a class="button_img position_right" href="javascript:rejectSheet();"><img src="images/reject.png"/><span><fmt:message key="reject.all"/></span></a>
					<a class="button_img position_right" href="javascript:approveSheet();"><img src="images/approve.png"/><span><fmt:message key="approve.all"/></span></a>
				</div>
			</fieldset>
		</c:if>
	</fieldset>
</form>
<jsp:include page="common/comments.inc.jsp" flush="true"/>
