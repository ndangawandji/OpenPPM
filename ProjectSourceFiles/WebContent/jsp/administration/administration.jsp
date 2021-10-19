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
<%@page import="es.sm2.openppm.model.Setting"%>
<%@page import="es.sm2.openppm.common.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.servlets.AdministrationServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="visible"><%=Settings.SETTING_STATUS_VISIBLE %></c:set>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtValueRequired">
	<fmt:param><b><fmt:message key="setting.value"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
var adminAjax = new AjaxCall('<%=AdministrationServlet.REFERENCE%>','<fmt:message key="error"/>');
var settingsTable;
var validatorSetting;

function viewSetting(element) {
	
	var setting = settingsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.frm_setting;
	f.reset();
	f.<%=Setting.IDSETTING%>.value = setting[0];
	f.<%=Setting.NAME%>.value = setting[1];
	f.<%=Setting.VALUE%>.value = setting[2];
	f.<%=Setting.INFORMATION%>.value = setting[4];
	
	$('#settingPopup').dialog('open');
}

function closeSetting() { $('#settingPopup').dialog('close'); }

readyMethods.add(function() {

	settingsTable = $('#tb_settings').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 50,
		"aoColumns": [
              { "bVisible": false },
              { "sClass": "left", "sWidth": "45%" },
              { "sClass": "left", "sWidth": "45%"},
              { "sClass": "center", "sWidth": "10%", "bSortable": false },
              { "bVisible": false }
     	]
	});
	
	$('#tb_settings tbody tr').live('click', function (event) {
		settingsTable.fnSetSelectable(this,'selected_internal');
	});
	
	$('#settingPopup').dialog({
		autoOpen: false, modal: true,
		width: 400, resizable: false,
		open: function() {
			$('#<%=Setting.VALUE %>').focus();
		}
	});
	
	validatorSetting = $("#frm_setting").validate({
		errorContainer: 'div#setting-errors',
		errorLabelContainer: 'div#setting-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#setting-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Setting.VALUE %>: { required: true }
		},
		messages: {
			<%=Setting.VALUE %>: { required: '${fmtValueRequired}' }
		}
	});	
	
	$('#frm_setting').submit(function() {
		
		if (validatorSetting.form()) {
			
			adminAjax.call($('#frm_setting').serialize(),function(data) {
				
				var setting = settingsTable.fnGetSelectedData();
				setting[2] = document.frm_setting.<%=Setting.VALUE %>.value;
				settingsTable.fnUpdateRow(setting);
				
				closeSetting();
			});
		}
		return false;
	});
});

//-->
</script>

<form name="frm_administration" id="frm_administration" action="<%=AdministrationServlet.REFERENCE%>" method="post">
	<input type="hidden" name="accion" value="" />
	
	<fieldset>
		<%-- LIST SETTINGS FOR VIEW OR CONFIGURE --%>
		<table id="tb_settings" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th><fmt:message key="setting.name"/></th>
					<th><fmt:message key="setting.value"/></th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="setting" items="${settings }">
					<tr>
						<td>${setting.idSetting }</td>
						<td><fmt:message key="${setting.name }"/></td>
						<td>${setting.value }</td>
						<td>
							<c:if test="${setting.status eq visible}">
								<img onclick="viewSetting(this);" title="<fmt:message key="view"/>" class="link" src="images/view.png">
							</c:if>
						</td>
						<td>${setting.information }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</form>

<div id="settingPopup" class="popup">

	<div id="setting-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="setting-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	
	<form name="frm_setting" id="frm_setting" action="<%=AdministrationServlet.REFERENCE%>" method="post">
		<input type="hidden" name="accion" value="<%=AdministrationServlet.SAVE_SETTING%>">
		<input type="hidden" name="<%=Setting.IDSETTING %>" value="">
		
		<fieldset>
			<legend><fmt:message key="setting"/></legend>
			<table width="100%" cellspacing="1">
				<tr>
					<th width="15%"><fmt:message key="setting.name"/>:</th>
					<td><input type="text" name="<%=Setting.NAME %>" readonly/>
				</tr>
				<tr>
					<th><fmt:message key="setting.value"/>&nbsp;*:</th>
					<td><input type="text" name="<%=Setting.VALUE %>" id="<%=Setting.VALUE %>" class="campo" maxlength="100"/>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<th><fmt:message key="setting.tips"/>:</th>
					<td><input type="text" name="<%=Setting.INFORMATION %>" readonly/>
				</tr>
			</table>
		</fieldset>
		<div class="popButtons">
			<input type="submit" class="boton" value="<fmt:message key="save" />" />
			<a href="javascript:closeSetting();" class="boton"><fmt:message key="close" /></a>
		</div>
	</form>
</div>
