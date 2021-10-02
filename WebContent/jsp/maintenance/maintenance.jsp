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

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.MaintenanceServlet"%>
<%@page import="es.sm2.openppm.utils.ParamUtil"%>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="p_mant_category"  value="<%=Constants.MANT_CATEGORY%>" />
<c:set var="p_mant_company"  value="<%=Constants.MANT_COMPANY%>" /> 
<c:set var="p_mant_contact"  value="<%=Constants.MANT_CONTACT%>" />
<c:set var="p_mant_contracttype"  value="<%=Constants.MANT_CONTRACTTYPE%>" />
<c:set var="p_mant_resource"  value="<%=Constants.MANT_RESOURCE%>" />
<c:set var="p_mant_expenseaccounts"  value="<%=Constants.MANT_EXPENSEACCOUNTS%>" />
<c:set var="p_mant_geography"  value="<%=Constants.MANT_GEOGRAPHY%>" />
<c:set var="p_mant_operation"  value="<%=Constants.MANT_OPERATION%>" />
<c:set var="p_mant_operationaccount"  value="<%=Constants.MANT_OPERATIONACCOUNT%>" />
<c:set var="p_mant_performing_org"  value="<%=Constants.MANT_PERFORMING_ORG%>" />
<c:set var="p_mant_budgetaccounts"  value="<%=Constants.MANT_BUDGETACCOUNTS%>" />
<c:set var="p_mant_skill"  value="<%=Constants.MANT_SKILL%>" />
<c:set var="p_mant_customers"  value="<%=Constants.MANT_CUSTOMERS%>" />
<c:set var="p_mant_sellers"  value="<%=Constants.MANT_SELLERS%>" />
<c:set var="p_mant_metrickpi"  value="<%=Constants.MANT_METRIC_KPI%>" />
<c:set var="p_mant_customer_type"  value="<%=Constants.MANT_CUSTOMER_TYPE%>" />
<c:set var="p_mant_fundingsource"  value="<%=Constants.MANT_FUNDINGSOURCE%>" />
<c:set var="p_mant_documentation"  value="<%=Constants.MANT_DOCUMENTATION%>" />
<c:set var="p_mant_changetype"  value="<%=Constants.MANT_CHANGETYPE%>" />

<script type="text/javascript">

var mainAjax = new AjaxCall('<%=MaintenanceServlet.REFERENCE%>','<fmt:message key="error"/>');

function consMaintenance() {
	var f = document.forms["frm_mantenimientos"];
	f.action = "maintenance";
	f.accion.value = "<%=MaintenanceServlet.CONS_MAINTENANCE %>";
	loadingPopup();
	f.submit();
}

</script>

<form name="frm_mantenimientos" method="post">
	<input type="hidden" name="accion" value="" />
	<table>
		<tr>
			<th width="20%">
				<fmt:message key="menu.maintenance" />
			</th>
			<td width="40%">
				<select class="campo" name="idManten" id="idManten">
					<optgroup label="<fmt:message key="people"/>">
						<option value="<%=Constants.MANT_CONTACT%>" <c:if test="${param.idManten == p_mant_contact}">selected</c:if>><fmt:message key="maintenance.contacts"/></option>
						<option value="<%=Constants.MANT_RESOURCE%>" <c:if test="${param.idManten == p_mant_resource}">selected</c:if>><fmt:message key="maintenance.profiles"/></option>
						<option value="<%=Constants.MANT_SKILL%>" <c:if test="${param.idManten == p_mant_skill}">selected</c:if>><fmt:message key="maintenance.skills"/></option>
					</optgroup>
					<optgroup label="<fmt:message key="project"/>">
						<option value="<%=Constants.MANT_CATEGORY%>" <c:if test="${param.idManten == p_mant_category}">selected</c:if>><fmt:message key="maintenance.categories"/></option>
						<option value="<%=Constants.MANT_GEOGRAPHY%>" <c:if test="${param.idManten == p_mant_geography}">selected</c:if>><fmt:message key="maintenance.geographic_places"/></option>
						<option value="<%=Constants.MANT_CONTRACTTYPE%>" <c:if test="${param.idManten == p_mant_contracttype}">selected</c:if>><fmt:message key="maintenance.contract_types"/></option>
						<option value="<%=Constants.MANT_CHANGETYPE%>" <c:if test="${idManten == p_mant_changetype}">selected</c:if>><fmt:message key="maintenance.change_types"/></option>
						<option value="<%=Constants.MANT_METRIC_KPI%>" <c:if test="${param.idManten == p_mant_metrickpi}">selected</c:if>><fmt:message key="maintenance.metric_kpi"/></option>
						<option value="<%=Constants.MANT_FUNDINGSOURCE%>" <c:if test="${param.idManten == p_mant_fundingsource}">selected</c:if>><fmt:message key="maintenance.fundingsource"/></option>
					</optgroup>
					<optgroup label="<fmt:message key="finance_accounts"/>">
						<option value="<%=Constants.MANT_BUDGETACCOUNTS%>" <c:if test="${param.idManten == p_mant_budgetaccounts}">selected</c:if>><fmt:message key="maintenance.project_charge_accounts"/></option>
						<option value="<%=Constants.MANT_EXPENSEACCOUNTS%>" <c:if test="${param.idManten == p_mant_expenseaccounts}">selected</c:if>><fmt:message key="maintenance.expense_charge_accounts"/></option>
						<option value="<%=Constants.MANT_OPERATION%>" <c:if test="${param.idManten == p_mant_operation}">selected</c:if>><fmt:message key="maintenance.operation"/></option>
						<option value="<%=Constants.MANT_OPERATIONACCOUNT%>" <c:if test="${param.idManten == p_mant_operationaccount}">selected</c:if>><fmt:message key="maintenance.operationaccount"/></option>
					</optgroup>
					<optgroup label="<fmt:message key="company"/>">
						<option value="<%=Constants.MANT_PERFORMING_ORG%>" <c:if test="${param.idManten == p_mant_performing_org}">selected</c:if>><fmt:message key="maintenance.performing_organizations"/></option>
						<option value="<%=Constants.MANT_CUSTOMERS%>" <c:if test="${param.idManten == p_mant_customers}">selected</c:if>><fmt:message key="maintenance.customers"/></option>
						<option value="<%=Constants.MANT_CUSTOMER_TYPE%>" <c:if test="${param.idManten == p_mant_customer_type}">selected</c:if>><fmt:message key="maintenance.customer_types"/></option>
						<option value="<%=Constants.MANT_SELLERS%>" <c:if test="${param.idManten == p_mant_sellers}">selected</c:if>><fmt:message key="maintenance.sellers"/></option>
					</optgroup>
					<optgroup label="<fmt:message key="other"/>">
						<option value="<%=Constants.MANT_DOCUMENTATION%>" <c:if test="${idManten == p_mant_documentation}">selected</c:if>><fmt:message key="maintenance.documentation_manuals"/></option>						
					</optgroup>
				</select>
			</td>
			<td align="left" width="25%">
				<a href="#" class="boton" onClick="return consMaintenance();"><fmt:message key="show" /></a>
			</td>
		</tr>
	</table>
	
</form>

<c:choose>
	<c:when test="${param.idManten == p_mant_company}">
		<jsp:include page="mant_company.jsp"></jsp:include>	
	</c:when>
	<c:when test="${param.idManten == p_mant_performing_org}">
		<jsp:include page="mant_performing_org.jsp"></jsp:include>
	</c:when>	
	<c:when test="${param.idManten == p_mant_skill}">
		<jsp:include page="mant_skill.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_contact}">
		<jsp:include page="mant_contact.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_resource}">
		<jsp:include page="mant_resource.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_budgetaccounts}">
		<jsp:include page="mant_budgetaccounts.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_contracttype}">
		<jsp:include page="mant_contracttype.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_expenseaccounts}">
		<jsp:include page="mant_expenseaccounts.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_category}">
		<jsp:include page="mant_category.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_geography}">
		<jsp:include page="mant_geography.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_operationaccount}">
		<jsp:include page="mant_operationaccount.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_operation}">
		<jsp:include page="mant_operation.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_customers}">
		<jsp:include page="mant_customer.jsp"></jsp:include>
	</c:when>	
	<c:when test="${param.idManten == p_mant_sellers}">
		<jsp:include page="mant_seller.jsp"></jsp:include>
	</c:when>	
	<c:when test="${param.idManten == p_mant_metrickpi}">
		<jsp:include page="mant_metric_kpi.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_customer_type}">
		<jsp:include page="mant_customer_type.jsp"></jsp:include>
	</c:when>
	<c:when test="${param.idManten == p_mant_fundingsource}">
		<jsp:include page="mant_funding_source.jsp"></jsp:include>
	</c:when>
	<c:when test="${idManten == p_mant_documentation}">
		<jsp:include page="mant_documentation.jsp"></jsp:include>
	</c:when>
	<c:when test="${idManten == p_mant_changetype}">
		<jsp:include page="mant_changetype.jsp"></jsp:include>
	</c:when>
</c:choose>
