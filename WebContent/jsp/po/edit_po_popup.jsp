<%--
 - Created 29/06/2015
 - Openppm versius Devoteam, user story 17
 - Author : Cédric Ndanga.
--%>

<%@page import="es.sm2.openppm.model.Projectactivity"%>
<%@page import="es.sm2.openppm.servlets.PurchaseorderServlet" %>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.utils.StringPool"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>


<script type="text/javascript">
<!--
var validatorPO;

function savePO() {
	
	var f = document.forms["frm_purchaseorder"];
	f.submit();
	$('div#po-popup').dialog('close');
	
}

function close() {
	
	$('div#po-popup').dialog('close');
}

readyMethods.add(function() {

	$('div#po-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 550, 
		minWidth: 300, 
		resizable: false,
		open: function(event, ui) { validatorActivity.resetForm(); }
	});
	
	$("#po_reception_date").datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true
	});

	//Validate required fields
	/* validatorActivity = $("#frm_activity").validate({
		errorContainer: 'div#activity-errors',
		errorLabelContainer: 'div#activity-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#activity-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			init_date: { required: true, date : true, minDateTo: '#act_end_date' },
			end_date: { required: true, date : true, maxDateTo: '#act_init_date' },
			wbs_dictionary: { maxlength: 300 }
		},
		messages: {
			init_date: { required: '${fmtStartDateRequired}', date : '${fmtStartDateFormat}', minDateTo: '${fmtStartDateAfterFinish}' },
			end_date: { required: '${fmtFinishDateRequired}', date : '${fmtFinishDateFormat}', maxDateTo: '${fmtFinishDateBeforeStart}' }
		}
	});	 */
});

//-->
</script>

<div id="po-popup" class="popup">

	<%-- <div id="member-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="member-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div> --%>

	<form name="frm_purchaseorder" id="frm_purchaseorder" action="<%=PurchaseorderServlet.REFERENCE%>" >
		<input type="hidden" name="accion" value="<%=PurchaseorderServlet.SAVE_PO_JX%>">
		<input type="hidden" name="idmember" value="" />
		<input type="hidden" name="employee_id" />
			
		<fieldset>
			<legend></legend>
			
			<table width="100%" cellpadding="1" cellspadding="2" border="0">
				<tr>
					<th class="left"><fmt:message key="purchaseorder.name"/></th>
					<td colspan="3"><input type="text" name="po_name" id="po_name" class="campo"></td>
				</tr>
				<tr>
					<th class="left"><fmt:message key="purchaseorder.reference"/></th>
					<td><input type="text" name="po_ref" id="po_ref" class="campo fecha"></td>
				</tr>
				<tr>
					<th class="left"><fmt:message key="purchaseorder.customer"/></th>
					<td colspan="3">
						<select name="po_customer" id="po_customer" class="campo">
							<option value=""><fmt:message key="select_opt" /></option>
							<c:forEach var="customer" items="${customers}">
								<option value="${customer.idCustomer}">${customer.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th class="left"><fmt:message key="purchaseorder.cost"/></th>
					<td><input type="text" name="po_cost" id="po_cost" class="campo fecha"></td>
					<th class="left"><fmt:message key="purchaseorder.reception_date"/></th>
					<td><input type="text" name="po_reception_date" id="po_reception_date" class="campo fecha"></td>
				</tr>
			</table>
		</fieldset>
		
		<div class="popButtons">
			<a href="javascript:savePO();" class="boton" id="btnSave"><fmt:message key="save"/></a>
			<a href="javascript:close();" class="boton"><fmt:message key="close"/></a>
		</div>
    </form>
</div>

