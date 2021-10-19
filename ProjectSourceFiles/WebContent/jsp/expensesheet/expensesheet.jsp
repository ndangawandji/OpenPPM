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
<%@page import="es.sm2.openppm.utils.SettingUtil"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ExpenseSheetServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="app0" value="<%=Constants.EXPENSE_STATUS_APP0 %>"/>
<c:set var="btn_comments"><img onclick="javascript:viewComments(this);" title="<fmt:message key="comments.view"/>" class="ico link" src="images/comments_delete.png"/></c:set>

<fmt:message key="msg.confirm.delete_all" var="deleteExpenses">
	<fmt:param><fmt:message key="expenses"/></fmt:param>
</fmt:message>

<fmt:message key="msg.confirm.delete" var="deleteExpense">
	<fmt:param><fmt:message key="expense"/></fmt:param>
</fmt:message>

<script language="javascript" type="text/javascript" >
<!--
var expenseSheetAjax = new AjaxCall('<%=ExpenseSheetServlet.REFERENCE%>','<fmt:message key="error"/>');
var expenseSheetTable;

function changeMonth(accion) {
	var f = document.frm_expense_sheet;
	f.accion.value = accion;
	loadingPopup();
	f.submit();
}

function saveExpense(element) {
	
	var aData = expenseSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	var f = document.frm_expense_sheet;
	
	var idExpenseAccount = (typeof f['expensesType_'+aData[1]] === 'undefined'?-1:f['expensesType_'+aData[1]].value);
	var idExpense		 = (typeof f['idExpense_'+aData[1]] === 'undefined'?-1:f['idExpense_'+aData[1]].value);	
	
	var params = {
		accion: 			'<%=ExpenseSheetServlet.JX_SAVE_EXPENSESHEET%>',
		idExpenseSheet: 	aData[1],
		expenseDate: 		f['expenseDate_'+aData[1]		].value,
		idExpenseAccount:	idExpenseAccount,
		idExpense:			idExpense,
		reimbursable:		f['reimbursable_'+aData[1]		].checked,
		paidEmployee:		f['paidEmployee_'+aData[1]		].checked,
		autorizationNumber:	f['autorizationNumber_'+aData[1]].value,
		description: 		f['description_'+aData[1]		].value,
		cost: 				f['cost_'+aData[1]				].value
	};
	
	expenseSheetAjax.call(params);
}

function approveExpense(element) {
	
	var aData = expenseSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	
	confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				
				var f = document.frm_expense_sheet;
				
				var idExpenseAccount = (typeof f['expensesType_'+aData[1]] === 'undefined'?-1:f['expensesType_'+aData[1]].value);
				var idExpense		 = (typeof f['idExpense_'+aData[1]] === 'undefined'?-1:f['idExpense_'+aData[1]].value);
				
				var params = {
					accion: 			'<%=ExpenseSheetServlet.JX_APPROVE_EXPENSESHEET%>',
					idExpenseSheet: 	aData[1],
					expenseDate: 		f['expenseDate_'+aData[1]		].value,
					idExpenseAccount:	idExpenseAccount,
					idExpense:			idExpense,
					reimbursable:		f['reimbursable_'+aData[1]		].checked,
					paidEmployee:		f['paidEmployee_'+aData[1]		].checked,
					autorizationNumber:	f['autorizationNumber_'+aData[1]].value,
					description: 		f['description_'+aData[1]		].value,
					cost: 				f['cost_'+aData[1]				].value,
					comments: msg
				};
				
				expenseSheetAjax.call(params, function() {
					
					$(f['expenseDate_'+aData[1]]).datepicker('destroy');
					$('#changeStatus_'+aData[1]).text('<fmt:message key="applevel.app1"/>');
					$('#changeButtons_'+aData[1]).html('<nobr>${btn_comments}</nobr>');
					
					$('.change_'+aData[1]).attr('disabled',true);
				});
			}
	);
}

function deleteExpense(element) {
	
	var aData = expenseSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	
	confirmUI('<fmt:message key="delete"/>', '${deleteExpense}',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function() {
				var params = {
					accion: 			'<%=ExpenseSheetServlet.JX_DELETE_EXPENSESHEET%>',
					idExpenseSheet: 	aData[1]
				};
				expenseSheetAjax.call(params, function() { expenseSheetTable.fnDeleteSelected(); });
			}
		);
}

function saveSheet() {
	var f = document.frm_expense_sheet;
	f.accion.value = "<%=ExpenseSheetServlet.SAVE_ALL_EXPENSESHEET %>";
	loadingPopup();
	f.submit();
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

function deleteSheet() {
	confirmUI('<fmt:message key="delete"/>', '${deleteExpenses}',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function() {
				
				var f = document.frm_expense_sheet;
				f.accion.value = "<%=ExpenseSheetServlet.DELETE_ALL_EXPENSESHEET %>";
				loadingPopup();
				f.submit();
			}
	);
}

function changeReimbursable(element, id) {
	
	var f = document.frm_expense_sheet;	
	if (element.checked) {
		f["paidEmployee_"+id].disabled = false;
	}
	else {
		f["paidEmployee_"+id].checked = false;
		f["paidEmployee_"+id].disabled = true;
	}
}

readyMethods.add(function () {

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
	
	$('.importe').bind('change', function() {
		var total = 0;
		
		$('.importe').each(function() {
			
			var value = Number(isNaN(Number($(this).val()))? toNumber($(this).val()):$(this).val());
			total += value;
		});
		$("#totalCost").text(toCurrency(total));
	});
});
//-->
</script>

<form id="frm_expense_sheet" name="frm_expense_sheet" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="sheetDate" value="<fmt:formatDate value="${sheetDate}" pattern="${datePattern}"/>" />
	<input type="hidden" name="idProject" value="" />
	<input type="hidden" name="idOperation" value="" />
	<input type="hidden" name="comments" value="" />
	
	<fieldset>
		<table width="100%" border="0" cellpadding="7" cellspacing="1">
			<tr>
				<th width="5%"><fmt:message key="filter"/>:</th>
				<td width="40%">
					<select id="filter" class="campo" style="width:100%;">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<option value="<fmt:message key="applevel.app0"/>"><fmt:message key="applevel.app0_desc" /></option>
						<option value="<fmt:message key="applevel.app1"/>"><fmt:message key="applevel.app1_desc" /></option>
						<c:if test="<%=SettingUtil.getApprovalRol(request) > 0%>">
							<option value="<fmt:message key="applevel.app2"/>"><fmt:message key="applevel.app2_desc" /></option>
						</c:if>
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
					<th><fmt:message key="cost.charge_account" /></th>
					<th><fmt:message key="expenses.reimburs" /></th>
					<th><fmt:message key="expenses.paid" /></th>
					<th><fmt:message key="expenses.autorization_number" /></th>
					<th><fmt:message key="desc" /></th>
					<th><fmt:message key="cost.value" /></th>
					<th><fmt:message key="state" /></th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="totalCost" value="0"/>
				<c:forEach var="expenseSheet" items="${expenseSheets}">
					<c:set var="totalCost" value="${totalCost + expenseSheet.cost}"/>
					<c:choose>
						<c:when test="${app0 ne expenseSheet.status }"><c:set var="disabled">disabled</c:set></c:when>
						<c:otherwise><c:set var="disabled"></c:set></c:otherwise>
					</c:choose>
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
						<td>
							<nobr>
								<c:choose>
									<c:when test="${app0 eq expenseSheet.status }">
										<input type="text" class="campo fecha expenseDate change_${expenseSheet.idExpenseSheet }" name="expenseDate_${expenseSheet.idExpenseSheet }" value="<fmt:formatDate value="${expenseSheet.expenseDate}" pattern="${datePattern}"/>" readonly/>
									</c:when>
									<c:otherwise>
										<input type="text" class="campo fecha change_${expenseSheet.idExpenseSheet }" name="expenseDate_${expenseSheet.idExpenseSheet }" value="<fmt:formatDate value="${expenseSheet.expenseDate}" pattern="${datePattern}"/>" ${disabled }/>
									</c:otherwise>
								</c:choose>
							</nobr>
						</td>
						<td>
							<c:choose>
								<c:when test="${expenseSheet.project ne null }">
									<select name="idExpense_${expenseSheet.idExpenseSheet}" class="campo change_${expenseSheet.idExpenseSheet }" ${disabled }>
										<c:forEach var="costs" items="${expenseSheet.project.projectcostses}">
											<c:forEach var="expense" items="${costs.expenseses}">
												<c:choose>
													<c:when test="${expenseSheet.expenses.idExpense == expense.idExpense}">
														<option value="${expense.idExpense }" selected="selected">${tl:escape(expense.budgetaccounts.description) }</option>
													</c:when>
													<c:otherwise>
														<option value="${expense.idExpense }">${tl:escape(expense.budgetaccounts.description) }</option>
													</c:otherwise>																
												</c:choose>
											</c:forEach>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise>
									<select name="expensesType_${expenseSheet.idExpenseSheet}" class="campo change_${expenseSheet.idExpenseSheet }" ${disabled }>
										<c:forEach var="account" items="${expenseAccounts}">
											<c:choose>
												<c:when test="${expenseSheet.expenseaccounts.idExpenseAccount == account.idExpenseAccount}">
													<option value="${account.idExpenseAccount }" selected="selected">${tl:escape(account.description) }</option>
												</c:when>
												<c:otherwise>
													<option value="${account.idExpenseAccount }">${tl:escape(account.description) }</option>
												</c:otherwise>																
											</c:choose>
										</c:forEach>
									</select>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${expenseSheet.reimbursable}">
									<input type="checkbox" class="change_${expenseSheet.idExpenseSheet }" onchange="changeReimbursable(this, ${expenseSheet.idExpenseSheet })" name="reimbursable_${expenseSheet.idExpenseSheet}" checked="checked"  ${disabled }/>
								</c:when>
								<c:otherwise>
									<input type="checkbox" class="change_${expenseSheet.idExpenseSheet }" onchange="changeReimbursable(this, ${expenseSheet.idExpenseSheet })" name="reimbursable_${expenseSheet.idExpenseSheet}" name="reimbursable_${expenseSheet.idExpenseSheet}" ${disabled }/>
								</c:otherwise>																
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${expenseSheet.paidEmployee}">
									<input type="checkbox" class="change_${expenseSheet.idExpenseSheet }" name="paidEmployee_${expenseSheet.idExpenseSheet}" checked="checked" ${expenseSheet.reimbursable?disabled:"disabled" }/>
								</c:when>
								<c:otherwise>
									<input type="checkbox" class="change_${expenseSheet.idExpenseSheet }" name="paidEmployee_${expenseSheet.idExpenseSheet}" ${expenseSheet.reimbursable?disabled:"disabled" }/>
								</c:otherwise>																
							</c:choose>
						</td>
						<td>
							<input type="text" class="campo number change_${expenseSheet.idExpenseSheet }" style="width: 55px;" name="autorizationNumber_${expenseSheet.idExpenseSheet}" value="${expenseSheet.autorizationNumber}"  ${disabled }/>
						</td>
						<td><input type="text" class="campo change_${expenseSheet.idExpenseSheet }" name="description_${expenseSheet.idExpenseSheet}" value="${tl:escape(expenseSheet.description)}" maxlength="150" ${disabled }/></td>
						<td><input type="text" class="campo importe change_${expenseSheet.idExpenseSheet }" style="width: 50px;" name="cost_${expenseSheet.idExpenseSheet}" value="${expenseSheet.cost}" ${disabled }/></td>
						<td id="changeStatus_${expenseSheet.idExpenseSheet}"><fmt:message key="applevel.${expenseSheet.status}"/></td>
						<td id="changeButtons_${expenseSheet.idExpenseSheet}">
							<nobr>
								<c:if test="${app0 eq expenseSheet.status }">
									<img onclick="saveExpense(this)" src="images/save.png" class="ico link" title="<fmt:message key="save"/>"/>&nbsp;
									<img onclick="approveExpense(this)" src="images/approve.png" class="ico link" title="<fmt:message key="approve"/>"/>&nbsp;
									<img onclick="deleteExpense(this)" src="images/delete.jpg" class="ico link" title="<fmt:message key="delete"/>"/>&nbsp;
								</c:if>
								${btn_comments }
							</nobr>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="9">&nbsp;</td>
					<td><b id="totalCost">${tl:toCurrency(totalCost) }</b></td>
				</tr>
			</tfoot>
		</table>
		<div>&nbsp;</div>
		<div style="padding: 15px;">
			<a class="button_img position_right" href="javascript:deleteSheet();"><img src="images/delete.jpg"/><span><fmt:message key="delete.all"/></span></a>
			<a class="button_img position_right" href="javascript:approveSheet();"><img src="images/approve.png"/><span><fmt:message key="approve.all"/></span></a>
			<a class="button_img position_right" href="javascript:saveSheet();"><img src="images/save.png"/><span><fmt:message key="save.all"/></span></a>
			<a class="button_img position_right" href="javascript:newExpense();"><img src="images/add_proj.png"/><span><fmt:message key="expense.add"/></span></a>
		</div>
	</fieldset>
</form>
<jsp:include page="add_expense_popup.jsp" flush="true"/>
<jsp:include page="common/comments.inc.jsp" flush="true"/>
