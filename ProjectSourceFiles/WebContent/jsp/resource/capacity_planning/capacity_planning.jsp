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
<%@page import="java.util.Date"%>
<%@page import="es.sm2.openppm.utils.DateUtil"%>
<%@page import="es.sm2.openppm.servlets.ResourceServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script language="javascript" type="text/javascript" >
<!--
var resourceAjax = new AjaxCall('<%=ResourceServlet.REFERENCE%>','<fmt:message key="error" />');

function exportCSV() {

	var f = document.forms.frm_resource; 
	f.accion.value = '<%=ResourceServlet.CAPACITY_PLANNING_TO_CSV%>';
	f.submit();
}

function actionApplyFilter() {

	document.forms.frm_resource.accion.value = '<%=ResourceServlet.JX_UPDATE_CAPACITY_PLANNING%>';
	var $since = $('#since');
	var $until = $('#until');
	
	if ($since.val() == '') { $since.val('<fmt:formatDate value="<%=DateUtil.getFirstMonthDay(new Date())%>" pattern="${datePattern}"/>'); }
	if ($until.val() == '') { $until.val('<fmt:formatDate value="<%=DateUtil.getLastMonthDay(new Date())%>" pattern="${datePattern}"/>'); }
	
	resourceAjax.call($("#frm_resource").serialize(),function(data) {
		$('#staffingTable').html(data);
	},'html');
}

readyMethods.add(function () {
	
	loadFilterState();
	
});
//-->
</script>

<form id="frm_resource" name="frm_resource" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="idEmployee" id="idEmployee" value="" />
	<input type="hidden" name="resourceType" value="" />
	
	<%-- FILTERS --%>
	<jsp:include page="filters.inc.jsp" flush="true"/>
	<%-- PROJECT STAFFING TABLE --%>
	<div id="staffingTable"></div>
	<div style="margin: 10px;">&nbsp;</div>
</form>

<jsp:include page="resource_popup.jsp" flush="true"/>
