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
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>
<fmt:setBundle basename="es.sm2.openppm.common.openppm"/>

<fmt:message key="error" var="fmt_error" />
<c:if test="${project.status ne status_closed}">
	<c:set var="editFollowup"><img onclick="return editFollowup(this);" class="link" src="images/view.png" title="<fmt:message key="view"/>"/></c:set>
</c:if>

<script type="text/javascript">
<!--
function saveFollowup() {

	loadingPopup();
	document.forms["frm_followup"].submit();
}

function updatePoc() {
	var f = document.forms["frm_followup"];

	var ev = f.ev.value;
	var bac = toNumber(f.bac.value);
	
	if (ev >= 0 && bac > 0) {
		f.poc.value = formatInteger((ev*100/bac));
	}
}
function calculateFollowupEv() {
	var f = document.forms["frm_followup"];

	var poc = toNumber(f.poc.value);
	var bac = toNumber(f.bac.value);

	if (poc >= 0 && bac >=0) {
		f.ev.value = toCurrency((poc * bac / 100));
	} 
}

readyMethods.add(function() {

	$('div#followup-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 500, 
		resizable: false
	});
});
//-->
</script>

<div id="followup-popup" class="popup">

	<form name="frm_followup" id="frm_followup" action="<%=ProjectControlServlet.REFERENCE%>" method="post">
		<input type="hidden" name="accion" value="<%=ProjectControlServlet.UPDATE_FOLLOWUP%>"/>
		<input type="hidden" name="id" value="${project.idProject }"/>
		<input type="hidden" name="followup_id"/>
		
		<fieldset>
			<legend><fmt:message key="followup.earner_management.item"/></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="40%"><fmt:message key="project.bac"/>&nbsp;</th>
					<th class="left" width="17%"><fmt:message key="followup.ac"/>&nbsp;*</th>
					<th class="left" width="18%"><fmt:message key="followup.status_date"/></th>
					<th class="left" width="30%"><fmt:message key="activity.ac.time_sheet"/></th>
				</tr>
				<tr>
					<td>
						<input type="text" id="bac" name="bac" readonly value="${tl:toCurrency(project.bac) }"/>
					</td>
					<td>
						<input type="text" id="ac" name="ac" class="campo importe" style="width: 80%"/>
					</td>
					<td>
						<input type="text" name="statusDate" class="importe center" readonly/>
					</td>
					<td class="right">${tl:toCurrency(sumTimeSheet) }</td>
				</tr>
				<tr>
					<th class="left"><fmt:message key="activity.earned_value"/>&nbsp;*</th>
					<th class="left"><fmt:message key="followup.poc"/></th>
					<th class="left">&nbsp;</th>
					<th class="left"><fmt:message key="activity.ev.sum"/></th>
				</tr>
				<tr>
					<td>
						<input type="text" id="ev" name="ev" class="campo importe" onblur="updatePoc()" style="width: 80%"/>
					</td>
					<td>
						<input type="text" id="poc" name="poc" class="campo integer" style="width: 80%;"/>
					</td>
					<td>
						<a href="javascript:calculateFollowupEv();" class="boton" title="<fmt:message key="calculate" />"><fmt:message key="calculate" /></a> 
					</td>
					<td class="right">${tl:toCurrency(sumEVActivity) }</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<input type="submit" class="boton" onclick="saveFollowup(); return false;" value="<fmt:message key="save" />" />
    	</div>
    </form>
</div>
