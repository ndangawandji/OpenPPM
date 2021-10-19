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
 -  Devoteam 04/09/2015, user-story 17 : Deleting Work and Payments Schedule functionalities
--%>
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProjectProcurementServlet"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.model.Projectactivity"%>
<jsp:useBean id="now" class="java.util.Date" scope="page" />
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectProcurementServlet"%>

<fmt:setLocale value="${locale}" scope="request" />
<fmt:setBundle basename="es.sm2.openppm.common.openppm" />

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_seller">
	<fmt:param><fmt:message key="seller"/></fmt:param>
</fmt:message>

<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_payment">
	<fmt:param><fmt:message key="procurement.payment_schedule.procurement_payments"/></fmt:param>
</fmt:message>

<c:set var="documentStorage"><%=es.sm2.openppm.common.Constants.DOCUMENT_STORAGE%></c:set>

<script type="text/javascript">
<!--

var procurementAjax = new AjaxCall('<%=ProjectProcurementServlet.REFERENCE%>','<fmt:message key="error"/>');

function deleteSeller(id) {
	
	document.forms["frm_project"].idSeller.value = id;
	confirmUI(
		'', '${msg_confirm_delete_seller}', 
		"${msg_yes}", "${msg_no}", 
		function () {
			$('#dialog-confirm').dialog("close"); 
			var f = document.forms["frm_project"];
			f.accion.value = "<%=ProjectProcurementServlet.DELETE_SELLER %>";
			loadingPopup();
			f.submit();
	});
}

function deletePayment(id) {
	
	document.forms["frm_project"].idPayment.value = id;
	confirmUI(
		'', '${msg_confirm_delete_payment}', 
		"${msg_yes}", "${msg_no}", 
		function () {
			$('#dialog-confirm').dialog("close"); 
			var f = document.forms["frm_project"];
			f.accion.value = "<%=ProjectProcurementServlet.DELETE_PAYMENT %>";
			loadingPopup();
			f.submit();
	});
}

//When document is ready
readyMethods.add(function() {	
	sowTable = $('#tb_sow').dataTable({
		"oLanguage": datatable_language,
		"iDisplayLength": 25,
		"aaSorting": [[2,'asc']],
		"bFilter": false,				
		"sPaginationType": "full_numbers",		
		"aoColumns": [
		              { "bVisible": false },		               
		              { "bVisible": false },
		              { "sClass": "left"},
		              { "sClass": "left"},
		              { "bVisible": false },
		              { "sClass": "left"},
		              { "sClass": "left"},		              
		              { "sClass": "center", "bSortable": false }
		      		]
	});
	
	$('#tb_sow tbody tr').live('click',  function (event) {
		fnSetSelectable(sowTable, this);
	} );
	
	workTable = $('#tb_work').dataTable({
		"oLanguage": datatable_language,
		"iDisplayLength": 25,
		"aaSorting": [[2,'asc']],
		"iDisplayLength": 50,
		"bFilter": false,				
		"sPaginationType": "full_numbers",	
		"aoColumns": [
		              { "bVisible": false },	
		              { "bVisible": false },
		              { "sClass": "left"},
		              { "sClass": "left"},
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "left"},		              
		              { "sClass": "center", "bSortable": false },
		              { "bVisible": false },	
		              { "bVisible": false }	
		      		]
	});
	
	paymentTable = $('#tb_payment').dataTable({
		"oLanguage": datatable_language,
		"iDisplayLength": 25,
		"aaSorting": [[2,'asc']],
		"bFilter": false,				
		"sPaginationType": "full_numbers",	
		"aoColumns": [	              
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "left"},
		              { "sClass": "right"},
		              { "sClass": "left"},
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "center", "sType": "es_date" },
		              { "sClass": "right"},
		              { "sClass": "right"},
		              { "sClass": "left"},
		              { "sClass": "center", "bSortable": false }
		      		]
	});
	
	budgetTable = $('#tb_budget').dataTable({
		"oLanguage": datatable_language,
		"iDisplayLength": 25,
		"aaSorting": [[0,'asc']],
		"bFilter": false,				
		"sPaginationType": "full_numbers",	
		"aoColumns": [
		              { "sClass": "left"},
		              { "sClass": "center"},
		              { "sClass": "left"},
		              { "sClass": "right"},
		              { "sClass": "right"}           
		      		]
	});
	
	sellerTable = $('#tb_seller').dataTable({
		"oLanguage": datatable_language,
		"iDisplayLength": 25,
		"aaSorting": [[2,'asc']],
		"bFilter": false,				
		"sPaginationType": "full_numbers",	
		"aoColumns": [
		              { "bVisible": false },
		              { "bVisible": false },
		              { "sClass": "left"},
		              { "sClass": "left"},
		              { "sClass": "left"},
		              { "sClass": "center", "bSortable": false }
		      		]
	});
	
});
//-->
</script>
<jsp:include page="../common/header_project.jsp">
	<jsp:param value="PR" name="actual_page"/>
</jsp:include>

<div class="caja_formulario">
	<form name="frm_project" id="frm_project" method="post">
		<input type="hidden" name="id" id="id" value="${project.idProject}" />
		<input type="hidden" name="accion" />
		<input type="hidden" name="idSeller" />
		<input type="hidden" name="idPayment" />
		<input type="hidden" id="idDocument" name="idDocument" />
		
   		<%-- INFORMATION OF PROJECT --%>
		<jsp:include page="../common/info_project.jsp" flush="true" />
		
		<%-- SOW & SELECTION --%>		
		<fieldset class="level_1 hide">		<!-- cnw us17  adding the css class hide -->
			<legend class="link" onclick="changeCookie('sow_selection')"><fmt:message key="procurement.sow_selection"/></legend>
			<div class="buttons">
				<img id="sow_selectionBtn" onclick="changeCookie('sow_selection', this)" class="link" src="images/ico_mas.gif">
			</div>			
			<div id="sow_selection" class="hide" style="padding-top:10px;">
				<table id="tb_sow" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th> <%-- idSeller --%>
							<th width="15%"><fmt:message key="procurement.seller_name"/></th>							
							<th width="37%"><fmt:message key="procurement.sow_selection.sow"/></th>
							<th width="0%">&nbsp;</th> <%-- idActivity --%>
							<th width="15%"><fmt:message key="procurement.activity_name"/></th>
							<th width="25%"><fmt:message key="procurement.sow_selection.procurement_docs"/></th>
							<th width="8%">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img onclick="addSow()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
								</c:if>								
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="activitySeller" items="${activitySellers}">
							<tr>
								<td>${activitySeller.idActivitySeller}</td>
								<td>${activitySeller.seller.idSeller}</td>
								<td>${tl:escape(activitySeller.seller.name)}</td>
								<td>${tl:escape(activitySeller.statementOfWork)}</td>
								<td>${activitySeller.projectactivity.idActivity}</td>
								<td>${tl:escape(activitySeller.projectactivity.activityName)}</td>
								<td>${tl:escape(activitySeller.procurementDocuments)}</td>														
								<td>			
									<img onclick="editSow(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">
									<c:if test="${tl:hasPermission(user,project.status,tab)}">
										&nbsp;&nbsp;&nbsp;
										<img src="images/delete.jpg" class="link" onclick="deleteSeller(${activitySeller.idActivitySeller})" />
									</c:if>			
								</td>								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</fieldset>
		
		<%-- WORK SHEDULE --%>
		<div>&nbsp;</div>
		<fieldset class="level_1 hide">		<!-- cnw us17  adding the css class hide -->
			<legend class="link" onclick="changeCookie('work_schedule')"><fmt:message key="procurement.work_schedule"/></legend>
			<div class="buttons">
				<img id="work_scheduleBtn" onclick="changeCookie('work_schedule', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="work_schedule" class="hide" style="padding-top:10px;">
				<table id="tb_work" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th> <!-- idSeller -->
							<th width="15%"><fmt:message key="procurement.seller_name"/></th>
							<th width="15%"><fmt:message key="procurement.activity_name"/></th>
							<th width="10%"><fmt:message key="procurement.work_schedule.baseline_start"/></th>
							<th width="10%"><fmt:message key="procurement.work_schedule.start"/></th>
							<th width="10%"><fmt:message key="procurement.work_schedule.baseline_finish"/></th>
							<th width="10%"><fmt:message key="procurement.work_schedule.finish"/></th>
							<th width="25%"><fmt:message key="procurement.work_schedule.work_info"/></th>							
							<th width="5%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="activitySeller" items="${activitySellers}">
							<tr>
								<td>${activitySeller.idActivitySeller}</td>
								<td>${activitySeller.seller.idSeller}</td>
								<td>${tl:escape(activitySeller.seller.name)}</td>
								<td>${tl:escape(activitySeller.projectactivity.activityName)}</td>
								<td><fmt:formatDate value="${activitySeller.baselineStart}" pattern="${datePattern}"/></td>
								<td><fmt:formatDate value="${activitySeller.startDate}" pattern="${datePattern}"/></td>
								<td><fmt:formatDate value="${activitySeller.baselineFinish}" pattern="${datePattern}"/></td>
								<td><fmt:formatDate value="${activitySeller.finishDate}" pattern="${datePattern}"/></td>
								<td>${tl:escape(activitySeller.workScheduleInfo)}</td>
								<td>			
									<img onclick="editWork(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">			
								</td>								
								<td><fmt:formatDate value="${activitySeller.projectactivity.planInitDate}" pattern="${datePattern}"/></td>
								<td><fmt:formatDate value="${activitySeller.projectactivity.planEndDate}" pattern="${datePattern}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>				
			</div>
		</fieldset>
		
		<%-- PAYMENTS SCHEDULE --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('payments_schedule')"><fmt:message key="procurement.payment_schedule"/></legend>
			<div class="buttons">		
				<img id="payments_scheduleBtn" onclick="changeCookie('payments_schedule', this)" class="link" src="images/ico_mas.gif">
			</div>			
			<div id="payments_schedule" class="hide" style="padding-top:10px;">
				<div class="hColor"><fmt:message key="procurement.payment_schedule.procurement_budget"/></div>
				<table id="tb_budget" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>							
							<th width="30%"><fmt:message key="procurement.seller_name"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.number_payment"/></th>
							<th width="40%"><fmt:message key="procurement.payment_schedule.purchase_order"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.planned_payment"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.actual_payment"/></th>						
						</tr>
					</thead>					
					<tbody>						
						<c:forEach var="procBudget" items="${procBudgets}">											
							<tr>																
								<td>${tl:escape(procBudget.seller)}</td>
								<td>${procBudget.nPayments}</td>
								<td>${tl:escape(procBudget.purchaseOrder)}</td>																
								<td>${tl:toCurrency(procBudget.plannedPayment)}</td>
								<td>${tl:toCurrency(procBudget.actualPayment)}</td>																								
							</tr>
						</c:forEach>						 
					</tbody>
				</table>		
				
				<div>&nbsp;</div>
				
				<div class="hColor"><fmt:message key="procurement.payment_schedule.procurement_payments"/></div>
				
				<table id="tb_payment" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th> <!-- idSeller -->
							<th width="10%"><fmt:message key="procurement.seller_name"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.n_payment"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.purchase_order"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.planned_date"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.actual_date"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.planned_payment"/></th>
							<th width="10%"><fmt:message key="procurement.payment_schedule.actual_payment"/></th>
							<th width="22%"><fmt:message key="procurement.payment_schedule.payment_info"/></th>							
							<th width="8%">
								<c:if test="${tl:hasPermission(user,project.status,tab)}">
									<img onclick="addPayment()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
								</c:if>
							</th>
						</tr>
					</thead>
					<tbody>					
						<c:set var="actual" value="-1"/>
						<c:forEach var="procPayment" items="${procPayments}">												
							<c:choose>										
								<c:when test="${actual eq procPayment.seller.idSeller}">									
									<c:set var="cont" value="${cont + 1}" />																						 											
								</c:when>
								<c:otherwise>
									<c:set var="cont" value="1" />
									<c:set var="actual" value="${procPayment.seller.idSeller}" />									
								</c:otherwise>
							</c:choose>							
							<tr>
								<td>${procPayment.idProcurementPayment}</td>
								<td>${procPayment.seller.idSeller}</td>
								<td>${procPayment.seller.name}</td>
								<td>									
									<c:out value="${cont}" />&nbsp;&nbsp;&nbsp;																																				
								</td>
								<td>${tl:escape(procPayment.purchaseOrder)}</td>
								<td><fmt:formatDate value="${procPayment.plannedDate}" pattern="${datePattern}"/></td>
								<td><fmt:formatDate value="${procPayment.actualDate}" pattern="${datePattern}"/></td>								
								<td>${tl:toCurrency(procPayment.plannedPayment)}</td>
								<td>${tl:toCurrency(procPayment.actualPayment)}</td>
								<td>${tl:escape(procPayment.paymentScheduleInfo)}</td>
								<td>
									<img onclick="editPayment(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">
									<c:if test="${tl:hasPermission(user,project.status,tab)}">
										&nbsp;&nbsp;&nbsp;
										<img src="images/delete.jpg" class="link" onclick="deletePayment(${procPayment.idProcurementPayment})" />
									</c:if>			
								</td>								
							</tr>
						</c:forEach>
					</tbody>
				</table>								
			</div>
		</fieldset>
		
		<%-- SELLERS PERFORMANCE --%>
		<div>&nbsp;</div>
		<fieldset class="level_1">
			<legend class="link" onclick="changeCookie('sellers_performance')"><fmt:message key="procurement.seller_performance"/></legend>
			<div class="buttons">
				<img id="sellers_performanceBtn" onclick="changeCookie('sellers_performance', this)" class="link" src="images/ico_mas.gif">
			</div>			
			<div id="sellers_performance" class="hide" style="padding-top:10px;">
				<table id="tb_seller" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							<th width="0%">&nbsp;</th>
							<th width="0%">&nbsp;</th> <!-- idSeller -->
							<th width="25%"><fmt:message key="procurement.seller_name"/></th>
							<th width="25%"><fmt:message key="procurement.activity_name"/></th>							
							<th width="45%"><fmt:message key="procurement.seller_performance.seller_info"/></th>							
							<th width="5%">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="activitySeller" items="${activitySellers}">
							<tr>
								<td>${activitySeller.idActivitySeller}</td>
								<td>${activitySeller.seller.idSeller}</td>
								<td>${tl:escape(activitySeller.seller.name)}</td>
								<td>${tl:escape(activitySeller.projectactivity.activityName)}</td>								
								<td>${tl:escape(activitySeller.sellerPerformanceInfo)}</td>
								<td>		
									<img onclick="editSeller(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">			
								</td>								
							</tr>
						</c:forEach>
					</tbody>
				</table>							
			</div>			

		</fieldset>

	</form>
	
	<%--  DOCUMENTATION --%>
	<div>&nbsp;</div>
	<fmt:message var="documentationTitle" key="documentation.procurement"/>	
	<jsp:include page="../common/project_documentation_${documentStorage}.jsp">		
		<jsp:param name="documentationType" value="<%=Constants.DOCUMENT_PROCUREMENT %>"/>
		<jsp:param name="documentationTitle" value="${documentationTitle }"/>
	</jsp:include>
</div>

<jsp:include page="sow_selection_popup.jsp" flush="true" />
<jsp:include page="work_schedule_popup.jsp" flush="true" />
<jsp:include page="procurement_payment_popup.jsp" flush="true" />
<jsp:include page="seller_performance_popup.jsp" flush="true" />
