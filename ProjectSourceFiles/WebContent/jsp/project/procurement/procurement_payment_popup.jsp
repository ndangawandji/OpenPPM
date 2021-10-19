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
 -  Devoteam 22/06/2015 user story 17 : Changing Seller Name to Activity Name, and input text of the PO to select
--%>
<%@page import="es.sm2.openppm.model.Procurementpayments"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProjectProcurementServlet"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.model.Activityseller"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="error" var="fmtError" />
<fmt:message key="maintenance.procurement.edit_payment" var="edit_payment_title" />
<fmt:message key="maintenance.procurement.new_payment" var="new_payment_title" />

<fmt:message key="maintenance.error_msg_select_a" var="fmtSellerRequired">
	<fmt:param><b><fmt:message key="procurement.seller_name"/></b></fmt:param>
</fmt:message>

<script language="javascript" type="text/javascript" >
<!--
var paymentValidator;

function addPayment() {
	var f = document.forms["frm_payment_popup"];
	f.reset();
	f.idPayment.value = "";
	$("#<%=Procurementpayments.PAYMENTSCHEDULEINFO %>").text("");		
	$('div#payment_popup legend').html('${new_payment_title}');
	$('div#payment_popup').dialog('open');
}

function editPayment(element) {	
	
	var payment = paymentTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_payment_popup"];
	
	f.idPayment.value 								= payment[0];	
	f.<%=Procurementpayments.SELLER %>.value 		= payment[1];
	f.<%=Procurementpayments.PURCHASEORDER %>.value = unEscape(payment[4]);
	f.<%=Procurementpayments.PLANNEDDATE%>.value 	= payment[5];
	f.<%=Procurementpayments.ACTUALDATE%>.value 	= payment[6];
	f.<%=Procurementpayments.PLANNEDPAYMENT%>.value = payment[7];
	f.<%=Procurementpayments.ACTUALPAYMENT%>.value 	= payment[8];
	$("#<%=Procurementpayments.PAYMENTSCHEDULEINFO %>").text(unEscape(payment[9]));		
		
	$('div#payment_popup legend').html('${edit_payment_title}');	
	$('div#payment_popup').dialog('open');
}

function savePayment() {
	
	if (paymentValidator.form()) {		
		var f = document.forms["frm_payment_popup"];		
		f.action = "<%=ProjectProcurementServlet.REFERENCE%>";
		f.accion.value = "<%=ProjectProcurementServlet.SAVE_PAYMENT %>";
		loadingPopup();
		f.submit();
	}
}

function closePayment() {
	$('div#payment_popup').dialog('close');
}

//When document is ready
readyMethods.add(function() {
	
	$('div#payment_popup').dialog({ 
		autoOpen: false, 
		modal: true, 
		width: 550, 
		minWidth: 300, 
		resizable: false,
		open: function(event, ui) { paymentValidator.resetForm(); }
	});
	
	// validate the form when it is submitted
	paymentValidator = $("#frm_payment_popup").validate({
		errorContainer: 'div#payment-errors',
		errorLabelContainer: 'div#payment-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Procurementpayments.SELLER %> : { required: true },
			<%=Procurementpayments.PAYMENTSCHEDULEINFO %>: { maxlength: 200 }
		},
		messages: {
			<%=Procurementpayments.SELLER %> : {required: '${fmtSellerRequired}' }
		}
	});
	
});
//-->
</script>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<script type="text/javascript">
	<!--
		readyMethods.add(function() {
			$('#<%=Procurementpayments.PLANNEDDATE %>').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function() {
					if (paymentValidator.numberOfInvalids() > 0) paymentValidator.form();
				}
			});
			
			$('#<%=Procurementpayments.ACTUALDATE %>').datepicker({
				dateFormat: '${datePickerPattern}',
				firstDay: 1,
				showOn: 'button',
				buttonImage: 'images/calendario.png',
				buttonImageOnly: true,
				changeMonth: true,
				onSelect: function() {
					if (paymentValidator.numberOfInvalids() > 0) paymentValidator.form();
				}
			});						
		});
	//-->
	</script>
</c:if>

<div id="payment_popup" class="popup">

	<div id="payment-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_payment_popup" id="frm_payment_popup">	
		<input type="hidden" name="id" value="${project.idProject}" /> <!-- idProject -->
		<input type="hidden" name="idPayment" />		
		<input type="hidden" name="accion" />
		
		<fieldset>
			<legend></legend>
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="30%"><fmt:message key="activity"/>&nbsp;*</th> <!-- cnw us17 Changing Seller Name to Activity Name -->
					<td colspan = "3">
						<select name="<%=Procurementpayments.SELLER %>" id="<%=Procurementpayments.SELLER %>" class="campo">
							<option value=""><fmt:message key="select_opt" /></option>
							<c:forEach var="activity" items="${projActivities}">	<!-- cnw us17, Show all control account activities in the current project -->
								<c:if test="${not activity.wbsnode.isControlAccount}">
									<option value="${activity.idActivity}">${activity.activityName}</option>
								</c:if>
							</c:forEach>
						</select>							
					</td>							
				</tr>
				<tr>
					<th class="left"><fmt:message key="procurement.payment_schedule.purchase_order"/>&nbsp;</th>
					<td colspan = "3">
						<select name="<%=Procurementpayments.PURCHASEORDER %>" id="<%=Procurementpayments.PURCHASEORDER %>" class="campo">	<!-- cnw us17, changing input text to select -->
							<option value=""><fmt:message key="select_opt" /></option>
							<c:forEach var="purchaseOrder" items="${purchaseOrders}">
								<option value="${purchaseOrder.idPurchase}">${purchaseOrder.purchaseName}</option>
							</c:forEach>
						</select>												
					</td>							
				</tr>	
				<tr>
					<th class="left"><fmt:message key="procurement.payment_schedule.planned_date"/>&nbsp;</th>
					<td width="25%"><input type="text" name="<%=Procurementpayments.PLANNEDDATE %>" id="<%=Procurementpayments.PLANNEDDATE %>" class="campo fecha" /></td>					
					<th class="left" width="20%"><fmt:message key="procurement.payment_schedule.actual_date"/>&nbsp;</th>
					<td width="30%"><input type="text" name="<%=Procurementpayments.ACTUALDATE %>" id="<%=Procurementpayments.ACTUALDATE %>" class="campo fecha" /></td>
				</tr>	
				<tr>
					<th class="left"><fmt:message key="procurement.payment_schedule.planned_payment"/>&nbsp;</th>
					<td><input type="text" name="<%=Procurementpayments.PLANNEDPAYMENT %>" id="<%=Procurementpayments.PLANNEDPAYMENT %>" class="campo importe" /></td>					
					<th class="left"><fmt:message key="procurement.payment_schedule.actual_payment"/>&nbsp;</th>
					<td><input type="text" name="<%=Procurementpayments.ACTUALPAYMENT %>" id="<%=Procurementpayments.ACTUALPAYMENT %>" class="campo importe" /></td>
				</tr>	
				<tr>
					<th class="left" colspan ="4"><fmt:message key="procurement.payment_schedule.payment_info"/>&nbsp;</th>
				</tr>
				<tr>
					<td colspan ="4">
						<textarea name="<%=Procurementpayments.PAYMENTSCHEDULEINFO %>" id="<%=Procurementpayments.PAYMENTSCHEDULEINFO %>" class="campo" style="width:98%;" ></textarea>						
					</td>
				</tr>
			</table>			
    	</fieldset>
    	<div class="popButtons">
    		<c:if test="${tl:hasPermission(user,project.status,tab)}">
    			<input type="submit" class="boton" onclick="savePayment(); return false;" value="<fmt:message key="save" />" />
			</c:if>
			<a href="javascript:closePayment();" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
