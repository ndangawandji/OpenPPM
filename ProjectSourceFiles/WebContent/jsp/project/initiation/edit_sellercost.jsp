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

<%@page import="es.sm2.openppm.servlets.ProjectInitServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="update" var="msg_update" />
<fmt:message key="add" var="msg_add" />
<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message key="msg.confirm_delete" var="msg_delete_sellercost">
	<fmt:param><fmt:message key="sellercost"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_delete_sellercost">
	<fmt:param><fmt:message key="sellercost"/></fmt:param>
</fmt:message>

<c:if test="${project.status ne status_closed}">
	<c:set var="deleteSellerCost"><img onclick="deleteSellerCost(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg"></c:set>
</c:if>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtNameRequired">
	<fmt:param><b><fmt:message key="sellerscosts.name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtCostRequired">
	<fmt:param><b><fmt:message key="sellerscosts.cost"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.maximum_allowed" var="fmtCostMax">
	<fmt:param><b><fmt:message key="sellerscosts.cost"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var sel_validator;

function viewSellerCost(element) {
	
	sel_validator.resetForm();
	var sellercost = sellersCostsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_sellercost"];

	// Recover sellercost info
	f.sel_id.value		= sellercost[0];
	f.sel_name.value	= sellercost[1];
	f.sel_cost.value	= sellercost[2];
	f.cost_old.value	= sellercost[2];
	
	$('#btn_savesellercost').button("option", "label", '${msg_update}');
	
	$('#sellercost-popup').dialog('open');
}

function deleteSellerCostConfirmated () {
	$('#dialog-confirm').dialog("close"); 

	var f = document.forms["frm_sellercost"];
	
	var params = {
		accion: "<%=ProjectInitServlet.JX_DELETE_SELLERCOST%>", 
		id: document.forms["frm_project"].id.value, // Project ID
		sel_id: f.sel_id.value
	};
		
	initAjax.call(params, function (data) {
				
	    var total = toNumber($('#totalsellerscosts').html());
		var oldCost = toNumber(sellersCostsTable.fnGetSelectedCol(2));

	    var newTotal = parseFloat(total) - parseFloat(oldCost);
	    
	    sellersCostsTable.fnDeleteSelected();
	    
		$('#totalsellerscosts').html(toCurrency(newTotal));
		updateTotalCosts();
	});
}

function deleteSellerCost(element) {
	
	var sellercost = sellersCostsTable.fnGetData( element.parentNode.parentNode );
	
	$('#sel_id').val(sellercost[0]);
	
	$('#dialog-confirm-msg').html('${msg_delete_sellercost}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": deleteSellerCostConfirmated,
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_delete_sellercost}'
	);
	$('#dialog-confirm').dialog('open');
}

function resetSellerCost() {
	var f = document.forms["frm_sellercost"];
	f.sel_id.value = '';
	f.reset();
}

function newSellerCost() {
	
	resetSellerCost();
	sel_validator.resetForm();
	
	$('#btn_savesellercost').button("option", "label", '${msg_add}');
	$('#sellercost-popup').dialog('open');

	var f = document.forms["frm_sellercost"];
	f.cost_old.value	=  0;
	
	f.sel_name.focus();
}

function saveSellerCost() {
	
	if (sel_validator.form()) {
		var f = document.forms["frm_sellercost"];

		var sel_id = f.sel_id.value;
		
		var params = {
			accion: "<%=ProjectInitServlet.JX_SAVE_SELLERCOST%>", 
			id: document.forms["frm_project"].id.value, // Project ID
			sel_id: f.sel_id.value,
			sel_name: f.sel_name.value,
			sel_cost: f.sel_cost.value 
		};
			
		initAjax.call(params, function (data) {

			var idSellerCost = data.id;
			
			var dataRow = [
      		    idSellerCost,
      		    f.sel_name.value,
				f.sel_cost.value,
				'<img onclick="viewSellerCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'+
				'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
				'${deleteSellerCost}'
  			];
			
			if (sel_id != '') { 
			
				var anSelected = fnGetSelected(sellersCostsTable);
				var aPos = sellersCostsTable.fnGetPosition(anSelected[0]);
				
				sellersCostsTable.fnUpdate(dataRow, aPos, 0);
			}
			else { 
				sellersCostsTable.fnAddData(dataRow); 
			}

			var total = toNumber($('#totalsellerscosts').html());
			total = (total==""?0:total);
			
			var oldCost = toNumber(f.cost_old.value);
			var newCost = toNumber(f.sel_cost.value);
			
			var newTotal = parseFloat(total) - parseFloat(oldCost) + parseFloat(newCost);
			
			$('#totalsellerscosts').html(toCurrency(newTotal));
			updateTotalCosts();
			
			if(f.sel_id.value != "" ) {
				$('#sellercost-popup').dialog('close');
			}
			else {
				f.sel_id.value = "";
				f.sel_name.value = "";
				f.sel_cost.value = "";	
			}					
		});
	} 
}

function closeSellerCostDetail() {
	sel_validator.resetForm();
	resetSellerCost();
	$('#sellercost-popup').dialog('close');
}


readyMethods.add(function() {
	
	//Validate required fields
	sel_validator = $("#frm_sellercost").validate({
		errorContainer: 'div#sellercost-errors',
		errorLabelContainer: 'div#sellercost-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#sellercost_numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			sel_name: "required",
			sel_cost: { required: true, maxlength: <%=Constants.MAX_CURRENCY%> }
		},
		messages: {
			sel_name: { required: '${fmtNameRequired}'},
			sel_cost: { required: '${fmtCostRequired}', maxlength:'${fmtCostMax}' }
		}
	});
	
	$('#sellercost-popup').dialog({ 
		autoOpen: false, 
		modal: true, 
		width: 500, 
		resizable: false,
		open: function(event, ui) { sel_validator.resetForm(); }
	});
});
//-->
</script>

<div id="sellercost-popup" class="popup">
	<div id="sellercost-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="sellercost_numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	<form name="frm_sellercost" id="frm_sellercost">
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="sel_id" id="sel_id" />
		<input type="hidden" name="cost_old" id="cost_old" value="0" />
		<fieldset>
			<legend><fmt:message key="sellercost"/></legend>
			<table width="100%" cellpadding="2" cellspacing="1" align="center">
				<tr>
					<th class="left" width="75%"><fmt:message key="sellerscosts.name" />&nbsp;*</th>
					<th class="left" width="20%"><fmt:message key="sellerscosts.cost" />&nbsp;*</th>
					<th width="2px;">&nbsp;</th>
				</tr>
				<tr>
					<td><input type="text" id="sel_name" name="sel_name" class="campo" maxlength="75" /></td>
					<td><input type="text" id="sel_cost" name="sel_cost" class="campo importe" style="align:left;" /></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</fieldset>
		<div class="popButtons">
			<c:if test="${project.status ne status_closed}">
				<input type="submit" class="boton" id="btn_savesellercost" onclick="saveSellerCost(); return false;" value="<fmt:message key="add" />" />
			</c:if>
			<a href="javascript:closeSellerCostDetail();" class="boton" id="btn_closesellercost"><fmt:message key="close" /></a>
		</div>
	</form>
</div>
