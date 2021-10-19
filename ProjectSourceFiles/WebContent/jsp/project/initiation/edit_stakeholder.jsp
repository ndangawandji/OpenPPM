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
<%@page import="es.sm2.openppm.servlets.ProjectInitServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:message key="update" var="msg_update" />
<fmt:message key="add" var="msg_add" />
<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message var="fmt_internal" key="stakeholder.internal"/>
<fmt:message var="fmt_external" key="stakeholder.external"/>
<fmt:message var="fmt_supporter" key="stakeholder.supporter"/>
<fmt:message var="fmt_neutral" key="stakeholder.neutral"/>
<fmt:message var="fmt_opponent" key="stakeholder.opponent"/>

<fmt:message key="msg.confirm_delete" var="msg_delete_stakeholder">
	<fmt:param><fmt:message key="stakeholder"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_delete_stakeholder">
	<fmt:param><fmt:message key="stakeholder"/></fmt:param>
</fmt:message>

<c:set var="stk_internal"><%=Constants.CLASS_STAKEHOLDER_INTERNAL%></c:set>
<c:set var="stk_external"><%=Constants.CLASS_STAKEHOLDER_EXTERNAL%></c:set>
<c:set var="stk_supporter"><%=Constants.TYPE_STAKEHOLDER_SUPPORTER%></c:set>
<c:set var="stk_neutral"><%=Constants.TYPE_STAKEHOLDER_NEUTRAL%></c:set>
<c:set var="stk_opponent"><%=Constants.TYPE_STAKEHOLDER_OPPONENT%></c:set>
<c:if test="${project.status ne status_closed}">
	<c:set var="stakeholderEditButtons"><img onclick="deleteStakeholder(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg"></c:set>
</c:if>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtContactRequired">
	<fmt:param><b><fmt:message key="stakeholder.name_contact"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtRolRequired">
	<fmt:param><b><fmt:message key="stakeholder.rol"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtClassificationRequired">
	<fmt:param><b><fmt:message key="stakeholder.classification"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtTypeRequired">
	<fmt:param><b><fmt:message key="stakeholder.type"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var stk_validator;

function viewStakeholder(element) {
	
	//stk_validator.resetForm();
	var stakeholder = stakeholdersTable.fnGetData( element.parentNode.parentNode );

	var f = document.forms["frm_stakeholder"];

	// Recover stakeholder info
	f.stk_id.value				= stakeholder[0];	
	$("#stk_businessneed").text(unEscape(stakeholder[1]));
	$("#stk_expectations").text(unEscape(stakeholder[2]));
	f.stk_influence.value 		= unEscape(stakeholder[3]);
	f.stk_mgtstrategy.value 	= unEscape(stakeholder[4]);
	f.stk_contact_name.value	= unEscape(stakeholder[5]);
	f.stk_rol.value 			= unEscape(stakeholder[6]);
	f.stk_classification.value 	= stakeholder[9];
	f.stk_type.value			= stakeholder[10];
	f.stk_department.value		= unEscape(stakeholder[11]);
	f.stk_order.value			= stakeholder[13];
	
	$('#btn_saveStakeholder').button("option", "label", '${msg_update}');
	
	$('#stakeholder-popup').dialog('open');
}

function deleteStakeholderConfirmated() {
		
	var f = document.frm_stakeholder;
	
	f.accion.value = "<%=ProjectInitServlet.DELETE_STAKEHOLDER%>";
	f.stk_id.value = $('#stk_id').val();
	
	loadingPopup();
	f.submit();

}

function deleteStakeholder(element) {
	
	var stakeholder = stakeholdersTable.fnGetData( element.parentNode.parentNode );
	
	$('#stk_id').val(stakeholder[0]);
	
	$('#dialog-confirm-msg').html('${msg_delete_stakeholder}');
	$('#dialog-confirm').dialog(
			'option', 
			'buttons', 
			{
				"${msg_yes}": deleteStakeholderConfirmated,
				"${msg_no}": function() { 
					$('#dialog-confirm').dialog("close"); 
				}
			}
	);
	
	$('#dialog-confirm').dialog(
			'option',
			'title',
			'${msg_title_delete_stakeholder}'
	);
	$('#dialog-confirm').dialog('open');
}

function resetStakeholder() {
	var f = document.forms["frm_stakeholder"];
	f.stk_id.value = '';
	f.stk_order.value = '';
	$("#stk_businessneed").text('');
	$("#stk_expectations").text('');
	f.reset();
}

function newStakeholder() {
	stk_validator.resetForm();
	resetStakeholder();
	
	$('#btn_saveStakeholder').button("option", "label", '${msg_add}');
	$('#stakeholder-popup').dialog('open');
}

function stkClassificationName(value) {
	var classification = '';
	if (value == "${stk_internal}") {
		classification = "${fmt_internal}";
	}
	else if (value == "${stk_external}") {
		classification = "${fmt_external}";
	}
	return classification;
}

function stkTypeName(value) {
	var type = '';
	if (value == "${stk_supporter}") {
		type = "${fmt_supporter}";
	}
	else if (value == "${stk_neutral}") {
		type = "${fmt_neutral}";
	}
	else if (value == "${stk_opponent}") {
		type = "${fmt_opponent}";
	}
	return type;
}

function saveStakeholder() {
	if (stk_validator.form()) {
		var f = document.forms["frm_stakeholder"];						
		f.accion.value = "<%=ProjectInitServlet.SAVE_STAKEHOLDER%>"; 
		f.project_id.value = document.forms["frm_project"].id.value;
		
		loadingPopup();
		f.submit();
	} 
}

function closeStakeholderDetail() {
	stk_validator.resetForm();
	resetStakeholder();
	$('#stakeholder-popup').dialog('close');
}
readyMethods.add(function() {
	
	//Validate required fields
	stk_validator = $("#frm_stakeholder").validate({
		errorContainer: 'div#stakeholder-errors',
		errorLabelContainer: 'div#stakeholder-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#stakeholder_numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			stk_contact_name: "required",
			stk_rol: "required", 
			stk_classification: "required",
			stk_type: "required",
			stk_businessneed: { maxlength: 200 },
			stk_expectations: { maxlength: 200 }
		},
		messages: {
			stk_contact_name: {required :"${fmtContactRequired}"},
			stk_rol: {required :"${fmtRolRequired}"}, 
			stk_classification: {required :"${fmtClassificationRequired}"},
			stk_type: {required :"${fmtTypeRequired}"}
		}
	});
	
	$('#stakeholder-popup').dialog({ 
		autoOpen: false, 
		modal: true, 
		width: 800, 
		resizable: false,
		open: function(event, ui) { stk_validator.resetForm(); $('#stk_contact_name').focus(); }
	});
});
//-->
</script>

<div id="stakeholder-popup" class="popup">
	<div id="stakeholder-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="stakeholder_numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	<form name="frm_stakeholder" id="frm_stakeholder" method="POST" >
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="stk_id" id="stk_id" />
		<input type="hidden" name="stk_order" id="stk_order" />
		<input type="hidden" name="project_id" id="project_id" value="${project.idProject}" />

		<fieldset>
			<legend><fmt:message key="detail_stakeholder"/></legend>
			<table width="100%">
				<tr>
					<th class="left" width="27%">
						<fmt:message key="contact" />&nbsp;*
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
<!-- 
							<a class="button_img_right" style="*margin-top: -15px !important;" href="javascript: searchContactPop('stk_contact',$('#stk_contact_name').val());">
								<span class="normal"><fmt:message key="search"/></span>
								<img style="width:16px;" src="images/search.png"/>
							</a>
 -->
							<img class="position_right icono"  title="<fmt:message key="search"/>" src="images/search.png" onclick="searchContactPop('stk_contact',$('#stk_contact_name').val());" />
						</c:if>
					</th>
					<th class="left" width="23%"><fmt:message key="stakeholder.rol" />&nbsp;*</th>
					<th class="left" width="25%"><fmt:message key="stakeholder.classification" />&nbsp;*</th>
					<th class="left" width="25%"><fmt:message key="stakeholder.type" />&nbsp;*</th>
				</tr>
				<tr>
					<td>						
						<input type="text" id="stk_contact_name" class="campo" name="stk_contact_name" value="" />
					</td>
					<td><input type="text" name="stk_rol" class="campo" maxlength="50" /></td>
					<td>
						<select name="stk_classification" id="stk_classification" class="campo">
							<option value=""><fmt:message key="select_opt"/></option>
							<option value="<%= Constants.CLASS_STAKEHOLDER_INTERNAL %>"><fmt:message key="stakeholder.internal"/></option>
							<option value="<%= Constants.CLASS_STAKEHOLDER_EXTERNAL %>"><fmt:message key="stakeholder.external"/></option>
						</select>
					</td>
					<td>
						<select name="stk_type" id="stk_type" class="campo">
							<option value=""><fmt:message key="select_opt"/></option>
							<option value="<%= Constants.TYPE_STAKEHOLDER_SUPPORTER %>"><fmt:message key="stakeholder.supporter"/></option>
							<option value="<%= Constants.TYPE_STAKEHOLDER_NEUTRAL %>"><fmt:message key="stakeholder.neutral"/></option>
							<option value="<%= Constants.TYPE_STAKEHOLDER_OPPONENT %>"><fmt:message key="stakeholder.opponent"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="left" colspan="2"><fmt:message key="stakeholder.business_need" /></th>
					<th class="left" colspan="2"><fmt:message key="stakeholder.expectations" /></th>
				</tr>
				<tr>
					<td colspan="2">
						<textarea name="stk_businessneed" id="stk_businessneed" class="campo show_scroll" style="width:90%;"></textarea>
					</td>
					<td colspan="2">
						<textarea name="stk_expectations" id="stk_expectations" class="campo show_scroll" style="width:90%;"></textarea>
					</td>
				</tr>
				<tr>
					<th class="left" colspan="2"><fmt:message key="stakeholder.influence" /></th>
					<th class="left" colspan="2"><fmt:message key="stakeholder.management_strategy" /></th>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" name="stk_influence" class="campo" maxlength="50" />
					</td>
					<td colspan="2">
						<input type="text" name="stk_mgtstrategy" class="campo" maxlength="50" />
					</td>
				</tr>
				<tr>
					<th class="left" colspan="2"><fmt:message key="stakeholder.department" /></th>
					<th class="left" colspan="2"></th>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" name="stk_department" class="campo" maxlength="150" />
					</td>
					<td colspan="2"></td>
				</tr>
			</table>			
		</fieldset>
		<div class="popButtons">
			<c:if test="${tl:hasPermission(user,project.status,tab)}">
				<input type="submit" class="boton" id="btn_saveStakeholder" onclick="saveStakeholder(); return false;" value="<fmt:message key="add" />" />
			</c:if>
			<a href="javascript:closeStakeholderDetail();" class="boton" id="btn_closeStakeholder"><fmt:message key="close" /></a>
		</div>
	</form>
</div>
