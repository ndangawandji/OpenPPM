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
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<fmt:message key="maintenance.procurement.new_sow" var="new_sow_title" />
<fmt:message key="maintenance.procurement.edit_sow" var="edit_sow_title" />

<fmt:message key="maintenance.error_msg_select_a" var="fmtSellerRequired">
	<fmt:param><b><fmt:message key="procurement.seller_name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_select_a" var="fmtActivityRequired">
	<fmt:param><b><fmt:message key="procurement.activity_name"/></b></fmt:param>
</fmt:message>

<c:set var="select_option"><fmt:message key="select_opt" /></c:set>

<script language="javascript" type="text/javascript" >
<!--
var sowValidator;
var newOption;

function addSow() {
	var f = document.forms["frm_sow_popup"];
	f.reset();
	f.idSow.value = "";
	$("#<%=Activityseller.STATEMENTOFWORK %>").text("");	
	f.<%=Activityseller.PROCUREMENTDOCUMENTS %>.value 	= "";	
	$("#a_linkIni").text("");
	
	$('#<%=Activityseller.PROJECTACTIVITY %>').find("option").remove();
	newOption = "<option value=''>${select_option}</option>";
	$('#<%=Activityseller.PROJECTACTIVITY %>').append(newOption);
	
	$('#sow_popup legend').html('${new_sow_title}');
	$('#sow_popup').dialog('open');
}

function saveSow() {
	if (sowValidator.form()) {		
		var f = document.forms["frm_sow_popup"];		
		f.action = "<%=ProjectProcurementServlet.REFERENCE%>";
		f.accion.value = "<%=ProjectProcurementServlet.SAVE_SOW %>";
		loadingPopup();
		f.submit();
	}
}

function editSow(element) {	
	var sow = sowTable.fnGetData( element.parentNode.parentNode );
	var f = document.forms["frm_sow_popup"];
	f.idSow.value 										= sow[0];
	f.<%=Activityseller.SELLER %>.value 				= sow[1];
	$("#<%=Activityseller.STATEMENTOFWORK %>").text(unEscape(sow[3]));		
	f.<%=Activityseller.PROCUREMENTDOCUMENTS %>.value 	= unEscape(sow[6]);
	$("#a_linkIni").attr("href", unEscape(sow[6]));
	$("#a_linkIni").text(unEscape(sow[6]));

	newOption = "<option value='" + sow[4] + "' selected>" + unEscape(sow[5]) + "</option>";
	loadActivities(newOption);
	
	$('div#sow_popup legend').html('${edit_sow_title}');	
	$('div#sow_popup').dialog('open');
}

function loadActivities(option){
	var f = document.forms["frm_sow_popup"];
	var seller = f.<%=Activityseller.SELLER %>.options[f.<%=Activityseller.SELLER %>.selectedIndex].value;
	if (seller != "-1") {
		
		var params = {
			accion: "<%=ProjectProcurementServlet.JX_CONS_SELLER_ACTIVITIES %>",
			idProject: f.id.value,
			idSeller: seller
		};
		
		procurementAjax.call(params, function(data) {
			$('#<%=Activityseller.PROJECTACTIVITY %>').find("option").remove();
			newOption = "<option value=''>${select_option}</option>";
			$('#<%=Activityseller.PROJECTACTIVITY %>').append(newOption);
			if(option != "") {
				$('#<%=Activityseller.PROJECTACTIVITY %>').append(option);	
			}					
			for(var i = 0; i < data.length; i++) {
				newOption = "<option value='" + data[i][0] + "'>" + data[i][1] + "</option>";
				$('#<%=Activityseller.PROJECTACTIVITY %>').append(newOption);
			}
		});
	}	
}

function confirmIniLink() {
	$('#toggleEditLinkIni').hide();
	$('#toggleALinkIni').show();
	
	$('#a_linkIni')
		.text($('#<%=Activityseller.PROCUREMENTDOCUMENTS %>')
		.val()).attr('href',$('#<%=Activityseller.PROCUREMENTDOCUMENTS %>').val());
}
function modifyIniLink() {

	$('#toggleALinkIni').hide();
	$('#toggleEditLinkIni').show();
}

function closeSow() {
	$('div#sow_popup').dialog('close');
}
//When document is ready
readyMethods.add(function() {
	
	$('div#sow_popup').dialog({ 
		autoOpen: false, 
		modal: true, 
		width: 550, 
		minWidth: 300, 
		resizable: false,
		open: function(event, ui) { sowValidator.resetForm(); }
	});
	
	// validate the form when it is submitted
	sowValidator = $("#frm_sow_popup").validate({
		errorContainer: 'div#sow-errors',
		errorLabelContainer: 'div#sow-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Activityseller.SELLER %> : {required: true },
			<%=Activityseller.PROJECTACTIVITY %> : {required: true },
			<%=Activityseller.STATEMENTOFWORK %>: { maxlength: 200 }
		},
		messages: {
			<%=Activityseller.SELLER %> : {required: '${fmtSellerRequired}' },
			<%=Activityseller.PROJECTACTIVITY%> : {required: '${fmtActivityRequired}' }
		}
	});
});
//-->
</script>

<div id="sow_popup" class="popup">

	<div id="sow-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_sow_popup" id="frm_sow_popup" method="post">	
		<input type="hidden" name="id" value="${project.idProject}" /> <!-- idProject -->
		<input type="hidden" name="idSow" />		
		<input type="hidden" name="accion" value="" />
		<fieldset>
			<legend></legend>
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="25%"><fmt:message key="procurement.seller_name"/>&nbsp;*</th>
					<td width="75%">
						<select name="<%=Activityseller.SELLER %>" id="<%=Activityseller.SELLER %>" class="campo" onchange="loadActivities('');">
							<option value=""><fmt:message key="select_opt" /></option>
							<c:forEach var="seller" items="${sellers}">
								<option value="${seller.idSeller}">${seller.name}</option>
							</c:forEach>
						</select>							
					</td>					
				</tr>
				<tr>
					<th class="left"><fmt:message key="procurement.activity_name"/>&nbsp;*</th>
					<td>
						<select name="<%=Activityseller.PROJECTACTIVITY %>" id="<%=Activityseller.PROJECTACTIVITY %>" class="campo">							
						</select>
					</td>
				</tr>
				<tr>
					<th class="left" colspan ="2"><fmt:message key="procurement.sow_selection.sow"/>&nbsp;</th>
				</tr>
				<tr>
					<td colspan ="2">
						<textarea name="<%=Activityseller.STATEMENTOFWORK %>" id="<%=Activityseller.STATEMENTOFWORK %>" class="campo" style="width:98%;" ></textarea>						
					</td>
				</tr>
				<tr>
					<th class="left" colspan ="2"><fmt:message key="procurement.sow_selection.procurement_docs"/>&nbsp;</th>
				</tr>
				<tr>
					<td colspan="2">
						<c:choose>
							<c:when test="${project.linkDoc == null or empty project.linkDoc}">
								<c:set var="linkDocument">style="display:none;"</c:set>
							</c:when>
							<c:otherwise>
								<c:set var="inputDocument">style="display:none;"</c:set>
							</c:otherwise>
						</c:choose>
						<div ${inputDocument } id="toggleEditLinkIni">
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img style="width:16px;" src="images/approve.png" onclick="confirmIniLink()"/>
							</c:if>
							<input type="text" name="<%=Activityseller.PROCUREMENTDOCUMENTS %>" id="<%=Activityseller.PROCUREMENTDOCUMENTS %>" style="width: 375px;" maxlength="200" class="campo" value="" />
						</div>
						<div ${linkDocument} id="toggleALinkIni">
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img style="width:16px;" src="images/modify.png" onclick="modifyIniLink()"/>
							</c:if>
							<a href="" id="a_linkIni"></a>
						</div>
					</td>
				</tr>
			</table>			
    	</fieldset>
    	<div class="popButtons">
    		<c:if test="${tl:hasPermission(user,project.status,tab)}">
    			<input type="submit" class="boton" onclick="saveSow(); return false;" value="<fmt:message key="save" />" />
			</c:if>
			<a href="javascript:closeSow();" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
