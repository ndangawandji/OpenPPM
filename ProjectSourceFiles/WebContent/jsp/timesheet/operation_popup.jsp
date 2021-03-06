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
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message var="msg_milestone_sign" key="milestone.report_type.milestone_sign" />
<fmt:message var="msg_no_report" key="milestone.report_type.no_report" />
<fmt:message key="error" var="fmt_error" />
<fmt:message key="msg.error.operation_exists_in_timesheet" var="fmt_operation_exists_in_timesheet" />

<%-- 
Request Attributes:
	operations:		Operation projects
--%>

<script type="text/javascript">
<!--

function addNewOperation() { $('div#operations-popup').dialog('open'); }

function addOperation() {
	
	var f = document.frm_timesheet;
	f.accion.value = '<%=TimeSheetServlet.ADD_OPERATION%>';
	f.idOperation.value = $("#idOperation").val();
	loadingPopup();
	f.submit();
}

readyMethods.add(function() {
	$('div#operations-popup').dialog({ autoOpen: false, modal: true, width: 400, resizable: false });

});
//-->
</script>

<div id="operations-popup" class="popup">
	<fieldset>
		<legend><fmt:message key="new_operation_timesheet"/></legend>
	
		<div style="margin: 10px;">
			<select id="idOperation" class="campo">
				<c:forEach var="operation" items="${operations}">
					<option value="${operation.idOperation}">${tl:escape(operation.operationName)}</option>
				</c:forEach>
			</select>
   		</div>
   	</fieldset>
   	<div class="popButtons">
		<a href="javascript:addOperation();" class="boton"><fmt:message key="add" /></a>
   	</div>
</div>
