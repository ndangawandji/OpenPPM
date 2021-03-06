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

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<script type="text/javascript">
<!--
function showRejectReason(reason,alternatives) {
	$('td#rejectReasonPop').html(reason);
	$('td#alternativesPop').html(alternatives);
	$('div#rejectReason-popup').dialog('open');
}

function closeReject() {
	$('div#rejectReason-popup').dialog('close');
}

readyMethods.add(function() {
	$('div#rejectReason-popup').dialog({ autoOpen: false, modal: true, width: 600, minWidth: 750, resizable: false });

});
//-->
</script>

<div id="rejectReason-popup" class="popup">

	<fieldset>
		<legend><fmt:message key="reject_reason"/></legend>
	
		<table border="0" cellpadding="2" cellspacing="1" width="100%">
			<tr>
				<th><fmt:message key="motives" /></th>
				<td>&nbsp;</td>
				<th><fmt:message key="alternatives" /></th>
			</tr>
			<tr>
				<td id="rejectReasonPop" style="text-align: justify;"></td>
				<td>&nbsp;</td>
				<td id="alternativesPop" style="text-align: justify;"></td>
			</tr>
   		</table>
   	</fieldset>
   	<div class="popButtons">
   		<a href="javascript:closeReject();" class="boton"><fmt:message key="close" /></a>
   	</div>
</div>
