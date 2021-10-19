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
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.servlets.MaintenanceServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<%-- Message --%>
<fmt:message key="maintenance.contact.new" var="new_contact_title" />
<fmt:message key="maintenance.contact.edit" var="edit_contact_title" />

<%-- Message for Confirmations --%>
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_contact">
	<fmt:param><fmt:message key="maintenance.contact"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_contact">
	<fmt:param><fmt:message key="maintenance.contact"/></fmt:param>
</fmt:message>
<fmt:message key="msg.confirm_reset_password" var="msg_confirm_reset_password"/>
<fmt:message key="msg.confirm_title_reset_password" var="msg_title_confirm_reset_password"/>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtFullNameRequired">
	<fmt:param><b><fmt:message key="maintenance.contact.full_name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtJobTitleRequired">
	<fmt:param><b><fmt:message key="maintenance.contact.job_title"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtFileAsRequired">
	<fmt:param><b><fmt:message key="maintenance.contact.file_as"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtBusinessAddressRequired">
	<fmt:param><b><fmt:message key="maintenance.contact.business_address"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtEmailRequired">
	<fmt:param><b><fmt:message key="maintenance.contact.email"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtUserNameRequired">
	<fmt:param><b><fmt:message key="maintenance.contact.username"/></b></fmt:param>
</fmt:message>

<script language="javascript" type="text/javascript" >

var contactsTable;
var contactValidator;

function addContact() {
	$('#login_name').attr('disabled','');
	$('#reset_password').hide();
	var f = document.frm_contact_pop;
	f.reset();
	f.id.value = "";
	$(f.contact_notes).text('');
	
	$('#contacts-popup legend').html('${new_contact_title}');
	$('#contacts-popup').dialog('open');
}

function saveContact() {
	var f = document.frm_contact_pop;
	
	if (contactValidator.form()) {
		
		var params = {
			accion: "<%=MaintenanceServlet.JX_SAVE_CONTACT %>",
			id: f.contact_id.value,
			full_name : f.contact_full_name.value,
			job_title : f.contact_job_title.value,
			file_as : f.contact_file_as.value,
			business_phone: f.contact_business_phone.value,
			mobile_phone : f.contact_mobile_phone.value,
			business_address : f.contact_business_address.value,
			email : f.contact_email.value,
			notes : f.contact_notes.value,
			login: f.login.value
		};
		
		mainAjax.call(params, function (data) {
			var dataRow = [
				data.id,
				escape(data.full_name),
				escape(data.job_title),
				escape(data.file_as),
				escape(data.business_phone),
				escape(data.mobile_phone),
				escape(data.business_address),
				escape(data.email),
				escape(data.notes),
				'<img onclick="editContact(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'+
				'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
				'<img onclick="deleteContact(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">',
			];
			
			if (f.id.value == data.id) { contactsTable.fnUpdateAndSelect(dataRow); }
			else { contactsTable.fnAddDataAndSelect(dataRow); }
			
			f.reset();
			$('#contacts-popup').dialog('close');
		});	
	}	
}

function editContact(element) {
	<% if (!SecurityUtil.isUserInRole(request, Constants.ROLE_PMO)) {%>
	$('#login_name').attr('disabled','disabled');
	<%}%>
	$('#reset_password').show();
	
	var contact = contactsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.forms["frm_contact_pop"];
	f.contact_id.value 					= contact[0];
	f.contact_full_name.value 			= unEscape(contact[1]);
	f.contact_job_title.value 			= unEscape(contact[2]);
	f.contact_file_as.value 			= unEscape(contact[3]);
	f.contact_business_phone.value 		= unEscape(contact[4]);
	f.contact_mobile_phone.value 		= unEscape(contact[5]);
	f.contact_business_address.value 	= unEscape(contact[6]);
	f.contact_email.value 				= unEscape(contact[7]);
	$('#contact_notes').text(unEscape(contact[8]));
	f.login.value 						= "";
	
	var params={
		accion: "<%=MaintenanceServlet.JX_GET_USERNAME %>",
		idContact: f.contact_id.value	
	};
	
	mainAjax.call(params, function (data) {
		f.login.value = data.login;
	});
	
	$('#contacts-popup legend').html('${edit_contact_title}');
	$('#contacts-popup').dialog('open');
}

function deleteContact(element) {
	
	confirmUI(
		'${msg_title_confirm_delete_contact}','${msg_confirm_delete_contact}',
		'<fmt:message key="yes"/>', '<fmt:message key="no"/>',
		function() {
			
			var contact = contactsTable.fnGetData( element.parentNode.parentNode );
			
			var f = document.frm_contacts;

			f.accion.value = "<%=MaintenanceServlet.DEL_CONTACT %>";
			f.id.value = contact[0];
			f.idManten.value = $('select#idManten').val();
			
			loadingPopup();
			f.submit();
	});
}

function resetPassword() {
	
	confirmUI(
		'${msg_title_confirm_reset_password}','${msg_confirm_reset_password}',
		'<fmt:message key="yes"/>', '<fmt:message key="no"/>',
		function() {
			
			var f = document.frm_contact_pop;
			
			var params={
				accion: "<%=MaintenanceServlet.JX_RESET_PASSWORD %>",
				idContact: f.contact_id.value	
			};
			
			mainAjax.call(params, function (data) {
				$('#contacts-popup').dialog('close');
			});
	});
}

readyMethods.add(function () {

	contactsTable = $('#tb_contacts').dataTable({
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"iDisplayLength": 50,
		"aaSorting": [[ 0, "asc" ]],
		"bAutoWidth": false,
		"aoColumns": [ 
			{ "bVisible" : false },
            { "sClass": "left" },
            { "sClass": "left" },
            { "bVisible": false },
			{ "sClass": "right" },
            { "sClass": "right" },
            { "bVisible": false },
            { "sClass": "center" },
            { "bVisible": false },
            { "sClass": "center", "bSortable" : false }
   		]	
	});

	$('#tb_contacts tbody tr').live('click',  function (event) {
		fnSetSelectable(contactsTable, this);
	} );

	$('div#contacts-popup').dialog({
		autoOpen: false,
		modal: true,
		width: 950,
		resizable: false,
		open: function(event, ui) { contactValidator.resetForm(); }
	});

	contactValidator = $("#frm_contact_pop").validate({
		errorContainer: 'div#contact-errors',
		errorLabelContainer: 'div#contact-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#contact-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			full_name: { required: true },
		    job_title: { required: true },
			file_as: { required: true },
			business_address: { required: true },
			email: { required: true, email: true },
			login: { required: true },
			contact_notes: { maxlength: 200 }
		},
		messages: {
			full_name: { required: '${fmtFullNameRequired}' },
		    job_title: { required: '${fmtJobTitleRequired}' },
			file_as: { required: '${fmtFileAsRequired}' },
			business_address: { required: '${fmtBusinessAddressRequired}' },
			email: { required: '${fmtEmailRequired}', email: '<fmt:message key="maintenance.error_email"/>' },
			login: { required: '${fmtUserNameRequired}' }
		}
	});
});
</script>

<form id="frm_contacts" name="frm_contacts" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="idManten" value="" />
	<input type="hidden" id="id" name="id" />

	<fieldset>
		<legend><fmt:message key="maintenance.contact" /></legend>
		<table id="tb_contacts" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
				 <th width="0%">&nbsp;</th>
				 <th width="20%"><fmt:message key="maintenance.contact.full_name" /></th>
				 <th width="25%"><fmt:message key="maintenance.contact.job_title" /></th>
				 <th width="0%"><fmt:message key="maintenance.contact.file_as" /></th>
				 <th width="12%"><fmt:message key="maintenance.contact.business_phone" /></th>
				 <th width="10%"><fmt:message key="maintenance.contact.mobile_phone" /></th>
				 <th width="0%"><fmt:message key="maintenance.contact.business_address" /></th>
				 <th width="25%"><fmt:message key="maintenance.contact.email" /></th>
				 <th width="0%"><fmt:message key="maintenance.contact.notes" /></th>
				 <th width="8%">
				 	<img onclick="addContact()" title="<fmt:message key="new"/>" class="link" src="images/add.png">
				 </th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="contact" items="${list}">
					<tr>
						<td>${contact.idContact}</td>
						<td>${tl:escape(contact.fullName)}</td>
						<td>${tl:escape(contact.jobTitle)}</td>
						<td>${tl:escape(contact.fileAs)}</td>
						<td>${tl:escape(contact.businessPhone)}</td>
						<td>${tl:escape(contact.mobilePhone)}</td>
						<td>${tl:escape(contact.businessAddress)}</td>
						<td>${tl:escape(contact.email)}</td>
						<td>${tl:escape(contact.notes)}</td>
						<td>
							<img onclick="editContact(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
							&nbsp;&nbsp;&nbsp;
							<img onclick="deleteContact(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</form>


<div id="contacts-popup">
	<div id="contact-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="contact-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_contact_pop" id="frm_contact_pop">
		<input type="hidden" name="id" id="contact_id"/>
		<fieldset>
			<legend><fmt:message key="maintenance.contact.new"/></legend>
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					 <th><fmt:message key="maintenance.contact.full_name" />&nbsp;*</th>
					 <th><fmt:message key="maintenance.contact.file_as" />&nbsp;*</th>
					 <th><fmt:message key="maintenance.contact.job_title" />&nbsp;*</th>
				</tr>
				<tr>
					<td><input type="text" name="full_name" id="contact_full_name" class="campo" maxlength="50"/></td>
					<td><input type="text" name="file_as" id="contact_file_as" class="campo" maxlength="60"/></td>
					<td><input type="text" name="job_title" id="contact_job_title" class="campo" maxlength="50"/></td>
				</tr>
				<tr>
					 <th colspan="2"><fmt:message key="maintenance.contact.business_address" />&nbsp;*</th>
					 <th><fmt:message key="maintenance.contact.business_phone" /></th>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" name="business_address" id="contact_business_address" class="campo" maxlength="200"/>
					</td>
					<td>
						<input type="text" name="business_phone" id="contact_business_phone" class="campo" maxlength="12"/>
					</td>
				</tr>
				<tr>
					 <th><fmt:message key="maintenance.contact.username" />&nbsp;*</th>
					 <th><fmt:message key="maintenance.contact.mobile_phone" /></th>
					 <th><fmt:message key="maintenance.contact.email" />&nbsp;*</th>
				</tr>
				<tr>
					<td><input type="text" class="campo" name="login" id="login_name" maxlength="20"/></td>
					<td>
						<input type="text" name="mobile_phone" id="contact_mobile_phone" class="campo" maxlength="12"/>
					</td>
					<td>
						<input type="text" name="email" id="contact_email" class="campo" maxlength="50"/>
					</td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
				<tr>
					 <th colspan="3"><fmt:message key="maintenance.contact.notes" /></th>
				</tr>			
				<tr>
					<td colspan="3">
						<textarea name="notes" id="contact_notes" name="contact_notes" class="campo" style="width:98%;"></textarea>
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
 			<a href="javascript:resetPassword();" class="boton" id="reset_password"><fmt:message key="maintenance.employee.reset_password" /></a>   		
    		<input type="submit" class="boton" onclick="saveContact(); return false;" value="<fmt:message key="save" />" />
    	</div>
    </form>
</div>
