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
<%@page import="es.sm2.openppm.servlets.ProjectProcurementServlet"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.model.Activityseller"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="error" var="fmtError" />
<fmt:message key="maintenance.procurement.edit_seller" var="edit_seller_title" />

<fmt:message key="maintenance.error_msg_select_a" var="fmtSellerRequired">
	<fmt:param><b><fmt:message key="procurement.seller_name"/></b></fmt:param>
</fmt:message>

<script language="javascript" type="text/javascript" >
<!--
var workValidator;

function editSeller(element) {	
	
	var seller = sellerTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_seller_popup"];
	
	f.idActSeller.value 							= seller[0];	
	f.<%=Activityseller.SELLER %>.value 			= seller[1];
	$("#sellerSellerName").text(unEscape(seller[2]));
	$("#sellerActivityName").text(unEscape(seller[3]));
	$("#<%=Activityseller.SELLERPERFORMANCEINFO %>").text(unEscape(seller[4]));		
		
	$('div#seller_popup legend').html('${edit_seller_title}');	
	$('div#seller_popup').dialog('open');
}

function saveSeller() {
	
	if (sellerValidator.form()) {		
		var f = document.forms["frm_seller_popup"];		
		f.action = "<%=ProjectProcurementServlet.REFERENCE%>";
		f.accion.value = "<%=ProjectProcurementServlet.SAVE_SELLER %>";
		loadingPopup();
		f.submit();
	}
}

function closeSeller() {
	$('div#seller_popup').dialog('close');
}

//When document is ready
readyMethods.add(function() {
	
	$('div#seller_popup').dialog({ 
		autoOpen: false, 
		modal: true, 
		width: 550, 
		minWidth: 300, 
		resizable: false,
		open: function(event, ui) { sellerValidator.resetForm(); }
	});
	
	// validate the form when it is submitted
	sellerValidator = $("#frm_seller_popup").validate({
		errorContainer: 'div#seller-errors',
		errorLabelContainer: 'div#seller-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Activityseller.SELLER %> : { required: true },	
			<%=Activityseller.SELLERPERFORMANCEINFO %> : { maxlength: 200 }			
		},
		messages: {
			<%=Activityseller.SELLER %> : { required: '${fmtSellerRequired}' }
		}
	});
});
//-->
</script>

<div id="seller_popup" class="popup">

	<div id="seller-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_seller_popup" id="frm_seller_popup" method="post">	
		<input type="hidden" name="id" value="${project.idProject}" /> <!-- idProject -->
		<input type="hidden" name="idActSeller" />		
		<input type="hidden" name="accion" />
		<input type="hidden" name="<%=Activityseller.SELLER %>" />
		
		<fieldset>
			<legend></legend>
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="25%"><fmt:message key="procurement.seller_name"/></th>
					<td width="75%">
						<span id="sellerSellerName"></span>						
					</td>							
				</tr>
				<tr>
					<th class="left" width="25%"><fmt:message key="procurement.activity_name"/></th>
					<td width="75%">
						<span id="sellerActivityName"></span>						
					</td>							
				</tr>					
				<tr>
					<th class="left" colspan ="2"><fmt:message key="procurement.seller_performance.seller_info"/>&nbsp;</th>
				</tr>
				<tr>
					<td colspan ="2">
						<textarea name="<%=Activityseller.SELLERPERFORMANCEINFO %>" id="<%=Activityseller.SELLERPERFORMANCEINFO %>" class="campo" style="width:98%;" ></textarea>						
					</td>
				</tr>
			</table>			
    	</fieldset>
    	<div class="popButtons">
    		<c:if test="${tl:hasPermission(user,project.status,tab)}">
				<a href="javascript:saveSeller();" class="boton"><fmt:message key="save" /></a>
			</c:if>
			<a href="javascript:closeSeller();" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
